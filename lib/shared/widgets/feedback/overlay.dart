import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

  static const _successFill = Color(0xFFEEE9FF);
  static const _successBorder = Color(0xFFC9B8FF);
  static const _successText = Color(0xFF4524B8);
  static const _successIcon = Color(0xFF5F33E1);

  static const _errorFill = Color(0xFFFFDFE0);
  static const _errorBorder = Color(0xFFFFB2B2);
  static const _errorText = Color(0xFFEA2B2B);
  static const _errorIcon = Color(0xFFFF4B4B);

  @override
  Widget build(BuildContext context) {
    final fill = isError ? _errorFill : _successFill;
    final border = isError ? _errorBorder : _successBorder;
    final textColor = isError ? _errorText : _successText;
    final iconColor = isError ? _errorIcon : _successIcon;
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
    return Positioned.fill(
      child: Material(
        color: Colors.black.withValues(alpha: 0.25),
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 22),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFFE5E5E5), width: 2),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CupertinoActivityIndicator(
                  radius: 14,
                  color: Color(0xFF5F33E1),
                ),
                const SizedBox(height: 14),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xFF3C3C3C),
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
