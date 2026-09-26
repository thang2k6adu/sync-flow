import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Reusable `CustomAppBar` widget.
///
/// Đây là một AppBar tuỳ chỉnh có thể tái sử dụng mạnh mẽ:
/// - Có thể hiển thị nút back (leading) với callback tùy chỉnh.
/// - Có thể hiển thị danh sách [actions] bên phải (icon, menu, v.v.).
/// - Tuỳ chỉnh màu nền, màu chữ, elevation, border dưới AppBar.
/// - Dễ dàng tái sử dụng cho nhiều màn hình.
///
/// Tham số:
/// - [title]: tiêu đề AppBar.
/// - [onBackPressed]: callback khi bấm nút back, mặc định sẽ pop route.
/// - [actions]: danh sách widget hiển thị bên phải AppBar (ví dụ IconButton, menu…).
/// - [backgroundColor]: màu nền của AppBar (mặc định Colors.white).
/// - [titleColor]: màu chữ tiêu đề và icon (mặc định Colors.black).
/// - [elevation]: độ đổ bóng của AppBar (mặc định 0).
/// - [showBottomBorder]: bật/tắt đường viền phía dưới AppBar (mặc định true).
/// - [bottomBorderHeight]: chiều cao của border dưới AppBar (mặc định 1.0).
/// - [bottomBorderColor]: màu border dưới AppBar (mặc định `Color(0xFFE0E0E0)`).
///
/// Ví dụ sử dụng:
/// ```dart
/// Scaffold(
///   appBar: CustomAppBar(
///     title: 'Edit Information',
///     onBackPressed: () {
///       // callback khi bấm back
///       Navigator.of(context).pop();
///     },
///     actions: [
///       IconButton(
///         icon: Icon(Icons.edit, color: Colors.black),
///         onPressed: () {
///           GoRouter.of(context).go('/user/setting');
///         },
///       ),
///     ],
///     backgroundColor: Colors.white,
///     titleColor: Colors.black,
///     elevation: 0,
///   ),
///   body: Center(child: Text('Nội dung trang')),
/// );
/// ```

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBackPressed;
  final List<Widget>? actions; // Icon hoặc menu bên phải
  final Color backgroundColor;
  final Color titleColor;
  final double elevation;
  final bool showBottomBorder;
  final double bottomBorderHeight;
  final Color bottomBorderColor;

  const CustomAppBar({
    super.key,
    required this.title,
    this.onBackPressed,
    this.actions,
    this.backgroundColor = Colors.white,
    this.titleColor = Colors.black,
    this.elevation = 0,
    this.showBottomBorder = true,
    this.bottomBorderHeight = 1.0,
    this.bottomBorderColor = const Color(0xFFE0E0E0),
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      elevation: elevation,
      centerTitle: true,
      iconTheme: IconThemeData(color: titleColor),
      leading: IconButton(
        padding: const EdgeInsets.only(left: 8.0),
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: onBackPressed ?? () => GoRouter.of(context).pop(),
      ),
      leadingWidth: 72,
      title: Text(
        title,
        style: TextStyle(
          color: titleColor,
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      ),
      actions: actions,
      bottom: showBottomBorder
          ? PreferredSize(
              preferredSize: Size.fromHeight(bottomBorderHeight),
              child: Container(
                height: bottomBorderHeight,
                color: bottomBorderColor,
              ),
            )
          : null,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
    kToolbarHeight + (showBottomBorder ? bottomBorderHeight : 0),
  );
}
