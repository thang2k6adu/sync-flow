import 'package:flutter/material.dart';
import 'package:pp191225/core/theme/app_theme.dart';
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
    final colors = context.themeColors;

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
                    color: colors.brand,
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
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: colors.textMain,
                        ),
                      ),
                      if (deck.description != null && deck.description!.isNotEmpty) ...[
                        const SizedBox(height: 2),
                        Text(
                          deck.description!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: colors.textSub,
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
                      color: colors.brandSoft,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: colors.brandBorder, width: 2),
                    ),
                    child: Text(
                      deck.cefrLevel!,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: colors.brand,
                      ),
                    ),
                  ),
                if (onDelete != null)
                  PopupMenuButton<String>(
                    icon: Icon(Icons.more_vert_rounded, color: colors.textSub),
                    color: colors.surface,
                    surfaceTintColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                      side: BorderSide(color: colors.border, width: 2),
                    ),
                    onSelected: (value) {
                      if (value == 'delete') onDelete?.call();
                    },
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: 'delete',
                        child: Row(
                          children: [
                            Icon(Icons.delete_rounded, color: colors.coral, size: 20),
                            const SizedBox(width: 8),
                            Text(
                              'Xoá bộ từ',
                              style: TextStyle(
                                color: colors.coral,
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
                Icon(Icons.category_rounded, size: 16, color: colors.textSub),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    deck.category ?? 'Tổng quát',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13,
                      color: colors.textSub,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                SizedBox(
                  width: 128,
                  child: ChunkyButton(
                    label: 'Ôn tập',
                    size: ChunkyButtonSize.small,
                    onPressed: onStudy,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
