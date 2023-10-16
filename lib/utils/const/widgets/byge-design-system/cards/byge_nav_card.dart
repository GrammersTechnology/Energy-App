import 'package:flutter/material.dart';
import '../theme/borders.dart';
import '../theme/shadows.dart';
import '../theme/spacing.dart';

class BygeNavCard extends StatelessWidget {
  final String title;
  final Widget child;
  final Widget destination;
  final IconData iconData;
  final double iconSize;

  const BygeNavCard({
    Key? key,
    required this.title,
    required this.child,
    required this.destination,
    this.iconData = Icons.arrow_forward_ios_sharp,
    this.iconSize = 20,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => destination),
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppSpaces.m),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(AppBorders.borderRadius),
          boxShadow: const [AppShadows.baseShadow],
        ),
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            minHeight: 50,
          ),
          child: IntrinsicHeight(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ),
                    const SizedBox(width: AppSpaces.s),
                    Icon(iconData, size: iconSize),
                  ],
                ),
                const SizedBox(height: AppSpaces.s),
                child,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
