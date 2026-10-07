import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pp191225/core/theme/app_theme.dart';

/// Bảng màu độc quyền của Sync Flow ("Flow 3D"):
/// - Lấy cảm hứng từ cơ chế tương tác xúc giác của Duolingo nhưng mang sắc thái công nghệ, hiện đại.
/// - Màu chủ đạo: Electric Violet (#5F33E1) kết hợp Midnight Indigo (#3B1A99).
/// - Điểm nhấn phụ: Lavender Mist (#F4F0FF) và Mint Flow (#00C48C) tạo nét trẻ trung, không bị biến thành bản sao Duolingo.
class ChunkyColors {
  ChunkyColors._();

  // Nền & viền mang ánh tím xám công nghệ (không xám đục thông thường)
  static const Color background = Color(0xFFFAFAFE);
  static const Color border = Color(0xFFECEAF5);
  static const Color borderStrong = Color(0xFFDEDAEB);
  static const Color surfaceMuted = Color(0xFFF6F5FB);

  // Typography
  static const Color textMain = Color(0xFF1E1B39); // Deep Indigo
  static const Color textSub = Color(0xFF747094); // Muted Slate Violet

  // Brand Signature: Electric Violet & Midnight Indigo
  static const Color brand = Color(0xFF5F33E1);
  static const Color brandDark = Color(0xFF3B1A99); // Khối đáy 3D sâu và đầm tay
  static const Color brandSoft = Color(0xFFF4F0FF); // Lavender Mist
  static const Color brandBorder = Color(0xFFDACDFE);
  static const Color brandBase = Color(0xFFC7B4FA); // Đáy của nút Lavender

  // Accent Colors: Khác biệt với màu hoạt hình của Duolingo
  static const Color mint = Color(0xFF00C48C); // Tech Mint (thay vì xanh lá chuối)
  static const Color mintDark = Color(0xFF008C63);

  static const Color amber = Color(0xFFF59E0B); // Warm Sunburst
  static const Color amberDark = Color(0xFFC97A00);
  static const Color amberText = Color(0xFFD97706);

  static const Color coral = Color(0xFFF43F5E); // Coral Berry (thay vì đỏ gắt)
  static const Color coralDark = Color(0xFFBE123C);

  // Tương thích ngược
  static const Color green = mint;
  static const Color greenDark = mintDark;
  static const Color orange = amber;
  static const Color yellow = amber;
  static const Color red = coral;
  static const Color redDark = coralDark;
  static const Color blue = Color(0xFF4F46E5);

  // Dynamic getters theo theme context
  static Color backgroundOf(BuildContext context) => context.themeColors.background;
  static Color surfaceOf(BuildContext context) => context.themeColors.surface;
  static Color borderOf(BuildContext context) => context.themeColors.border;
  static Color borderStrongOf(BuildContext context) => context.themeColors.borderStrong;
  static Color textMainOf(BuildContext context) => context.themeColors.textMain;
  static Color textSubOf(BuildContext context) => context.themeColors.textSub;
  static Color surfaceMutedOf(BuildContext context) => context.themeColors.surfaceMuted;
  static Color brandOf(BuildContext context) => context.themeColors.brand;
  static Color brandSoftOf(BuildContext context) => context.themeColors.brandSoft;
  static Color brandBorderOf(BuildContext context) => context.themeColors.brandBorder;
}

/// Thẻ nổi phẳng phong cách Sync Flow (Neo-Card) tự động thích ứng Dark Mode.
class ChunkyCard extends StatefulWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color? fillColor;
  final Color? borderColor;
  final double radius;
  final double depth;
  final VoidCallback? onTap;

  const ChunkyCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.fillColor,
    this.borderColor,
    this.radius = 16,
    this.depth = 4,
    this.onTap,
  });

  @override
  State<ChunkyCard> createState() => _ChunkyCardState();
}

class _ChunkyCardState extends State<ChunkyCard> {
  bool _pressed = false;

  void _setPressed(bool value) {
    if (widget.onTap == null || _pressed == value) return;
    if (value) HapticFeedback.selectionClick();
    setState(() => _pressed = value);
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.themeColors;
    final isDark = context.isDarkMode;

    // Tự động phân giải màu nền và viền nếu là mặc định hoặc Colors.white
    Color effectiveFill = widget.fillColor ?? colors.surface;
    if (isDark && (widget.fillColor == Colors.white || widget.fillColor == const Color(0xFFFFFFFF))) {
      effectiveFill = colors.surface;
    }

    Color effectiveBorder = widget.borderColor ?? colors.border;
    if (isDark && widget.borderColor == ChunkyColors.border) {
      effectiveBorder = colors.border;
    }

    final radius = BorderRadius.circular(widget.radius);
    final depth = _pressed ? 0.0 : widget.depth;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: (_) => _setPressed(true),
      onTapUp: (_) => _setPressed(false),
      onTapCancel: () => _setPressed(false),
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 60),
        margin: EdgeInsets.only(top: widget.depth - depth),
        padding: EdgeInsets.only(bottom: depth),
        decoration: BoxDecoration(
          color: effectiveBorder,
          borderRadius: radius,
        ),
        child: Container(
          width: double.infinity,
          padding: widget.padding,
          decoration: BoxDecoration(
            color: effectiveFill,
            borderRadius: radius,
            border: Border.all(color: effectiveBorder, width: 2),
          ),
          child: widget.child,
        ),
      ),
    );
  }
}

/// Nút bấm đặc trưng của Sync Flow ("FlowButton"):
/// - Kế thừa cảm giác dậm lún 3D cơ học và rung xúc giác của Duolingo.
/// - Mang thiết kế riêng:
///   1. Nút chính (Primary): Tím Electric Violet + đáy Midnight Indigo sang trọng.
///   2. Nút phụ (Secondary): Lavender Mist độc quyền (mặt tím sương mù, đáy tím pastel, chữ tím đậm) thay vì màu xám tẻ nhạt.
///   3. Bo góc 14px tinh gọn, hiện đại thay vì bo tròn đồ chơi.
enum FlowButtonVariant { primary, secondary, mint, coral }

class ChunkyButton extends StatefulWidget {
  final String label;
  final VoidCallback? onPressed;
  final FlowButtonVariant variant;
  final Color? color;
  final Color? shadowColor;
  final Color? textColor;
  final double height;
  final double depth;
  final double radius;
  final IconData? icon;
  final Widget? leading;
  final double? width;
  final double fontSize;

  const ChunkyButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = FlowButtonVariant.primary,
    this.color,
    this.shadowColor,
    this.textColor,
    this.height = 48,
    this.depth = 4,
    this.radius = 14,
    this.icon,
    this.leading,
    this.width,
    this.fontSize = 15,
  });

  /// Nút phụ mang sắc tím Lavender Mist đặc trưng của Sync Flow.
  const ChunkyButton.outlined({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = FlowButtonVariant.secondary,
    this.color,
    this.shadowColor,
    this.textColor,
    this.height = 48,
    this.depth = 4,
    this.radius = 14,
    this.icon,
    this.leading,
    this.width,
    this.fontSize = 15,
  });

  /// Nút hành động thành công (Mint Flow)
  const ChunkyButton.mint({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = FlowButtonVariant.mint,
    this.color,
    this.shadowColor,
    this.textColor,
    this.height = 48,
    this.depth = 4,
    this.radius = 14,
    this.icon,
    this.leading,
    this.width,
    this.fontSize = 15,
  });

  @override
  State<ChunkyButton> createState() => _ChunkyButtonState();
}

class _ChunkyButtonState extends State<ChunkyButton> {
  bool _isPressed = false;

  bool get _isEnabled => widget.onPressed != null;

  void _handleTapDown(TapDownDetails _) {
    if (!_isEnabled) return;
    HapticFeedback.lightImpact();
    setState(() => _isPressed = true);
  }

  void _handleTapUp(TapUpDetails _) {
    if (!_isEnabled) return;
    setState(() => _isPressed = false);
    widget.onPressed?.call();
  }

  void _handleTapCancel() {
    if (!_isEnabled) return;
    setState(() => _isPressed = false);
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.themeColors;
    final isDark = context.isDarkMode;

    Color faceColor;
    Color baseColor;
    Color textColor;
    Border? border;

    if (!_isEnabled) {
      faceColor = isDark ? const Color(0xFF28253E) : const Color(0xFFEAE9F2);
      baseColor = isDark ? const Color(0xFF1E1B32) : const Color(0xFFD4D2E2);
      textColor = isDark ? const Color(0xFF6B668B) : const Color(0xFFA19DB8);
      border = null;
    } else {
      switch (widget.variant) {
        case FlowButtonVariant.primary:
          faceColor = widget.color ?? colors.brand;
          baseColor = widget.shadowColor ?? colors.brandDark;
          textColor = widget.textColor ?? Colors.white;
          border = null;
          break;
        case FlowButtonVariant.secondary:
          final isDestructive = widget.textColor == ChunkyColors.coral || widget.textColor == ChunkyColors.red;
          faceColor = widget.color ?? (isDestructive ? (isDark ? const Color(0xFF3E1C27) : const Color(0xFFFFF1F4)) : colors.brandSoft);
          baseColor = widget.shadowColor ?? (isDestructive ? (isDark ? const Color(0xFF5A1D2F) : const Color(0xFFFFD1DC)) : colors.brandBase);
          textColor = widget.textColor ?? (isDestructive ? colors.coral : colors.brand);
          border = Border.all(
            color: isDestructive ? (isDark ? const Color(0xFF6A263B) : const Color(0xFFFFCCD5)) : colors.brandBorder,
            width: 2,
          );
          break;
        case FlowButtonVariant.mint:
          faceColor = widget.color ?? colors.mint;
          baseColor = widget.shadowColor ?? (isDark ? const Color(0xFF065F46) : ChunkyColors.mintDark);
          textColor = widget.textColor ?? Colors.white;
          border = null;
          break;
        case FlowButtonVariant.coral:
          faceColor = widget.color ?? colors.coral;
          baseColor = widget.shadowColor ?? (isDark ? const Color(0xFF881337) : ChunkyColors.coralDark);
          textColor = widget.textColor ?? Colors.white;
          border = null;
          break;
      }
    }

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      child: SizedBox(
        width: widget.width ?? double.infinity,
        height: widget.height + widget.depth,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Khối đáy 3D
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              height: widget.height,
              child: Container(
                decoration: BoxDecoration(
                  color: baseColor,
                  borderRadius: BorderRadius.circular(widget.radius),
                ),
              ),
            ),
            // Mặt trên dậm lún cơ học
            AnimatedPositioned(
              duration: const Duration(milliseconds: 60),
              curve: Curves.easeOutQuad,
              top: _isPressed ? widget.depth : 0,
              left: 0,
              right: 0,
              height: widget.height,
              child: Container(
                decoration: BoxDecoration(
                  color: faceColor,
                  borderRadius: BorderRadius.circular(widget.radius),
                  border: border,
                ),
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (widget.leading != null) ...[
                      widget.leading!,
                      const SizedBox(width: 8),
                    ] else if (widget.icon != null) ...[
                      Icon(widget.icon, color: textColor, size: 20),
                      const SizedBox(width: 8),
                    ],
                    Flexible(
                      child: Text(
                        widget.label.toUpperCase(),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: textColor,
                          fontSize: widget.fontSize,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.6,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Thanh tiến độ bo tròn.
class ChunkyProgressBar extends StatelessWidget {
  final double value;
  final Color? color;
  final Color? trackColor;
  final double height;

  const ChunkyProgressBar({
    super.key,
    required this.value,
    this.color,
    this.trackColor,
    this.height = 14,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.themeColors;
    final effectiveColor = color ?? colors.brand;
    final effectiveTrack = trackColor ?? colors.border;
    final v = value.clamp(0.0, 1.0);
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth * v;
        return Container(
          height: height,
          width: double.infinity,
          decoration: BoxDecoration(
            color: effectiveTrack,
            borderRadius: BorderRadius.circular(height),
          ),
          alignment: Alignment.centerLeft,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeOut,
            width: v == 0 ? 0 : width.clamp(height, constraints.maxWidth),
            height: height,
            decoration: BoxDecoration(
              color: effectiveColor,
              borderRadius: BorderRadius.circular(height),
            ),
          ),
        );
      },
    );
  }
}

/// Hộp thoại xác nhận phong cách Sync Flow thích ứng Theme.
Future<bool> showChunkyConfirm(
  BuildContext context, {
  required String title,
  required String message,
  required String confirmLabel,
  String cancelLabel = 'Huỷ',
  bool destructive = false,
}) async {
  final colors = context.themeColors;
  final result = await showDialog<bool>(
    context: context,
    builder: (ctx) => Dialog(
      backgroundColor: colors.surface,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: colors.border, width: 2),
      ),
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: colors.textMain,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: colors.textSub,
              ),
            ),
            const SizedBox(height: 24),
            ChunkyButton(label: cancelLabel, onPressed: () => Navigator.pop(ctx, false)),
            const SizedBox(height: 10),
            ChunkyButton(
              variant: destructive ? FlowButtonVariant.coral : FlowButtonVariant.secondary,
              label: confirmLabel,
              onPressed: () => Navigator.pop(ctx, true),
            ),
          ],
        ),
      ),
    ),
  );
  return result ?? false;
}

