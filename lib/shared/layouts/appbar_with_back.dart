import 'package:flutter/material.dart';
import 'package:pp191225/core/theme/app_theme.dart';
import 'package:pp191225/shared/helpers/router_helper.dart';

/// AppBar có nút Back và tiêu đề nằm giữa.
/// - [title]: văn bản hiển thị ở giữa AppBar.
/// - [onBack]: callback khi nhấn nút back (mặc định là Navigator.pop).
/// - [backgroundColor]: màu nền AppBar (mặc định là trắng).
/// - [textColor]: màu chữ và icon (mặc định là đen).
/// - [elevation]: độ đổ bóng (mặc định = 0).
/// - [centerTitle]: có căn giữa tiêu đề hay không (mặc định = true).
/// - [bottomBorder]: có hiển thị border dưới AppBar hay không (mặc định = false).
/// - [actions]: có hiển thị actions hay không (mặc định = false).
///
/// Ví dụ:
/// ```dart
/// UserRelationAppBar(title: 'Darlene Bears')
/// ```
class AppBarWithBack extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final PreferredSizeWidget? bottom;
  final VoidCallback? onBack;
  final Color? backgroundColor;
  final Color? textColor;
  final double elevation;
  final bool centerTitle;
  final bool bottomBorder;
  final List<Widget>? actions;

  const AppBarWithBack({
    super.key,
    required this.title,
    this.bottom,
    this.onBack,
    this.backgroundColor,
    this.textColor,
    this.elevation = 0,
    this.centerTitle = true,
    this.bottomBorder = false,
    this.actions,
  });

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + (bottom?.preferredSize.height ?? 0));

  @override
  Widget build(BuildContext context) {
    final colors = context.themeColors;
    final bg = backgroundColor ?? colors.surface;
    final fg = textColor ?? colors.textMain;

    return AppBar(
      backgroundColor: bg,
      elevation: elevation,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios_new_rounded, color: fg, size: 20),
        onPressed: () =>
            Navigator.canPop(context) && onBack != null ? goBack(context) : goHome(context),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: fg,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
      ),
      centerTitle: centerTitle,
      bottom:
          bottom ??
          (bottomBorder
              ? PreferredSize(
                  preferredSize: const Size.fromHeight(2),
                  child: Container(height: 2, color: colors.border),
                )
              : null),
      actions: actions,
    );
  }
}
