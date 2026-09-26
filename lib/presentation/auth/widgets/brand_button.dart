import 'package:flutter/material.dart';
import 'package:pp191225/core/core.dart';

/// Nút bo tròn dạng viên thuốc của màn Welcome / Login.
/// [filled] = true: nền tím, chữ trắng. false: nền trắng, viền và chữ tím.
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
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppDimens.buttonRadius),
    );

    return SizedBox(
      width: double.infinity,
      height: AppDimens.buttonHeight,
      child: filled
          ? ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.brand,
                foregroundColor: AppColors.white,
                elevation: 0,
                shape: shape,
              ),
              child: Text(label, style: AppTextStyles.button),
            )
          : OutlinedButton(
              onPressed: onPressed,
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.brand,
                side: const BorderSide(color: AppColors.brand),
                shape: shape,
              ),
              child: Text(label, style: AppTextStyles.buttonOutlined),
            ),
    );
  }
}
