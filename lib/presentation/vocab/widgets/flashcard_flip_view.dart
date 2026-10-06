import 'dart:math';
import 'package:flutter/material.dart';
import 'package:pp191225/core/theme/app_colors.dart';
import 'package:pp191225/domain/entities/vocab/study_item.dart';

class FlashcardFlipView extends StatelessWidget {
  final StudyItem item;
  final bool isFlipped;
  final VoidCallback onFlip;

  const FlashcardFlipView({
    super.key,
    required this.item,
    required this.isFlipped,
    required this.onFlip,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onFlip,
      child: TweenAnimationBuilder(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOutBack,
        tween: Tween<double>(begin: 0, end: isFlipped ? 180 : 0),
        builder: (context, double value, child) {
          final isBack = value >= 90;
          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY((value * pi) / 180),
            child: Container(
              width: double.infinity,
              height: 380,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.08),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
                border: Border.all(
                  color: isBack
                      ? AppColors.primary.withOpacity(0.4)
                      : AppColors.neutral200,
                  width: 1.5,
                ),
              ),
              child: isBack
                  ? Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()..rotateY(pi),
                      child: _buildBackContent(),
                    )
                  : _buildFrontContent(),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFrontContent() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.secondary,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              'Cấp độ SRS: ${item.masteryLevel}',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
          ),
          const Spacer(),
          Text(
            item.term,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
              color: AppColors.neutral900,
            ),
          ),
          if (item.phonetic != null && item.phonetic!.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              item.phonetic!,
              style: const TextStyle(
                fontSize: 18,
                color: AppColors.neutral500,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.touch_app_outlined, size: 16, color: AppColors.slate[4]),
              const SizedBox(width: 6),
              Text(
                'Chạm vào thẻ để lật xem nghĩa',
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.slate[5],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBackContent() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                item.term,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              if (item.phonetic != null) ...[
                const SizedBox(width: 8),
                Text(
                  item.phonetic!,
                  style: const TextStyle(
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                    color: AppColors.neutral500,
                  ),
                ),
              ],
            ],
          ),
          const Divider(height: 20),
          Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: item.meanings.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final m = item.meanings[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        if (m.pos != null)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            margin: const EdgeInsets.only(right: 6),
                            decoration: BoxDecoration(
                              color: AppColors.slate[2],
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              m.pos!,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: AppColors.slate[7],
                              ),
                            ),
                          ),
                        Expanded(
                          child: Text(
                            m.meaningVi,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: AppColors.neutral900,
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (m.definitionEn != null && m.definitionEn!.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        m.definitionEn!,
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppColors.neutral700,
                        ),
                      ),
                    ],
                    if (m.exampleEn != null && m.exampleEn!.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.slate[0],
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppColors.slate[2]),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '“${m.exampleEn!}”',
                              style: const TextStyle(
                                fontSize: 12,
                                fontStyle: FontStyle.italic,
                                color: AppColors.neutral900,
                              ),
                            ),
                            if (m.exampleVi != null && m.exampleVi!.isNotEmpty) ...[
                              const SizedBox(height: 2),
                              Text(
                                m.exampleVi!,
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: AppColors.neutral500,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
