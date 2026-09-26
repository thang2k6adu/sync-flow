// Pill tag with thumbnail and label (e.g., "Art")
import 'package:flutter/material.dart';
import 'package:pp191225/core/theme/app_colors.dart';

/// Pill tag có thumbnail nhỏ ở trái, label ở phải, border nhẹ.
/// - [thumbnail]: widget nhỏ ở trái (Image, Icon, Container...)
/// - [label]: văn bản
/// - [backgroundColor]: màu nền
/// - [borderColor]: màu viền
class PillTag extends StatelessWidget {
  final Widget thumbnail;
  final String label;
  final Color backgroundColor;
  final Color borderColor;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry padding;

  const PillTag({
    super.key,
    required this.thumbnail,
    required this.label,
    this.backgroundColor = AppColors.white,
    this.borderColor = const Color(0xFFE5E7EB),
    this.textStyle,
    this.padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
  });

  @override
  Widget build(BuildContext context) {
    final TextStyle effectiveTextStyle = textStyle ??
        Theme.of(context)
            .textTheme
            .bodySmall!
            .copyWith(color: Colors.black, fontWeight: FontWeight.w500);
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor, width: 1.2),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // thumbnail should be compact
          SizedBox(width: 20, height: 20, child: ClipRRect(borderRadius: BorderRadius.circular(6), child: thumbnail)),
          const SizedBox(width: 8),
          Text(label, style: effectiveTextStyle),
        ],
      ),
    );
  }
}