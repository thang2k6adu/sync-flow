import 'dart:math';
import 'package:flutter/material.dart';
import 'package:pp191225/domain/entities/vocab/study_item.dart';
import 'package:pp191225/shared/widgets/common/chunky_card.dart';

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
      behavior: HitTestBehavior.opaque,
      child: TweenAnimationBuilder(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
        tween: Tween<double>(begin: 0, end: isFlipped ? 180 : 0),
        builder: (context, double value, child) {
          final isBack = value >= 90;
          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY((value * pi) / 180),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: ChunkyCard(
                depth: 5,
                radius: 24,
                borderColor: isBack ? ChunkyColors.brandBorder : ChunkyColors.border,
                padding: EdgeInsets.zero,
                child: SizedBox(
                  height: 380,
                  child: isBack
                      ? Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.identity()..rotateY(pi),
                          child: _buildBackContent(),
                        )
                      : _buildFrontContent(),
                ),
              ),
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
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: ChunkyColors.brandSoft,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: ChunkyColors.brandBorder, width: 1.5),
            ),
            child: Text(
              'CẤP ĐỘ SRS: ${item.masteryLevel}',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: ChunkyColors.brand,
                letterSpacing: 0.5,
              ),
            ),
          ),
          const Spacer(),
          Text(
            item.term,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.w800,
              color: ChunkyColors.textMain,
            ),
          ),
          if (item.phonetic != null && item.phonetic!.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              item.phonetic!,
              style: const TextStyle(
                fontSize: 17,
                color: ChunkyColors.textSub,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.touch_app_rounded, size: 18, color: ChunkyColors.textSub),
              SizedBox(width: 6),
              Text(
                'Chạm vào thẻ để lật xem nghĩa',
                style: TextStyle(
                  fontSize: 13,
                  color: ChunkyColors.textSub,
                  fontWeight: FontWeight.w600,
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
                  fontWeight: FontWeight.w800,
                  color: ChunkyColors.brand,
                ),
              ),
              if (item.phonetic != null) ...[
                const SizedBox(width: 8),
                Text(
                  item.phonetic!,
                  style: const TextStyle(
                    fontSize: 14,
                    color: ChunkyColors.textSub,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 12),
          const Divider(height: 2, thickness: 2, color: ChunkyColors.border),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: item.meanings.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final m = item.meanings[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (m.pos != null)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            margin: const EdgeInsets.only(right: 8),
                            decoration: BoxDecoration(
                              color: ChunkyColors.brandSoft,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: ChunkyColors.brandBorder, width: 1),
                            ),
                            child: Text(
                              m.pos!,
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: ChunkyColors.brand,
                              ),
                            ),
                          ),
                        Expanded(
                          child: Text(
                            m.meaningVi,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: ChunkyColors.textMain,
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
                          color: ChunkyColors.textSub,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                    if (m.exampleEn != null && m.exampleEn!.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: ChunkyColors.surfaceMuted,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: ChunkyColors.border, width: 1.5),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '“${m.exampleEn!}”',
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: ChunkyColors.textMain,
                              ),
                            ),
                            if (m.exampleVi != null && m.exampleVi!.isNotEmpty) ...[
                              const SizedBox(height: 2),
                              Text(
                                m.exampleVi!,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: ChunkyColors.textSub,
                                  fontWeight: FontWeight.w500,
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
