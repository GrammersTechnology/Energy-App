// USAGE 
// import 'package:{your_app}/byge-design-system/buttons/primary_button.dart';

import 'package:flutter/material.dart';
import 'primary_button.dart';
import 'secondary_button.dart';
import 'tertiary_button.dart';
import '../theme/spacing.dart';

class ButtonExamples extends StatelessWidget {
  const ButtonExamples({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpaces.m),
      child: Column(
        children: [
          BygePrimaryButton(
            label: 'Default',
            onPressed: () {
              print('Default');
            },
          ),
          const SizedBox(height: 20),
          BygePrimaryButton(
            label: 'With Icon',
            icon: Icons.propane,
            onPressed: () {
              print('With Icon');
            },
          ),
          const SizedBox(height: 20),
          BygePrimaryButton(
            minWidth: 250.0,
            label: 'Fixed Width',
            icon: Icons.propane,
            onPressed: () {
              print('Fixed Width');
            },
          ),
          const SizedBox(height: 20),
          BygePrimaryButton(
            minWidth: 250.0,
            label: 'Fixed width with an veeeeeeeeery long name',
            icon: Icons.access_alarm,
            onPressed: () {
              print('Fixed width with an veeeeeeeeery long name');
            },
          ),
          const SizedBox(height: 20),
          BygeSecondaryButton(
            label: 'Defualt',
            onPressed: () {
              print('With Icon');
            },
          ),
          const SizedBox(height: 20),
          BygeSecondaryButton(
            label: 'With Icon',
            icon: Icons.propane,
            onPressed: () {
              print('With Icon');
            },
          ),
          const SizedBox(height: 20),
          BygeSecondaryButton(
            minWidth: 250.0,
            label: 'Fixed Width',
            icon: Icons.propane,
            onPressed: () {
              print('Fixed Width');
            },
          ),
          const SizedBox(height: 20),
          BygeSecondaryButton(
            minWidth: 250.0,
            label: 'Fixed width with an veeeeeeeeery long name',
            icon: Icons.access_alarm,
            onPressed: () {
              print('Fixed width with an veeeeeeeeery long name');
            },
          ),
          const SizedBox(height: 20),
          BygeTertiaryButton(
            label: 'Default',
            onPressed: () {
              print('Fixed width with an veeeeeeeeery long name');
            },
          ),
          const SizedBox(height: 20),
          BygeTertiaryButton(
            label: 'With Icon',
            icon: Icons.access_alarm,
            onPressed: () {
              print('Fixed width with an veeeeeeeeery long name');
            },
          ),
          const SizedBox(height: 20),
          BygeTertiaryButton(
            minWidth: 250.0,
            label: 'Fixed width',
            icon: Icons.access_alarm,
            onPressed: () {
              print('Fixed width with an veeeeeeeeery long name');
            },
          ),
          const SizedBox(height: 20),
          BygeTertiaryButton(
            minWidth: 250.0,
            label: 'Fixed width with an veeeeeeeeery long name',
            icon: Icons.access_alarm,
            onPressed: () {
              print('Fixed width with an veeeeeeeeery long name');
            },
          ),
        ],
      ),
    );
  }
}
