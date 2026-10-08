import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pp191225/core/theme/app_theme.dart';

class CollapsibleNavItem {
  final IconData icon;
  final IconData activeIcon;
  final String label;

  const CollapsibleNavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });
}

/// Navbar chuyển đổi hình thể an toàn (Morphing Floating Pill Navbar - Dribbble Style)
/// - Cố định RenderBox layout đầy đủ, không gây lỗi "Cannot hit test a render box that has never been laid out".
class CollapsibleFloatingNavBar extends StatefulWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;
  final List<CollapsibleNavItem> items;
  final bool isCollapsed;
  final VoidCallback onExpandRequest;

  const CollapsibleFloatingNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
    required this.items,
    required this.isCollapsed,
    required this.onExpandRequest,
  });

  @override
  State<CollapsibleFloatingNavBar> createState() =>
      _CollapsibleFloatingNavBarState();
}

class _CollapsibleFloatingNavBarState extends State<CollapsibleFloatingNavBar>
    with TickerProviderStateMixin {
  late AnimationController _morphController;
  late Animation<double> _morphAnimation;

  late AnimationController _indicatorController;
  late Animation<double> _indicatorPosition;

  @override
  void initState() {
    super.initState();
    _morphController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _morphAnimation = CurvedAnimation(
      parent: _morphController,
      curve: Curves.easeInOutCubicEmphasized,
    );

    if (widget.isCollapsed) {
      _morphController.value = 1.0;
    }

    _indicatorController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 280),
    );
    _indicatorPosition = Tween<double>(
      begin: widget.selectedIndex.toDouble(),
      end: widget.selectedIndex.toDouble(),
    ).animate(CurvedAnimation(
      parent: _indicatorController,
      curve: Curves.easeOutBack,
    ));
  }

  @override
  void didUpdateWidget(covariant CollapsibleFloatingNavBar oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.isCollapsed != widget.isCollapsed) {
      if (widget.isCollapsed) {
        _morphController.forward();
      } else {
        _morphController.reverse();
      }
    }

    if (oldWidget.selectedIndex != widget.selectedIndex) {
      final oldPos = _indicatorPosition.value;
      _indicatorPosition = Tween<double>(
        begin: oldPos,
        end: widget.selectedIndex.toDouble(),
      ).animate(CurvedAnimation(
        parent: _indicatorController,
        curve: Curves.easeOutBack,
      ));
      _indicatorController.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _morphController.dispose();
    _indicatorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.themeColors;
    final isDark = context.isDarkMode;
    final bottomInset = MediaQuery.paddingOf(context).bottom;
    final screenWidth = MediaQuery.sizeOf(context).width;

    final navBgColor =
        isDark ? const Color(0xFF1E1F29) : const Color(0xFF28282E);
    final indicatorColor = colors.brand;

    const barHeight = 64.0;
    const itemWidth = 64.0;
    final expandedWidth = (itemWidth * widget.items.length) + 16.0;

    final expandedCenterX = screenWidth / 2;
    final expandedBottom = bottomInset > 0 ? bottomInset + 10 : 20.0;

    const collapsedWidth = 58.0;
    const collapsedHeight = 64.0;
    final collapsedCenterX = screenWidth - (collapsedWidth / 2);
    final collapsedBottom = expandedBottom + 8.0;

    return AnimatedBuilder(
      animation: Listenable.merge([_morphAnimation, _indicatorPosition]),
      builder: (context, child) {
        final t = _morphAnimation.value;

        final currentWidth = lerpDouble(expandedWidth, collapsedWidth, t)!;
        final currentHeight = lerpDouble(barHeight, collapsedHeight, t)!;
        final currentCenterX =
            lerpDouble(expandedCenterX, collapsedCenterX, t)!;
        final currentBottom = lerpDouble(expandedBottom, collapsedBottom, t)!;

        final currentLeft = currentCenterX - (currentWidth / 2);
        final contentOpacity = (1.0 - (t * 2.2)).clamp(0.0, 1.0);
        final burgerOpacity = ((t - 0.5) * 2.0).clamp(0.0, 1.0);

        return SizedBox(
          width: screenWidth,
          height: expandedBottom + barHeight + 20,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                left: currentLeft,
                bottom: currentBottom,
                width: currentWidth,
                height: currentHeight,
                child: CustomPaint(
                  painter: _MorphingNavPainter(
                    t: t,
                    color: navBgColor,
                    shadowColor: Colors.black.withValues(alpha: 0.28),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(currentHeight / 2),
                    child: Stack(
                      clipBehavior: Clip.hardEdge,
                      children: [
                        // 1. THANH TABS (CHỈ HIT-TEST KHI T < 0.4)
                        Positioned(
                          left: 0,
                          top: 0,
                          width: expandedWidth,
                          height: barHeight,
                          child: IgnorePointer(
                            ignoring: t > 0.4,
                            child: Opacity(
                              opacity: contentOpacity,
                              child: Stack(
                                children: [
                                  // Indicator tròn tím di chuyển mượt mà
                                  Positioned(
                                    left: 8.0 +
                                        (_indicatorPosition.value * itemWidth) +
                                        (itemWidth - 48.0) / 2,
                                    top: (barHeight - 48.0) / 2,
                                    child: Container(
                                      width: 48,
                                      height: 48,
                                      decoration: BoxDecoration(
                                        color: indicatorColor,
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color: indicatorColor
                                                .withValues(alpha: 0.45),
                                            blurRadius: 10,
                                            offset: const Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  // Hàng icon các tab
                                  Positioned.fill(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: List.generate(
                                            widget.items.length, (index) {
                                          final item = widget.items[index];
                                          final isSelected =
                                              widget.selectedIndex == index;

                                          return SizedBox(
                                            width: itemWidth,
                                            height: barHeight,
                                            child: GestureDetector(
                                              behavior:
                                                  HitTestBehavior.opaque,
                                              onTap: () {
                                                widget.onItemSelected(index);
                                              },
                                              child: Center(
                                                child: Icon(
                                                  isSelected
                                                      ? item.activeIcon
                                                      : item.icon,
                                                  color: isSelected
                                                      ? Colors.white
                                                      : Colors.white.withValues(
                                                          alpha: 0.45),
                                                  size: 26,
                                                ),
                                              ),
                                            ),
                                          );
                                        }),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        // 2. NÚT HAMBURGER KHI THU GỌN (CHỈ HIT-TEST KHI T > 0.6)
                        Positioned.fill(
                          child: IgnorePointer(
                            ignoring: t < 0.6,
                            child: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                HapticFeedback.lightImpact();
                                widget.onExpandRequest();
                              },
                              child: Opacity(
                                opacity: burgerOpacity,
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 6.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          width: 19,
                                          height: 2.6,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(2),
                                          ),
                                        ),
                                        const SizedBox(height: 3.8),
                                        Container(
                                          width: 19,
                                          height: 2.6,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(2),
                                          ),
                                        ),
                                        const SizedBox(height: 3.8),
                                        Container(
                                          width: 19,
                                          height: 2.6,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(2),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _MorphingNavPainter extends CustomPainter {
  final double t;
  final Color color;
  final Color shadowColor;

  _MorphingNavPainter({
    required this.t,
    required this.color,
    required this.shadowColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final path = Path();

    if (t < 0.08) {
      path.addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, w, h),
        Radius.circular(h / 2),
      ));
    } else {
      final notchFactor = ((t - 0.08) / 0.92).clamp(0.0, 1.0);
      final r = h / 2;

      path.moveTo(w, 0);

      path.cubicTo(
        w,
        h * 0.22 * notchFactor,
        w - (r * (1.0 - notchFactor * 0.4)),
        h * 0.25 * notchFactor,
        r,
        0,
      );

      path.arcToPoint(
        Offset(r, h),
        radius: Radius.circular(r),
        clockwise: false,
      );

      path.cubicTo(
        w - (r * (1.0 - notchFactor * 0.4)),
        h - (h * 0.25 * notchFactor),
        w,
        h - (h * 0.22 * notchFactor),
        w,
        h,
      );

      path.lineTo(w, 0);
      path.close();
    }

    canvas.drawShadow(path, shadowColor, 12.0, false);

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _MorphingNavPainter oldDelegate) {
    return oldDelegate.t != t ||
        oldDelegate.color != color ||
        oldDelegate.shadowColor != shadowColor;
  }
}
