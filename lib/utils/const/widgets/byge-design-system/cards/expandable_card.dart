import 'package:flutter/material.dart';
import '../theme/borders.dart';
import '../theme/spacing.dart';
import '../theme/text_styles.dart';

/// TODO: onTap --> transition for downward arrow.

class BygeExpandableCard extends StatefulWidget {
  final String title;
  final Widget child;
  final double minHeight;
  final String? subtitle;
  final double subtitleLineHeight;
  final IconData iconDataInitial;
  final IconData iconDataExpanded;
  final double iconSize;
  final int expandDurationMilliseconds;

  const BygeExpandableCard({
    super.key,
    required this.title,
    required this.child,
    this.minHeight = 72,
    this.subtitle,
    this.subtitleLineHeight = 20,
    this.iconDataInitial = Icons.keyboard_arrow_down,
    this.iconDataExpanded = Icons.keyboard_arrow_up,
    this.iconSize = 20,
    this.expandDurationMilliseconds = 500,
  });

  @override
  State<BygeExpandableCard> createState() => _BygeExpandableCardState();
}

class _BygeExpandableCardState extends State<BygeExpandableCard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    double lineHeightFontSizeRatio =
        widget.subtitleLineHeight / bodyMedium.fontSize!;
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: widget.minHeight,
      ),
      child: AnimatedContainer(
        duration: Duration(milliseconds: widget.expandDurationMilliseconds),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: AppBorders.borderWidth,
            ),
            borderRadius: BorderRadius.circular(AppBorders.borderRadius),
          ),
          child: Column(
            children: [
              InkWell(
                splashColor: Colors.transparent,
                onTap: () {
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                },
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    AppSpaces.m,
                    AppSpaces.m,
                    AppSpaces.m,
                    isExpanded ? AppSpaces.s : AppSpaces.m,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Padding(
                          // Padding between title and subtitle. No padding if there are no subtitle.
                          padding: EdgeInsets.only(
                            bottom: widget.subtitle != null ? AppSpaces.xs : 0,
                          ),
                          // Title
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  widget.title,
                                  style: labelLarge,
                                ),
                              ),
                              Icon(
                                !isExpanded
                                    ? widget.iconDataInitial
                                    : widget.iconDataExpanded,
                                size: widget.iconSize,
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Show subtitle if subtitle is provided and card is collapsed
                      if (widget.subtitle != null && !isExpanded)
                        SizedBox(
                          width: double.infinity,
                          child: Text(
                            widget.subtitle!,
                            style: bodyMedium.copyWith(
                              // Line height
                              height: lineHeightFontSizeRatio,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              // Show child widget if card is expanded
              if (isExpanded)
                Padding(
                  padding: const EdgeInsets.only(
                    left: AppSpaces.m,
                    right: AppSpaces.m,
                    bottom: AppSpaces.m,
                  ),
                  child: widget.child,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
