import 'dart:core';
// 1
import 'repository.dart';
// 2
import 'models/models.dart';

import 'dart:async';

//3
class MemoryRepository extends Repository {
  //4
  final List<Recipe> _currentRecipes = <Recipe>[];
  //5
  final List<Ingredient> _currentIngredients = <Ingredient>[];

  Stream<List<Recipe>>? _recipeStream;
  Stream<List<Ingredient>>? _ingredientStream;

  final StreamController<List<Recipe>> _recipeStreamController =
      StreamController<List<Recipe>>();

  final StreamController<List<Ingredient>> _ingredientStreamController =
      StreamController<List<Ingredient>>();

  // overridden find methods

  @override
  Stream<List<Recipe>> watchAllRecipes() {
    _recipeStream ??= _recipeStreamController.stream;
    return _recipeStream!;
  }

  @override
  Stream<List<Ingredient>> watchAllIngredients() {
    _ingredientStream ??= _ingredientStreamController.stream;
    return _ingredientStream!;
  }

  @override
  Future<List<Recipe>> findAllRecipes() async {
    return Future.value(_currentRecipes);
  }

  //
  @override
  Future<Recipe> findRecipeById(int id) async {
    return Future.value(
      _currentRecipes.firstWhere((recipe) => recipe.id == id),
    );
  }

  //
  @override
  Future<List<Ingredient>> findAllIngredients() async {
    return Future.value(_currentIngredients);
  }

  //
  @override
  Future<List<Ingredient>> findRecipeIngredients(int recipeId) async {
    final recipe =
        _currentRecipes.firstWhere((recipe) => recipe.id == recipeId);

    final recipeIngredients = _currentIngredients
        .where((ingredient) => ingredient.recipeId == recipe.id)
        .toList();

    return Future.value(recipeIngredients);
  }

  // overridden Add insert methods
  @override
  Future<int> insertRecipe(Recipe recipe) async {
    _currentRecipes.add(recipe);
    if (recipe.ingredients != null) {
      insertIngredients(recipe.ingredients!);
    }

    _recipeStreamController.sink.add(_currentRecipes);

    return Future.value(0);
  }

  //
  @override
  Future<List<int>> insertIngredients(List<Ingredient> ingredients) async {
    if (ingredients.isNotEmpty) {
      _currentIngredients.addAll(ingredients);
    }

    _ingredientStreamController.sink.add(_currentIngredients);

    return Future.value(<int>[]);
  }

  // overridden Add delete methods
  @override
  Future<void> deleteRecipe(Recipe recipe) async {
    _currentRecipes.remove(recipe);

    if (recipe.id != null) {
      deleteRecipeIngredients(recipe.id!);
    }

    _recipeStreamController.sink.add(_currentRecipes);
    return Future.value();
  }

  //
  @override
  Future<void> deleteIngredient(Ingredient ingredient) async {
    _currentIngredients.remove(ingredient);

    _ingredientStreamController.sink.add(_currentIngredients);

    return Future.value();
  }

  //
  @override
  Future<void> deleteIngredients(List<Ingredient> ingredients) async {
    _currentIngredients
        .removeWhere((ingredient) => ingredients.contains(ingredient));

    _ingredientStreamController.sink.add(_currentIngredients);

    return Future.value();
  }

  //
  @override
  Future<void> deleteRecipeIngredients(int recipeId) async {
    _currentIngredients
        .removeWhere((ingredient) => ingredient.recipeId == recipeId);

    _ingredientStreamController.sink.add(_currentIngredients);

    return Future.value();
  }

  //6
  @override
  Future init() {
    return Future.value();
  }

  //7
  @override
  void close() {
    _recipeStreamController.close();
    _ingredientStreamController.close();
  }
}
