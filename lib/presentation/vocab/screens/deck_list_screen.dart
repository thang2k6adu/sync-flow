import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pp191225/core/constants/route_constants.dart';
import 'package:pp191225/domain/entities/vocab/deck.dart';
import 'package:pp191225/presentation/vocab/controllers/deck_list_controller.dart';
import 'package:pp191225/presentation/vocab/widgets/create_deck_dialog.dart';
import 'package:pp191225/presentation/vocab/widgets/deck_card_item.dart';
import 'package:pp191225/shared/widgets/common/chunky_card.dart';
import 'package:pp191225/shared/widgets/feedback/overlay.dart';

class DeckListScreen extends ConsumerWidget {
  const DeckListScreen({super.key});

  void _showCreateDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => const CreateDeckDialog(),
    );
  }

  Future<void> _confirmDelete(BuildContext context, WidgetRef ref, Deck deck) async {
    final ok = await showChunkyConfirm(
      context,
      title: 'Xoá bộ từ?',
      message: 'Bộ "${deck.name}" sẽ bị xoá và không thể khôi phục.',
      confirmLabel: 'Xoá',
      cancelLabel: 'Giữ lại',
      destructive: true,
    );
    if (!ok || !context.mounted) return;

    final overlay = UOverlay(context);
    try {
      await ref.read(deckListControllerProvider.notifier).deleteDeck(deck.id);
      overlay.showWithTimeout(message: 'Đã xoá bộ từ');
    } catch (e) {
      overlay.showWithTimeout(message: 'Xoá thất bại');
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final decksAsync = ref.watch(deckListControllerProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: const Text(
          'Kho từ vựng',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 18,
            color: ChunkyColors.textMain,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.school_rounded, color: ChunkyColors.brand),
            tooltip: 'Học ngay (Toàn bộ)',
            onPressed: () => context.push(RouteConstants.studySession),
          ),
          const SizedBox(width: 4),
        ],
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(2),
          child: Divider(height: 2, thickness: 2, color: ChunkyColors.border),
        ),
      ),
      body: decksAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(color: ChunkyColors.brand),
        ),
        error: (err, _) => Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.error_rounded, size: 48, color: ChunkyColors.red),
                const SizedBox(height: 12),
                Text(
                  'Lỗi: ${err.toString()}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: ChunkyColors.textSub,
                  ),
                ),
                const SizedBox(height: 16),
                ChunkyButton(
                  label: 'Thử lại',
                  onPressed: () =>
                      ref.read(deckListControllerProvider.notifier).refresh(),
                ),
              ],
            ),
          ),
        ),
        data: (decks) {
          return RefreshIndicator(
            color: ChunkyColors.brand,
            onRefresh: () =>
                ref.read(deckListControllerProvider.notifier).refresh(),
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                // Banner ôn tập SRS
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
                    child: ChunkyCard(
                      fillColor: ChunkyColors.brand,
                      borderColor: ChunkyColors.brandDark,
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Ôn tập mỗi ngày',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            'Ôn đúng lúc sắp quên để nhớ lâu hơn.',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 16),
                          ChunkyButton(
                            label: 'Bắt đầu ôn tập',
                            color: Colors.white,
                            shadowColor: ChunkyColors.brandBorder,
                            textColor: ChunkyColors.brand,
                            onPressed: () => context.push(RouteConstants.studySession),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
                    child: Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'Bộ từ vựng của bạn',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: ChunkyColors.textMain,
                            ),
                          ),
                        ),
                        Text(
                          '${decks.length} bộ',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: ChunkyColors.textSub,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                if (decks.isEmpty)
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 32),
                      child: Column(
                        children: [
                          const Icon(
                            Icons.style_rounded,
                            size: 72,
                            color: ChunkyColors.brandBorder,
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Chưa có bộ từ vựng nào',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: ChunkyColors.textMain,
                            ),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            'Tạo bộ từ đầu tiên để bắt đầu học nhé!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: ChunkyColors.textSub,
                            ),
                          ),
                          const SizedBox(height: 24),
                          ChunkyButton(
                            label: 'Tạo bộ từ mới',
                            onPressed: () => _showCreateDialog(context),
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final deck = decks[index];
                        return DeckCardItem(
                          deck: deck,
                          onTap: () => context.push(
                            RouteConstants.deckDetail,
                            extra: deck,
                          ),
                          onStudy: () => context.push(
                            RouteConstants.studySession,
                            extra: deck.id,
                          ),
                          onDelete: () => _confirmDelete(context, ref, deck),
                        );
                      },
                      childCount: decks.length,
                    ),
                  ),
                const SliverToBoxAdapter(child: SizedBox(height: 96)),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showCreateDialog(context),
        icon: const Icon(Icons.add_rounded),
        label: const Text(
          'THÊM BỘ TỪ',
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
