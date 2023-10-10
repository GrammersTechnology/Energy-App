// USAGE
// import 'package:{your_app}/byge-design-system/nav_bars/app_bar/byge_app_bar.dart';

import 'package:flutter/material.dart';
import 'byge_app_bar.dart';

class AppBarExample extends StatelessWidget {
  const AppBarExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SecondScreen()),
          );
        },
        child: const Text('Go to Second Screen'),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BygeAppBar(
        title: const Text(
          'Second Screen',
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.favorite_outline),
          ),
        ],
      ),
      body: const Center(
        child: Text('Second screen'),
      ),
    );
  }
}
