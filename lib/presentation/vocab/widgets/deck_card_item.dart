import 'package:flutter/material.dart';
import 'package:pp191225/domain/entities/vocab/deck.dart';
import 'package:pp191225/shared/widgets/common/chunky_card.dart';

String getGifPathForDeck(Deck deck) {
  final text = '${deck.name} ${deck.category}'.toLowerCase();
  if (text.contains('ai') || text.contains('artificial')) return 'assets/gifs/artificial-intelligence.gif';
  if (text.contains('city') || text.contains('cities') || text.contains('thành phố')) return 'assets/gifs/cities.gif';
  if (text.contains('economy') || text.contains('kinh tế')) return 'assets/gifs/economy.gif';
  if (text.contains('education') || text.contains('giáo dục')) return 'assets/gifs/educations.gif';
  if (text.contains('environment') || text.contains('môi trường')) return 'assets/gifs/environment.gif';
  if (text.contains('invent') || text.contains('phát minh')) return 'assets/gifs/inventations.gif';
  if (text.contains('medicine') || text.contains('y tế') || text.contains('sức khỏe')) return 'assets/gifs/medicine.gif';
  if (text.contains('psychology') || text.contains('tâm lý')) return 'assets/gifs/psychology.gif';
  if (text.contains('social') || text.contains('xã hội')) return 'assets/gifs/social.gif';
  if (text.contains('tech') || text.contains('công nghệ') || text.contains('it')) return 'assets/gifs/technology.gif';
  
  return 'assets/gifs/educations.gif'; // Fallback
}

class DeckCardItem extends StatelessWidget {
  final Deck deck;
  final VoidCallback onTap;
  final VoidCallback onStudy;
  final VoidCallback? onDelete;
  final bool isSystem;

  const DeckCardItem({
    super.key,
    required this.deck,
    required this.onTap,
    required this.onStudy,
    this.onDelete,
    this.isSystem = false,
  });

  @override
  Widget build(BuildContext context) {
    final gifPath = getGifPathForDeck(deck);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 16),
      child: ChunkyCard(
        onTap: onTap,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        deck.name,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: ChunkyColors.textMain,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (deck.description != null && deck.description!.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        Text(
                          deck.description!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14,
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
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: ChunkyColors.brandSoft,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: ChunkyColors.brandBorder, width: 2),
                    ),
                    child: Text(
                      deck.cefrLevel!,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: ChunkyColors.brand,
                      ),
                    ),
                  ),
                if (isSystem)
                  Container(
                    margin: const EdgeInsets.only(left: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: ChunkyColors.brandSoft,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: ChunkyColors.brandBorder, width: 1),
                    ),
                    child: const Text(
                      'HỆ THỐNG',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        color: ChunkyColors.brand,
                        letterSpacing: 0.5,
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
            // Big GIF in the middle
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: ChunkyColors.background,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: ChunkyColors.border, width: 2),
                ),
                padding: const EdgeInsets.all(24),
                child: Image.asset(
                  gifPath,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.auto_awesome_rounded, size: 64, color: ChunkyColors.brand),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Footer
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.style_rounded, size: 16, color: ChunkyColors.textSub),
                        const SizedBox(width: 6),
                        Text(
                          '${deck.cardCount} thẻ',
                          style: const TextStyle(
                            fontSize: 14,
                            color: ChunkyColors.textSub,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.category_rounded, size: 16, color: ChunkyColors.textSub),
                        const SizedBox(width: 6),
                        Text(
                          deck.category ?? 'Tổng quát',
                          style: const TextStyle(
                            fontSize: 14,
                            color: ChunkyColors.textSub,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                SizedBox(
                  width: 140,
                  height: 48,
                  child: ChunkyButton(label: 'Bắt đầu học', onPressed: onStudy),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
