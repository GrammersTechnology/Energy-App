// USAGE
// import 'package:{your_app}/byge-design-system/nav_bars/byge_tabbed/byge_tabbed.dart';

import 'package:flutter/material.dart';
import '../../buttons/primary_button.dart';
import '../../theme/spacing.dart';
import 'byge_tabbed.dart';

class BygeTabbedExample extends StatefulWidget {
  const BygeTabbedExample({super.key});

  @override
  State<BygeTabbedExample> createState() => _ExampleUsageScreenState();
}

class _ExampleUsageScreenState extends State<BygeTabbedExample> {
  late PageController _externalController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpaces.m),
      child: Column(
        children: [
          BygeTabbedWidgets(
            maxContentHeight: 400,
            animationSpeed: 300,
            tabNames: const ['Tab 1', 'Tab 2', 'Tab 3'],
            widgets: const [
              TabContent(text: 'Content 1'),
              TabContent(text: 'Content 2'),
              TabContent(text: 'Content 3'),
            ],
            onControllerCreated: (controller) {
              _externalController = controller;
            },
          ),
          const SizedBox(height: 80),
          BygePrimaryButton(
            label: 'Go to tab 3',
            minWidth: 100,
            onPressed: () {
              _externalController.animateToPage(
                2,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
          ),
        ],
      ),
    );
  }
}

class TabContent extends StatelessWidget {
  const TabContent({
    super.key,
    this.color = Colors.grey,
    required this.text,
  });

  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: Center(
        child: Text(text),
      ),
    );
  }
}
