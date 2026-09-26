import 'package:flutter/material.dart';

/// Helper class để quản lý scroll pagination cho nhiều ScrollController
/// 
/// Usage:
/// ```dart
/// final _paginationHelper = MultiScrollPaginationHelper(
///   onLoadMore: (controllerId) => _loadMoreForController(controllerId),
///   hasNext: (controllerId) => _hasNextForController(controllerId),
///   isLoadingMore: (controllerId) => _isLoadingMoreForController(controllerId),
/// );
/// 
/// _paginationHelper.setupController('following', followingScrollController);
/// ```
class MultiScrollPaginationHelper {
  final Future<void> Function(String controllerId) onLoadMore;
  final bool Function(String controllerId) hasNext;
  final bool Function(String controllerId) isLoadingMore;
  final double threshold;
  
  final Map<String, ScrollController> _controllers = {};
  final Map<String, VoidCallback> _listeners = {};
  final Map<String, bool> _isCheckingFullScreen = {};
  
  MultiScrollPaginationHelper({
    required this.onLoadMore,
    required this.hasNext,
    required this.isLoadingMore,
    this.threshold = 200,
  });
  
  /// Setup scroll controller với ID
  void setupController(String controllerId, ScrollController controller) {
    _controllers[controllerId] = controller;
    final listener = () => _onScroll(controllerId);
    _listeners[controllerId] = listener;
    controller.addListener(listener);
  }
  
  /// Remove scroll controller
  void removeController(String controllerId) {
    final controller = _controllers[controllerId];
    final listener = _listeners[controllerId];
    if (controller != null && listener != null) {
      controller.removeListener(listener);
      _controllers.remove(controllerId);
      _listeners.remove(controllerId);
    }
  }
  
  /// Dispose tất cả controllers (chỉ remove listeners, không dispose controllers)
  void dispose() {
    for (final entry in _controllers.entries) {
      final listener = _listeners[entry.key];
      if (listener != null) {
        entry.value.removeListener(listener);
      }
    }
    _controllers.clear();
    _listeners.clear();
    _isCheckingFullScreen.clear();
  }
  
  void _onScroll(String controllerId) {
    final controller = _controllers[controllerId];
    if (controller == null || !controller.hasClients) return;
    
    final position = controller.position;
    if (position.pixels >= position.maxScrollExtent - threshold) {
      if (hasNext(controllerId) && !isLoadingMore(controllerId)) {
        onLoadMore(controllerId);
      }
    }
  }
  
  /// Check và load more nếu list chưa đầy màn hình
  void checkLoadMoreIfListNotFull(String controllerId) {
    if (_isCheckingFullScreen[controllerId] == true) return;
    _isCheckingFullScreen[controllerId] = true;
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _isCheckingFullScreen[controllerId] = false;
      final controller = _controllers[controllerId];
      if (controller == null || !controller.hasClients) return;
      
      final position = controller.position;
      if (position.maxScrollExtent <= position.viewportDimension) {
        // List chưa đầy màn hình
        if (hasNext(controllerId) && !isLoadingMore(controllerId)) {
          onLoadMore(controllerId).then((_) {
            // Recursive check sau khi load xong
            checkLoadMoreIfListNotFull(controllerId);
          });
        }
      }
    });
  }
}

