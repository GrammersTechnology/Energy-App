import 'package:flutter/material.dart';

class NavBarExample extends StatefulWidget {
  const NavBarExample({super.key});

  @override
  State<NavBarExample> createState() => _NavBarExampleState();
}

class _NavBarExampleState extends State<NavBarExample> {
  int _currentIndex = 0;

  final tabs = [
    const Center(child: Text('Strømpris')),
    const Center(child: Text('Apparater')),
    const Center(child: Text('Meg')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.flash_on_outlined),
            label: 'Strømpris',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_laundry_service),
            label: 'Apparater',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Meg',
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
