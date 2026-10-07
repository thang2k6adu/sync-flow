import 'package:flutter/material.dart';
import 'package:pp191225/core/theme/app_theme.dart';
import 'package:pp191225/shared/widgets/common/chunky_card.dart';

/// Badge hiển thị trên thẻ Leech Card (thẻ khó nhớ, quên >= 1 lần)
class LeechBadge extends StatelessWidget {
  final int lapsesCount;

  const LeechBadge({super.key, required this.lapsesCount});

  @override
  Widget build(BuildContext context) {
    final colors = context.themeColors;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: context.isDarkMode
            ? const Color(0xFF3E1C27)
            : const Color(0xFFFFF1F4),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: colors.coral, width: 1.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.warning_amber_rounded, size: 14, color: colors.coral),
          const SizedBox(width: 4),
          Text(
            'Từ khó • $lapsesCount lần quên',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: colors.coral,
            ),
          ),
        ],
      ),
    );
  }
}

/// Banner hiển thị trên Flashcard mặt trước khi thẻ là Leech
class LeechRescueBanner extends StatelessWidget {
  final String? mnemonicClue;

  const LeechRescueBanner({super.key, this.mnemonicClue});

  @override
  Widget build(BuildContext context) {
    final colors = context.themeColors;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: context.isDarkMode
            ? const Color(0xFF2D1F0D)
            : const Color(0xFFFFF8EB),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: colors.amber.withValues(alpha: 0.5),
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.psychology_rounded, size: 18, color: colors.amber),
              const SizedBox(width: 6),
              Text(
                'MẸO GHI NHỚ',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: colors.amber,
                  letterSpacing: 0.8,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            mnemonicClue ?? 'Thử liên tưởng từ này với hình ảnh hoặc câu chuyện quen thuộc để dễ nhớ hơn.',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: colors.textMain,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

/// Entry point cho phiên Leech Rescue — banner trên đầu Study Session
class LeechRescueSessionBanner extends StatelessWidget {
  final int leechCount;
  final VoidCallback onStart;

  const LeechRescueSessionBanner({
    super.key,
    required this.leechCount,
    required this.onStart,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.themeColors;
    if (leechCount <= 0) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      child: ChunkyCard(
        fillColor: colors.coral,
        borderColor: const Color(0xFFC52940),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: const BoxDecoration(
                    color: Colors.white24,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.local_fire_department_rounded,
                    color: Colors.white,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Phiên cứu trợ từ khó',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Bạn có $leechCount từ hay quên. Ôn tập tập trung để gỡ rối!',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            ChunkyButton(
              label: 'Bắt đầu cứu trợ',
              color: Colors.white,
              shadowColor: const Color(0xFFC52940),
              textColor: colors.coral,
              onPressed: onStart,
            ),
          ],
        ),
      ),
    );
  }
}
