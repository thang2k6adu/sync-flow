import 'package:flutter/material.dart';
import 'package:pp191225/core/theme/app_theme.dart';

/// ActionButton kiểu dáng 3D Chunky (Duolingo Style):
/// - Sử dụng Transform.translate an toàn tuyệt đối với mọi Layout Constraints.
class ActionButton extends StatefulWidget {
  final String text;
  final Color? backgroundColor;
  final Color? shadowColor;
  final Color textColor;
  final VoidCallback? onPressed;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final bool isLoading;
  final double depth;

  const ActionButton({
    super.key,
    required this.text,
    this.backgroundColor,
    this.shadowColor,
    this.textColor = Colors.white,
    this.onPressed,
    this.borderRadius = 12.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    this.isLoading = false,
    this.depth = 3.0,
  });

  @override
  State<ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<ActionButton> {
  bool _isPressed = false;

  bool get _isEnabled => widget.onPressed != null && !widget.isLoading;

  void _handleTapDown(TapDownDetails _) {
    if (!_isEnabled) return;
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

    final Color faceColor = widget.backgroundColor ?? colors.brand;
    final Color baseColor = widget.shadowColor ??
        (widget.backgroundColor != null
            ? Color.lerp(widget.backgroundColor, Colors.black, 0.25)!
            : colors.brandDark);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 80),
        child: Container(
          decoration: BoxDecoration(
            color: _isEnabled ? baseColor : colors.border,
            borderRadius: BorderRadius.circular(widget.borderRadius),
          ),
          padding: EdgeInsets.only(bottom: widget.depth),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 60),
            curve: Curves.easeOutQuad,
            transform: Matrix4.translationValues(
              0,
              _isPressed ? widget.depth : 0,
              0,
            ),
            padding: widget.padding,
            decoration: BoxDecoration(
              color: _isEnabled ? faceColor : colors.surfaceMuted,
              borderRadius: BorderRadius.circular(widget.borderRadius),
            ),
            alignment: Alignment.center,
            child: widget.isLoading
                ? SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor:
                          AlwaysStoppedAnimation<Color>(widget.textColor),
                    ),
                  )
                : Text(
                    widget.text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: _isEnabled ? widget.textColor : colors.textSub,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
