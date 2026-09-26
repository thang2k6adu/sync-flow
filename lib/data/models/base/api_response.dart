import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_response.freezed.dart';
part 'api_response.g.dart';

/// Base API Response wrapper
/// Generic type T represents the data payload
@Freezed(genericArgumentFactories: true)
abstract class ApiResponse<T> with _$ApiResponse<T> {
  const factory ApiResponse({
    @Default(false) bool error,
    @Default(0) int code,
    @Default('Success') String message,
    T? data,
    String? traceId,
  }) = _ApiResponse<T>;

  /// fromJson/toJson hỗ trợ generic T theo chuẩn Freezed
  /// Usage:
  ///   ApiResponse<User>.fromJson(
  ///     json,
  ///     (data) => User.fromJson(data as Map<String, dynamic>),
  ///   );
  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT,
  ) =>
      _$ApiResponseFromJson<T>(json, fromJsonT);

  Map<String, dynamic> toJson(
    Object? Function(T value) toJsonT,
  ) =>
      _$ApiResponseToJson<T>(this as _ApiResponse<T>, toJsonT);
}

/// Paginated data wrapper - used inside ApiResponse
/// Matches structure: { "items": [...], "meta": {...} }
@Freezed(genericArgumentFactories: true)
abstract class PaginatedData<T> with _$PaginatedData<T> {
  const factory PaginatedData({
    @Default([]) List<T> items,
    required PaginationMeta meta,
  }) = _PaginatedData<T>;

  /// Chuẩn fromJson/toJson cho trường hợp key mặc định: items + meta
  factory PaginatedData.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT,
  ) =>
      _$PaginatedDataFromJson<T>(json, fromJsonT);

  Map<String, dynamic> toJson(
    Object? Function(T value) toJsonT,
  ) =>
      _$PaginatedDataToJson<T>(this as _PaginatedData<T>, toJsonT);

  /// Helper nếu backend dùng key khác cho items/meta
  /// Example:
  ///   PaginatedData.fromDynamicJson(
  ///     json,
  ///     (item) => User.fromJson(item as Map<String, dynamic>),
  ///     dataKey: 'data',
  ///     metaKey: 'pagination',
  ///   );
  factory PaginatedData.fromDynamicJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT, {
    String dataKey = 'items',
    String metaKey = 'meta',
  }) {
    final itemsList =
        (json[dataKey] as List<dynamic>?)?.map((e) => fromJsonT(e)).toList() ??
            [];

    final rawMeta = json[metaKey];
    final meta = (rawMeta is Map<String, dynamic>)
        ? PaginationMeta.fromJson(rawMeta)
        : const PaginationMeta(); // default meta nếu không có

    return PaginatedData<T>(
      items: itemsList,
      meta: meta,
    );
  }
}

/// Pagination metadata - matches backend "meta" structure
@freezed
abstract class PaginationMeta with _$PaginationMeta {
  const factory PaginationMeta({
    @Default(0) @JsonKey(name: 'item_count', readValue: PaginationMeta._readEither, fromJson: PaginationMeta._toInt) int itemCount,
    @Default(0) @JsonKey(name: 'total_items', readValue: PaginationMeta._readEither, fromJson: PaginationMeta._toInt) int totalItems,
    @Default(10) @JsonKey(name: 'items_per_page', readValue: PaginationMeta._readEither, fromJson: PaginationMeta._toInt) int itemsPerPage,
    @Default(0) @JsonKey(name: 'total_pages', readValue: PaginationMeta._readEither, fromJson: PaginationMeta._toInt) int totalPages,
    @Default(1) @JsonKey(name: 'current_page', readValue: PaginationMeta._readEither, fromJson: PaginationMeta._toInt) int currentPage,
  }) = _PaginationMeta;

  factory PaginationMeta.fromJson(Map<String, dynamic> json) =>
      _$PaginationMetaFromJson(json);

  /// Backend (Nest/Java) trả camelCase (itemCount), bản cũ trả snake_case (item_count): đọc được cả hai.
  static Object? _readEither(Map<dynamic, dynamic> json, String snakeKey) {
    final camelKey = snakeKey.replaceAllMapped(
      RegExp(r'_([a-z])'),
      (m) => m[1]!.toUpperCase(),
    );
    return json[snakeKey] ?? json[camelKey];
  }

  static int _toInt(dynamic v) {
    if (v == null) return 0;
    if (v is int) return v;
    if (v is String) return int.tryParse(v) ?? 0;
    return 0;
  }
}

