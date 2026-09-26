import 'package:flutter/material.dart';
import 'package:pp191225/core/core.dart';

/// Nền trắng có vài vệt màu pastel mờ của màn Login.
class AuthBackground extends StatelessWidget {
  static const double _blobSize = 420;

  final Widget child;

  const AuthBackground({super.key, required this.child});

  static Widget _blob(Color color) {
    return Container(
      width: _blobSize,
      height: _blobSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [color.withValues(alpha: 0.55), color.withValues(alpha: 0)],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        const Positioned.fill(child: ColoredBox(color: AppColors.white)),
        Positioned(top: -120, left: -120, child: _blob(AppColors.blobMint)),
        Positioned(top: 140, right: -160, child: _blob(AppColors.blobLilac)),
        Positioned(bottom: -140, left: -100, child: _blob(AppColors.blobSky)),
        Positioned(bottom: -160, right: -160, child: _blob(AppColors.blobCream)),
        child,
      ],
    );
  }
}
