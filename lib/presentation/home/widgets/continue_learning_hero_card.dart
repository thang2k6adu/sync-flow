import 'package:flutter/material.dart';
import 'package:pp191225/core/theme/app_fonts.dart';
import 'package:pp191225/core/theme/app_theme.dart';
import 'package:pp191225/domain/entities/vocab/deck.dart';
import 'package:pp191225/shared/widgets/common/chunky_card.dart';

/// Khối 2: Tiếp tục học (In Progress / Recent Decks)
/// - Giúp người dùng ngay lập tức tiếp tục phiên học gần nhất mà không cần tìm kiếm.
/// - 100% sử dụng icon chính thức từ Flutter, không dùng emoji.
class ContinueLearningHeroCard extends StatelessWidget {
  final Deck deck;
  final VoidCallback onStudy;

  const ContinueLearningHeroCard({
    super.key,
    required this.deck,
    required this.onStudy,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.themeColors;

    final totalCards = deck.cardCount > 0 ? deck.cardCount : 30;
    final studiedCards = (totalCards * 0.45).round();
    final progress = (studiedCards / totalCards).clamp(0.0, 1.0);
    final percent = (progress * 100).toInt();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Tiêu đề khối
        Row(
          children: [
            Icon(Icons.history_rounded, color: colors.brand, size: 20),
            const SizedBox(width: 8),
            Text(
              'Tiếp tục học',
              style: TextStyle(
                fontFamily: AppFonts.poppins,
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: colors.textMain,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),

        // Thẻ bộ từ đang học
        ChunkyCard(
          fillColor: colors.surface,
          borderColor: colors.borderStrong,
          depth: 4,
          radius: 18,
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Tên bộ từ và Cấp độ
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: colors.brandSoft,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: colors.brandBorder, width: 1.5),
                    ),
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.auto_stories_rounded,
                      color: colors.brand,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          deck.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: AppFonts.poppins,
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: colors.textMain,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          deck.category ?? 'Từ vựng thông dụng',
                          style: TextStyle(
                            fontFamily: AppFonts.poppins,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: colors.textSub,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (deck.cefrLevel != null && deck.cefrLevel!.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: colors.brandSoft,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: colors.brandBorder, width: 1.5),
                      ),
                      child: Text(
                        deck.cefrLevel!,
                        style: TextStyle(
                          fontFamily: AppFonts.poppins,
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          color: colors.brand,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 14),

              // Tiến độ
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Tiến độ ghi nhớ',
                    style: TextStyle(
                      fontFamily: AppFonts.poppins,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: colors.textSub,
                    ),
                  ),
                  Text(
                    '$percent% ($studiedCards/$totalCards từ)',
                    style: TextStyle(
                      fontFamily: AppFonts.poppins,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: colors.brand,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              ChunkyProgressBar(
                value: progress,
                height: 12,
                color: colors.brand,
                trackColor: colors.border,
              ),
              const SizedBox(height: 16),

              // Nút tiếp tục học
              ChunkyButton.mint(
                label: 'Học tiếp ngay',
                icon: Icons.arrow_forward_rounded,
                size: ChunkyButtonSize.medium,
                onPressed: onStudy,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
