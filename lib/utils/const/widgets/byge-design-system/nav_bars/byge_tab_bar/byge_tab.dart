import 'package:flutter/material.dart';
import '../../theme/spacing.dart';

class BygeTab extends StatelessWidget {
  final String? text;
  final Widget? icon;
  final Widget? child;
  final EdgeInsetsGeometry iconMargin;
  final double height;

  const BygeTab(
      {super.key,
      this.text,
      this.icon,
      this.child,
      this.iconMargin = const EdgeInsets.only(bottom: AppSpaces.xs),
      this.height = AppSpaces.l});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Tab(
        text: text,
        icon: icon,
        iconMargin: iconMargin,
        height: height,
        child: child,
      ),
    );
  }
}
