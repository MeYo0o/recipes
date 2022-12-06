import 'package:flutter/material.dart';

import '../models/simple_recipe.dart';
import 'components.dart';

class RecipesGridView extends StatelessWidget {
  const RecipesGridView({
    super.key,
    required this.recipes,
  });

  final List<SimpleRecipe> recipes;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        top: 16,
        right: 16,
      ),
      child: GridView.builder(
        itemCount: recipes.length,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 500,
        ),
        itemBuilder: (context, index) => RecipeThumbnail(
          recipe: recipes[index],
        ),
      ),
    );
  }
}
