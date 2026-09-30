import 'package:flutter/material.dart';
import 'package:pp191225/core/core.dart';

/// Nút bo tròn dạng viên thuốc của màn Welcome / Login.
/// Màu và hình dạng lấy từ `elevatedButtonTheme` / `outlinedButtonTheme`.
/// [filled] = true: nền primary, chữ trắng. false: nền trắng, viền và chữ primary.
class BrandButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool filled;

  const BrandButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.filled = true,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: AppDimens.buttonHeight,
      child: filled
          ? ElevatedButton(
              onPressed: onPressed,
              child: Text(label, style: AppTextStyles.button),
            )
          : OutlinedButton(
              onPressed: onPressed,
              child: Text(label, style: AppTextStyles.buttonOutlined),
            ),
    );
  }
}
