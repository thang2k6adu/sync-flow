import 'dart:math';
import 'dart:ui';

String convertToCompactFormNumber(num value, {int digits = 2}) {
  if (value == 0) return '0';

  final List<Map<String, dynamic>> lookup = [
    {'value': 1, 'symbol': ''},
    {'value': 1e3, 'symbol': 'K'},
    {'value': 1e6, 'symbol': 'M'},
    {'value': 1e9, 'symbol': 'B'},
    {'value': 1e12, 'symbol': 'T'},
    {'value': 1e15, 'symbol': 'G'},
    {'value': 1e18, 'symbol': 'E'},
  ];

  if (value >= 1e18) {
    return value.toStringAsExponential(digits);
  }

  final item = lookup.lastWhere(
    (item) => value >= item['value'],
    orElse: () => {'value': 1, 'symbol': ''},
  );

  final formattedValue = (value / item['value']);

  final displayValue = formattedValue % 1 == 0
      ? formattedValue.toStringAsFixed(0)
      : formattedValue
            .toStringAsFixed(digits)
            .replaceAll(RegExp(r'\.?0+$'), '');

  return '$displayValue${item['symbol']}';
}

double roundDown(num number, int decimalPlaces) {
  double factor = pow(10, decimalPlaces).toDouble();
  return (number * factor).truncateToDouble() / factor;
}

int convertLevelToIndex(int number, int size) {
  return number ~/ size;
}

List<Color> adjustOpacityGradient({
  required List<Color> colors,
  double minOpacity = 0.5,
}) {
  int n = colors.length;
  if (n == 0) return [];

  List<Color> result = [];
  result.add(colors[0].withOpacity(1.0));

  if (n == 1) return result;

  for (int i = 1; i < n; i++) {
    double opacity = 1.0 - (i - 1) * ((1.0 - minOpacity) / (n - 2));
    if (opacity < minOpacity) opacity = minOpacity;

    result.add(colors[i].withOpacity(opacity));
  }

  return result;
}


String formatNumberWithCommas(num value, {int decimalDigits = 2}) {
  // Làm tròn số với decimalDigits chữ số sau dấu phẩy
  String fixed = value.toStringAsFixed(decimalDigits);

  // Tách phần nguyên và phần thập phân
  List<String> parts = fixed.split('.');
  String integerPart = parts[0];
  String decimalPart = parts.length > 1 ? parts[1] : '';

  // Thêm dấu phẩy phân tách phần nghìn
  final buffer = StringBuffer();
  for (int i = 0; i < integerPart.length; i++) {
    int positionFromEnd = integerPart.length - i;
    buffer.write(integerPart[i]);
    if (positionFromEnd > 1 && positionFromEnd % 3 == 1) {
      buffer.write(',');
    }
  }

  // Trả kết quả
  return decimalPart.isNotEmpty
      ? '${buffer.toString()}.$decimalPart'
      : buffer.toString();
}