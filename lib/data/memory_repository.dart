import 'dart:core';
import 'package:flutter/foundation.dart';
// 1
import 'repository.dart';
// 2
import 'models/models.dart';

//3
class MemoryRepository extends Repository with ChangeNotifier {
  //4
  final List<Recipe> _currentRecipes = <Recipe>[];
  //5
  final List<Ingredient> _currentIngredients = <Ingredient>[];

  // overridden find methods
  @override
  List<Recipe> findAllRecipes() {
    return _currentRecipes;
  }

  //
  @override
  Recipe findRecipeById(int id) {
    return _currentRecipes.firstWhere((recipe) => recipe.id == id);
  }

  //
  @override
  List<Ingredient> findAllIngredients() {
    return _currentIngredients;
  }

  //
  @override
  List<Ingredient> findRecipeIngredients(int recipeId) {
    final recipe =
        _currentRecipes.firstWhere((recipe) => recipe.id == recipeId);

    final recipeIngredients = _currentIngredients
        .where((ingredient) => ingredient.recipeId == recipe.id)
        .toList();

    return recipeIngredients;
  }

  // overridden Add insert methods
  @override
  int insertRecipe(Recipe recipe) {
    _currentRecipes.add(recipe);
    if (recipe.ingredients != null) {
      insertIngredients(recipe.ingredients!);
    }
    notifyListeners();
    return 0;
  }

  //
  @override
  List<int> insertIngredients(List<Ingredient> ingredients) {
    if (ingredients.isNotEmpty) {
      _currentIngredients.addAll(ingredients);

      notifyListeners();
    }

    return <int>[];
  }

  // overridden Add delete methods
  @override
  void deleteRecipe(Recipe recipe) {
    _currentRecipes.remove(recipe);

    if (recipe.id != null) {
      deleteRecipeIngredients(recipe.id!);
    }

    notifyListeners();
  }

  //
  @override
  void deleteIngredient(Ingredient ingredient) {
    _currentIngredients.remove(ingredient);
  }

  //
  @override
  void deleteIngredients(List<Ingredient> ingredients) {
    _currentIngredients
        .removeWhere((ingredient) => ingredients.contains(ingredient));
    notifyListeners();
  }

  //
  @override
  void deleteRecipeIngredients(int recipeId) {
    _currentIngredients
        .removeWhere((ingredient) => ingredient.recipeId == recipeId);
    notifyListeners();
  }

  //6
  @override
  Future init() {
    return Future.value(null);
  }

  //7
  @override
  void close() {}
}
