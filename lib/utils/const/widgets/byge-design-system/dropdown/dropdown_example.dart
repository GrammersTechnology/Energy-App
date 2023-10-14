// USAGE
// import 'package:{your_app}/byge-design-system/dropdown/byge_dropdown.dart';


import 'package:flutter/material.dart';
import 'byge_dropdown.dart';

class DropdownExample extends StatelessWidget {
  const DropdownExample({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> entries = ['Item1', 'Item2', 'Item3', 'Item4'];
    const String hint = 'Select an item';

    return Row(
      children: [
        BygeDropdown(
          dropdownEntry: entries,
          dropdownHint: hint,
          onSelected: (value) {
            print('Default');
          },
        ),
      ],
    );
  }
}
