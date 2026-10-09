import 'package:flutter/material.dart';
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
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: const BorderSide(color: ChunkyColors.border, width: 2),
      ),
      backgroundColor: Colors.white,
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
                color: ChunkyColors.yellow,
                border: Border.all(color: const Color(0xFFE5A100), width: 4),
              ),
              child: const Icon(
                Icons.military_tech_rounded,
                size: 54,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 18),
            const Text(
              'LÊN CẤP MỚI!',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.5,
                color: ChunkyColors.textMain,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Chúc mừng bạn đã đạt Cấp độ ${progression.level}!',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: ChunkyColors.textSub,
              ),
            ),
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: ChunkyColors.brandSoft,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: ChunkyColors.brandBorder, width: 1.5),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.stars_rounded, color: ChunkyColors.brand, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    progression.rankTitle,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: ChunkyColors.brand,
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
