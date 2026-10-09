import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pp191225/core/constants/route_constants.dart';
import 'package:pp191225/domain/entities/vocab/deck.dart';
import 'package:pp191225/presentation/vocab/controllers/deck_detail_controller.dart';
import 'package:pp191225/presentation/vocab/widgets/vocab_card_item.dart';
import 'package:pp191225/shared/widgets/common/chunky_card.dart';

class DeckDetailScreen extends ConsumerWidget {
  final Deck deck;

  const DeckDetailScreen({super.key, required this.deck});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cardsAsync = ref.watch(deckCardsControllerProvider(deck.id));

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: ChunkyColors.textMain),
          onPressed: () => context.pop(),
        ),
        title: Text(
          deck.name,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 18,
            color: ChunkyColors.textMain,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.school_rounded, color: ChunkyColors.brand),
            tooltip: 'Ôn tập bộ này',
            onPressed: () => context.push(
              RouteConstants.studySession,
              extra: deck.id,
            ),
          ),
          const SizedBox(width: 4),
        ],
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(2),
          child: Divider(height: 2, thickness: 2, color: ChunkyColors.border),
        ),
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Deck header summary
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
              child: ChunkyCard(
                fillColor: ChunkyColors.surfaceMuted,
                borderColor: ChunkyColors.border,
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: ChunkyColors.brandSoft,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: ChunkyColors.brandBorder, width: 1.5),
                          ),
                          child: Text(
                            deck.cefrLevel ?? 'CEFR',
                            style: const TextStyle(
                              color: ChunkyColors.brand,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          deck.category ?? 'Từ vựng',
                          style: const TextStyle(
                            color: ChunkyColors.textSub,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      deck.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: ChunkyColors.textMain,
                      ),
                    ),
                    if (deck.description != null && deck.description!.isNotEmpty) ...[
                      const SizedBox(height: 6),
                      Text(
                        deck.description!,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: ChunkyColors.textSub,
                        ),
                      ),
                    ],
                    const SizedBox(height: 18),
                    ChunkyButton(
                      label: 'Bắt đầu ôn tập ngay',
                      onPressed: () => context.push(
                        RouteConstants.studySession,
                        extra: deck.id,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Cards list section header
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Danh sách thẻ từ',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: ChunkyColors.textMain,
                      ),
                    ),
                  ),
                  cardsAsync.maybeWhen(
                    data: (cards) => Text(
                      '${cards.length} từ',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: ChunkyColors.textSub,
                      ),
                    ),
                    orElse: () => const SizedBox.shrink(),
                  ),
                ],
              ),
            ),
          ),

          // Cards list
          cardsAsync.when(
            loading: () => const SliverFillRemaining(
              child: Center(
                child: CircularProgressIndicator(color: ChunkyColors.brand),
              ),
            ),
            error: (err, _) => SliverFillRemaining(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.error_outline_rounded, size: 48, color: ChunkyColors.red),
                      const SizedBox(height: 12),
                      Text(
                        'Lỗi tải danh sách: $err',
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontWeight: FontWeight.w600, color: ChunkyColors.textSub),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            data: (cards) {
              if (cards.isEmpty) {
                return SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.style_rounded,
                            size: 64,
                            color: ChunkyColors.border,
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Chưa có thẻ từ vựng nào',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: ChunkyColors.textMain,
                            ),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            'Bấm nút bên dưới để thêm từ mới vào bộ nhé!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: ChunkyColors.textSub,
                            ),
                          ),
                          const SizedBox(height: 20),
                          ChunkyButton(
                            label: 'Thêm thẻ từ mới',
                            onPressed: () => context.push(
                              RouteConstants.cardForm,
                              extra: deck,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }

              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final card = cards[index];
                    return VocabCardItem(
                      card: card,
                      onTap: () {},
                    );
                  },
                  childCount: cards.length,
                ),
              );
            },
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 96)),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(
          RouteConstants.cardForm,
          extra: deck,
        ),
        icon: const Icon(Icons.add_rounded),
        label: const Text(
          'THÊM TỪ MỚI',
          style: TextStyle(fontWeight: FontWeight.w700, letterSpacing: 0.8),
        ),
        elevation: 0,
        focusElevation: 0,
        hoverElevation: 0,
        highlightElevation: 0,
        backgroundColor: ChunkyColors.brand,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: ChunkyColors.brandDark, width: 2),
        ),
      ),
    );
  }
}
