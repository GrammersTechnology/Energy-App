import 'package:flutter/material.dart';
import '../theme/spacing.dart';
import '../theme/borders.dart';

class BygePrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final double minWidth;
  final IconData? icon;
  final Color? color;
  final Color? borderColor;
  final Color? labelColor;

  const BygePrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.labelColor,
    this.borderColor,
    this.color,
    this.minWidth = double.infinity,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).colorScheme.onPrimary;
    final bgColor = Theme.of(context).colorScheme.primary;

    return ConstrainedBox(
      constraints: BoxConstraints(minWidth: minWidth),
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(color ?? bgColor),
          overlayColor: MaterialStateProperty.all(
            textColor.withOpacity(0.1),
          ),
          side: MaterialStateProperty.all(
            BorderSide(
                width: AppBorders.borderWidth, color: borderColor ?? textColor),
          ),
          padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(
              vertical: AppSpaces.s,
              horizontal: AppSpaces.m,
            ),
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppBorders.borderRadius),
            ),
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
                      color: labelColor ?? textColor,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
