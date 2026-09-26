import 'package:flutter/material.dart';

/// Ô tìm kiếm dùng chung trong toàn app.
/// Có thể tái sử dụng ở bất kỳ màn hình nào.
///
/// Ví dụ:
/// ```dart
/// AppSearchField(
///   hintText: 'Search users',
///   controller: myController,
///   onChanged: (value) => print(value),
/// )
/// ```
class AppSearchField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final EdgeInsetsGeometry padding;
  final ValueChanged<String>? onChanged;
  final Color backgroundColor;
  final IconData prefixIcon;
  final double borderRadius;

  const AppSearchField({
    super.key,
    this.controller,
    this.hintText = 'Search',
    this.padding = const EdgeInsets.all(20),
    this.onChanged,
    this.backgroundColor = const Color(0xFFF5F5F5),
    this.prefixIcon = Icons.search,
    this.borderRadius = 12,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: TextField(
          controller: controller,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey[600], fontSize: 15),
            prefixIcon: Icon(
              prefixIcon,
              color: Colors.grey[600],
              size: 22,
            ),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
        ),
      ),
    );
  }
}
