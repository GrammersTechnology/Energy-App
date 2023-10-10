import 'package:flutter/material.dart';
import 'expandable_card.dart';
import '../checkbox/checkbox.dart';

class ExpandableCardExamples extends StatefulWidget {
  const ExpandableCardExamples({
    super.key,
  });

  @override
  State<ExpandableCardExamples> createState() => _ExpandableCardExamples();
}

class _ExpandableCardExamples extends State<ExpandableCardExamples> {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(24.0),
      child: Center(
        child: Column(
          children: [
            BygeExpandableCard(
              title:
                  'Here is a veeeeeery, veeeeeery, veeeeeeeeeeeeeeery long title',
              subtitle:
                  'Logg ut, bytt passord og samtykke. Logg ut, bytt passord og samtykke. Logg ut, bytt passord og samtykke. Logg ut, bytt passord og samtykke. Logg ut, bytt passord og samtykke',
              child: ExpandableCardContent(),
            ),
            SizedBox(
              height: 16,
            ),
            BygeExpandableCard(
              //
              title: 'Pushvarslinger',
              child: ExpandableCardContent(),
            ),
            SizedBox(
              height: 16,
            ), //
            BygeExpandableCard(
              title: 'Din konto',
              subtitle: 'Logg ut, bytt passord og samtykke',
              child: ExpandableCardContent(),
            ),
            // overflows on example should use listview
            SizedBox(
              height: 16,
            ),
            BygeExpandableCard(
              title: 'Ditt hjem',
              subtitle: 'Informasjon om din bolig, strømleverandør og forbruk',
              child: ExpandableCardContent(),
            ),
          ],
        ),
      ),
    );
  }
}

/// Copy of checkbox_examples.dart, but with padding removed
class ExpandableCardContent extends StatefulWidget {
  const ExpandableCardContent({super.key});

  @override
  State<ExpandableCardContent> createState() => _ExpandableCardContent();
}

class _ExpandableCardContent extends State<ExpandableCardContent> {
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
    return Center(
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
          const SizedBox(
            height: 20,
          ),
          BygeCheckbox(
            initialValue: checked,
            label: 'Default',
            onChanged: setChecked,
            checkboxSemanticLabel: 'testing checkboxSemanticLabel',
          ),
          const SizedBox(
            height: 20,
          ),
          BygeCheckbox(
            initialValue: longVal,
            label: 'Fixed width with an veeeeeeeeery long name',
            onChanged: setLong,
          ),
        ],
      ),
    );
  }
}
