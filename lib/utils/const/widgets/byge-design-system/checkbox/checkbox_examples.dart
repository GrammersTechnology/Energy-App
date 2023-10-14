// USAGE
// import 'package:{your_app}/byge-design-system/checkbox/checkbox.dart';

import 'package:flutter/material.dart';
import 'checkbox.dart';
import '../theme/spacing.dart';

class CheckboxExamples extends StatefulWidget {
  const CheckboxExamples({super.key});

  @override
  State<CheckboxExamples> createState() => _CheckboxExamples();
}

class _CheckboxExamples extends State<CheckboxExamples> {
  bool unchecked = false;
  bool checked = true;
  bool longVal = true;

  void setChecked(bool? value) {
    if (value == null) {
      return;
    }
    setState(() {
      checked = value;
    });
  }

  void setLong(bool? value) {
    if (value == null) {
      return;
    }
    setState(() {
      longVal = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpaces.m),
      child: Center(
        child: Column(
          children: [
            // do not change state i.e no need for onChanged doing anything
            BygeCheckbox(
              initialValue: unchecked,
              label: 'Disabled',
              onChanged: (bool? value) {
                print('Default');
              },
              enabled: false,
            ),
            const SizedBox(height: 20),
            BygeCheckbox(
              initialValue: checked,
              label: 'Default',
              onChanged: setChecked,
              checkboxSemanticLabel: 'testing checkboxSemanticLabel',
            ),
            const SizedBox(height: 20),
            BygeCheckbox(
              initialValue: longVal,
              label: 'Fixed width with an veeeeeeeeery long name',
              onChanged: setLong,
            ),
          ],
        ),
      ),
    );
  }
}
