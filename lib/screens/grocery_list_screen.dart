import 'package:flutter/material.dart';
import 'grocery_item_screen.dart';

import '../components/grocery_tile.dart';
import '../providers/grocery_manager.dart';

class GroceryListScreen extends StatelessWidget {
  const GroceryListScreen({super.key, required this.manager});

  final GroceryManager manager;

  @override
  Widget build(BuildContext context) {
    final groceryItems = manager.groceryItems;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView.separated(
        itemCount: groceryItems.length,
        separatorBuilder: (_, __) => const SizedBox(
          height: 16,
        ),
        itemBuilder: (context, index) {
          final item = groceryItems[index];
          // 5
          return Dismissible(
            key: Key(item.id),
            direction: DismissDirection.endToStart,
            background: Container(
              alignment: Alignment.centerRight,
              color: Colors.red,
              child: const Icon(
                Icons.delete_forever,
                color: Colors.white,
                size: 50,
              ),
            ),
            onDismissed: (direction) {
              manager.deleteItem(index);

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${item.name} dismissed'),
                ),
              );
            },
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GroceryItemScreen(
                      originalItem: item,
                      // 3
                      onUpdate: (item) {
                        // 4
                        manager.updateItem(item, index);
                        // 5
                        Navigator.pop(context);
                      },
                      // 6
                      onCreate: (item) {},
                    ),
                  ),
                );
              },
              child: GroceryTile(
                groceryItem: item,
                onComplete: (change) {
                  if (change != null) {
                    manager.completeItem(
                      item,
                      change,
                    );
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
