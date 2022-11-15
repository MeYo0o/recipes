import 'package:flutter/material.dart';

import '../extensions/stateless_extension.dart';

class Card1 extends StatelessWidget {
  const Card1({super.key});
  // 1
  final String category = 'Editor\'s Choice';
  final String title = 'The Art of Dough';
  final String description = 'Learn to make the perfect bread.';
  final String chef = 'Ray Wenderlich';
// 2
  @override
  Widget build(BuildContext context) {
// 3
    return Center(
      child: Container(
        // 1
        padding: const EdgeInsets.all(16),
        // 2
        constraints: const BoxConstraints.expand(
          width: 350,
          height: 450,
        ),
        // 3
        decoration: const BoxDecoration(
          //4
          image: DecorationImage(
            //5
            image: AssetImage('assets/mag1.png'),
            //6
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        child: Stack(
          children: [
            Text(
              category,
              style: extensionTheme(context).textTheme.bodyText1,
            ),
            Positioned(
              top: 20,
              child: Text(
                title,
                style: extensionTheme(context).textTheme.headline5,
              ),
            ),
            Positioned(
              bottom: 30,
              right: 0,
              child: Text(
                description,
                style: extensionTheme(context).textTheme.bodyText1,
              ),
            ),
            Positioned(
              bottom: 10,
              right: 0,
              child: Text(
                chef,
                style: extensionTheme(context).textTheme.bodyText1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
