import 'dart:ui';
import 'package:intl/intl.dart';

/// Enum để chọn locale tiền tệ
enum CurrencyLocale {
  vietnam, // ₫ ở bên phải, dấu thập phân kiểu Việt Nam
  us,      // $ ở bên trái, dấu thập phân kiểu US
}

/// Utility class format tiền tệ
class CurrencyFormatter {
  /// Format số thành tiền tệ
  /// [value] : số cần format
  /// [locale] : chọn enum CurrencyLocale
  /// [symbol] : override ký hiệu tiền tệ (mặc định tự chọn theo locale)
  /// [decimalDigits] : số chữ số thập phân
  static String format(
    num value, {
    CurrencyLocale? locale,
    String? symbol,
    int decimalDigits = 2,
  }) {
    // Lấy locale từ enum
    final CurrencyLocale usedLocale = locale ?? _getSystemLocale();

    String localeString;
    String defaultSymbol;

    switch (usedLocale) {
      case CurrencyLocale.vietnam:
        localeString = 'vi_VN';
        defaultSymbol = '₫';
        break;
      case CurrencyLocale.us:
        localeString = 'en_US';
        defaultSymbol = '\$';
        break;
    }

    final NumberFormat formatter = NumberFormat.currency(
      locale: localeString,
      symbol: symbol ?? defaultSymbol,
      decimalDigits: decimalDigits,
    );

    return formatter.format(value);
  }

  /// Tự động lấy locale hệ thống
  static CurrencyLocale _getSystemLocale() {
    final String lang = window.locale.languageCode.toLowerCase();
    if (lang == 'vi') return CurrencyLocale.vietnam;
    return CurrencyLocale.us;
  }
}
