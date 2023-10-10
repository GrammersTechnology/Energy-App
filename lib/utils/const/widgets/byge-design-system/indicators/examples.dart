// USAGE
// import 'package:{your_app}/byge-design-system/indicators/dot_indicators.dart';

import 'package:flutter/material.dart';
import 'dot_indicators.dart';

class DotIndicatorExample extends StatefulWidget {
  const DotIndicatorExample({super.key});

  @override
  State<DotIndicatorExample> createState() => _DotIndicatorExampleState();
}

class _DotIndicatorExampleState extends State<DotIndicatorExample> {
  final int _items = 6;
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: PageView.builder(
              itemCount: _items,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              itemBuilder: (BuildContext context, int index) {
                return Center(
                  child: Text('Page $index'),
                );
              },
            ),
          ),
          DotIndicators(
            totalDots: _items,
            currentDot: _currentPage,
            size: 11,
            gap: 8,
          ),
        ],
      ),
    );
  }
}
