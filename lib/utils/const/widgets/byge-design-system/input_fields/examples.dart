// USAGE
// import 'package:{your_app}/byge-design-system/input_fields/byge_input_field.dart';

import 'package:flutter/material.dart';
import '../theme/spacing.dart';
import 'byge_input_field.dart';

class InputFieldExamples extends StatelessWidget {
  InputFieldExamples({super.key});
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppSpaces.m),
      child: Center(
        child: ListView(
          children: [
            const BygeInputField(placeholder: 'No Suffix'),
            const SizedBox(height: AppSpaces.m),
            const BygeInputField(placeholder: 'With Suffix', suffix: 'kwt'),
            const SizedBox(height: AppSpaces.m),
            BygeInputField(
              placeholder: 'With onEditingComplete',
              suffix: 'kwt',
              onEditingComplete: (text) {
                // Get the text value from the input field
                print(text);
              },
            ),
            const SizedBox(height: AppSpaces.m),
            BygeInputField(
              placeholder: 'Custom Controller',
              suffix: 'kwt',
              controller: _controller,
              onEditingComplete: (_) {
                // Access the text directly from the custom controller
                print(_controller.text);
              },
            ),
            const SizedBox(height: AppSpaces.m),
            BygeInputField(
              placeholder: 'Prefilled',
              suffix: 'kwt',
              initialValue: 'Prefilled',
              onEditingComplete: (text) {
                print(text);
              },
            ),
            const SizedBox(height: AppSpaces.m),
            BygeInputField(
              placeholder: 'Custom keyboard type',
              suffix: 'kwt',
              keyboardType: TextInputType.number,
              initialValue: 'Custom keyboard type',
              onEditingComplete: (text) {
                print(text);
              },
            ),
            const SizedBox(height: AppSpaces.m),
            const BygeInputField(
              enabled: false,
              placeholder: 'Disabled',
            ),
          ],
        ),
      ),
    );
  }
}
