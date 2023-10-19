import 'package:flutter/material.dart';
import '../theme/borders.dart';
import '../theme/spacing.dart';

class BygeInputField extends StatefulWidget {
  final String placeholder;
  final String? initialValue;
  final String suffix;
  final Function(String)? onEditingComplete;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final bool enabled;
  final Color? placeholderColor;

  const BygeInputField({
    Key? key,
    required this.placeholder,
    this.placeholderColor,
    this.initialValue,
    this.suffix = '',
    this.onEditingComplete,
    this.keyboardType = TextInputType.text,
    this.controller,
    this.enabled = true,
  }) : super(key: key);

  @override
  State<BygeInputField> createState() => _BygeInputFieldState();
}

class _BygeInputFieldState extends State<BygeInputField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      _controller = TextEditingController(text: widget.initialValue ?? '');
    } else {
      _controller = widget.controller!;
    }
  }

  @override
  void didUpdateWidget(covariant BygeInputField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      if (widget.controller == null) {
        _controller = TextEditingController(text: widget.initialValue ?? '');
        return;
      }
      _controller = widget.controller!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    final onSurfaceVariant = Theme.of(context).colorScheme.onSurfaceVariant;
    final textStyle = Theme.of(context).textTheme.labelLarge;
    final hintStyle = Theme.of(context).textTheme.bodyLarge;
    final suffixStyle = Theme.of(context).textTheme.bodyMedium;

    return TextFormField(
      keyboardType: widget.keyboardType,
      enabled: widget.enabled,
      controller: _controller,
      style: textStyle,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpaces.m,
          vertical: AppSpaces.s,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(AppBorders.borderRadius),
          ),
          borderSide: BorderSide(
              color: onSurface, width: AppBorders.highlightedBorderWidth),
        ),
        border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(AppBorders.borderRadius),
          ),
          borderSide: BorderSide(color: onSurface),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(AppBorders.borderRadius),
          ),
          borderSide: BorderSide(color: onSurface),
        ), // your color
        hintText: widget.placeholder,

        prefixStyle: textStyle,
        hintStyle: hintStyle?.copyWith(
            color: widget.placeholderColor ?? onSurfaceVariant),
        suffix: Text(widget.suffix),
        suffixStyle: suffixStyle?.copyWith(color: onSurfaceVariant),
      ),
      onEditingComplete: () {
        if (widget.onEditingComplete != null) {
          widget.onEditingComplete!(_controller.text);
        }
        FocusScope.of(context).unfocus();
      },
    );
  }
}
