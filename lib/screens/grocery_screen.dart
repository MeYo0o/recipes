import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import 'empty_grocery_screen.dart';
import 'grocery_item_screen.dart';

class GroceryScreen extends StatelessWidget {
  const GroceryScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
        ),
        onPressed: () {
          final groceryManager =
              Provider.of<GroceryManager>(context, listen: false);

          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => GroceryItemScreen(
                onCreate: (item) {
                  groceryManager.addItem(item);
                  Navigator.of(context).pop();
                },
                onUpdate: (item) {},
              ),
            ),
          );
        },
      ),
      body: buildGroceryScreen(),
    );
  }

  Widget buildGroceryScreen() {
    return Consumer<GroceryManager>(
      builder: (
        context,
        groceryManager,
        child,
      ) {
        if (groceryManager.groceryItems.isNotEmpty) {
          return Container();
        } else {
          return const EmptyGroceryScreen();
        }
      },
    );
  }
}
