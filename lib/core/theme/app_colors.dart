import 'package:flutter/material.dart';

class AppColors {
  static const Color white = Color(0xFFffffff);
  static const Color black = Color(0xFF000000);
  // ---- Màu theo Figma (PP191225) ----

  /// Màu thương hiệu chính (Figma: Brand/500)
  static const Color primary = Color(0xFF5F33E1);

  /// Màu thương hiệu nhạt, dùng cho nền / vùng chọn (Figma: Brand/600)
  static const Color secondary = Color(0xFFEEE9FF);

  /// Trung tính (Figma: Neutral/50-900)
  static const Color neutral50 = Color(0xFFFFFFFF);
  static const Color neutral200 = Color(0xFFE9EAEB);
  static const Color neutral500 = Color(0xFF717680);
  static const Color neutral700 = Color(0xFF777777);
  static const Color neutral900 = Color(0xFF181D27);

  /// Trạng thái
  static const Color error = Color(0xFF7F1D1D);
  static const Color warning = Color(0xFFFEC84B);
  static const Color success = Color(0xFF6CE9A6);

  static const Color textPrimary = neutral900;
  static const Color textSecondary = neutral500;

  /// Các vệt màu pastel mờ ở nền màn Login
  static const Color blobMint = Color(0xFFDDF5E6);
  static const Color blobLilac = Color(0xFFE6DDFB);
  static const Color blobSky = Color(0xFFDDEEFB);
  static const Color blobCream = Color(0xFFFFF3D6);

  static const List<Color> slate = [
    Color(0xFFf8fafc),
    Color(0xFFf1f5f9),
    Color(0xFFe2e8f0),
    Color(0xFFcbd5e1),
    Color(0xFF94a3b8),
    Color(0xFF64748b),
    Color(0xFF475569),
    Color(0xFF334155),
    Color(0xFF1e293b),
    Color(0xFF0f172a),
    Color(0xFF020617),
  ];

  static const List<Color> gray = [
    Color(0xFFF9FAFB),
    Color(0xFFF3F4F6),
    Color(0xFFE5E7EB),
    Color(0xFFD1D5DB),
    Color(0xFF9CA3AF),
    Color(0xFF6B7280),
    Color(0xFF4B5563),
    Color(0xFF374151),
    Color(0xFF1F2937),
    Color(0xFF111827),
    Color(0xFF030712),
  ];

  static const List<Color> zinc = [
    Color(0xFFFAFAFA),
    Color(0xFFF4F4F5),
    Color(0xFFE4E4E7),
    Color(0xFFD4D4D8),
    Color(0xFFA1A1AA),
    Color(0xFF71717A),
    Color(0xFF52525B),
    Color(0xFF3F3F46),
    Color(0xFF27272A),
    Color(0xFF18181B),
    Color(0xFF09090B),
  ];

  static const List<Color> neutral = [
    Color(0xFFFAFAFA),
    Color(0xFFF5F5F5),
    Color(0xFFE5E5E5),
    Color(0xFFD4D4D4),
    Color(0xFFA3A3A3),
    Color(0xFF737373),
    Color(0xFF525252),
    Color(0xFF404040),
    Color(0xFF262626),
    Color(0xFF171717),
    Color(0xFF0A0A0A),
  ];
  static const List<Color> stone = [
    Color(0xFFfafaf9),
    Color(0xFFf5f5f4),
    Color(0xFFe7e5e4),
    Color(0xFFd6d3d1),
    Color(0xFFa8a29e),
    Color(0xFF78716c),
    Color(0xFF57534e),
    Color(0xFF44403c),
    Color(0xFF292524),
    Color(0xFF1c1917),
    Color(0xFF0c0a09),
  ];
  static const List<Color> red = [
    Color(0xFFfef2f2),
    Color(0xFFfee2e2),
    Color(0xFFfecaca),
    Color(0xFFfca5a5),
    Color(0xFFf87171),
    Color(0xFFef4444),
    Color(0xFFdc2626),
    Color(0xFFb91c1c),
    Color(0xFF991b1b),
    Color(0xFF7f1d1d),
    Color(0xFF450a0a),
  ];
  static const List<Color> orange = [
    Color(0xFFfff7ed),
    Color(0xFFffedd5),
    Color(0xFFfed7aa),
    Color(0xFFfdba74),
    Color(0xFFfb923c),
    Color(0xFFf97316),
    Color(0xFFea580c),
    Color(0xFFc2410c),
    Color(0xFF9a3412),
    Color(0xFF7c2d12),
    Color(0xFF431407),
  ];
  static const List<Color> amber = [
    Color(0xFFfffbeb),
    Color(0xFFfef3c7),
    Color(0xFFfde68a),
    Color(0xFFfcd34d),
    Color(0xFFfbbf24),
    Color(0xFFf59e0b),
    Color(0xFFd97706),
    Color(0xFFb45309),
    Color(0xFF92400e),
    Color(0xFF78350f),
    Color(0xFF451a03),
  ];
  static const List<Color> yellow = [
    Color(0xFFfefce8),
    Color(0xFFfef9c3),
    Color(0xFFfef08a),
    Color(0xFFfde047),
    Color(0xFFfacc15),
    Color(0xFFeab308),
    Color(0xFFca8a04),
    Color(0xFFa16207),
    Color(0xFF854d0e),
    Color(0xFF713f12),
    Color(0xFF422006),
  ];
  static const List<Color> lime = [
    Color(0xFFf7fee7),
    Color(0xFFecfccb),
    Color(0xFFd9f99d),
    Color(0xFFbef264),
    Color(0xFFa3e635),
    Color(0xFF84cc16),
    Color(0xFF65a30d),
    Color(0xFF4d7c0f),
    Color(0xFF3f6212),
    Color(0xFF365314),
    Color(0xFF1a2e05),
  ];
  static const List<Color> green = [
    Color(0xFFf0fdf4),
    Color(0xFFdcfce7),
    Color(0xFFbbf7d0),
    Color(0xFF86efac),
    Color(0xFF4ade80),
    Color(0xFF22c55e),
    Color(0xFF16a34a),
    Color(0xFF15803d),
    Color(0xFF166534),
    Color(0xFF14532d),
    Color(0xFF052e16),
  ];
  static const List<Color> emerald = [
    Color(0xFFecfdf5),
    Color(0xFFd1fae5),
    Color(0xFFa7f3d0),
    Color(0xFF6ee7b7),
    Color(0xFF34d399),
    Color(0xFF10b981),
    Color(0xFF059669),
    Color(0xFF047857),
    Color(0xFF065f46),
    Color(0xFF064e3b),
    Color(0xFF022c22),
  ];
  static const List<Color> teal = [
    Color(0xFFf0fdfa),
    Color(0xFFccfbf1),
    Color(0xFF99f6e4),
    Color(0xFF5eead4),
    Color(0xFF2dd4bf),
    Color(0xFF14b8a6),
    Color(0xFF0d9488),
    Color(0xFF0f766e),
    Color(0xFF115e59),
    Color(0xFF134e4a),
    Color(0xFF042f2e),
  ];
  static const List<Color> cyan = [
    Color(0xFFecfeff),
    Color(0xFFcffafe),
    Color(0xFFa5f3fc),
    Color(0xFF67e8f9),
    Color(0xFF22d3ee),
    Color(0xFF06b6d4),
    Color(0xFF0891b2),
    Color(0xFF0e7490),
    Color(0xFF155e75),
    Color(0xFF164e63),
    Color(0xFF083344),
  ];
  static const List<Color> sky = [
    Color(0xFFf0f9ff),
    Color(0xFFe0f2fe),
    Color(0xFFbae6fd),
    Color(0xFF7dd3fc),
    Color(0xFF38bdf8),
    Color(0xFF0ea5e9),
    Color(0xFF0284c7),
    Color(0xFF0369a1),
    Color(0xFF075985),
    Color(0xFF0c4a6e),
    Color(0xFF082f49),
  ];
  static const List<Color> blue = [
    Color(0xFFeff6ff),
    Color(0xFFdbeafe),
    Color(0xFFbfdbfe),
    Color(0xFF93c5fd),
    Color(0xFF60a5fa),
    Color(0xFF3b82f6),
    Color(0xFF2563eb),
    Color(0xFF1d4ed8),
    Color(0xFF1e40af),
    Color(0xFF1e3a8a),
    Color(0xFF172554),
  ];
  static const List<Color> indigo = [
    Color(0xFFeef2ff),
    Color(0xFFe0e7ff),
    Color(0xFFc7d2fe),
    Color(0xFFa5b4fc),
    Color(0xFF818cf8),
    Color(0xFF6366f1),
    Color(0xFF4f46e5),
    Color(0xFF4338ca),
    Color(0xFF3730a3),
    Color(0xFF312e81),
    Color(0xFF1e1b4b),
  ];
  static const List<Color> violet = [
    Color(0xFFf5f3ff),
    Color(0xFFede9fe),
    Color(0xFFddd6fe),
    Color(0xFFc4b5fd),
    Color(0xFFa78bfa),
    Color(0xFF8b5cf6),
    Color(0xFF7c3aed),
    Color(0xFF6d28d9),
    Color(0xFF5b21b6),
    Color(0xFF4c1d95),
    Color(0xFF2e1065),
  ];
  static const List<Color> purple = [
    Color(0xFFfaf5ff),
    Color(0xFFf3e8ff),
    Color(0xFFe9d5ff),
    Color(0xFFd8b4fe),
    Color(0xFFc084fc),
    Color(0xFFa855f7),
    Color(0xFF9333ea),
    Color(0xFF7e22ce),
    Color(0xFF6b21a8),
    Color(0xFF581c87),
    Color(0xFF3b0764),
  ];
  static const List<Color> fuchsia = [
    Color(0xFFfdf4ff),
    Color(0xFFfae8ff),
    Color(0xFFf5d0fe),
    Color(0xFFf0abfc),
    Color(0xFFe879f9),
    Color(0xFFd946ef),
    Color(0xFFc026d3),
    Color(0xFFa21caf),
    Color(0xFF86198f),
    Color(0xFF701a75),
    Color(0xFF4a044e),
  ];
  static const List<Color> pink = [
    Color(0xFFfdf2f8),
    Color(0xFFfce7f3),
    Color(0xFFfbcfe8),
    Color(0xFFf9a8d4),
    Color(0xFFf472b6),
    Color(0xFFec4899),
    Color(0xFFdb2777),
    Color(0xFFbe185d),
    Color(0xFF9d174d),
    Color(0xFF831843),
    Color(0xFF500724),
  ];
  static const List<Color> rose = [
    Color(0xFFfff1f2),
    Color(0xFFffe4e6),
    Color(0xFFfecdd3),
    Color(0xFFfda4af),
    Color(0xFFfb7185),
    Color(0xFFf43f5e),
    Color(0xFFe11d48),
    Color(0xFFbe123c),
    Color(0xFF9f1239),
    Color(0xFF881337),
    Color(0xFF4c0519),
  ];
}
