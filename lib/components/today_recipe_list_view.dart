import 'package:flutter/material.dart';

import '../models/explore_recipe.dart';
import 'components.dart';

class TodayRecipeListView extends StatelessWidget {
  const TodayRecipeListView({
    super.key,
    required this.recipes,
  });

  final List<ExploreRecipe> recipes;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        top: 16,
        right: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recipes of the Day 🍳',
            style: Theme.of(context).textTheme.headline1,
          ),
          const SizedBox(
            height: 16,
          ),

          // 7
          Container(
            height: 400,
            color: Colors.transparent,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: recipes.length,
              separatorBuilder: (context, index) => const SizedBox(width: 16),
              itemBuilder: (context, index) {
                final recipe = recipes[index];
                return buildCard(recipe);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCard(ExploreRecipe recipe) {
    switch (recipe.cardType) {
      case RecipeCardType.card1:
        return Card1(recipe: recipe);

      case RecipeCardType.card2:
        return Card2(recipe: recipe);

      case RecipeCardType.card3:
        return Card3(recipe: recipe);

      default:
        throw Exception('This card doesn\'t exist yet');
    }
  }
}
