// USAGE
// import 'package:{your_app}/byge-design-system/labels/byge_label.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'byge_label.dart';
import '../theme/spacing.dart';

class BygeLabelExamples extends StatelessWidget {
  const BygeLabelExamples({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const BygeLabel(
          label: 'With Icon',
          icon: Icon(Icons.arrow_upward),
        ),
        const SizedBox(height: AppSpaces.l),
        BygeLabel(
          label: 'With SVG',
          icon: SvgPicture.asset('assets/svg/arrow_up.svg'),
        ),
        const SizedBox(height: AppSpaces.l),
        const BygeLabel(
          label: 'Without icon',
        ),
      ],
    );
  }
}
