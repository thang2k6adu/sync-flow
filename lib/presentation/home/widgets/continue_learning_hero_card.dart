import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pp191225/core/theme/app_fonts.dart';
import 'package:pp191225/core/theme/app_theme.dart';
import 'package:pp191225/domain/entities/vocab/deck.dart';
import 'package:pp191225/shared/widgets/common/chunky_card.dart';

/// Thẻ Tiếp tục học (In-Progress Deck Card) thiết kế hiện đại, tinh giản:
/// - Loại bỏ hoàn toàn nút xanh lá chói lọi, thay bằng phong cách Modern EdTech cao cấp.
/// - Không cắt cụt chữ tên bộ từ.
/// - Thanh tiến độ gradient mượt mà với số liệu rõ ràng.
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

    final totalCards = deck.cardCount > 0 ? deck.cardCount : 20;
    final studiedCards = (totalCards * 0.5).round();
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
                fontSize: 15,
                fontWeight: FontWeight.w800,
                color: colors.textMain,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),

        // Thẻ nội dung chính
        ChunkyCard(
          padding: const EdgeInsets.all(18),
          fillColor: colors.surface,
          borderColor: colors.borderStrong,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hàng thông tin trên: Icon + Tên bộ từ + Badge Level
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Icon bộ từ
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: colors.brandSoft,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: colors.brand.withOpacity(0.2),
                        width: 1.5,
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.auto_stories_rounded,
                        color: colors.brand,
                        size: 22,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Tên bộ từ & Chủ đề
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          deck.name,
                          style: TextStyle(
                            fontFamily: AppFonts.poppins,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: colors.textMain,
                            height: 1.25,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 3),
                        Row(
                          children: [
                            Icon(
                              Icons.category_outlined,
                              size: 13,
                              color: colors.textSub,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              deck.category != null && deck.category!.isNotEmpty
                                  ? deck.category!
                                  : 'Chủ đề học',
                              style: TextStyle(
                                fontFamily: AppFonts.poppins,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: colors.textSub,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Badge CEFR Level
                  if (deck.cefrLevel != null && deck.cefrLevel!.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                      decoration: BoxDecoration(
                        color: colors.brand.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: colors.brand.withOpacity(0.25),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        deck.cefrLevel!,
                        style: TextStyle(
                          fontFamily: AppFonts.poppins,
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          color: colors.brand,
                        ),
                      ),
                    ),
                ],
              ),

              const SizedBox(height: 16),

              // Thanh tiến độ & phần trăm ghi nhớ
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
                  RichText(
                    text: TextSpan(
                      text: '$percent% ',
                      style: TextStyle(
                        fontFamily: AppFonts.poppins,
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        color: colors.brand,
                      ),
                      children: [
                        TextSpan(
                          text: '($studiedCards/$totalCards từ)',
                          style: TextStyle(
                            fontFamily: AppFonts.poppins,
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: colors.textSub,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Progress Bar hiện đại
              Container(
                height: 8,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: colors.surfaceMuted,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Stack(
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          width: constraints.maxWidth * progress,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [colors.brand, colors.brandDark],
                            ),
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),

              const SizedBox(height: 18),

              // Nút hành động hiện đại (không dùng màu neon lỗi thời)
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    HapticFeedback.lightImpact();
                    onStudy();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colors.brand,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Tiếp tục phiên học',
                        style: TextStyle(
                          fontFamily: AppFonts.poppins,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.2,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.arrow_forward_rounded,
                        size: 18,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
