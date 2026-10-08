import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pp191225/core/theme/app_fonts.dart';
import 'package:pp191225/core/theme/app_theme.dart';
import 'package:pp191225/presentation/progression/controllers/progression_controller.dart';
import 'package:pp191225/shared/widgets/common/chunky_card.dart';

/// Thanh Header trạng thái học tập tinh gọn:
/// - 100% sử dụng icon chuẩn từ Flutter Material Icons (`Icons.*`), không dùng emoji.
/// - Bên trái: Tiêu đề Sync Flow.
/// - Bên phải: Chip Chuỗi ngày (Streak), Chip Cấp độ (Level), Avatar cá nhân.
class GamificationHeaderBar extends ConsumerWidget {
  final VoidCallback? onProfileTap;

  const GamificationHeaderBar({super.key, this.onProfileTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.themeColors;
    final isDark = context.isDarkMode;
    final progressionState = ref.watch(progressionControllerProvider);
    final prog = progressionState.progression;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border(bottom: BorderSide(color: colors.border, width: 2)),
      ),
      child: SafeArea(
        bottom: false,
        child: Row(
          children: [
            // Logo & Tiêu đề ứng dụng
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Sync Flow',
                  style: TextStyle(
                    fontFamily: AppFonts.poppins,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.3,
                    color: colors.brand,
                  ),
                ),
                Text(
                  'Học từ vựng thông minh',
                  style: TextStyle(
                    fontFamily: AppFonts.poppins,
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: colors.textSub,
                  ),
                ),
              ],
            ),
            const Spacer(),

            // Chip Chuỗi ngày học (Streak)
            _StatusChip(
              icon: Icons.local_fire_department_rounded,
              iconColor: const Color(0xFFF59E0B),
              textColor: isDark ? const Color(0xFFFBBF24) : const Color(0xFFB45309),
              backgroundColor: isDark ? const Color(0xFF2E2204) : const Color(0xFFFEF3C7),
              borderColor: isDark ? const Color(0xFF6B4200) : const Color(0xFFFDE68A),
              label: '${prog.streak} ngày',
              tooltip: 'Chuỗi học: ${prog.streak} ngày liên tiếp',
            ),
            const SizedBox(width: 8),

            // Chip Cấp độ & Tiến độ EXP
            _StatusChip(
              icon: Icons.bolt_rounded,
              iconColor: colors.brand,
              textColor: colors.brand,
              backgroundColor: colors.brandSoft,
              borderColor: colors.brandBorder,
              label: 'Lv.${prog.level}',
              tooltip: 'Cấp độ ${prog.level}: ${prog.rankTitle}',
            ),
            const SizedBox(width: 8),

            // Nút Avatar
            ChunkyIconButton.circle(
              icon: Icons.person_rounded,
              size: ChunkyButtonSize.small,
              variant: FlowButtonVariant.secondary,
              tooltip: 'Hồ sơ cá nhân',
              onPressed: onProfileTap,
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color textColor;
  final Color backgroundColor;
  final Color borderColor;
  final String label;
  final String tooltip;

  const _StatusChip({
    required this.icon,
    required this.iconColor,
    required this.textColor,
    required this.backgroundColor,
    required this.borderColor,
    required this.label,
    required this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: borderColor, width: 1.5),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: iconColor, size: 16),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                fontFamily: AppFonts.poppins,
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
