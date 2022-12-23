// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class Ingredient extends Equatable {
  int? id;
  int? recipeId;
  final String? name;
  final double? weight;

  Ingredient({
    this.id,
    this.name,
    this.recipeId,
    this.weight,
  });

  @override
  List<Object?> get props => [
        recipeId,
        name,
        weight,
      ];
}
