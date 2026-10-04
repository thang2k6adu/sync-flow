/// Helper tạo JSON giống hệt response của backend thật:
/// { error, code, message, data, traceId }
Map<String, dynamic> mockSuccess({
  Object? data,
  String message = 'Success',
  int code = 200,
}) {
  return {
    'error': false,
    'code': code,
    'message': message,
    'data': data,
    'traceId': 'mock-trace-id',
  };
}

/// Phân trang list `all` theo `page`/`limit`, trả về `data` dạng { items, meta }.
Map<String, dynamic> mockPaginated(
  List<Map<String, dynamic>> all, {
  required int page,
  required int limit,
  String message = 'Success',
}) {
  final safeLimit = limit < 1 ? 10 : limit;
  final safePage = page < 1 ? 1 : page;
  final totalPages = (all.length / safeLimit).ceil();
  final start = (safePage - 1) * safeLimit;
  final items = start >= all.length
      ? <Map<String, dynamic>>[]
      : all.sublist(start, (start + safeLimit).clamp(0, all.length));

  return mockSuccess(
    message: message,
    data: {
      'items': items,
      'meta': {
        'itemCount': items.length,
        'totalItems': all.length,
        'itemsPerPage': safeLimit,
        'totalPages': totalPages,
        'currentPage': safePage,
      },
    },
  );
}

int mockToInt(Object? value, int fallback) {
  if (value is int) return value;
  return int.tryParse('$value') ?? fallback;
}
