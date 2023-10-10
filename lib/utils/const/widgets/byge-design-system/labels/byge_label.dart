import 'package:flutter/material.dart';
import '../theme/spacing.dart';

class BygeLabel extends StatelessWidget {
  final Widget? icon;
  final String label;

  const BygeLabel({
    Key? key,
    this.icon,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double textScaleFactor = MediaQuery.of(context).textScaleFactor;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null)
          Transform.scale(
            scale: textScaleFactor,
            child: icon!,
          ),
        SizedBox(width: AppSpaces.xs * textScaleFactor),
        Text(label, style: Theme.of(context).textTheme.labelLarge),
      ],
    );
  }
}
