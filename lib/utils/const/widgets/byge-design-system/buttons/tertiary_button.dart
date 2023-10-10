import 'package:flutter/material.dart';
import '../theme/borders.dart';
import '../theme/spacing.dart';

class BygeTertiaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final double minWidth;
  final IconData? icon;

  const BygeTertiaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.minWidth = double.infinity,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).colorScheme.onSurface;
    final leadingText = Theme.of(context).textTheme.labelLarge;

    return ConstrainedBox(
      constraints: BoxConstraints(minWidth: minWidth),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppBorders.borderRadius),
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: AppSpaces.s,
            horizontal: AppSpaces.m,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(icon, color: textColor),
                const SizedBox(
                  width: AppSpaces.xs,
                ), // spacing between icon and text
              ],
              const SizedBox(width: AppSpaces.xxs),
              Flexible(
                child: Text(label, style: leadingText),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
