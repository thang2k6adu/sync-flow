import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pp191225/shared/widgets/common/chunky_card.dart';

class SrsRatingBar extends StatelessWidget {
  final Function(String rating) onRating;

  const SrsRatingBar({
    super.key,
    required this.onRating,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: ChunkyColors.border, width: 2)),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Expanded(
              child: _SrsRatingButton(
                label: 'Lại',
                subLabel: '< 10p',
                color: ChunkyColors.red,
                shadowColor: ChunkyColors.redDark,
                onTap: () => onRating('AGAIN'),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _SrsRatingButton(
                label: 'Khó',
                subLabel: '1 ngày',
                color: ChunkyColors.orange,
                shadowColor: const Color(0xFFD97F00),
                onTap: () => onRating('HARD'),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _SrsRatingButton(
                label: 'Tốt',
                subLabel: '3 ngày',
                color: ChunkyColors.brand,
                shadowColor: ChunkyColors.brandDark,
                onTap: () => onRating('GOOD'),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _SrsRatingButton(
                label: 'Dễ',
                subLabel: '5 ngày',
                color: ChunkyColors.green,
                shadowColor: ChunkyColors.greenDark,
                onTap: () => onRating('EASY'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SrsRatingButton extends StatefulWidget {
  final String label;
  final String subLabel;
  final Color color;
  final Color shadowColor;
  final VoidCallback onTap;

  const _SrsRatingButton({
    required this.label,
    required this.subLabel,
    required this.color,
    required this.shadowColor,
    required this.onTap,
  });

  @override
  State<_SrsRatingButton> createState() => _SrsRatingButtonState();
}

class _SrsRatingButtonState extends State<_SrsRatingButton> {
  bool _isPressed = false;
  static const double _depth = 4.0;
  static const double _height = 54.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: (_) {
        HapticFeedback.lightImpact();
        setState(() => _isPressed = true);
      },
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: SizedBox(
        height: _height + _depth,
        child: Stack(
          children: [
            // Đáy nút 3D
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              height: _height,
              child: Container(
                decoration: BoxDecoration(
                  color: widget.shadowColor,
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
            // Mặt trên nút dậm lún xuống
            AnimatedPositioned(
              duration: const Duration(milliseconds: 60),
              curve: Curves.easeOutQuad,
              top: _isPressed ? _depth : 0,
              left: 0,
              right: 0,
              height: _height,
              child: Container(
                decoration: BoxDecoration(
                  color: widget.color,
                  borderRadius: BorderRadius.circular(14),
                ),
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.label.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      widget.subLabel,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Colors.white70,
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
