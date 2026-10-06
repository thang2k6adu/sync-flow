import 'package:flutter/material.dart';
import 'package:pp191225/shared/widgets/common/chunky_card.dart';

/// Nút bấm 3D phong cách Duolingo cho các màn hình Auth / Login / Register.
class BrandButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool filled;

  const BrandButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.filled = true,
  });

  @override
  Widget build(BuildContext context) {
    if (filled) {
      return ChunkyButton(
        label: label,
        onPressed: onPressed,
        height: 50,
        depth: 4,
        radius: 16,
      );
    } else {
      return ChunkyButton.outlined(
        label: label,
        onPressed: onPressed,
        height: 50,
        depth: 4,
        radius: 16,
      );
    }
  }
}
