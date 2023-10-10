import 'package:flutter/material.dart';
import 'toggle_button.dart';
import '../theme/spacing.dart';

class ToggleExamples extends StatefulWidget {
  const ToggleExamples({super.key});

  @override
  State<ToggleExamples> createState() => _ToggleExamples();
}

class _ToggleExamples extends State<ToggleExamples> {
  bool toggled = false;
  bool toggledEnglish = false;
  bool toggledLongLabel = false;

  void setToggle(bool? value) {
    if (value == null) {
      return;
    }
    setState(() {
      toggled = value;
    });
  }

  void setToggleEnglish(bool? value) {
    if (value == null) {
      return;
    }
    setState(() {
      toggledEnglish = value;
    });
  }

  void setToggledLongLabel(bool? value) {
    if (value == null) {
      return;
    }
    setState(() {
      toggledLongLabel = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpaces.m),
      child: Center(
        child: Column(
          children: [
            BygeToggleButton(
              toggled: toggled,
              toggleText: 'Active',
              onChanged: setToggle,
            ),
            const SizedBox(height: 20),
            BygeToggleButton(
              toggled: toggledEnglish,
              toggleText: 'Aktiv',
              onChanged: setToggleEnglish,
            ),
            const SizedBox(height: 20),
            BygeToggleButton(
              toggled: toggledLongLabel,
              toggleText: 'Activeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee',
              onChanged: setToggledLongLabel,
            ),
          ],
        ),
      ),
    );
  }
}
