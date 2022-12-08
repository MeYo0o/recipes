import 'package:flutter/material.dart';

import '../models/grocery_item.dart';

class GroceryManager extends ChangeNotifier {
  final _groceryItems = <GroceryItem>[];

  //Getter
  List<GroceryItem> get groceryItems => List.unmodifiable(_groceryItems);

  //Add
  void addItem(GroceryItem item) {
    _groceryItems.add(item);
    notifyListeners();
  }

  void deleteItem(GroceryItem item) {
    _groceryItems.remove(item);
    notifyListeners();
  }

  void updateItem(GroceryItem item) {
    final itemIndex = _groceryItems.indexOf(item);
    _groceryItems[itemIndex] = item;
    notifyListeners();
  }

  void completeItem(GroceryItem item, bool isComplete) {
    final itemIndex = _groceryItems.indexOf(item);
    _groceryItems[itemIndex] = item.copyWith(
      isComplete: isComplete,
    );
    notifyListeners();
  }

  //
}