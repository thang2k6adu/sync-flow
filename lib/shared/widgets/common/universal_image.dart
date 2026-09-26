import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

/// Hiển thị ảnh từ cả Asset và Network.
/// Tự nhận diện đường dẫn, có loading, error, và cache.
class UniversalImage extends StatelessWidget {
  final String src;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;

  const UniversalImage({
    Key? key,
    required this.src,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
  }) : super(key: key);

  bool get _isNetwork => src.startsWith('http');

  @override
  Widget build(BuildContext context) {
    final imageWidget = _isNetwork
        ? CachedNetworkImage(
            imageUrl: src,
            fit: fit,
            width: width,
            height: height,
            placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator(strokeWidth: 2)),
            errorWidget: (context, url, error) =>
                const Center(child: Icon(Icons.broken_image, size: 48)),
          )
        : Image.asset(
            src,
            fit: fit,
            width: width,
            height: height,
            errorBuilder: (context, error, stackTrace) =>
                const Center(child: Icon(Icons.broken_image, size: 48)),
          );

    if (borderRadius != null) {
      return ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.zero,
        child: imageWidget,
      );
    }

    return imageWidget;
  }
}
