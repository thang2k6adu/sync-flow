import 'package:flutter/material.dart';
import 'package:pp191225/core/theme/app_fonts.dart';
import 'package:pp191225/core/theme/app_theme.dart';

class HomeSearchBar extends StatelessWidget {
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onClear;
  final VoidCallback? onTap;

  const HomeSearchBar({
    super.key,
    this.controller,
    this.onChanged,
    this.onClear,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.themeColors;
    final hasText = controller?.text.isNotEmpty ?? false;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: colors.border, width: 1.2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: TextField(
          controller: controller,
          onChanged: onChanged,
          onTap: onTap,
          style: TextStyle(
            fontFamily: AppFonts.poppins,
            fontSize: 13,
            color: colors.textMain,
          ),
          decoration: InputDecoration(
            hintText: 'Tìm kiếm bộ từ, chủ đề, từ vựng...',
            hintStyle: TextStyle(
              fontFamily: AppFonts.poppins,
              fontSize: 13,
              color: colors.textSub.withOpacity(0.7),
            ),
            prefixIcon: Icon(
              Icons.search_rounded,
              color: colors.textSub,
              size: 20,
            ),
            suffixIcon: hasText
                ? IconButton(
                    icon: Icon(Icons.close_rounded, size: 18, color: colors.textSub),
                    onPressed: () {
                      controller?.clear();
                      onClear?.call();
                    },
                  )
                : null,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 14),
          ),
        ),
      ),
    );
  }
}
