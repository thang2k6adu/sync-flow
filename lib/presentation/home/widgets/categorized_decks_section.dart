import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pp191225/core/theme/app_fonts.dart';
import 'package:pp191225/core/theme/app_theme.dart';
import 'package:pp191225/domain/entities/vocab/deck.dart';
import 'package:pp191225/shared/widgets/common/chunky_card.dart';

/// Mục hiển thị danh mục các bộ từ với bộ lọc Pills xúc giác chuẩn Duolingo:
class CategorizedDecksSection extends StatefulWidget {
  final List<Deck> decks;
  final Function(Deck) onStudy;
  final Function(Deck) onTap;
  final VoidCallback onSeeAll;

  const CategorizedDecksSection({
    super.key,
    required this.decks,
    required this.onStudy,
    required this.onTap,
    required this.onSeeAll,
  });

  @override
  State<CategorizedDecksSection> createState() => _CategorizedDecksSectionState();
}

class _CategorizedDecksSectionState extends State<CategorizedDecksSection> {
  int _selectedFilterIndex = 0;
  final List<String> _filters = ['Tất cả', 'Khám phá (CEFR)', 'Của tôi'];

  List<Deck> get _filteredDecks {
    switch (_selectedFilterIndex) {
      case 1:
        return widget.decks.where((d) => d.isSystem).toList();
      case 2:
        return widget.decks.where((d) => !d.isSystem).toList();
      default:
        return widget.decks;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.themeColors;
    final filtered = _filteredDecks;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.auto_stories_rounded, color: colors.brand, size: 20),
                const SizedBox(width: 8),
                Text(
                  'Kho bộ từ vựng',
                  style: TextStyle(
                    fontFamily: AppFonts.poppins,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: colors.textMain,
                  ),
                ),
              ],
            ),
            InkWell(
              onTap: widget.onSeeAll,
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                child: Row(
                  children: [
                    Text(
                      'Xem tất cả',
                      style: TextStyle(
                        fontFamily: AppFonts.poppins,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: colors.brand,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(Icons.arrow_forward_ios_rounded, size: 12, color: colors.brand),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Filter Pills
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
            children: List.generate(_filters.length, (index) {
              final isSelected = _selectedFilterIndex == index;
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: _FilterPill(
                  label: _filters[index],
                  isSelected: isSelected,
                  onTap: () {
                    HapticFeedback.selectionClick();
                    setState(() => _selectedFilterIndex = index);
                  },
                ),
              );
            }),
          ),
        ),
        const SizedBox(height: 14),

        // Danh sách các Deck
        if (filtered.isEmpty)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: colors.surfaceMuted,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: colors.border, width: 2),
            ),
            child: Center(
              child: Text(
                'Chưa có bộ từ vựng nào trong mục này.',
                style: TextStyle(
                  fontFamily: AppFonts.poppins,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: colors.textSub,
                ),
              ),
            ),
          )
        else
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: filtered.length > 5 ? 5 : filtered.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final deck = filtered[index];
              return _ModernDeckItem(
                deck: deck,
                onStudy: () => widget.onStudy(deck),
                onTap: () => widget.onTap(deck),
              );
            },
          ),
      ],
    );
  }
}

class _FilterPill extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterPill({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.themeColors;

    if (isSelected) {
      return ChunkyButton.primary(
        label: label,
        size: ChunkyButtonSize.small,
        onPressed: onTap,
      );
    }

    return ChunkyButton.outlined(
      label: label,
      size: ChunkyButtonSize.small,
      color: colors.surface,
      shadowColor: colors.border,
      textColor: colors.textSub,
      onPressed: onTap,
    );
  }
}

class _ModernDeckItem extends StatelessWidget {
  final Deck deck;
  final VoidCallback onStudy;
  final VoidCallback onTap;

  const _ModernDeckItem({
    required this.deck,
    required this.onStudy,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.themeColors;

    return ChunkyCard(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      radius: 16,
      depth: 3,
      onTap: onTap,
      child: Row(
        children: [
          // Icon hoặc CEFR Pill
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: colors.brandSoft,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: colors.brandBorder, width: 2),
            ),
            alignment: Alignment.center,
            child: deck.cefrLevel != null && deck.cefrLevel!.isNotEmpty
                ? Text(
                    deck.cefrLevel!,
                    style: TextStyle(
                      fontFamily: AppFonts.poppins,
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: colors.brand,
                    ),
                  )
                : Icon(Icons.school_rounded, color: colors.brand, size: 22),
          ),
          const SizedBox(width: 14),

          // Tên bộ từ và metadata
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  deck.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: AppFonts.poppins,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: colors.textMain,
                  ),
                ),
                const SizedBox(height: 3),
                Row(
                  children: [
                    Icon(Icons.style_outlined, size: 13, color: colors.textSub),
                    const SizedBox(width: 4),
                    Text(
                      '${deck.cardCount} thẻ từ',
                      style: TextStyle(
                        fontFamily: AppFonts.poppins,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: colors.textSub,
                      ),
                    ),
                    if (deck.category != null && deck.category!.isNotEmpty) ...[
                      const SizedBox(width: 8),
                      Text('•', style: TextStyle(color: colors.textSub, fontSize: 10)),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          deck.category!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: AppFonts.poppins,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: colors.textSub,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),

          // Nút học 3D xúc giác
          SizedBox(
            width: 84,
            child: ChunkyButton(
              label: 'Học',
              size: ChunkyButtonSize.small,
              onPressed: onStudy,
            ),
          ),
        ],
      ),
    );
  }
}
