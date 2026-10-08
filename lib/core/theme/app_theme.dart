import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pp191225/core/constants/app_dimens.dart';
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
  final Color mintDark;
  final Color amber;
  final Color amberDark;
  final Color coral;
  final Color coralDark;

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
    required this.mintDark,
    required this.amber,
    required this.amberDark,
    required this.coral,
    required this.coralDark,
  });

  static const light = AppThemeColors(
    background: Color(0xFFF7F7FA),
    surface: Colors.white,
    surfaceMuted: Color(0xFFF3F1FA),
    border: Color(0xFFE8E5F3),
    borderStrong: Color(0xFFDDD8ED),
    textMain: Color(0xFF1E1B39),
    textSub: Color(0xFF747094),
    brand: Color(0xFF7F57C8),
    brandDark: Color(0xFF5E3A9B),
    brandSoft: Color(0xFFF5F1FD),
    brandBorder: Color(0xFFDDD2F6),
    brandBase: Color(0xFFCFC0F0),
    mint: Color(0xFF58CC02),
    mintDark: Color(0xFF46A302),
    amber: Color(0xFFFFC800),
    amberDark: Color(0xFFE5A500),
    coral: Color(0xFFFF4B4B),
    coralDark: Color(0xFFD33131),
  );

  static const dark = AppThemeColors(
    background: Color(0xFF13141B),
    surface: Color(0xFF1D1E2C),
    surfaceMuted: Color(0xFF27293C),
    border: Color(0xFF2D3048),
    borderStrong: Color(0xFF3F4363),
    textMain: Color(0xFFF3F2F8),
    textSub: Color(0xFF9EA3B8),
    brand: Color(0xFF8E68D6),
    brandDark: Color(0xFF633EAA),
    brandSoft: Color(0xFF2B2544),
    brandBorder: Color(0xFF483A6D),
    brandBase: Color(0xFF382B57),
    mint: Color(0xFF58CC02),
    mintDark: Color(0xFF3D8C01),
    amber: Color(0xFFFFC800),
    amberDark: Color(0xFFB88500),
    coral: Color(0xFFFF4B4B),
    coralDark: Color(0xFFB82828),
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
    Color? mintDark,
    Color? amber,
    Color? amberDark,
    Color? coral,
    Color? coralDark,
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
      mintDark: mintDark ?? this.mintDark,
      amber: amber ?? this.amber,
      amberDark: amberDark ?? this.amberDark,
      coral: coral ?? this.coral,
      coralDark: coralDark ?? this.coralDark,
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
      mintDark: Color.lerp(mintDark, other.mintDark, t)!,
      amber: Color.lerp(amber, other.amber, t)!,
      amberDark: Color.lerp(amberDark, other.amberDark, t)!,
      coral: Color.lerp(coral, other.coral, t)!,
      coralDark: Color.lerp(coralDark, other.coralDark, t)!,
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

  static final ThemeData lightTheme = _buildLightTheme();
  static final ThemeData darkTheme = _buildDarkTheme();

  static ThemeData _buildLightTheme() {
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

  static ThemeData _buildDarkTheme() {
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
        color: subColor,
      ),
      labelLarge: TextStyle(
        fontFamily: AppFonts.poppins,
        fontSize: 15,
        fontWeight: FontWeight.w600,
        height: 1.3,
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
        fontSize: 11,
        fontWeight: FontWeight.w500,
        height: 1.3,
        color: subColor,
      ),
    );
  }
}
