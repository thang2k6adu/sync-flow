import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pp191225/core/constants/app_dimens.dart';
import 'package:pp191225/core/theme/app_colors.dart';
import 'package:pp191225/core/theme/app_fonts.dart';

/// Bảng màu ngữ nghĩa thích ứng Light/Dark mode cho Sync Flow
@immutable
class AppThemeColors extends ThemeExtension<AppThemeColors> {
  final Color background;
  final Color surface;
  final Color surfaceMuted;
  final Color border;
  final Color borderStrong;
  final Color textMain;
  final Color textSub;
  final Color brand;
  final Color brandDark;
  final Color brandSoft;
  final Color brandBorder;
  final Color brandBase;
  final Color mint;
  final Color amber;
  final Color coral;

  const AppThemeColors({
    required this.background,
    required this.surface,
    required this.surfaceMuted,
    required this.border,
    required this.borderStrong,
    required this.textMain,
    required this.textSub,
    required this.brand,
    required this.brandDark,
    required this.brandSoft,
    required this.brandBorder,
    required this.brandBase,
    required this.mint,
    required this.amber,
    required this.coral,
  });

  static const light = AppThemeColors(
    background: Color(0xFFFAFAFE),
    surface: Colors.white,
    surfaceMuted: Color(0xFFF6F5FB),
    border: Color(0xFFECEAF5),
    borderStrong: Color(0xFFDEDAEB),
    textMain: Color(0xFF1E1B39),
    textSub: Color(0xFF747094),
    brand: Color(0xFF5F33E1),
    brandDark: Color(0xFF3B1A99),
    brandSoft: Color(0xFFF4F0FF),
    brandBorder: Color(0xFFDACDFE),
    brandBase: Color(0xFFC7B4FA),
    mint: Color(0xFF00C48C),
    amber: Color(0xFFF59E0B),
    coral: Color(0xFFF43F5E),
  );

  static const dark = AppThemeColors(
    background: Color(0xFF0F0E17),
    surface: Color(0xFF1A1829),
    surfaceMuted: Color(0xFF242238),
    border: Color(0xFF2A2742),
    borderStrong: Color(0xFF3A365B),
    textMain: Color(0xFFF5F3FF),
    textSub: Color(0xFFA5A1C8),
    brand: Color(0xFF7C5CFC),
    brandDark: Color(0xFF4B2EAF),
    brandSoft: Color(0xFF262046),
    brandBorder: Color(0xFF42377A),
    brandBase: Color(0xFF322A5E),
    mint: Color(0xFF10B981),
    amber: Color(0xFFFBBF24),
    coral: Color(0xFFFB7185),
  );

  @override
  AppThemeColors copyWith({
    Color? background,
    Color? surface,
    Color? surfaceMuted,
    Color? border,
    Color? borderStrong,
    Color? textMain,
    Color? textSub,
    Color? brand,
    Color? brandDark,
    Color? brandSoft,
    Color? brandBorder,
    Color? brandBase,
    Color? mint,
    Color? amber,
    Color? coral,
  }) {
    return AppThemeColors(
      background: background ?? this.background,
      surface: surface ?? this.surface,
      surfaceMuted: surfaceMuted ?? this.surfaceMuted,
      border: border ?? this.border,
      borderStrong: borderStrong ?? this.borderStrong,
      textMain: textMain ?? this.textMain,
      textSub: textSub ?? this.textSub,
      brand: brand ?? this.brand,
      brandDark: brandDark ?? this.brandDark,
      brandSoft: brandSoft ?? this.brandSoft,
      brandBorder: brandBorder ?? this.brandBorder,
      brandBase: brandBase ?? this.brandBase,
      mint: mint ?? this.mint,
      amber: amber ?? this.amber,
      coral: coral ?? this.coral,
    );
  }

  @override
  AppThemeColors lerp(ThemeExtension<AppThemeColors>? other, double t) {
    if (other is! AppThemeColors) return this;
    return AppThemeColors(
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      surfaceMuted: Color.lerp(surfaceMuted, other.surfaceMuted, t)!,
      border: Color.lerp(border, other.border, t)!,
      borderStrong: Color.lerp(borderStrong, other.borderStrong, t)!,
      textMain: Color.lerp(textMain, other.textMain, t)!,
      textSub: Color.lerp(textSub, other.textSub, t)!,
      brand: Color.lerp(brand, other.brand, t)!,
      brandDark: Color.lerp(brandDark, other.brandDark, t)!,
      brandSoft: Color.lerp(brandSoft, other.brandSoft, t)!,
      brandBorder: Color.lerp(brandBorder, other.brandBorder, t)!,
      brandBase: Color.lerp(brandBase, other.brandBase, t)!,
      mint: Color.lerp(mint, other.mint, t)!,
      amber: Color.lerp(amber, other.amber, t)!,
      coral: Color.lerp(coral, other.coral, t)!,
    );
  }
}

extension AppThemeContextExtension on BuildContext {
  AppThemeColors get themeColors {
    return Theme.of(this).extension<AppThemeColors>() ??
        (Theme.of(this).brightness == Brightness.dark
            ? AppThemeColors.dark
            : AppThemeColors.light);
  }

  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;
}

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme {
    const colors = AppThemeColors.light;
    return ThemeData(
      brightness: Brightness.light,
      fontFamily: AppFonts.poppins,
      scaffoldBackgroundColor: colors.background,
      canvasColor: colors.surface,
      cardColor: colors.surface,
      dividerColor: colors.border,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      colorScheme: ColorScheme.light(
        primary: colors.brand,
        onPrimary: Colors.white,
        secondary: colors.brandSoft,
        onSecondary: colors.brand,
        surface: colors.surface,
        onSurface: colors.textMain,
        error: colors.coral,
        onError: Colors.white,
      ),
      extensions: const [colors],
      appBarTheme: AppBarTheme(
        backgroundColor: colors.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        iconTheme: IconThemeData(color: colors.textMain),
        titleTextStyle: TextStyle(
          fontFamily: AppFonts.poppins,
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: colors.textMain,
        ),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: colors.surface,
        selectedItemColor: colors.brand,
        unselectedItemColor: const Color(0xFFAFAFAF),
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.brand,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimens.buttonRadius),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colors.brand,
          side: BorderSide(color: colors.brand),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimens.buttonRadius),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: colors.brand),
      ),
      textTheme: _buildTextTheme(colors.textMain, colors.textSub),
    );
  }

  static ThemeData get darkTheme {
    const colors = AppThemeColors.dark;
    return ThemeData(
      brightness: Brightness.dark,
      fontFamily: AppFonts.poppins,
      scaffoldBackgroundColor: colors.background,
      canvasColor: colors.surface,
      cardColor: colors.surface,
      dividerColor: colors.border,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      colorScheme: ColorScheme.dark(
        primary: colors.brand,
        onPrimary: Colors.white,
        secondary: colors.brandSoft,
        onSecondary: colors.textMain,
        surface: colors.surface,
        onSurface: colors.textMain,
        error: colors.coral,
        onError: Colors.white,
      ),
      extensions: const [colors],
      appBarTheme: AppBarTheme(
        backgroundColor: colors.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        iconTheme: IconThemeData(color: colors.textMain),
        titleTextStyle: TextStyle(
          fontFamily: AppFonts.poppins,
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: colors.textMain,
        ),
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: colors.surface,
        selectedItemColor: colors.brand,
        unselectedItemColor: const Color(0xFF757193),
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.brand,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimens.buttonRadius),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colors.brand,
          side: BorderSide(color: colors.brand),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimens.buttonRadius),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: colors.brand),
      ),
      textTheme: _buildTextTheme(colors.textMain, colors.textSub),
    );
  }

  static TextTheme _buildTextTheme(Color mainColor, Color subColor) {
    return TextTheme(
      displayLarge: TextStyle(
        fontFamily: AppFonts.poppins,
        fontSize: 36,
        fontWeight: FontWeight.w700,
        height: 1.15,
        letterSpacing: -0.2,
        color: mainColor,
      ),
      headlineLarge: TextStyle(
        fontFamily: AppFonts.poppins,
        fontSize: 26,
        fontWeight: FontWeight.w600,
        height: 1.2,
        letterSpacing: -0.2,
        color: mainColor,
      ),
      headlineMedium: TextStyle(
        fontFamily: AppFonts.poppins,
        fontSize: 24,
        fontWeight: FontWeight.w600,
        height: 1.25,
        color: mainColor,
      ),
      headlineSmall: TextStyle(
        fontFamily: AppFonts.poppins,
        fontSize: 20,
        fontWeight: FontWeight.w600,
        height: 1.3,
        color: mainColor,
      ),
      titleLarge: TextStyle(
        fontFamily: AppFonts.poppins,
        fontSize: 16,
        fontWeight: FontWeight.w600,
        height: 1.4,
        color: mainColor,
      ),
      titleMedium: TextStyle(
        fontFamily: AppFonts.poppins,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        height: 1.4,
        color: subColor,
      ),
      titleSmall: TextStyle(
        fontFamily: AppFonts.poppins,
        fontSize: 12,
        fontWeight: FontWeight.w400,
        height: 1.4,
        color: subColor,
      ),
      bodyLarge: TextStyle(
        fontFamily: AppFonts.poppins,
        fontSize: 18,
        fontWeight: FontWeight.w400,
        height: 1.55,
        letterSpacing: 0.15,
        color: mainColor,
      ),
      bodyMedium: TextStyle(
        fontFamily: AppFonts.poppins,
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.5,
        letterSpacing: 0.15,
        color: mainColor,
      ),
      bodySmall: TextStyle(
        fontFamily: AppFonts.poppins,
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.45,
        letterSpacing: 0.14,
        color: subColor,
      ),
      labelLarge: TextStyle(
        fontFamily: AppFonts.poppins,
        fontSize: 16,
        fontWeight: FontWeight.w600,
        height: 1.4,
        letterSpacing: 0.4,
        color: mainColor,
      ),
      labelMedium: TextStyle(
        fontFamily: AppFonts.poppins,
        fontSize: 13,
        fontWeight: FontWeight.w500,
        height: 1.3,
        color: subColor,
      ),
      labelSmall: TextStyle(
        fontFamily: AppFonts.poppins,
        fontSize: 12,
        fontWeight: FontWeight.w500,
        height: 1.2,
        letterSpacing: 0.4,
        color: subColor,
      ),
    );
  }
}
