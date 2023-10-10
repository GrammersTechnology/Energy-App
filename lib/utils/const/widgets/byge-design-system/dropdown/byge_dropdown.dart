// IMPORTANT: The DropdownMenu-widget is wrapped in a LayoutBuilder-widget and
// an Flexible-widget to set the DropdownMenu's width to that of
// the parent. The parent needs to have some sort of size.
// This will become redundant when Flutter v.14 is released.

import 'package:flutter/material.dart';
import '../theme/spacing.dart';
import '../theme/borders.dart';

typedef DropdownOnSelected = void Function(String? value);

class BygeDropdown extends StatefulWidget {
  const BygeDropdown({
    super.key,
    required this.dropdownEntry,
    required this.dropdownHint,
    required this.onSelected,
  });

  final List<String> dropdownEntry;
  final String dropdownHint;
  final DropdownOnSelected onSelected;

  @override
  State<BygeDropdown> createState() => _BygeDropdownState();
}

class _BygeDropdownState extends State<BygeDropdown> {
  @override
  Widget build(BuildContext context) {
    // Necessary to convert the list of Strings to a list of DropdownMenuEntry<String>
    final List<DropdownMenuEntry<String>> dropdownEntries =
        <DropdownMenuEntry<String>>[];
    for (final String entry in widget.dropdownEntry) {
      dropdownEntries.add(
        DropdownMenuEntry<String>(value: entry, label: entry),
      );
    }

    final hintTextStyle = Theme.of(context).textTheme.bodyLarge;
    final menuEntryStyle = Theme.of(context).textTheme.labelLarge;
    final onSurfaceVariant = Theme.of(context).colorScheme.onSurfaceVariant;
    final onSurface = Theme.of(context).colorScheme.onSurface;

    // Expanded ensures the DropdownMenu does not overflow in width
    // LayoutBuilder retrieves the width and height constraints of the parent widget
    return Flexible(
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return DropdownMenu(
            width: constraints
                .maxWidth, // Width is set based on the parent widget's maxWidth
            textStyle: menuEntryStyle?.copyWith(color: onSurface),
            trailingIcon: Icon(
              Icons.keyboard_arrow_down,
              color: onSurface,
              semanticLabel: 'Closed dropdown icon',
            ), // Icon before you open the dropdown
            selectedTrailingIcon: Icon(
              Icons.keyboard_arrow_up_sharp,
              color: onSurface,
              semanticLabel: 'Opened dropdown icon',
            ), // Icon after you open the dropdown
            dropdownMenuEntries: dropdownEntries,
            menuStyle: MenuStyle(
              elevation: MaterialStateProperty.all(0.0),
            ),
            hintText: widget.dropdownHint,
            inputDecorationTheme: InputDecorationTheme(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppSpaces.m,
                vertical: AppSpaces.s,
              ),
              hintStyle: hintTextStyle?.copyWith(color: onSurfaceVariant),
              enabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  Radius.circular(AppBorders.borderRadius),
                ),
                borderSide: BorderSide(
                  color: onSurface,
                  width: AppBorders.borderWidth,
                ),
              ),
            ),
            onSelected: widget.onSelected,
          );
        },
      ),
    );
  }
}
