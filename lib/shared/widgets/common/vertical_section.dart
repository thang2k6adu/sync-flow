import 'package:flutter/material.dart';

/// Widget bao bọc (wrapper) để tạo khoảng cách theo chiều dọc giữa các section trong Column.
///
/// Thay vì dùng nhiều `SizedBox(height: X)` rải rác trong UI,
/// bạn có thể bọc từng section bằng `VerticalSection` và điều chỉnh khoảng cách ở một nơi.
class VerticalSection extends StatelessWidget {
  /// Widget con (child) sẽ hiển thị trong section
  final Widget child;

  /// Khoảng cách phía dưới widget con. Mặc định là 20.
  final double spacing;

  const VerticalSection({
    required this.child,
    this.spacing = 20, // khoảng cách mặc định
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      // Chỉ padding phía dưới để tạo khoảng cách theo chiều dọc giữa các section
      padding: EdgeInsets.only(bottom: spacing),
      child: child,
    );
  }
}
