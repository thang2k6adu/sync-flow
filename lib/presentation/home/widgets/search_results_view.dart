import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pp191225/core/constants/route_constants.dart';
import 'package:pp191225/core/theme/app_fonts.dart';
import 'package:pp191225/core/theme/app_theme.dart';
import 'package:pp191225/domain/entities/vocab/deck.dart';
import 'package:pp191225/domain/entities/vocab/vocab_card.dart';
import 'package:pp191225/presentation/home/controllers/unified_search_controller.dart';
import 'package:pp191225/providers/datasources_provider.dart';
import 'package:pp191225/shared/widgets/common/chunky_card.dart';

class SearchResultsView extends ConsumerWidget {
  const SearchResultsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.themeColors;
    final state = ref.watch(unifiedSearchControllerProvider);
    final controller = ref.read(unifiedSearchControllerProvider.notifier);

    if (!state.isSearching) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header kết quả tìm kiếm & Tabs lọc
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Kết quả tìm kiếm ("${state.query}")',
                style: TextStyle(
                  fontFamily: AppFonts.poppins,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: colors.textMain,
                ),
              ),
              Text(
                '${state.totalMatches} kết quả',
                style: TextStyle(
                  fontFamily: AppFonts.poppins,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: colors.brand,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Bộ lọc Tab: Tất cả / Bộ từ / Từ vựng
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildFilterChip(
                  label: 'Tất cả (${state.totalMatches})',
                  isSelected: state.tabFilter == SearchTabFilter.all,
                  onTap: () => controller.setTabFilter(SearchTabFilter.all),
                  colors: colors,
                ),
                const SizedBox(width: 8),
                _buildFilterChip(
                  label: 'Bộ từ (${state.matchedDecks.length})',
                  isSelected: state.tabFilter == SearchTabFilter.decks,
                  onTap: () => controller.setTabFilter(SearchTabFilter.decks),
                  colors: colors,
                ),
                const SizedBox(width: 8),
                _buildFilterChip(
                  label: 'Từ vựng (${state.matchedCards.length})',
                  isSelected: state.tabFilter == SearchTabFilter.cards,
                  onTap: () => controller.setTabFilter(SearchTabFilter.cards),
                  colors: colors,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Nội dung kết quả
          if (state.totalMatches == 0)
            _buildEmptyState(colors)
          else ...[
            if (state.tabFilter == SearchTabFilter.all ||
                state.tabFilter == SearchTabFilter.decks)
              if (state.matchedDecks.isNotEmpty) ...[
                _buildSectionHeader(
                  title: 'Bộ từ liên quan',
                  count: state.matchedDecks.length,
                  icon: Icons.folder_copy_rounded,
                  colors: colors,
                ),
                const SizedBox(height: 8),
                ...state.matchedDecks.map((deck) => _buildDeckItem(context, deck, colors)),
                const SizedBox(height: 16),
              ],

            if (state.tabFilter == SearchTabFilter.all ||
                state.tabFilter == SearchTabFilter.cards)
              if (state.matchedCards.isNotEmpty) ...[
                _buildSectionHeader(
                  title: 'Từ vựng khớp từ khóa',
                  count: state.matchedCards.length,
                  icon: Icons.translate_rounded,
                  colors: colors,
                ),
                const SizedBox(height: 8),
                ...state.matchedCards.map((card) => _buildCardItem(context, ref, card, colors)),
              ],
          ],
        ],
      ),
    );
  }

  Widget _buildFilterChip({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
    required AppThemeColors colors,
  }) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.selectionClick();
        onTap();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          color: isSelected ? colors.brand : colors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? colors.brand : colors.border,
            width: 1.2,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontFamily: AppFonts.poppins,
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
            color: isSelected ? Colors.white : colors.textSub,
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader({
    required String title,
    required int count,
    required IconData icon,
    required AppThemeColors colors,
  }) {
    return Row(
      children: [
        Icon(icon, size: 16, color: colors.brand),
        const SizedBox(width: 6),
        Text(
          title,
          style: TextStyle(
            fontFamily: AppFonts.poppins,
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: colors.textMain,
          ),
        ),
        const SizedBox(width: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
          decoration: BoxDecoration(
            color: colors.brandSoft,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            '$count',
            style: TextStyle(
              fontFamily: AppFonts.poppins,
              fontSize: 10,
              fontWeight: FontWeight.w800,
              color: colors.brand,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDeckItem(BuildContext context, Deck deck, AppThemeColors colors) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: ChunkyCard(
        padding: const EdgeInsets.all(12),
        fillColor: colors.surface,
        borderColor: colors.border,
        onTap: () {
          context.push(RouteConstants.deckDetail, extra: deck);
        },
        child: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: colors.brandSoft,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(Icons.menu_book_rounded, color: colors.brand, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    deck.name,
                    style: TextStyle(
                      fontFamily: AppFonts.poppins,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: colors.textMain,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '${deck.cardCount} thẻ • ${deck.category ?? 'Bộ từ'}',
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
            if (deck.cefrLevel != null)
              Container(
                margin: const EdgeInsets.only(right: 8),
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: colors.brandSoft,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  deck.cefrLevel!,
                  style: TextStyle(
                    fontFamily: AppFonts.poppins,
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    color: colors.brand,
                  ),
                ),
              ),
            Icon(Icons.arrow_forward_ios_rounded, size: 12, color: colors.textSub),
          ],
        ),
      ),
    );
  }

  Widget _buildCardItem(
    BuildContext context,
    WidgetRef ref,
    VocabCard card,
    AppThemeColors colors,
  ) {
    final tts = ref.read(ttsServiceProvider);
    final firstMeaning = card.meanings.isNotEmpty ? card.meanings.first : null;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: colors.border, width: 1.2),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Nút phát âm loa TTS
          GestureDetector(
            onTap: () {
              HapticFeedback.lightImpact();
              tts.speak(text: card.term, audioUrl: card.audioUrl);
            },
            child: Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: colors.brandSoft,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.volume_up_rounded, color: colors.brand, size: 20),
            ),
          ),
          const SizedBox(width: 12),

          // Chi tiết từ & Nghĩa
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      card.term,
                      style: TextStyle(
                        fontFamily: AppFonts.poppins,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: colors.textMain,
                      ),
                    ),
                    if (card.phonetic != null) ...[
                      const SizedBox(width: 6),
                      Text(
                        card.phonetic!,
                        style: TextStyle(
                          fontSize: 12,
                          color: colors.textSub,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                    const Spacer(),
                    if (card.cefrLevel != null)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: colors.mint.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          card.cefrLevel!,
                          style: TextStyle(
                            fontFamily: AppFonts.poppins,
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            color: colors.mintDark,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 3),
                if (firstMeaning != null)
                  Text(
                    firstMeaning.meaningVi,
                    style: TextStyle(
                      fontFamily: AppFonts.poppins,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: colors.textMain.withOpacity(0.9),
                    ),
                  ),
                if (firstMeaning?.definitionEn != null && firstMeaning!.definitionEn!.isNotEmpty)
                  Text(
                    firstMeaning.definitionEn!,
                    style: TextStyle(
                      fontSize: 11,
                      color: colors.textSub,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(AppThemeColors colors) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Column(
          children: [
            Icon(Icons.search_off_rounded, size: 40, color: colors.textSub.withOpacity(0.5)),
            const SizedBox(height: 8),
            Text(
              'Không tìm thấy bộ từ hay từ vựng phù hợp',
              style: TextStyle(
                fontFamily: AppFonts.poppins,
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: colors.textSub,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Thử tìm kiếm với từ khóa khác hoặc tạo thẻ từ mới',
              style: TextStyle(
                fontSize: 11,
                color: colors.textSub.withOpacity(0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
