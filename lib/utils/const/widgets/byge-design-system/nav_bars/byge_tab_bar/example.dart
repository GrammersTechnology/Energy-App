// USAGE
// import 'package:{your_app}/byge-design-system/nav_bars/byge_tab_bar/byge_tab.dart';
// import 'package:{your_app}/byge-design-system/nav_bars/byge_tab_bar/byge_tab_bar.dart';

import 'package:flutter/material.dart';

import 'byge_tab_bar.dart';
import 'byge_tab.dart';
import '../../theme/spacing.dart';

class BygeTabBarExample extends StatelessWidget {
  const BygeTabBarExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const BygeTabBarExampleScreen(),
            ),
          );
        },
        child: const Text('Go to Tab Example'),
      ),
    );
  }
}

class BygeTabBarExampleScreen extends StatelessWidget {
  const BygeTabBarExampleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // DefualtTabController will connect the BygeTabBar and the TabBarView
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Byge TabBar Example'),
          bottom: const BygeTabBar(
            padding: EdgeInsets.symmetric(horizontal: AppSpaces.s),
            tabs: [
              BygeTab(text: 'I dag'),
              BygeTab(text: 'I går'),
              BygeTab(text: 'Nest uke'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Container(
              color: Colors.cyanAccent,
              child: const Center(child: Text('Screen 1')),
            ),
            Container(
              color: Colors.lightBlueAccent,
              child: const Center(child: Text('Screen 2')),
            ),
            Container(
              color: Colors.redAccent,
              child: const Center(child: Text('Screen 3')),
            )
          ],
        ),
      ),
    );
  }
}
