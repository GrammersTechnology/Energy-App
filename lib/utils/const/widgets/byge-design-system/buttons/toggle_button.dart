import 'package:flutter/cupertino.dart';
import '../theme/colors.dart';
import '../theme/spacing.dart';
import '../theme/text_styles.dart';

typedef ToggleOnChange = void Function(bool? value);

class BygeToggleButton extends StatefulWidget {
  final bool toggled;
  final String toggleText;
  final ToggleOnChange onChanged;

  const BygeToggleButton({
    super.key,
    required this.toggled,
    required this.toggleText,
    required this.onChanged,
  });

  @override
  State<BygeToggleButton> createState() => _BygeToggleButtonState();
}

class _BygeToggleButtonState extends State<BygeToggleButton> {
  double minHeight = 60.0;
  double maxWidth = 60.0;
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        // 60.0 = height of Switch widget + Text widget in Figma
        minHeight: minHeight,
        maxWidth: maxWidth,
      ),
      child: Column(
        children: [
          CupertinoSwitch(
            value: widget.toggled,
            onChanged: widget.onChanged,
            activeColor: primary,
            thumbColor: onPrimary,
            trackColor: onSurfaceVariant,
          ),
          // Show text if switch is active
          if (widget.toggled)
            Padding(
              /// Add left and right padding in case of long translation in order to avoid the word taking up
              /// the entire width of the Switch widget (including the "white space")
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpaces.xs + 2,
              ),
              child: Text(
                widget.toggleText,
                style: labelSmall.copyWith(
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
