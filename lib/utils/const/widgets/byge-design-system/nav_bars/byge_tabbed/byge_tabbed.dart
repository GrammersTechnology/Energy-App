import 'package:flutter/material.dart';

import '../../theme/spacing.dart';
import '../../theme/borders.dart';

class BygeTabbedWidgets extends StatefulWidget {
  final List<Widget> widgets;
  final List<String> tabNames;
  final double maxContentHeight;
  final int animationSpeed;

  const BygeTabbedWidgets({
    super.key,
    required this.widgets,
    required this.tabNames,
    this.maxContentHeight = 400,
    this.animationSpeed = 300,
    this.onControllerCreated,
  }) : assert(tabNames.length == widgets.length);

  final void Function(PageController)? onControllerCreated;

  @override
  State<BygeTabbedWidgets> createState() => _TabbedWidgetsState();
}

class _TabbedWidgetsState extends State<BygeTabbedWidgets> {
  late PageController _pageController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
    if (widget.onControllerCreated != null) {
      widget.onControllerCreated!(_pageController);
    }
  }

  @override
  Widget build(BuildContext context) {
    final surfaceColor = Theme.of(context).colorScheme.surface;
    final onSurfaceColor = Theme.of(context).colorScheme.onSurface;
    final labelSmall = Theme.of(context).textTheme.labelSmall;

    return Column(
      children: [
        // Tabs/ Content
        ConstrainedBox(
          constraints: BoxConstraints(maxHeight: widget.maxContentHeight),
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.widgets.length,
            onPageChanged: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return widget.widgets[index];
            },
          ),
        ),
        const SizedBox(height: AppSpaces.l),
        Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppBorders.borderRadius),
          ),
          foregroundDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppBorders.borderRadius),
            border: Border.all(
              width: AppBorders.borderWidth,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          child: Row(
            children: widget.tabNames.asMap().entries.map((entry) {
              int tabIndex = entry.key;
              String name = entry.value;

              Border border = const Border();

              // Right border to divide each tab, except for the last one
              if (tabIndex != widget.tabNames.length - 1) {
                border = Border(
                  right: BorderSide(
                    color: onSurfaceColor,
                  ),
                );
              }

              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    _pageController
                        .animateToPage(
                      tabIndex,
                      duration: Duration(milliseconds: widget.animationSpeed),
                      curve: Curves.easeInOut,
                    )
                        .then((_) {
                      setState(() {
                        _selectedIndex = tabIndex;
                      });
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: AppSpaces.xs),
                    decoration: BoxDecoration(
                      color: _selectedIndex == tabIndex
                          ? onSurfaceColor
                          : surfaceColor,
                      border: border,
                    ),
                    child: Center(
                      child: Text(
                        name,
                        style: _selectedIndex == tabIndex
                            ? labelSmall?.copyWith(color: surfaceColor)
                            : labelSmall,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
