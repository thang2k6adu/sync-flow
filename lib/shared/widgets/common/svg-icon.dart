import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Widget đơn giản để hiển thị SVG với khả năng tuỳ chỉnh size.
/// Hỗ trợ 3 nguồn SVG: asset, network hoặc raw SVG string.
/// Chỉ exposes các tuỳ chỉnh cơ bản như size, color, fit.
/// Yêu cầu dependency: flutter_svg
class SvgIconSimple extends StatelessWidget {
  /// Tên file SVG trong assets
  final String? assetName;

  /// URL SVG từ mạng
  final String? networkUrl;

  /// Chuỗi SVG raw
  final String? svgString;

  /// Kích thước widget (width & height)
  final double size;

  /// Màu của SVG, sẽ override màu gốc nếu có
  final Color? color;

  /// Cách fit hình trong bounding box (BoxFit)
  final BoxFit fit;

  /// Label phục vụ cho accessibility
  final String? semanticsLabel;

  /// Constructor cho asset SVG
  const SvgIconSimple.asset(
    this.assetName, {
    super.key,
    this.size = 24.0,
    this.color,
    this.fit = BoxFit.contain,
    this.semanticsLabel,
  }) : networkUrl = null,
       svgString = null;

  /// Constructor cho network SVG
  const SvgIconSimple.network(
    this.networkUrl, {
    super.key,
    this.size = 24.0,
    this.color,
    this.fit = BoxFit.contain,
    this.semanticsLabel,
  }) : assetName = null,
       svgString = null;

  /// Constructor cho SVG raw string
  const SvgIconSimple.string(
    this.svgString, {
    super.key,
    this.size = 24.0,
    this.color,
    this.fit = BoxFit.contain,
    this.semanticsLabel,
  }) : assetName = null,
       networkUrl = null;

  @override
  Widget build(BuildContext context) {
    Widget child;

    // Xác định loại SVG dựa trên constructor được dùng
    if (assetName != null) {
      child = SvgPicture.asset(
        assetName!,
        colorFilter: color != null
            ? ColorFilter.mode(color!, BlendMode.srcIn)
            : null, // nếu null thì giữ màu gốc
        fit: fit,
        semanticsLabel: semanticsLabel,
      );
    } else if (networkUrl != null) {
      child = SvgPicture.network(
        networkUrl!,
        colorFilter: color != null
            ? ColorFilter.mode(color!, BlendMode.srcIn)
            : null,
        fit: fit,
        semanticsLabel: semanticsLabel,
      );
    } else if (svgString != null) {
      child = SvgPicture.string(
        svgString!,
        colorFilter: color != null
            ? ColorFilter.mode(color!, BlendMode.srcIn)
            : null,
        fit: fit,
        semanticsLabel: semanticsLabel,
      );
    } else {
      child = const SizedBox.shrink();
    }

    // Bọc widget SVG trong SizedBox để đảm bảo kích thước
    return SizedBox(
      width: size,
      height: size,
      child: Center(child: child), // center SVG trong bounding box
    );
  }
}
