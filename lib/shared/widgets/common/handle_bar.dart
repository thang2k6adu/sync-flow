import 'package:flutter/material.dart';

class HandleBar extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final BorderRadiusGeometry borderRadius;

  const HandleBar({
    super.key,
    this.width = 48,
    this.height = 6,
    this.color = const Color(0xFFCDCFD0),
    this.borderRadius = const BorderRadius.all(Radius.circular(100)),
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: width,
        child: Container(
          height: height,
          decoration: BoxDecoration(
            color: color,
            borderRadius: borderRadius,
          ),
        ),
      ),
    );
  }
}
