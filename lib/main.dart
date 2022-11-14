import 'package:flutter/material.dart';

import 'fooderlich_theme.dart';

void main() {
  // 1
  runApp(const Fooderlich());
}

class Fooderlich extends StatelessWidget {
  // 2
  const Fooderlich({super.key});
  @override
  Widget build(BuildContext context) {
    final currentTheme = FooderlichTheme.dark();
    // final currentTheme = FooderlichTheme.light();

    // TODO: Apply Home widget
    // 3
    return MaterialApp(
      theme: currentTheme,
      title: 'Fooderlich',
      // 4
      home: Scaffold(
        appBar: AppBar(
            title: Text(
          'Fooderlich',
          style: currentTheme.textTheme.headline6,
        )),
        body: Center(
          child: Text(
            'Let\'s get cooking 👩‍🍳',
            style: currentTheme.textTheme.headline1,
          ),
        ),
      ),
    );
  }
}
