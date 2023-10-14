import 'package:flutter/material.dart';
import '../../theme/borders.dart';
import '../../theme/spacing.dart';

class BygeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Text? title;
  final List<Widget>? actions;
  final bool showBackButton;
  final String backButtonText;
  final PreferredSizeWidget? bottom;

  const BygeAppBar({
    super.key,
    this.title,
    this.actions,
    this.showBackButton = true,
    this.backButtonText = 'Tilbake',
    this.bottom,
  });

  @override
  Size get preferredSize => const Size.fromHeight(AppSpaces.appBar);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title,
      actions: actions,
      leadingWidth: AppSpaces.appBarLeading,
      leading: showBackButton ? AppBarBack(text: backButtonText) : null,
      bottom: bottom,
    );
  }
}

class AppBarBack extends StatelessWidget {
  const AppBarBack({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final leadingText = Theme.of(context).textTheme.labelLarge;
    return InkWell(
      borderRadius: BorderRadius.circular(AppBorders.borderRadius),
      onTap: () {
        Navigator.pop(context);
      },
      child: Padding(
        padding: const EdgeInsets.only(left: AppSpaces.s),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.arrow_back_ios, size: 18),
            Text(text, style: leadingText),
          ],
        ),
      ),
    );
  }
}
