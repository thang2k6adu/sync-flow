import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pp191225/core/theme/app_theme.dart';

enum ToastType { auto, loading, success, error }

class UOverlay {
  OverlayEntry? _entry;
  final BuildContext context;
  final OverlayState _overlayState;

  UOverlay(this.context) : _overlayState = Overlay.of(context);

  /// [type] = auto: `loading` -> loading, chứa "thất bại"/"lỗi" -> error, còn lại -> success.
  void show({
    required String message,
    bool loading = false,
    ToastType type = ToastType.auto,
  }) {
    hide();

    final resolved = _resolve(message, loading, type);

    _entry = OverlayEntry(
      builder: (_) => resolved == ToastType.loading
          ? _LoadingToast(message: message)
          : _BannerToast(message: message, isError: resolved == ToastType.error),
    );
    _overlayState.insert(_entry!);
  }

  void hide() {
    _entry?.remove();
    _entry = null;
  }

  void showWithTimeout({
    required String message,
    bool loading = false,
    ToastType type = ToastType.auto,
    Duration duration = const Duration(seconds: 2),
  }) {
    show(message: message, loading: loading, type: type);
    final entry = _entry;
    Future.delayed(duration, () {
      // Chỉ ẩn nếu toast này vẫn là toast đang hiển thị.
      if (_entry == entry) hide();
    });
  }

  ToastType _resolve(String message, bool loading, ToastType type) {
    if (type != ToastType.auto) return type;
    if (loading) return ToastType.loading;
    final lower = message.toLowerCase();
    if (lower.contains('thất bại') || lower.contains('lỗi')) {
      return ToastType.error;
    }
    return ToastType.success;
  }
}

/// Banner trượt xuống từ đỉnh màn hình, viền dày, màu phẳng.
class _BannerToast extends StatelessWidget {
  final String message;
  final bool isError;

  const _BannerToast({required this.message, required this.isError});

  @override
  Widget build(BuildContext context) {
    final colors = context.themeColors;
    final isDark = context.isDarkMode;

    final fill = isError
        ? (isDark ? const Color(0xFF3B1E22) : const Color(0xFFFFDFE0))
        : (isDark ? colors.brandSoft : colors.brandSoft);
    final border = isError
        ? (isDark ? colors.coral : const Color(0xFFFFB2B2))
        : colors.brandBorder;
    final textColor = isError
        ? (isDark ? const Color(0xFFFF8B8B) : const Color(0xFFEA2B2B))
        : (isDark ? colors.textMain : colors.brandDark);
    final iconColor = isError ? colors.coral : colors.brand;
    final topInset = MediaQuery.of(context).padding.top;

    return Positioned(
      left: 16,
      right: 16,
      top: topInset + 12,
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: 1),
        duration: const Duration(milliseconds: 280),
        curve: Curves.easeOutBack,
        builder: (context, t, child) => Opacity(
          opacity: t.clamp(0.0, 1.0),
          child: Transform.translate(offset: Offset(0, (1 - t) * -40), child: child),
        ),
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: fill,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: border, width: 2),
            ),
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(color: iconColor, shape: BoxShape.circle),
                  child: Icon(
                    isError ? Icons.close_rounded : Icons.check_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    message,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Thẻ loading ở giữa màn hình, nền trắng viền dày.
class _LoadingToast extends StatelessWidget {
  final String message;

  const _LoadingToast({required this.message});

  @override
  Widget build(BuildContext context) {
    final colors = context.themeColors;

    return Positioned.fill(
      child: Material(
        color: Colors.black.withValues(alpha: 0.35),
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 22),
            decoration: BoxDecoration(
              color: colors.surface,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: colors.border, width: 2),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CupertinoActivityIndicator(
                  radius: 14,
                  color: colors.brand,
                ),
                const SizedBox(height: 14),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: colors.textMain,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
