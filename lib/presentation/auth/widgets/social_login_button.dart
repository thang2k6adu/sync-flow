import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pp191225/core/core.dart';

/// Nút tròn đăng nhập mạng xã hội (Google / Facebook / GitHub).
class SocialLoginButton extends StatelessWidget {
  final String? svgAsset;
  final IconData? icon;
  final VoidCallback onPressed;
  final String tooltip;

  const SocialLoginButton({
    super.key,
    this.svgAsset,
    this.icon,
    required this.onPressed,
    required this.tooltip,
  }) : assert(svgAsset != null || icon != null);

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: onPressed,
        customBorder: const CircleBorder(),
        child: Container(
          width: AppDimens.socialButtonSize,
          height: AppDimens.socialButtonSize,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.white,
            border: Border.all(color: AppColors.primary),
          ),
          child: svgAsset != null
              ? SvgPicture.asset(svgAsset!, height: AppDimens.socialIconSize)
              : Icon(icon, size: AppDimens.socialIconSize, color: AppColors.black),
        ),
      ),
    );
  }
}
