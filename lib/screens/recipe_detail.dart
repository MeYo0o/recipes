import 'package:flutter/material.dart';
import 'package:recipes/models/ingredient.dart';
import 'package:recipes/models/recipe.dart';

class RecipeDetail extends StatefulWidget {
  const RecipeDetail({super.key, required this.recipe});

  final Recipe recipe;

  @override
  State<RecipeDetail> createState() => _RecipeDetailState();
}

class _RecipeDetailState extends State<RecipeDetail> {
  int _sliderVal = 1;
  @override
  Widget build(BuildContext context) {
    //1
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recipe.label),
      ),
      //2
      body: SafeArea(
        //3
        child: Column(
          children: [
            //4
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Image(
                image: AssetImage(
                  widget.recipe.imageUrl,
                ),
              ),
            ),

            //5
            const SizedBox(
              height: 4,
            ),

            //6
            Text(
              widget.recipe.label,
              style: const TextStyle(
                fontSize: 18.0,
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(7.0),
                itemCount: widget.recipe.ingredients.length,
                itemBuilder: (context, index) {
                  final Ingredient ingredient =
                      widget.recipe.ingredients[index];

                  //9
                  return Text(
                      '${ingredient.quantity * _sliderVal} ${ingredient.measure} ${ingredient.name}');
                },
              ),
            ),

            Slider(
              //10
              min: 1,
              max: 10,
              divisions: 9,
              //11
              label: '${_sliderVal * widget.recipe.servings} servings',
              //12
              value: _sliderVal.toDouble(),
              //13
              onChanged: (value) {
                setState(() {
                  _sliderVal = value.toInt();
                });
              },
              //14
              activeColor: Colors.green,
              inactiveColor: Colors.grey.shade300,
            ),
          ],
        ),
      ),
    );
  }
}
