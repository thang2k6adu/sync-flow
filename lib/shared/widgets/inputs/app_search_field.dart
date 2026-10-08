import 'package:flutter/material.dart';
import 'package:pp191225/core/theme/app_theme.dart';

/// Ô tìm kiếm phong cách Chunky (Duolingo Style):
/// - Viền 2px dày dặn, góc bo tròn mềm mại.
/// - Thích ứng liền mạch Light/Dark mode.
class AppSearchField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final EdgeInsetsGeometry padding;
  final ValueChanged<String>? onChanged;
  final Color? backgroundColor;
  final IconData prefixIcon;
  final double borderRadius;

  const AppSearchField({
    super.key,
    this.controller,
    this.hintText = 'Tìm kiếm...',
    this.padding = const EdgeInsets.all(16),
    this.onChanged,
    this.backgroundColor,
    this.prefixIcon = Icons.search_rounded,
    this.borderRadius = 16,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.themeColors;
    final fill = backgroundColor ?? colors.surfaceMuted;

    return Padding(
      padding: padding,
      child: Container(
        decoration: BoxDecoration(
          color: fill,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(color: colors.border, width: 2),
        ),
        child: TextField(
          controller: controller,
          onChanged: onChanged,
          style: TextStyle(
            color: colors.textMain,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: colors.textSub,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
            prefixIcon: Icon(
              prefixIcon,
              color: colors.textSub,
              size: 22,
            ),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
          ),
        ),
      ),
    );
  }
}
