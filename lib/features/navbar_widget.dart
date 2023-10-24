import 'package:demo/features/Hva%20Koster/view/hva_koster_screen.dart';
import 'package:demo/features/auth/screen/auth_management.dart';
import 'package:demo/features/home/home_screen.dart';
import 'package:flutter/material.dart';

class NavBarWidget extends StatefulWidget {
  const NavBarWidget({
    super.key,
  });
  @override
  State<NavBarWidget> createState() => _NavBarWidgetState();
}

class _NavBarWidgetState extends State<NavBarWidget> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final tabs = [
      HomeScreen(),
      const HvaKosterScreen(),
      const ProfileAuthentication()
    ];
    return Scaffold(
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
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
