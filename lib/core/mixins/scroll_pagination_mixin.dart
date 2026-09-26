import 'dart:async';
import 'package:flutter/material.dart';

/// Mixin để handle scroll pagination cho các StatefulWidget
/// 
/// Usage:
/// ```dart
/// class _MyListState extends State<MyList> with ScrollPaginationMixin {
///   @override
///   Future<void> Function() get onLoadMore => () async {
///     await ref.read(myProvider.notifier).loadMore();
///   }
///   
///   @override
///   bool Function() get hasNext => () => ref.read(myProvider.notifier).hasNext;
///   
///   @override
///   bool Function() get isLoadingMore => () => ref.read(myProvider.notifier).isLoadingMore;
/// }
/// ```
mixin ScrollPaginationMixin<T extends StatefulWidget> on State<T> {
  ScrollController? _scrollController;
  bool _isCheckingFullScreen = false;
  Timer? _debounceTimer;
  DateTime? _lastLoadMoreTime;
  
  /// Callback để load more data khi scroll gần cuối
  Future<void> Function() get onLoadMore;
  
  /// Check xem còn data để load không
  /// Default: true (luôn cho phép load more nếu không override)
  bool Function() get hasNext => () => true;
  
  /// Check xem đang loading more không
  /// Default: false (không check loading state nếu không override)
  bool Function() get isLoadingMore => () => false;
  
  /// Threshold (pixels) để trigger load more khi scroll gần cuối
  /// Default: 200
  double get scrollThreshold => 200;
  
  /// Minimum interval giữa các lần gọi loadMore (debounce)
  /// Default: 300ms
  Duration get loadMoreDebounce => const Duration(milliseconds: 300);
  
  /// ScrollController được quản lý bởi mixin
  ScrollController get scrollController {
    _scrollController ??= ScrollController();
    return _scrollController!;
  }
  
  @override
  void initState() {
    super.initState();
    _setupScrollListener();
  }
  
  @override
  void dispose() {
    _debounceTimer?.cancel();
    _scrollController?.removeListener(_onScroll);
    _scrollController?.dispose();
    super.dispose();
  }
  
  /// Setup scroll listener
  void _setupScrollListener() {
    scrollController.addListener(_onScroll);
  }
  
  /// Handle scroll event - trigger loadMore khi gần cuối (có debounce)
  void _onScroll() {
    if (!scrollController.hasClients) return;
    
    final position = scrollController.position;
    if (position.pixels >= position.maxScrollExtent - scrollThreshold) {
      _triggerLoadMoreWithDebounce();
    }
  }
  
  /// Trigger loadMore với debounce để tránh duplicate calls
  void _triggerLoadMoreWithDebounce() {
    // Skip if loading or no more data
    if (!hasNext() || isLoadingMore()) return;
    
    // Rate limit check
    if (_lastLoadMoreTime != null) {
      final elapsed = DateTime.now().difference(_lastLoadMoreTime!);
      if (elapsed < loadMoreDebounce) {
        return; // Too soon, skip
      }
    }
    
    // Cancel pending timer
    _debounceTimer?.cancel();
    
    // Set debounce timer
    _debounceTimer = Timer(loadMoreDebounce, () {
      if (!mounted) return;
      
      // Double check before calling
      if (hasNext() && !isLoadingMore()) {
        _lastLoadMoreTime = DateTime.now();
        onLoadMore();
      }
    });
  }
  
  /// Check và load more nếu list chưa đầy màn hình
  /// Nên gọi sau khi:
  /// - Initial load complete
  /// - Refresh complete
  /// - Sau khi data thay đổi
  void checkLoadMoreIfListNotFull() {
    if (_isCheckingFullScreen) return;
    _isCheckingFullScreen = true;
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _isCheckingFullScreen = false;
      if (!mounted || !scrollController.hasClients) return;
      
      final position = scrollController.position;
      if (position.maxScrollExtent <= position.viewportDimension) {
        // List chưa đầy màn hình - check debounce
        if (!hasNext() || isLoadingMore()) return;
        
        // Rate limit check
        if (_lastLoadMoreTime != null) {
          final elapsed = DateTime.now().difference(_lastLoadMoreTime!);
          if (elapsed < loadMoreDebounce) {
            // Schedule retry after debounce period
            Future.delayed(loadMoreDebounce - elapsed, () {
              if (mounted) checkLoadMoreIfListNotFull();
            });
            return;
          }
        }
        
        _lastLoadMoreTime = DateTime.now();
        onLoadMore().then((_) {
          // Recursive check sau khi load xong
          if (mounted) checkLoadMoreIfListNotFull();
        });
      }
    });
  }
  
  /// Remove scroll listener (nếu cần tạm thời disable)
  void removeScrollListener() {
    _scrollController?.removeListener(_onScroll);
  }
  
  /// Add scroll listener lại (sau khi remove)
  void addScrollListener() {
    _scrollController?.addListener(_onScroll);
  }
}

