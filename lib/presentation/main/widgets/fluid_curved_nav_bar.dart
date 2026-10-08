import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pp191225/core/theme/app_fonts.dart';
import 'package:pp191225/core/theme/app_theme.dart';

class FluidNavBarItem {
  final IconData icon;
  final IconData activeIcon;
  final String label;

  const FluidNavBarItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });
}

class FluidCurvedNavBar extends StatefulWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;
  final List<FluidNavBarItem> items;

  const FluidCurvedNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
    required this.items,
  });

  @override
  State<FluidCurvedNavBar> createState() => _FluidCurvedNavBarState();
}

class _FluidCurvedNavBarState extends State<FluidCurvedNavBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animIndex;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 320),
    );
    _animIndex = Tween<double>(
      begin: widget.selectedIndex.toDouble(),
      end: widget.selectedIndex.toDouble(),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));
  }

  @override
  void didUpdateWidget(covariant FluidCurvedNavBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedIndex != widget.selectedIndex) {
      final oldVal = _animIndex.value;
      _animIndex = Tween<double>(
        begin: oldVal,
        end: widget.selectedIndex.toDouble(),
      ).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutCubic,
      ));
      _controller.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.themeColors;
    final bottomPadding = MediaQuery.paddingOf(context).bottom;
    const barHeight = 64.0;
    final totalHeight = barHeight + bottomPadding;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final currentPosition = _animIndex.value;
        return SizedBox(
          height: totalHeight,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // Nền thanh bar uốn lượn
              Positioned.fill(
                child: CustomPaint(
                  painter: _CurvedBarPainter(
                    selectedIndex: currentPosition,
                    itemCount: widget.items.length,
                    barColor: colors.surface,
                    borderColor: colors.border.withOpacity(0.8),
                    shadowColor: Colors.black.withOpacity(0.06),
                  ),
                ),
              ),

              // Danh sách các icon và nhãn của tab
              Positioned(
                left: 0,
                right: 0,
                top: 0,
                height: barHeight,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final itemWidth = constraints.maxWidth / widget.items.length;
                    return Row(
                      children: List.generate(widget.items.length, (index) {
                        final item = widget.items[index];

                        // Độ mờ khi tab này đang active (để nút tròn nổi bật hiển thị)
                        final diff = (currentPosition - index).abs();
                        final textOpacity = (diff.clamp(0.0, 1.0)).toDouble();

                        return SizedBox(
                          width: itemWidth,
                          height: barHeight,
                          child: GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              if (widget.selectedIndex != index) {
                                HapticFeedback.selectionClick();
                                widget.onItemSelected(index);
                              }
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                // Icon khi chưa chọn
                                Opacity(
                                  opacity: (diff.clamp(0.3, 1.0)),
                                  child: Icon(
                                    item.icon,
                                    size: 22,
                                    color: colors.textSub,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                // Nhãn tab
                                Opacity(
                                  opacity: textOpacity,
                                  child: Text(
                                    item.label,
                                    style: TextStyle(
                                      fontFamily: AppFonts.poppins,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: colors.textSub,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SizedBox(height: 8),
                              ],
                            ),
                          ),
                        );
                      }),
                    );
                  },
                ),
              ),

              // Nút tròn nổi (Floating Circle) lướt theo vị trí active
              LayoutBuilder(
                builder: (context, constraints) {
                  final itemWidth = constraints.maxWidth / widget.items.length;
                  final circleCenterX = itemWidth * (currentPosition + 0.5);
                  const circleSize = 52.0;

                  final activeIndex = widget.selectedIndex.clamp(0, widget.items.length - 1);
                  final activeItem = widget.items[activeIndex];

                  return Positioned(
                    left: circleCenterX - (circleSize / 2),
                    top: -12, // Nhô lên trên đường cong
                    child: GestureDetector(
                      onTap: () {
                        HapticFeedback.lightImpact();
                        widget.onItemSelected(widget.selectedIndex);
                      },
                      child: Container(
                        width: circleSize,
                        height: circleSize,
                        decoration: BoxDecoration(
                          color: colors.surface,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: colors.brand.withOpacity(0.18),
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: colors.brand.withOpacity(0.24),
                              blurRadius: 14,
                              offset: const Offset(0, 6),
                            ),
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Icon(
                            activeItem.activeIcon,
                            size: 26,
                            color: colors.brand,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class _CurvedBarPainter extends CustomPainter {
  final double selectedIndex;
  final int itemCount;
  final Color barColor;
  final Color borderColor;
  final Color shadowColor;

  _CurvedBarPainter({
    required this.selectedIndex,
    required this.itemCount,
    required this.barColor,
    required this.borderColor,
    required this.shadowColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (itemCount <= 0) return;

    final itemWidth = size.width / itemCount;
    final cx = itemWidth * (selectedIndex + 0.5);

    // Kích thước đường cong võng xuống
    const curveRadius = 38.0;
    const depth = 28.0;

    final p1 = cx - curveRadius - 18.0;
    final p2 = cx - curveRadius;
    final p3 = cx;
    final p4 = cx + curveRadius;
    final p5 = cx + curveRadius + 18.0;

    final path = Path();
    path.moveTo(0, 0);

    // Đoạn thẳng bên trái
    if (p1 > 0) {
      path.lineTo(p1, 0);
    } else {
      path.lineTo(0, 0);
    }

    // Uốn lượn vòng cung võng xuống quanh nút tròn
    path.cubicTo(
      p1 + 10, 0,
      p2 - 6, depth * 0.45,
      p2, depth * 0.85,
    );
    path.cubicTo(
      p2 + 8, depth * 1.15,
      p3 - 18, depth,
      p3, depth,
    );
    path.cubicTo(
      p3 + 18, depth,
      p4 - 8, depth * 1.15,
      p4, depth * 0.85,
    );
    path.cubicTo(
      p4 + 6, depth * 0.45,
      p5 - 10, 0,
      p5, 0,
    );

    // Đoạn thẳng bên phải tới hết màn hình
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    // Vẽ bóng mờ phía trên thanh bar
    final shadowPaint = Paint()
      ..color = shadowColor
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);
    canvas.drawPath(path, shadowPaint);

    // Vẽ nền thanh bar
    final fillPaint = Paint()
      ..color = barColor
      ..style = PaintingStyle.fill;
    canvas.drawPath(path, fillPaint);

    // Vẽ viền trên tinh tế
    final borderPath = Path();
    borderPath.moveTo(0, 0);
    if (p1 > 0) borderPath.lineTo(p1, 0);
    borderPath.cubicTo(
      p1 + 10, 0,
      p2 - 6, depth * 0.45,
      p2, depth * 0.85,
    );
    borderPath.cubicTo(
      p2 + 8, depth * 1.15,
      p3 - 18, depth,
      p3, depth,
    );
    borderPath.cubicTo(
      p3 + 18, depth,
      p4 - 8, depth * 1.15,
      p4, depth * 0.85,
    );
    borderPath.cubicTo(
      p4 + 6, depth * 0.45,
      p5 - 10, 0,
      p5, 0,
    );
    borderPath.lineTo(size.width, 0);

    final borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;
    canvas.drawPath(borderPath, borderPaint);
  }

  @override
  bool shouldRepaint(covariant _CurvedBarPainter oldDelegate) {
    return oldDelegate.selectedIndex != selectedIndex ||
        oldDelegate.barColor != barColor ||
        oldDelegate.borderColor != borderColor;
  }
}
