import 'package:flutter/material.dart';

/// ActionButton là một button tùy biến, có thể sử dụng cho nhiều hành động khác nhau.
/// Ví dụ: Follow, Like, Save, Add to Cart, hoặc bất kỳ hành động nào trong app.
///
/// - [text]: Văn bản hiển thị trên button.
/// - [backgroundColor]: Màu nền của button.
/// - [textColor]: Màu chữ trên button.
/// - [onPressed]: Callback khi button được nhấn.
/// - [borderRadius]: Bán kính bo tròn của button, mặc định 8.0.
/// - [padding]: Padding bên trong button, mặc định là `EdgeInsets.symmetric(horizontal: 20, vertical: 8)`.
///
/// Ví dụ sử dụng:
/// ```dart
/// ActionButton(
///   text: 'Follow',
///   backgroundColor: Colors.blue,
///   textColor: Colors.white,
///   onPressed: () {
///     print('Follow clicked');
///   },
///   borderRadius: 12,
///   padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
/// )
/// ```
class ActionButton extends StatelessWidget {
  final String text; // Text hiện trên button (ví dụ: Follow, Save, Like...)
  final Color backgroundColor; // Màu nền của button
  final Color textColor; // Màu chữ của button
  final VoidCallback? onPressed; // Callback khi nhấn button
  final double borderRadius; // Lưu ý có thể tuỳ chỉnh border radius của button
  final EdgeInsetsGeometry padding; // Padding của button
  final bool isLoading; // Cho phép nhấn button

  const ActionButton({
    super.key,
    required this.text,
    required this.backgroundColor,
    required this.textColor,
    this.onPressed,
    this.borderRadius = 4.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 80),
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          color: isLoading ? Colors.grey[300] : backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: GestureDetector(
          onTap: isLoading ? () => {} : onPressed,
          child: isLoading
              ? const Text('...', textAlign: TextAlign.center)
              : Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: textColor,
                  ),
                ),
        ),
      ),
    );
  }
}
