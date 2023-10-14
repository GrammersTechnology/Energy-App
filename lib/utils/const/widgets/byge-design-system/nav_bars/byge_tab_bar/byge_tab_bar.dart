import 'package:flutter/material.dart';
import '../../theme/borders.dart';

class BygeTabBar extends StatelessWidget implements PreferredSizeWidget {
  const BygeTabBar({
    super.key,
    required this.tabs,
    this.controller,
    this.isScrollable = false,
    this.indicatorColor,
    this.padding = EdgeInsets.zero,
  });

  final List<Widget> tabs;
  final TabController? controller;
  final bool isScrollable;
  final Color? indicatorColor;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: padding,
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppBorders.borderRadius),
            border: Border.all(color: theme.colorScheme.onSurface)),
        child: TabBar(
          tabs: tabs,
          controller: controller,
          isScrollable: isScrollable,
          indicatorColor: indicatorColor,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
