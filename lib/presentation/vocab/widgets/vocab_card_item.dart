import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pp191225/core/theme/app_theme.dart';
import 'package:pp191225/domain/entities/vocab/vocab_card.dart';
import 'package:pp191225/providers/datasources_provider.dart';
import 'package:pp191225/shared/widgets/common/chunky_card.dart';

class VocabCardItem extends ConsumerWidget {
  final VocabCard card;
  final VoidCallback? onTap;

  const VocabCardItem({
    super.key,
    required this.card,
    this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.themeColors;
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
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: colors.textMain,
                        ),
                      ),
                      if (card.phonetic != null && card.phonetic!.isNotEmpty) ...[
                        const SizedBox(width: 8),
                        Text(
                          card.phonetic!,
                          style: TextStyle(
                            fontSize: 13,
                            color: colors.textSub,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                      const SizedBox(width: 8),
                      InkWell(
                        onTap: () {
                          ref.read(ttsServiceProvider).speak(
                            text: card.term,
                            audioUrl: card.audioUrl,
                          );
                        },
                        borderRadius: BorderRadius.circular(16),
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: Icon(
                            Icons.volume_up_rounded,
                            color: colors.brand,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (card.cefrLevel != null)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: colors.brandSoft,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: colors.brandBorder, width: 1.5),
                    ),
                    child: Text(
                      card.cefrLevel!,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: colors.brand,
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
                        color: colors.surfaceMuted,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: colors.border, width: 1),
                      ),
                      child: Text(
                        firstMeaning.pos!,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: colors.textSub,
                        ),
                      ),
                    ),
                  Expanded(
                    child: Text(
                      firstMeaning.meaningVi,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: colors.textMain,
                      ),
                    ),
                  ),
                ],
              ),
              if (firstMeaning.exampleEn != null && firstMeaning.exampleEn!.isNotEmpty) ...[
                const SizedBox(height: 6),
                Text(
                  '“${firstMeaning.exampleEn!}”',
                  style: TextStyle(
                    fontSize: 12,
                    color: colors.textSub,
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
