// USAGE
// import 'package:{your_app}/byge-design-system/cards/byge_nav_card.dart';

import 'package:flutter/material.dart';
import 'byge_nav_card.dart';
import '../theme/spacing.dart';

class BygeNavCardExample extends StatelessWidget {
  const BygeNavCardExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSpaces.m),
      child: Center(
        child: Column(
          children: [
            BygeNavCard(
              title: 'Example with small child',
              destination: SomeNewPage(),
              child: FixedHeightBox(height: 50),
            ),
            SizedBox(height: AppSpaces.m),
            BygeNavCard(
              title: 'Card with a veeeeeeeeery long text',
              destination: SomeNewPage(),
              child: FixedHeightBox(
                height: 110,
              ),
            ),
            SizedBox(
              height: AppSpaces.m,
            ),
            BygeNavCard(
              title: 'Example with big child',
              destination: SomeNewPage(),
              child: FixedHeightBox(
                height: 150,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FixedHeightBox extends StatelessWidget {
  const FixedHeightBox({super.key, required this.height});

  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height, // Fixed height
      color: Colors.grey[200], // Just for visualization purposes
      width: double.infinity, // Takes the size of the parent horizontally
    );
  }
}

class SomeNewPage extends StatelessWidget {
  const SomeNewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('New Page')),
      body: const Center(child: Text('New page content')),
    );
  }
}
