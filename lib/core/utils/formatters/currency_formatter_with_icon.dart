import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Widget format tiền tệ với icon image
class CurrencyFormatterWithIcon extends StatelessWidget {
  final num value;
  final String iconPath; // đường dẫn asset cho icon tiền tệ
  final String locale; // 'vi_VN' hoặc 'en_US'
  final int decimalDigits;
  final double iconWidth;
  final double iconHeight;
  final double spacing;
  final Color? color;
  final FontWeight? fontWeight;
  final double? fontSize;

  const CurrencyFormatterWithIcon({
    super.key,
    required this.value,
    required this.iconPath,
    this.locale = 'vi_VN',
    this.decimalDigits = 2,
    this.iconWidth = 16,
    this.iconHeight = 16,
    this.spacing = 4,
    this.color = Colors.white,
    this.fontWeight = FontWeight.w500,
    this.fontSize = 14,
  });

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat.currency(
      locale: locale,
      symbol: '', // bỏ ký hiệu text
      decimalDigits: decimalDigits,
    );

    final formattedValue = formatter.format(value);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(iconPath, width: iconWidth, height: iconHeight),
        SizedBox(width: spacing),
        Text(
          formattedValue,
          style: TextStyle(
            color: color,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
