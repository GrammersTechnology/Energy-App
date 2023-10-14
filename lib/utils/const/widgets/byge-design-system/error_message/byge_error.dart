import 'package:flutter/material.dart';
import '../theme/borders.dart';
import '../theme/colors.dart';
import '../theme/spacing.dart';

class _BygeErrorBar extends StatelessWidget {
  const _BygeErrorBar({required this.title, required this.message});

  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      color: highIndicatorBackgroundColor,
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppBorders.borderRadius),
        side: const BorderSide(
          width: AppBorders.borderWidth,
          color: highIndicatorBorderColor,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: AppSpaces.m,
          horizontal: AppSpaces.m,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: errorTextColor,
                    ),
                  ),
                ),
                // const Spacer(),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: errorTextColor),
                  ),
                  child: const Icon(
                    Icons.question_mark_sharp,
                    color: errorTextColor,
                    size: 16,
                  ),
                ),
              ],
            ),
            Text(
              message,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: errorTextColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BygeError {
  static void show({
    required BuildContext context,
    required String title,
    required String message,
    bool clearBeforeShowing = false,
    int displayDuration = 4000,
  }) {
    final errorSnackBar = SnackBar(
      content: _BygeErrorBar(title: title, message: message),
      backgroundColor: Colors.transparent,
      // use 4000 as default value as flutter expected Duration and not Duration?
      // therefore duration: null using the Snackbars internal default value is not possible
      duration: Duration(milliseconds: displayDuration),
      elevation: 0,
    );
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    if (clearBeforeShowing && scaffoldMessenger.mounted) {
      // clears entire queue as we want to force this message to be the next
      clearMessageQueue(context);
    }
    scaffoldMessenger.showSnackBar(errorSnackBar);
  }

  // removes the current error message displaying
  static void removeMessage(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }

  // clear the queue of waiting messages
  static void clearMessageQueue(BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();
  }
}
