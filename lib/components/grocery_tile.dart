import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../models/grocery_item.dart';

class GroceryTile extends StatelessWidget {
  GroceryTile({super.key, 
    required this.groceryItem,
    this.onComplete,
  }) : textDecoration = groceryItem.isComplete
            ? TextDecoration.lineThrough
            : TextDecoration.none;

  final GroceryItem groceryItem;
  final Function(bool?)? onComplete;
  final TextDecoration textDecoration;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 5,
                color: groceryItem.color,
              ),
              const SizedBox(
                width: 16,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
// 5
                  Text(
                    groceryItem.name,
                    style: GoogleFonts.lato(
                      decoration: textDecoration,
                      fontSize: 21.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  buildDate(),
                  const SizedBox(height: 4.0),
                  buildImportance(),
                ],
              ),
            ],
          ),
          Row(
            children: [
              // 7
              Text(
                groceryItem.quantity.toString(),
                style: GoogleFonts.lato(
                  decoration: textDecoration,
                  fontSize: 21.0,
                ),
              ),
// 8
              buildCheckbox(),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildImportance() {
    switch (groceryItem.importance) {
      case Importance.low:
        return Text(
          'Low',
          style: GoogleFonts.lato(
            decoration: textDecoration,
          ),
        );

      case Importance.medium:
        return Text(
          'Medium',
          style: GoogleFonts.lato(
            fontWeight: FontWeight.w800,
            decoration: textDecoration,
          ),
        );

      case Importance.high:
        return Text(
          'High',
          style: GoogleFonts.lato(
            color: Colors.red,
            fontWeight: FontWeight.w900,
            decoration: textDecoration,
          ),
        );

      default:
        throw Exception('This Item doesn\'t exist');
    }
  }

  Widget buildDate() {
    final dateFormatter = DateFormat('MMMM dd h:mm a');
    final stringDate = dateFormatter.format(groceryItem.date);
    return Text(
      stringDate,
      style: TextStyle(decoration: textDecoration),
    );
  }

  Widget buildCheckbox() {
    return Checkbox(
      value: groceryItem.isComplete,
      onChanged: onComplete,
    );
  }
}
