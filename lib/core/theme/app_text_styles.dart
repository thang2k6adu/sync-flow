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

  static final TextStyle link = body.copyWith(color: AppColors.primary);

  static final TextStyle fieldHint = body.copyWith(color: AppColors.gray[5]);

  static final TextStyle small = _base.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.gray[5],
  );

  static final TextStyle smallLink = small.copyWith(color: AppColors.primary);

  static final TextStyle button = _base.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.white,
  );

  static final TextStyle buttonOutlined = button.copyWith(color: AppColors.primary);

  // --------------------------------------------------------------------------
  // Thang chữ theo Figma (Poppins). Tên: <nhóm><Weight>, ví dụ h1Regular,
  // bodyBaseMedium, captionLargeBold. Giá trị Figma dạng "cỡ chữ/line-height".
  // Không đặt màu, màu lấy từ DefaultTextStyle hoặc .copyWith(color: ...).
  // --------------------------------------------------------------------------

  static TextStyle _scale(double size, double lineHeight, FontWeight weight) =>
      _base.copyWith(
        fontSize: size,
        height: lineHeight / size,
        fontWeight: weight,
      );

  // Heading / H1: 48/58
  static final TextStyle h1Regular = _scale(48, 58, FontWeight.w400);
  static final TextStyle h1Medium = _scale(48, 58, FontWeight.w500);
  static final TextStyle h1SemiBold = _scale(48, 58, FontWeight.w600);
  static final TextStyle h1Bold = _scale(48, 58, FontWeight.w700);

  // Heading / H2: 40/50
  static final TextStyle h2Regular = _scale(40, 50, FontWeight.w400);
  static final TextStyle h2Medium = _scale(40, 50, FontWeight.w500);
  static final TextStyle h2SemiBold = _scale(40, 50, FontWeight.w600);
  static final TextStyle h2Bold = _scale(40, 50, FontWeight.w700);

  // Heading / H3: 33/43
  static final TextStyle h3Regular = _scale(33, 43, FontWeight.w400);
  static final TextStyle h3Medium = _scale(33, 43, FontWeight.w500);
  static final TextStyle h3SemiBold = _scale(33, 43, FontWeight.w600);
  static final TextStyle h3Bold = _scale(33, 43, FontWeight.w700);

  // Heading / H4: 28/36
  static final TextStyle h4Regular = _scale(28, 36, FontWeight.w400);
  static final TextStyle h4Medium = _scale(28, 36, FontWeight.w500);
  static final TextStyle h4SemiBold = _scale(28, 36, FontWeight.w600);
  static final TextStyle h4Bold = _scale(28, 36, FontWeight.w700);

  // Heading / H5: 23/30
  static final TextStyle h5Regular = _scale(23, 30, FontWeight.w400);
  static final TextStyle h5Medium = _scale(23, 30, FontWeight.w500);
  static final TextStyle h5SemiBold = _scale(23, 30, FontWeight.w600);
  static final TextStyle h5Bold = _scale(23, 30, FontWeight.w700);

  // Heading / H6: 19/25
  static final TextStyle h6Regular = _scale(19, 25, FontWeight.w400);
  static final TextStyle h6Medium = _scale(19, 25, FontWeight.w500);
  static final TextStyle h6SemiBold = _scale(19, 25, FontWeight.w600);
  static final TextStyle h6Bold = _scale(19, 25, FontWeight.w700);

  // Body / Base: 16/24
  static final TextStyle bodyBaseRegular = _scale(16, 24, FontWeight.w400);
  static final TextStyle bodyBaseMedium = _scale(16, 24, FontWeight.w500);
  static final TextStyle bodyBaseSemiBold = _scale(16, 24, FontWeight.w600);
  static final TextStyle bodyBaseBold = _scale(16, 24, FontWeight.w700);

  // Caption / Large: 13/18
  static final TextStyle captionLargeRegular = _scale(13, 18, FontWeight.w400);
  static final TextStyle captionLargeMedium = _scale(13, 18, FontWeight.w500);
  static final TextStyle captionLargeSemiBold = _scale(13, 18, FontWeight.w600);
  static final TextStyle captionLargeBold = _scale(13, 18, FontWeight.w700);

  // Caption / Small: 11/15
  static final TextStyle captionSmallRegular = _scale(11, 15, FontWeight.w400);
  static final TextStyle captionSmallMedium = _scale(11, 15, FontWeight.w500);
  static final TextStyle captionSmallSemiBold = _scale(11, 15, FontWeight.w600);
  static final TextStyle captionSmallBold = _scale(11, 15, FontWeight.w700);

  // Caption / XSmall: 9/12
  static final TextStyle captionXSmallRegular = _scale(9, 12, FontWeight.w400);
  static final TextStyle captionXSmallMedium = _scale(9, 12, FontWeight.w500);
  static final TextStyle captionXSmallSemiBold = _scale(9, 12, FontWeight.w600);
  static final TextStyle captionXSmallBold = _scale(9, 12, FontWeight.w700);
}
