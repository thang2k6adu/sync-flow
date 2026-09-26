import 'package:flutter/material.dart';
import 'package:pp191225/core/theme/app_colors.dart';
import 'package:pp191225/core/theme/app_fonts.dart';

/// Text style của các màn auth (Welcome / Login), dùng font Poppins
class AppTextStyles {
  AppTextStyles._();

  static const TextStyle _base = TextStyle(fontFamily: AppFonts.poppins);

  static final TextStyle screenTitle = _base.copyWith(
    fontSize: 32,
    fontWeight: FontWeight.w600,
    color: AppColors.black,
  );

  static final TextStyle sheetTitle = _base.copyWith(
    fontSize: 30,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static final TextStyle sheetSubtitle = _base.copyWith(
    fontSize: 14,
    height: 1.5,
    color: AppColors.textSecondary,
  );

  static final TextStyle body = _base.copyWith(
    fontSize: 16,
    color: AppColors.black,
  );

  static final TextStyle link = body.copyWith(color: AppColors.brand);

  static final TextStyle fieldHint = body.copyWith(color: AppColors.gray[5]);

  static final TextStyle small = _base.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.gray[5],
  );

  static final TextStyle smallLink = small.copyWith(color: AppColors.brand);

  static final TextStyle button = _base.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.white,
  );

  static final TextStyle buttonOutlined = button.copyWith(color: AppColors.brand);
}
