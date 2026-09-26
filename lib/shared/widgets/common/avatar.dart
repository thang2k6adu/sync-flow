// Avatar widget with gradient border and optional glow
import 'package:flutter/material.dart';

/// Avatar tròn có viền gradient, có thể hiện glow (shadow).
/// - [image]: ImageProvider (AssetImage, NetworkImage, MemoryImage...)
/// - [size]: đường kính avatar ngoài (bao gồm viền)
/// - [borderWidth]: độ dày viền gradient
/// - [borderColors]: màu gradient viền
/// - [backgroundColor]: màu nền bên trong viền (nếu image có vùng trong suốt)
/// - [showGlow]: bật/tắt glow
class AvatarWidget extends StatelessWidget {
  final ImageProvider image;
  final double size;
  final double borderWidth;
  final List<Color>? borderColors;
  final Color backgroundColor;
  final bool showGlow;

  const AvatarWidget({
    super.key,
    required this.image,
    this.size = 64,
    this.borderWidth = 4,
    this.borderColors,
    this.backgroundColor = Colors.white,
    this.showGlow = true,
  });

  @override
  Widget build(BuildContext context) {
    final double innerSize = size;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: showGlow ? Border.all(color: Colors.white, width: borderWidth) : null,
        gradient: borderColors?.isNotEmpty ?? false ? LinearGradient(
          colors: borderColors!,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ) : null,
        boxShadow: showGlow
            ? [
                BoxShadow(
                  color: borderColors?.last.withOpacity(0.35) ?? Colors.transparent,
                  blurRadius: 12,
                  spreadRadius: 2,
                ),
              ]
            : null,
      ),
      child: Center(
        child: Container(
          width: innerSize,
          height: innerSize,
          decoration: BoxDecoration(
            color: backgroundColor,
            shape: BoxShape.circle,
          ),
          child: ClipOval(
            child: Image(image: image, fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }
}
