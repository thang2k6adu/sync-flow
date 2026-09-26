// Icon (or image) above, label below - like the Rocket example
import 'package:flutter/material.dart';

/// Icon + label dọc (icon trên, text dưới)
/// - [icon]: widget biểu diễn hình (Image, Icon, SvgPicture...)
/// - [label]: văn bản
/// - [spacing]: khoảng cách giữa icon và label
class IconLabel extends StatelessWidget {
  final Widget icon;
  final String label;
  final double spacing;
  final TextStyle? labelStyle;
  final MainAxisAlignment alignment;

  const IconLabel({
    super.key,
    required this.icon,
    required this.label,
    this.spacing = 8,
    this.labelStyle,
    this.alignment = MainAxisAlignment.center,
  });

  @override
  Widget build(BuildContext context) {
    final TextStyle effectiveLabelStyle = labelStyle ??
        Theme.of(context)
            .textTheme
            .bodySmall!
            .copyWith(color: Colors.white, fontWeight: FontWeight.w600);
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: alignment,
      children: [
        icon,
        SizedBox(height: spacing),
        Text(label, style: effectiveLabelStyle),
      ],
    );
  }
}