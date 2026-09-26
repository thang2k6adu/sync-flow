// base_paginated_notifier.dart
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pp191225/data/models/base/api_response.dart';

/// Response wrapper for paginated API calls
class CachedPage<T> {
  final T data;
  final DateTime timestamp;

  CachedPage({required this.data, required this.timestamp});
}

abstract class PaginatedResponse<T> {
  List<T> get data;
  bool get hasNext;
}

/// Standard implementation of PaginatedResponse that wraps ApiResponse<PaginatedData<T>>
/// This is the standard response format from backend API
class ApiPaginatedResponse<T> implements PaginatedResponse<T> {
  final ApiResponse<PaginatedData<T>> _response;

  const ApiPaginatedResponse(this._response);

  @override
  List<T> get data {
    // Nếu có error hoặc data null, return empty list
    if (_response.error || _response.data == null) {
      return [];
    }
    return _response.data!.items;
  }

  @override
  bool get hasNext {
    // Nếu có error hoặc data null, return false
    if (_response.error || _response.data == null) {
      return false;
    }
    final meta = _response.data!.meta;
    final items = _response.data!.items;

    // Calculate hasNext based on current page and total pages
    // If totalPages is 0 (no meta from API), use heuristic
    if (meta.totalPages == 0) {
      // No pagination metadata from API
      // Assume there's more data if we got a full page of items
      // (i.e., items.length equals itemsPerPage limit)
      return items.length >= meta.itemsPerPage;
    }

    return meta.currentPage < meta.totalPages;
  }

  /// Expose error info for logging/debugging
  bool get hasError => _response.error;
  String? get errorMessage => _response.error ? _response.message : null;
}

/// Base class cho các list có phân trang, search, load more, refresh
abstract class BasePaginatedNotifier<T> extends AsyncNotifier<List<T>> {
  int _page = 1;
  bool _hasNext = true;
  bool _isLoadingMore = false;
  bool _isBackgroundFetching = false; // Flag để track background fetch
  String? _search;

  static const int limit = 10;

  final Map<String, CachedPage<List<T>>> _cache = {};
  static const _cacheTTL = Duration(minutes: 5);

  /// Concrete class cần implement: fetch 1 page từ API và trả về response với pagination
  Future<PaginatedResponse<T>> fetchPage({
    required int page,
    required int limit,
    String? search,
  });

  /// Generate cache key based on runtime type and search query
  /// Subclasses can override this to provide custom cache keys
  @protected
  String getCacheKey(String? search) {
    final feedName = runtimeType.toString();
    if (search != null && search.isNotEmpty) return "${feedName}_$search";
    return feedName;
  }

  /// Update cache with current state
  @protected
  void updateCacheWithCurrentState([String? search]) {
    final cacheKey = getCacheKey(search ?? _search);
    final currentData = state.value;
    if (currentData != null) {
      _cache[cacheKey] = CachedPage(
        data: currentData,
        timestamp: DateTime.now(),
      );
    }
  }

  @override
  Future<List<T>> build() async {
    return fetchData(reset: true, search: _search);
  }

  /// Fetch dữ liệu (có handle reset, pagination)
  Future<List<T>> fetchData({bool reset = false, String? search}) async {
    final cacheKey = getCacheKey(search);

    if (reset) {
      _page = 1;
      _hasNext = true;
      _search = search;

      final cached = _cache[cacheKey];
      if (cached != null &&
          DateTime.now().difference(cached.timestamp) < _cacheTTL) {
        state = AsyncData(cached.data);
        // fetch background
        _fetchAndUpdateCacheInBackground(reset: true, search: search);
        return cached.data;
      }

      state = const AsyncLoading();
    } else if (!_hasNext) {
      return state.value ?? [];
    }

    if (!reset) _isLoadingMore = true;

    try {
      final response = await fetchPage(
        page: _page,
        limit: limit,
        search: _search,
      );

      final newData = response.data;
      _hasNext = response.hasNext;
      if (_hasNext) _page++;

      // Kết hợp với list hiện tại
      final updatedList = <T>[if (!reset) ...(state.value ?? []), ...newData];

      state = AsyncData(updatedList);

      _cache[cacheKey] = CachedPage(
        data: updatedList,
        timestamp: DateTime.now(),
      );

      return updatedList;
    } catch (e, st) {
      state = AsyncError(e, st);
      return [];
    } finally {
      _isLoadingMore = false;
    }
  }

  /// Fetch and update cache in background without blocking UI
  /// Only updates state if it hasn't changed (to avoid overwriting optimistic updates)
  Future<void> _fetchAndUpdateCacheInBackground({
    bool reset = false,
    String? search,
  }) async {
    // Prevent duplicate background fetches
    if (_isBackgroundFetching) return;
    _isBackgroundFetching = true;

    final initialState = state;
    
    try {
      final response = await fetchPage(
        page: reset ? 1 : _page,
        limit: limit,
        search: search,
      );
      final updatedList = <T>[...response.data];
      final cacheKey = getCacheKey(search);

      print('state: $state');

      // Only update state if it hasn't changed (avoid overwriting optimistic updates)
      if (state == initialState) {
        state = AsyncData(updatedList);
      }
        // state = AsyncData(updatedList);
      
      // Always update cache
      _cache[cacheKey] = CachedPage(
        data: updatedList,
        timestamp: DateTime.now(),
      );
    } catch (_) {
      // Silent fail for background updates
    } finally {
      _isBackgroundFetching = false;
    }
  }

  /// Load thêm page kế tiếp
  Future<void> loadMore() async {
    // Check cả isLoadingMore và isBackgroundFetching để tránh duplicate calls
    if (!_hasNext || _isLoadingMore || _isBackgroundFetching) return;
    await fetchData();
  }

  /// Refresh toàn bộ dữ liệu
  Future<void> refresh() async {
    await fetchData(reset: true);
  }

  /// Clear all cache
  void clearCache() {
    _cache.clear();
  }

  /// Invalidate cache for specific search query or all cache if search is null
  void invalidateCache([String? search]) {
    if (search != null) {
      _cache.remove(getCacheKey(search));
    } else {
      clearCache();
    }
  }

  // --- Getters ---
  /// Check xem có đang loading (bao gồm cả background fetch)
  bool get isLoadingMore => _isLoadingMore || _isBackgroundFetching;
  
  /// Check xem đang fetch ở background không
  bool get isBackgroundFetching => _isBackgroundFetching;
  
  bool get hasNext => _hasNext;
  int get currentPage => _page;
  String? get searchQuery => _search;
}

/// Mixin cho các notifier cần update item trong list
mixin ListItemUpdateMixin<T> on AsyncNotifier<List<T>> {
  /// Update một item trong list dựa trên id
  /// [identify] - function để identify item cần update
  /// [update] - function để update item
  void updateItem(bool Function(T item) identify, T Function(T item) update) {
    final currentList = state.value ?? [];
    final updatedList = currentList.map((item) {
      if (identify(item)) {
        return update(item);
      }
      return item;
    }).toList();

    state = AsyncData(updatedList);
    
    // Update cache if this is a paginated notifier
    if (this is BasePaginatedNotifier) {
      (this as BasePaginatedNotifier).updateCacheWithCurrentState();
    }
  }

  /// Update item và await cho async operation, sau đó update lại theo kết quả
  Future<void> updateItemAsync(
    bool Function(T item) identify,
    T Function(T item) setPending,
    Future<bool> Function() operation,
    T Function(T item, bool success) updateResult,
  ) async {
    // 1) Optimistic update: set pending
    updateItem(identify, setPending);

    // 2) Perform operation
    final success = await operation();

    // 3) Get current list after optimistic update
    final currentList = state.value ?? [];

    // 4) Update item based on operation result
    final updatedList = currentList.map((item) {
      if (identify(item)) {
        return updateResult(item, success);
      }
      return item;
    }).toList();

    // 5) Set state
    state = AsyncData(updatedList);
    
    // 6) Update cache if this is a paginated notifier
    if (this is BasePaginatedNotifier) {
      (this as BasePaginatedNotifier).updateCacheWithCurrentState();
    }
  }
}
