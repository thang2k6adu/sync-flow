import 'package:flutter/material.dart';
import 'package:pp191225/core/theme/app_theme.dart';

/// Pill tag phong cách Chunky (Duolingo Style):
/// - Nổi nhẹ với viền 1.5px và bo tròn hình viên thuốc.
/// - Đồng bộ Theme Colors (Light & Dark).
class PillTag extends StatelessWidget {
  final Widget? thumbnail;
  final String label;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? textColor;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry padding;

  const PillTag({
    super.key,
    this.thumbnail,
    required this.label,
    this.backgroundColor,
    this.borderColor,
    this.textColor,
    this.textStyle,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.themeColors;
    final bg = backgroundColor ?? colors.surfaceMuted;
    final border = borderColor ?? colors.border;
    final textCol = textColor ?? colors.textMain;

    final TextStyle effectiveTextStyle = textStyle ??
        TextStyle(
          color: textCol,
          fontSize: 13,
          fontWeight: FontWeight.w700,
        );

    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: border, width: 2),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (thumbnail != null) ...[
            SizedBox(
              width: 18,
              height: 18,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: thumbnail!,
              ),
            ),
            const SizedBox(width: 6),
          ],
          Text(label, style: effectiveTextStyle),
        ],
      ),
    );
  }
}
