// Reusable settings/list tile that shows a left title and a trailing widget:
// - trailingText: simple text on the right (e.g., nickname)
// - or imageUrl: circular avatar (falls back to initials if image is null or fails)
// Tapable and exposes customization points.
import 'package:flutter/material.dart';

enum TrailingMode { text, avatar }

/// Reusable `SettingsTile` widget.
///
/// Đây là một tile có thể tái sử dụng (thường dùng trong trang Cài đặt hoặc Hồ sơ người dùng)
/// hiển thị một tiêu đề ở bên trái và một phần nội dung (text hoặc avatar) ở bên phải.
///
/// Hỗ trợ:
/// - Chế độ hiển thị chữ (`TrailingMode.text`) hoặc avatar (`TrailingMode.avatar`).
/// - Hiển thị icon mũi tên (chevron) tùy chọn.
/// - Avatar có fallback sang chữ viết tắt (initials) nếu không có ảnh.
/// - Tùy chỉnh style, màu nền avatar, bo góc, và callback khi nhấn.
///
/// Tham số:
/// - [title]: tiêu đề hiển thị bên trái (bắt buộc).
/// - [trailingText]: văn bản hiển thị bên phải (khi `trailingMode == TrailingMode.text`).
/// - [imageUrl]: URL ảnh đại diện (khi `trailingMode == TrailingMode.avatar`).
/// - [initials]: chữ viết tắt hiển thị nếu không có ảnh (hoặc ảnh lỗi).
/// - [trailingMode]: kiểu hiển thị phần bên phải (`TrailingMode.text` hoặc `TrailingMode.avatar`), mặc định là `TrailingMode.text`.
/// - [onTap]: callback khi người dùng nhấn vào tile.
/// - [showChevron]: có hiển thị mũi tên điều hướng hay không (mặc định `true`).
/// - [avatarRadius]: bán kính của avatar tròn (mặc định `18.0`).
/// - [titleStyle]: style cho phần tiêu đề.
/// - [trailingTextStyle]: style cho phần chữ bên phải.
/// - [avatarBackgroundColor]: màu nền cho avatar khi hiển thị chữ viết tắt.
///
/// Ví dụ sử dụng:
/// ```dart
/// // Hiển thị thông tin nickname với chữ bên phải
/// SettingsTile(
///   title: 'Nickname',
///   trailingText: 'thangpro',
///   onTap: () => print('Tapped Nickname'),
/// ),
///
/// // Hiển thị avatar với fallback sang chữ viết tắt
/// SettingsTile(
///   title: 'Profile',
///   trailingMode: TrailingMode.avatar,
///   imageUrl: 'https://example.com/avatar.jpg',
///   trailingText: 'Thắng Pro',
///   onTap: () => print('Tapped Profile'),
/// ),
///
/// // Hiển thị avatar với màu nền tùy chỉnh và không có chevron
/// SettingsTile(
///   title: 'User',
///   trailingMode: TrailingMode.avatar,
///   initials: 'TP',
///   showChevron: false,
///   avatarBackgroundColor: Colors.blueGrey,
/// ),
/// ```
///
/// Thường được sử dụng trong `ListView` hoặc `Column` để tạo danh sách cài đặt.

class SettingsTile extends StatelessWidget {
  final String title;
  final String? trailingText;
  final String? imageUrl;
  final String? initials; // explicitly set initials if you want
  final TrailingMode trailingMode;
  final VoidCallback? onTap;
  final bool showChevron;
  final double avatarRadius;
  final TextStyle? titleStyle;
  final TextStyle? trailingTextStyle;
  final Color? avatarBackgroundColor;

  const SettingsTile({
    super.key,
    required this.title,
    this.trailingText,
    this.imageUrl,
    this.initials,
    this.trailingMode = TrailingMode.text,
    this.onTap,
    this.showChevron = true,
    this.avatarRadius = 18.0,
    this.titleStyle,
    this.trailingTextStyle,
    this.avatarBackgroundColor,
  });

  String _generateInitials(String? explicit, String? fallback) {
    if (explicit != null && explicit.trim().isNotEmpty) {
      return explicit.trim().toUpperCase();
    }
    final source = (fallback ?? '').trim();
    if (source.isEmpty) return '';
    final parts = source.split(RegExp(r'\s+'));
    if (parts.length == 1) return parts.first.substring(0, 1).toUpperCase();
    final first = parts.first.substring(0, 1);
    final last = parts.last.substring(0, 1);
    return (first + last).toUpperCase();
  }

  Widget _initialsCircle(BuildContext context, String text) {
    final bg = avatarBackgroundColor ?? Theme.of(context).colorScheme.primary;
    return Container(
      width: avatarRadius * 2,
      height: avatarRadius * 2,
      decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
      alignment: Alignment.center,
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: avatarRadius * 0.9,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _avatarWithFallback(BuildContext context) {
    final initialsText = _generateInitials(initials, trailingText ?? title);
    final hasImage = imageUrl != null && imageUrl!.trim().isNotEmpty;

    if (!hasImage) {
      return _initialsCircle(context, initialsText);
    }

    // Try network image, fallback to initials on error
    return ClipOval(
      child: Container(
        width: avatarRadius * 2,
        height: avatarRadius * 2,
        color: Colors.transparent,
        child: Image.network(
          imageUrl!,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return _initialsCircle(context, initialsText);
          },
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            // show placeholder while loading (initials)
            return _initialsCircle(context, initialsText);
          },
        ),
      ),
    );
  }

  Widget _buildTrailing(BuildContext context) {
    switch (trailingMode) {
      case TrailingMode.avatar:
        return _avatarWithFallback(context);
      case TrailingMode.text:
        return ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 150), // giới hạn chiều rộng
          child: Text(
            trailingText ?? '',
            style:
                trailingTextStyle ??
                TextStyle(color: Colors.black54, fontSize: 16),
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: onTap,
        splashColor: Theme.of(
          context,
        ).colorScheme.primary.withValues(alpha: 0.1),
        highlightColor: Colors.transparent,
        child: Ink(
          padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Title (left)
              Expanded(
                child: Text(
                  title,
                  style:
                      titleStyle ??
                      TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (trailingMode == TrailingMode.text) ...[
                    _buildTrailing(context),
                    if (showChevron) const SizedBox(width: 8),
                  ] else ...[
                    _buildTrailing(context),
                    if (showChevron) const SizedBox(width: 8),
                  ],

                  // Chevron
                  if (showChevron)
                    Icon(
                      Icons.chevron_right,
                      color: Theme.of(context).disabledColor,
                    ),
                ],
              ),
              // Trailing (text or avatar)
            ],
          ),
        ),
      ),
    );
  }
}
