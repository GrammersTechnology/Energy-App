import 'package:flutter/material.dart';
import '../theme/borders.dart';
import '../theme/spacing.dart';

class BygeSecondaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final double minWidth;
  final IconData? icon;

  const BygeSecondaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.minWidth = double.infinity,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).colorScheme.onSurface;
    final bgColor = Theme.of(context).colorScheme.surface;

    return ConstrainedBox(
      constraints: BoxConstraints(minWidth: minWidth),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: bgColor,
          side: BorderSide(width: AppBorders.borderWidth, color: textColor),
          padding: const EdgeInsets.symmetric(
            vertical: AppSpaces.s,
            horizontal: AppSpaces.m,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppBorders.borderRadius),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, color: textColor),
              const SizedBox(
                width: AppSpaces.xs,
              ), // spacing between icon and text
            ],
            const SizedBox(width: AppSpaces.xxs),
            Flexible(
              child: Text(
                label,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: textColor,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
