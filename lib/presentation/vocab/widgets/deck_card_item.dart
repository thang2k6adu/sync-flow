import 'package:flutter/material.dart';
import 'package:pp191225/domain/entities/vocab/deck.dart';
import 'package:pp191225/shared/widgets/common/chunky_card.dart';

class DeckCardItem extends StatelessWidget {
  final Deck deck;
  final VoidCallback onTap;
  final VoidCallback onStudy;
  final VoidCallback? onDelete;

  const DeckCardItem({
    super.key,
    required this.deck,
    required this.onTap,
    required this.onStudy,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: ChunkyCard(
        onTap: onTap,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: ChunkyColors.brand,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(Icons.style_rounded, color: Colors.white, size: 26),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        deck.name,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: ChunkyColors.textMain,
                        ),
                      ),
                      if (deck.description != null && deck.description!.isNotEmpty) ...[
                        const SizedBox(height: 2),
                        Text(
                          deck.description!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: ChunkyColors.textSub,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                if (deck.cefrLevel != null)
                  Container(
                    margin: const EdgeInsets.only(left: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: ChunkyColors.brandSoft,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: ChunkyColors.brandBorder, width: 2),
                    ),
                    child: Text(
                      deck.cefrLevel!,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: ChunkyColors.brand,
                      ),
                    ),
                  ),
                if (onDelete != null)
                  PopupMenuButton<String>(
                    icon: const Icon(Icons.more_vert_rounded, color: ChunkyColors.textSub),
                    color: Colors.white,
                    surfaceTintColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                      side: const BorderSide(color: ChunkyColors.border, width: 2),
                    ),
                    onSelected: (value) {
                      if (value == 'delete') onDelete?.call();
                    },
                    itemBuilder: (context) => const [
                      PopupMenuItem(
                        value: 'delete',
                        child: Row(
                          children: [
                            Icon(Icons.delete_rounded, color: ChunkyColors.red, size: 20),
                            SizedBox(width: 8),
                            Text(
                              'Xoá bộ từ',
                              style: TextStyle(
                                color: ChunkyColors.red,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(Icons.category_rounded, size: 16, color: ChunkyColors.textSub),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    deck.category ?? 'Tổng quát',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 13,
                      color: ChunkyColors.textSub,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                SizedBox(
                  width: 128,
                  child: ChunkyButton(label: 'Ôn tập', onPressed: onStudy),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
