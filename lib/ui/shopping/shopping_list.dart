import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/models/ingredient.dart';
import '../../data/repository.dart';

class ShoppingList extends StatefulWidget {
  const ShoppingList({Key? key}) : super(key: key);

  @override
  State<ShoppingList> createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  final checkBoxValues = <int, bool>{};

  @override
  Widget build(BuildContext context) {
    final repository = Provider.of<Repository>(context, listen: false);
    return StreamBuilder<List<Ingredient>>(
      stream: repository.watchAllIngredients(),
      builder: (context, AsyncSnapshot<List<Ingredient>> snapshot) {
        var ingredients = <Ingredient>[];

        if (snapshot.connectionState == ConnectionState.active) {
          ingredients = snapshot.data ?? [];
        } else {
          return Container();
        }

        return ListView.builder(
          itemCount: ingredients.length,
          itemBuilder: (BuildContext context, int index) {
            final ingredient = ingredients[index];
            return CheckboxListTile(
              value:
                  checkBoxValues.containsKey(index) && checkBoxValues[index]!,
              title: Text(ingredient.name ?? ''),
              onChanged: (newValue) {
                if (newValue != null) {
                  setState(() {
                    checkBoxValues[index] = newValue;
                  });
                }
              },
            );
          },
        );
      },
    );
  }
}
