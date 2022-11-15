import 'package:flutter/material.dart';

import 'core/theme/fooderlich_theme.dart';
import 'screens/home.dart';

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

    // 3
    return MaterialApp(
      theme: currentTheme,
      debugShowCheckedModeBanner: false,
      title: 'Fooderlich',
      // 4
      home: const Home(),
      
    );
  }
}
