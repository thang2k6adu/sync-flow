import 'package:flutter/material.dart';
import 'package:pp191225/core/theme/app_theme.dart';
import 'package:pp191225/domain/entities/progression/user_progression.dart';
import 'package:pp191225/shared/widgets/common/chunky_card.dart';

class LevelUpDialog extends StatelessWidget {
  final UserProgression progression;
  final VoidCallback onDismiss;

  const LevelUpDialog({
    super.key,
    required this.progression,
    required this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.themeColors;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: BorderSide(color: colors.border, width: 2),
      ),
      backgroundColor: colors.surface,
      surfaceTintColor: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colors.amber,
                border: Border.all(color: colors.amber.withValues(alpha: 0.8), width: 4),
              ),
              child: const Icon(
                Icons.military_tech_rounded,
                size: 54,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 18),
            Text(
              'LÊN CẤP MỚI!',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.5,
                color: colors.textMain,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Chúc mừng bạn đã đạt Cấp độ ${progression.level}!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: colors.textSub,
              ),
            ),
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: colors.brandSoft,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: colors.brandBorder, width: 1.5),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.stars_rounded, color: colors.brand, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    progression.rankTitle,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: colors.brand,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            ChunkyButton(
              label: 'Tiếp tục học ngay',
              onPressed: () {
                Navigator.of(context).pop();
                onDismiss();
              },
            ),
          ],
        ),
      ),
    );
  }
}
