// USAGE
// import 'package:{your_app}/byge-design-system/error_message/byge_error.dart';

import 'package:flutter/material.dart';
import '../buttons/primary_button.dart';
import 'byge_error.dart';

class ErrorExamples extends StatelessWidget {
  const ErrorExamples({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: BygePrimaryButton(
            label: 'Show error default',
            onPressed: () {
              BygeError.show(
                context: context,
                title: 'Title',
                message: 'error message',
              );
            },
          ),
        ),
        Center(
          child: BygePrimaryButton(
            label: 'Show error 1 second',
            onPressed: () {
              BygeError.show(
                context: context,
                title: 'Title',
                message: 'error message for 1 second',
                displayDuration: 1000,
              );
            },
          ),
        ),
        Center(
          child: BygePrimaryButton(
            label: 'Show error with long text',
            onPressed: () {
              BygeError.show(
                context: context,
                title: 'Titles can alsoooooo beeeeee looooonnngg',
                message: 'Verrrrrrrrrrrrrrrrrrrry looooooooooooooong message',
              );
            },
          ),
        ),
        Center(
          child: BygePrimaryButton(
            label: 'Force to display first ',
            onPressed: () {
              BygeError.show(
                context: context,
                title: 'Forced message',
                message: 'Important text',
                clearBeforeShowing: true,
              );
            },
          ),
        ),
        Center(
          child: BygePrimaryButton(
            label: 'Remove message',
            onPressed: () {
              BygeError.removeMessage(context);
            },
          ),
        ),
        Center(
          child: BygePrimaryButton(
            label: 'Clear queue',
            onPressed: () {
              BygeError.clearMessageQueue(context);
            },
          ),
        ),
      ],
    );
  }
}
