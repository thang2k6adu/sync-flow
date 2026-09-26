import 'dart:async';
import 'package:flutter/material.dart';

/// Mixin để handle search với debounce cho các StatefulWidget
/// 
/// Usage:
/// ```dart
/// class _MySearchScreenState extends State<MySearchScreen> 
///     with SearchWithDebounceMixin {
///   final TextEditingController _searchController = TextEditingController();
///   
///   @override
///   void onSearchDebounced(String query) {
///     // Call API hoặc update provider
///     ref.read(myProvider.notifier).fetchData(reset: true, search: query);
///   }
///   
///   @override
///   Widget build(BuildContext context) {
///     return AppSearchField(
///       controller: _searchController,
///       onChanged: handleSearchChanged,
///     );
///   }
/// }
/// ```
mixin SearchWithDebounceMixin<T extends StatefulWidget> on State<T> {
  Timer? _debounce;
  String _currentQuery = '';
  
  /// Debounce duration, default 500ms
  /// Override để thay đổi duration
  Duration get debounceDuration => const Duration(milliseconds: 500);
  
  /// Current search query (updated immediately when user types)
  String get currentQuery => _currentQuery;
  
  /// Callback khi search query thay đổi (trước debounce)
  /// Override nếu cần update UI ngay lập tức
  void onSearchQueryChanged(String query) {
    setState(() {
      _currentQuery = query;
    });
  }
  
  /// Callback khi debounced search được trigger
  /// Override này để handle API call hoặc update provider
  void onSearchDebounced(String query);
  
  /// Handle search input change với debounce
  /// Sử dụng method này trong onChanged của TextField
  void handleSearchChanged(String value) {
    // Update query ngay lập tức để hiển thị text trong TextField
    onSearchQueryChanged(value);
    
    // Cancel previous timer nếu có
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    
    // Nếu query rỗng, trigger ngay lập tức
    if (value.trim().isEmpty) {
      onSearchDebounced('');
      return;
    }
    
    // Tạo timer mới để debounce
    _debounce = Timer(debounceDuration, () {
      onSearchDebounced(value.trim());
    });
  }
  
  /// Cancel debounce timer (nếu cần)
  void cancelDebounce() {
    _debounce?.cancel();
  }
  
  /// Get current debounced query (sau khi trim)
  String get debouncedQuery => _currentQuery.trim();
  
  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }
}

