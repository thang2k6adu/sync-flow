import 'package:pp191225/data/models/base/api_response.dart';

/// Domain-level pagination model used by usecases and presentation
class PaginatedResult<T> {
  final List<T> items;
  final PaginationMeta meta;

  const PaginatedResult({
    this.items = const [],
    required this.meta,
  });
}

extension PaginatedResultMapper<T> on PaginatedData<T> {
  PaginatedResult<T> toDomain() => PaginatedResult<T>(
        items: items,
        meta: meta,
      );
}



