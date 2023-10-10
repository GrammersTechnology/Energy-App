import 'package:flutter/material.dart';
import '../theme/spacing.dart';

class DotIndicators extends StatelessWidget {
  final int totalDots;
  final int currentDot;
  final double gap;
  final double size;

  const DotIndicators({
    super.key,
    required this.totalDots,
    required this.currentDot,
    this.gap = AppSpaces.xs,
    this.size = 11,
  });

  @override
  Widget build(BuildContext context) {
    final activeColor = Theme.of(context).colorScheme.primary;
    final inactiveColor = Theme.of(context).colorScheme.secondary;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(totalDots, (int index) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: gap / 2),
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: index == currentDot ? activeColor : inactiveColor,
            ),
          ),
        );
      }),
    );
  }
}
