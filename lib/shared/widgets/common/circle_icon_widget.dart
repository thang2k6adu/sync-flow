import 'package:flutter/material.dart';

class CircleIconWidget extends StatelessWidget {
  final String iconUrl;
  final double size;
  final double iconSize;
  final Color backgroundColor;
  final Color? borderColor;
  final double borderWidth;
  final VoidCallback? onTap;
  final BoxFit iconFit;
  final double elevation;
  final Color? shadowColor;
  final EdgeInsets? padding;
  final Color? iconColor;
  const CircleIconWidget({
    super.key,
    required this.iconUrl,
    this.size = 56.0,
    this.iconSize = 28.0,
    this.backgroundColor = Colors.blue,
    this.borderColor,
    this.borderWidth = 0.0,
    this.onTap,
    this.iconFit = BoxFit.contain,
    this.elevation = 0.0,
    this.shadowColor,
    this.padding,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
          border: borderWidth > 0
              ? Border.all(
                  color: borderColor ?? Colors.transparent,
                  width: borderWidth,
                )
              : null,
          boxShadow: elevation > 0
              ? [
                  BoxShadow(
                    color: shadowColor ?? Colors.black.withOpacity(0.2),
                    blurRadius: elevation,
                    offset: Offset(0, elevation / 2),
                  ),
                ]
              : null,
        ),
        child: ClipOval(
          child: Padding(
            padding: padding ?? EdgeInsets.all(size * 0.2),
            child: Image.asset(
              iconUrl,
              width: iconSize,
              height: iconSize,  
              errorBuilder: (context, error, stackTrace) {
                return Icon(
                  Icons.error_outline,
                  color: iconColor,
                  size: iconSize,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}