import 'package:flutter/material.dart';
import '../theme/spacing.dart';
import '../theme/borders.dart';

typedef CheckboxOnChange = void Function(bool? value);

class BygeCheckbox extends StatefulWidget {
  const BygeCheckbox({
    super.key,
    required this.initialValue,
    required this.label,
    required this.onChanged,
    this.checkboxSemanticLabel,
    this.minWidth = double.infinity,
    this.enabled = true,
  });

  final bool initialValue;
  final String label;
  final CheckboxOnChange onChanged;
  final double minWidth;
  final String? checkboxSemanticLabel;
  final bool? enabled;

  @override
  State<BygeCheckbox> createState() => _BygeCheckbox();
}

class _BygeCheckbox extends State<BygeCheckbox> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final onSurface = theme.colorScheme.onSurface;
    final statusColor =
        widget.enabled == true ? onSurface : theme.colorScheme.onSurfaceVariant;

    return ConstrainedBox(
      constraints: BoxConstraints(minWidth: widget.minWidth),
      child: Theme(
        data: theme.copyWith(
          // removes splashColor as this overflows the border
          splashColor: Colors.transparent,
        ),
        // InkWell to allow borders to be unaffected by the onpressed color
        child: SizedBox(
          height: 60,
          child: CheckboxListTile(
            tileColor: theme.colorScheme.surface,
            activeColor: onSurface,
            enabled: widget.enabled,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppBorders.borderRadius),
              side: BorderSide(
                width: AppBorders.borderWidth,
                color: statusColor,
              ),
            ),
            value: widget.initialValue,
            onChanged: widget.onChanged,
            contentPadding: const EdgeInsets.symmetric(
              // vertical: AppSpaces.s,
              horizontal: AppSpaces.m,
            ),

            // text for screen readers, gives some context if not provided by the user of the component
            // checkboxSemanticLabel: widget.checkboxSemanticLabel ?? widget.label,
            title: Text(
              widget.label,
              style: theme.textTheme.labelLarge?.copyWith(
                color: statusColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
