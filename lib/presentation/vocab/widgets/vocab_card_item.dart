import 'package:flutter/material.dart';
import 'package:pp191225/domain/entities/vocab/vocab_card.dart';
import 'package:pp191225/shared/widgets/common/chunky_card.dart';

class VocabCardItem extends StatelessWidget {
  final VocabCard card;
  final VoidCallback? onTap;

  const VocabCardItem({
    super.key,
    required this.card,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final firstMeaning = card.meanings.isNotEmpty ? card.meanings.first : null;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: ChunkyCard(
        onTap: onTap,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Text(
                        card.term,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: ChunkyColors.textMain,
                        ),
                      ),
                      if (card.phonetic != null && card.phonetic!.isNotEmpty) ...[
                        const SizedBox(width: 8),
                        Text(
                          card.phonetic!,
                          style: const TextStyle(
                            fontSize: 13,
                            color: ChunkyColors.textSub,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                if (card.cefrLevel != null)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: ChunkyColors.brandSoft,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: ChunkyColors.brandBorder, width: 1.5),
                    ),
                    child: Text(
                      card.cefrLevel!,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: ChunkyColors.brand,
                      ),
                    ),
                  ),
              ],
            ),
            if (firstMeaning != null) ...[
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (firstMeaning.pos != null)
                    Container(
                      margin: const EdgeInsets.only(right: 8, top: 1),
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: ChunkyColors.surfaceMuted,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: ChunkyColors.border, width: 1),
                      ),
                      child: Text(
                        firstMeaning.pos!,
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: ChunkyColors.textSub,
                        ),
                      ),
                    ),
                  Expanded(
                    child: Text(
                      firstMeaning.meaningVi,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: ChunkyColors.textMain,
                      ),
                    ),
                  ),
                ],
              ),
              if (firstMeaning.exampleEn != null && firstMeaning.exampleEn!.isNotEmpty) ...[
                const SizedBox(height: 6),
                Text(
                  '“${firstMeaning.exampleEn!}”',
                  style: const TextStyle(
                    fontSize: 12,
                    color: ChunkyColors.textSub,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }
}
