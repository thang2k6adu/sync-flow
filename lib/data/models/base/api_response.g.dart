// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ApiResponse<T> _$ApiResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) => _ApiResponse<T>(
  error: json['error'] as bool? ?? false,
  code: (json['code'] as num?)?.toInt() ?? 0,
  message: json['message'] as String? ?? 'Success',
  data: _$nullableGenericFromJson(json['data'], fromJsonT),
  traceId: json['traceId'] as String?,
);

Map<String, dynamic> _$ApiResponseToJson<T>(
  _ApiResponse<T> instance,
  Object? Function(T value) toJsonT,
) => <String, dynamic>{
  'error': instance.error,
  'code': instance.code,
  'message': instance.message,
  'data': _$nullableGenericToJson(instance.data, toJsonT),
  'traceId': instance.traceId,
};

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) => input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) => input == null ? null : toJson(input);

_PaginatedData<T> _$PaginatedDataFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) => _PaginatedData<T>(
  items: (json['items'] as List<dynamic>?)?.map(fromJsonT).toList() ?? const [],
  meta: PaginationMeta.fromJson(json['meta'] as Map<String, dynamic>),
);

Map<String, dynamic> _$PaginatedDataToJson<T>(
  _PaginatedData<T> instance,
  Object? Function(T value) toJsonT,
) => <String, dynamic>{
  'items': instance.items.map(toJsonT).toList(),
  'meta': instance.meta,
};

_PaginationMeta _$PaginationMetaFromJson(
  Map<String, dynamic> json,
) => _PaginationMeta(
  itemCount: PaginationMeta._readEither(json, 'item_count') == null
      ? 0
      : PaginationMeta._toInt(PaginationMeta._readEither(json, 'item_count')),
  totalItems: PaginationMeta._readEither(json, 'total_items') == null
      ? 0
      : PaginationMeta._toInt(PaginationMeta._readEither(json, 'total_items')),
  itemsPerPage: PaginationMeta._readEither(json, 'items_per_page') == null
      ? 10
      : PaginationMeta._toInt(
          PaginationMeta._readEither(json, 'items_per_page'),
        ),
  totalPages: PaginationMeta._readEither(json, 'total_pages') == null
      ? 0
      : PaginationMeta._toInt(PaginationMeta._readEither(json, 'total_pages')),
  currentPage: PaginationMeta._readEither(json, 'current_page') == null
      ? 1
      : PaginationMeta._toInt(PaginationMeta._readEither(json, 'current_page')),
);

Map<String, dynamic> _$PaginationMetaToJson(_PaginationMeta instance) =>
    <String, dynamic>{
      'item_count': instance.itemCount,
      'total_items': instance.totalItems,
      'items_per_page': instance.itemsPerPage,
      'total_pages': instance.totalPages,
      'current_page': instance.currentPage,
    };
