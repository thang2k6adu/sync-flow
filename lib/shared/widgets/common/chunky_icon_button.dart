import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pp191225/core/theme/app_theme.dart';
import 'package:pp191225/shared/widgets/common/chunky_card.dart';

/// Nút Icon 3D xúc giác (Duolingo-style Tactile Icon Button):
/// - Dùng cho nút loa nghe phát âm (Audio TTS), nút đóng modal ('X'), nút gợi ý (Hint), nút bookmark...
/// - Hỗ trợ cả dạng vuông bo góc và tròn hoàn toàn (`isCircle: true`).
/// - Cơ chế dậm lún cơ học 3D chuẩn xác đồng bộ với `ChunkyButton`.
class ChunkyIconButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final FlowButtonVariant variant;
  final ChunkyButtonSize size;
  final bool isCircle;
  final String? tooltip;
  final Color? color;
  final Color? shadowColor;
  final Color? iconColor;

  const ChunkyIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.variant = FlowButtonVariant.secondary,
    this.size = ChunkyButtonSize.medium,
    this.isCircle = false,
    this.tooltip,
    this.color,
    this.shadowColor,
    this.iconColor,
  });

  const ChunkyIconButton.circle({
    super.key,
    required this.icon,
    required this.onPressed,
    this.variant = FlowButtonVariant.secondary,
    this.size = ChunkyButtonSize.medium,
    this.tooltip,
    this.color,
    this.shadowColor,
    this.iconColor,
  }) : isCircle = true;

  @override
  State<ChunkyIconButton> createState() => _ChunkyIconButtonState();
}

class _ChunkyIconButtonState extends State<ChunkyIconButton> {
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

    Color faceColor;
    Color baseColor;
    Color iconColor;
    Border? border;

    if (!_isEnabled) {
      faceColor = colors.surfaceMuted;
      baseColor = colors.border;
      iconColor = colors.textSub.withValues(alpha: 0.6);
      border = null;
    } else {
      switch (widget.variant) {
        case FlowButtonVariant.primary:
          faceColor = widget.color ?? colors.brand;
          baseColor = widget.shadowColor ?? colors.brandDark;
          iconColor = widget.iconColor ?? Colors.white;
          border = null;
          break;
        case FlowButtonVariant.secondary:
          faceColor = widget.color ?? colors.brandSoft;
          baseColor = widget.shadowColor ?? colors.brandBase;
          iconColor = widget.iconColor ?? colors.brand;
          border = Border.all(color: colors.brandBorder, width: 2);
          break;
        case FlowButtonVariant.mint:
          faceColor = widget.color ?? colors.mint;
          baseColor = widget.shadowColor ?? colors.mintDark;
          iconColor = widget.iconColor ?? Colors.white;
          border = null;
          break;
        case FlowButtonVariant.amber:
          faceColor = widget.color ?? colors.amber;
          baseColor = widget.shadowColor ?? colors.amberDark;
          iconColor = widget.iconColor ?? Colors.white;
          border = null;
          break;
        case FlowButtonVariant.coral:
          faceColor = widget.color ?? colors.coral;
          baseColor = widget.shadowColor ?? colors.coralDark;
          iconColor = widget.iconColor ?? Colors.white;
          border = null;
          break;
      }
    }

    // Xác định kích thước hộp vuông
    final double buttonSize;
    final double iconSize;
    final double depth = widget.size.depth;

    switch (widget.size) {
      case ChunkyButtonSize.small:
        buttonSize = 36.0;
        iconSize = 18.0;
        break;
      case ChunkyButtonSize.medium:
        buttonSize = 46.0;
        iconSize = 22.0;
        break;
      case ChunkyButtonSize.large:
        buttonSize = 54.0;
        iconSize = 26.0;
        break;
    }

    final effectiveRadius = widget.isCircle
        ? BorderRadius.circular(buttonSize / 2)
        : BorderRadius.circular(widget.size.radius);

    Widget content = SizedBox(
      width: buttonSize,
      height: buttonSize + depth,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Khối đáy 3D
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: buttonSize,
            child: Container(
              decoration: BoxDecoration(
                color: baseColor,
                borderRadius: effectiveRadius,
              ),
            ),
          ),
          // Mặt trên dậm lún
          AnimatedPositioned(
            duration: const Duration(milliseconds: 60),
            curve: Curves.easeOutQuad,
            top: _isPressed ? depth : 0,
            left: 0,
            right: 0,
            height: buttonSize,
            child: Container(
              decoration: BoxDecoration(
                color: faceColor,
                borderRadius: effectiveRadius,
                border: border,
              ),
              alignment: Alignment.center,
              child: Icon(
                widget.icon,
                color: iconColor,
                size: iconSize,
              ),
            ),
          ),
        ],
      ),
    );

    if (widget.tooltip != null) {
      content = Tooltip(message: widget.tooltip!, child: content);
    }

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      child: content,
    );
  }
}
