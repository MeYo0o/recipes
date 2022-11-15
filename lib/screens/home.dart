import 'package:flutter/material.dart';
import '../widgets/card2.dart';
import '../extensions/stateful_extension.dart';
import '../widgets/card1.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  List<Widget> pages = [
    const Card1(),
    const Card2(),
    // TODO: Replace with Card3
    Container(color: Colors.blue),
  ];

  //change selected Tab
  void _onItemTapped(int value) {
    setState(() {
      _selectedIndex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Fooderlich',
          // 2
          style: extensionTheme(context).textTheme.headline6,
        ),
      ),
      // TODO: Show selected tab
      body: Center(
        child: pages[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor:
            extensionTheme(context).bottomNavigationBarTheme.selectedItemColor,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            label: 'Card 1',
            icon: Icon(
              Icons.card_giftcard,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Card 2',
            icon: Icon(
              Icons.card_giftcard,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Card 3',
            icon: Icon(
              Icons.card_giftcard,
            ),
          ),
        ],
      ),
    );
  }
}
