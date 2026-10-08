import 'package:flutter/material.dart';
import 'package:pp191225/core/theme/app_fonts.dart';
import 'package:pp191225/core/theme/app_theme.dart';
import 'package:pp191225/shared/widgets/common/chunky_card.dart';

/// Khối: Hôm nay cần ôn tập (Spaced Repetition Hub)
/// - Chỉ hiển thị khi có thẻ đến hạn hoặc từ hay quên cần cứu trợ.
/// - Nếu không có thẻ nào đến hạn, trả về SizedBox.shrink() để không chiếm diện tích hoặc đè chữ.
class SrsAlertCard extends StatelessWidget {
  final int dueCount;
  final int leechCount;
  final VoidCallback onStartLeechRescue;
  final VoidCallback onStartDueStudy;

  const SrsAlertCard({
    super.key,
    required this.dueCount,
    required this.leechCount,
    required this.onStartLeechRescue,
    required this.onStartDueStudy,
  });

  @override
  Widget build(BuildContext context) {
    // Không có thẻ nào cần ôn: ẩn hoàn toàn khối này để tránh chiếm diện tích / đè chữ
    if (dueCount <= 0) {
      return const SizedBox.shrink();
    }

    final colors = context.themeColors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Tiêu đề khối
        Row(
          children: [
            Icon(Icons.alarm_rounded, color: colors.brand, size: 20),
            const SizedBox(width: 8),
            Text(
              'Hôm nay cần ôn tập',
              style: TextStyle(
                fontFamily: AppFonts.poppins,
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: colors.textMain,
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: colors.brandSoft,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Spaced Repetition',
                style: TextStyle(
                  fontFamily: AppFonts.poppins,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: colors.brand,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),

        // Thẻ nội dung ôn tập
        ChunkyCard(
          fillColor: colors.surface,
          borderColor: colors.borderStrong,
          depth: 4,
          radius: 18,
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Chỉ số chi tiết
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Icon(Icons.history_rounded, size: 20, color: colors.brand),
                        const SizedBox(width: 6),
                        Text(
                          '$dueCount thẻ đến hạn',
                          style: TextStyle(
                            fontFamily: AppFonts.poppins,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: colors.textMain,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (leechCount > 0)
                    Row(
                      children: [
                        Icon(Icons.shield_rounded, size: 18, color: colors.coral),
                        const SizedBox(width: 4),
                        Text(
                          '$leechCount thẻ khó nhớ',
                          style: TextStyle(
                            fontFamily: AppFonts.poppins,
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: colors.coral,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
              const SizedBox(height: 16),

              // Nút hành động chính
              if (dueCount > 0)
                ChunkyButton.primary(
                  label: 'Ôn tập ngay ($dueCount thẻ)',
                  icon: Icons.play_arrow_rounded,
                  size: ChunkyButtonSize.large,
                  onPressed: onStartDueStudy,
                ),

              // Nút phụ giải cứu nếu có Leech
              if (leechCount > 0) ...[
                if (dueCount > 0) const SizedBox(height: 10),
                ChunkyButton.coral(
                  label: 'Cứu trợ $leechCount từ hay quên',
                  icon: Icons.shield_rounded,
                  size: ChunkyButtonSize.medium,
                  onPressed: onStartLeechRescue,
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
