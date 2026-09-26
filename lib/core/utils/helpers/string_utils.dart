extension SafeStringExtension on String {
  String substringSafe(int start, [int? end]) {
    if (start >= length) return '';
    return substring(start, end != null ? end.clamp(0, length) : length);
  }
}

extension FirstWhereOrNullExtension<E> on Iterable<E> {
  E? firstWhereOrNull(bool Function(E element) test) {
    for (var element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}

extension StringExtension on String {
  String capitalize() {
  if (isEmpty) return this;
  return '${this[0].toUpperCase()}${substring(1)}';
  }
}
