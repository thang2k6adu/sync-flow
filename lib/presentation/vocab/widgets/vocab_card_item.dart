import 'package:flutter/material.dart';
import 'package:pp191225/core/theme/app_colors.dart';
import 'package:pp191225/domain/entities/vocab/vocab_card.dart';

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

    return Card(
      elevation: 1,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: AppColors.neutral200.withOpacity(0.8)),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(14),
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
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: AppColors.neutral900,
                          ),
                        ),
                        if (card.phonetic != null && card.phonetic!.isNotEmpty) ...[
                          const SizedBox(width: 8),
                          Text(
                            card.phonetic!,
                            style: const TextStyle(
                              fontSize: 13,
                              fontStyle: FontStyle.italic,
                              color: AppColors.neutral500,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  if (card.cefrLevel != null)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.secondary,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        card.cefrLevel!,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                ],
              ),
              if (firstMeaning != null) ...[
                const SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (firstMeaning.pos != null)
                      Container(
                        margin: const EdgeInsets.only(right: 6, top: 1),
                        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                        decoration: BoxDecoration(
                          color: AppColors.slate[2],
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          firstMeaning.pos!,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: AppColors.slate[7],
                          ),
                        ),
                      ),
                    Expanded(
                      child: Text(
                        firstMeaning.meaningVi,
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.neutral700,
                        ),
                      ),
                    ),
                  ],
                ),
                if (firstMeaning.exampleEn != null && firstMeaning.exampleEn!.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    '"${firstMeaning.exampleEn!}"',
                    style: TextStyle(
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                      color: AppColors.slate[5],
                    ),
                  ),
                ],
              ],
            ],
          ),
        ),
      ),
    );
  }
}
