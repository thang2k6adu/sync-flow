import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pp191225/core/constants/route_constants.dart';
import 'package:pp191225/core/theme/app_theme.dart';
import 'package:pp191225/domain/entities/vocab/deck.dart';
import 'package:pp191225/presentation/vocab/controllers/deck_list_controller.dart';
import 'package:pp191225/presentation/vocab/widgets/create_deck_dialog.dart';
import 'package:pp191225/presentation/vocab/widgets/deck_card_item.dart';
import 'package:pp191225/presentation/vocab/widgets/leech_rescue_widgets.dart';
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

  void _startLeechRescue(BuildContext context) {
    // Navigate to study session with a special flag, or just route to studySession
    // and let controller handle it (e.g. extra: 'leech')
    context.push(RouteConstants.studySession, extra: 'leech_rescue');
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
    final colors = context.themeColors;
    final decksAsync = ref.watch(deckListControllerProvider);
    final leechCountAsync = ref.watch(leechCountProvider);
    final leechCount = leechCountAsync.value ?? 0;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: colors.background,
        appBar: AppBar(
          backgroundColor: colors.surface,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: true,
          title: Text(
            'Kho từ vựng',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18,
              color: colors.textMain,
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.school_rounded, color: colors.brand),
              tooltip: 'Học ngay (Toàn bộ)',
              onPressed: () => context.push(RouteConstants.studySession),
            ),
            const SizedBox(width: 4),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: Column(
              children: [
                Divider(height: 2, thickness: 2, color: colors.border),
                TabBar(
                  labelColor: colors.brand,
                  unselectedLabelColor: colors.textSub,
                  labelStyle: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                  unselectedLabelStyle: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                  indicatorColor: colors.brand,
                  indicatorWeight: 3,
                  dividerColor: colors.border,
                  dividerHeight: 2,
                  tabs: const [
                    Tab(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.explore_rounded, size: 18),
                          SizedBox(width: 6),
                          Text('Khám phá'),
                        ],
                      ),
                    ),
                    Tab(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.folder_special_rounded, size: 18),
                          SizedBox(width: 6),
                          Text('Thư viện của tôi'),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        body: decksAsync.when(
          loading: () => Center(
            child: CircularProgressIndicator(color: colors.brand),
          ),
          error: (err, _) => Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.error_rounded, size: 48, color: colors.coral),
                  const SizedBox(height: 12),
                  Text(
                    'Lỗi: ${err.toString()}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: colors.textSub,
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
            final systemDecks = decks.where((d) => d.isSystem).toList();
            final personalDecks = decks.where((d) => !d.isSystem).toList();

            return TabBarView(
              children: [
                // Tab 1: Khám phá (System Decks)
                _SystemDecksTab(
                  decks: systemDecks,
                  colors: colors,
                  onStudy: (deck) => context.push(
                    RouteConstants.studySession,
                    extra: deck.id,
                  ),
                  onTap: (deck) => context.push(
                    RouteConstants.deckDetail,
                    extra: deck,
                  ),
                  onRefresh: () =>
                      ref.read(deckListControllerProvider.notifier).refresh(),
                ),

                // Tab 2: Thư viện của tôi (Personal Decks)
                _PersonalDecksTab(
                  decks: personalDecks,
                  leechCount: leechCount,
                  colors: colors,
                  onStudy: (deck) => context.push(
                    RouteConstants.studySession,
                    extra: deck.id,
                  ),
                  onTap: (deck) => context.push(
                    RouteConstants.deckDetail,
                    extra: deck,
                  ),
                  onDelete: (deck) => _confirmDelete(context, ref, deck),
                  onRefresh: () =>
                      ref.read(deckListControllerProvider.notifier).refresh(),
                  onCreateDeck: () => _showCreateDialog(context),
                  onStartLeech: () => _startLeechRescue(context),
                ),
              ],
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
          backgroundColor: colors.brand,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: colors.brandDark, width: 2),
          ),
        ),
      ),
    );
  }
}

/// Tab Khám phá — hiển thị System Decks theo category
class _SystemDecksTab extends StatelessWidget {
  final List<Deck> decks;
  final AppThemeColors colors;
  final Function(Deck) onStudy;
  final Function(Deck) onTap;
  final Future<void> Function() onRefresh;

  const _SystemDecksTab({
    required this.decks,
    required this.colors,
    required this.onStudy,
    required this.onTap,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: colors.brand,
      onRefresh: onRefresh,
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          // Banner giới thiệu
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
              child: ChunkyCard(
                fillColor: colors.brand,
                borderColor: colors.brandDark,
                padding: const EdgeInsets.all(20),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Bộ từ chuẩn hóa',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Học theo lộ trình CEFR, IELTS, TOEIC hoặc chủ đề cuộc sống. Được biên soạn bởi chuyên gia.',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Phân nhóm theo category
          if (decks.isEmpty)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 32),
                child: Column(
                  children: [
                    Icon(Icons.explore_rounded, size: 72, color: colors.brandBorder),
                    const SizedBox(height: 16),
                    Text(
                      'Sắp ra mắt!',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: colors.textMain,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Bộ từ chuẩn hóa đang được biên soạn. Bạn có thể tạo bộ từ riêng trong tab "Thư viện của tôi".',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: colors.textSub,
                      ),
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
                  return _SystemDeckCard(
                    deck: deck,
                    colors: colors,
                    onTap: () => onTap(deck),
                    onStudy: () => onStudy(deck),
                  );
                },
                childCount: decks.length,
              ),
            ),

          const SliverToBoxAdapter(child: SizedBox(height: 96)),
        ],
      ),
    );
  }
}

/// Card riêng cho System Deck — không có nút xoá, có badge "Hệ thống"
class _SystemDeckCard extends StatelessWidget {
  final Deck deck;
  final AppThemeColors colors;
  final VoidCallback onTap;
  final VoidCallback onStudy;

  const _SystemDeckCard({
    required this.deck,
    required this.colors,
    required this.onTap,
    required this.onStudy,
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
                    gradient: LinearGradient(
                      colors: [colors.brand, colors.brandDark],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(Icons.auto_stories_rounded,
                      color: Colors.white, size: 26),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              deck.name,
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                                color: colors.textMain,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: colors.brandSoft,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                  color: colors.brandBorder, width: 1),
                            ),
                            child: Text(
                              'HỆ THỐNG',
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.w800,
                                color: colors.brand,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (deck.description != null &&
                          deck.description!.isNotEmpty) ...[
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: colors.brandSoft,
                      borderRadius: BorderRadius.circular(10),
                      border:
                          Border.all(color: colors.brandBorder, width: 2),
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
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Icon(Icons.style_rounded, size: 16, color: colors.textSub),
                const SizedBox(width: 6),
                Text(
                  '${deck.cardCount} thẻ',
                  style: TextStyle(
                    fontSize: 13,
                    color: colors.textSub,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (deck.category != null) ...[
                  const SizedBox(width: 12),
                  Icon(Icons.category_rounded, size: 16, color: colors.textSub),
                  const SizedBox(width: 4),
                  Text(
                    deck.category!,
                    style: TextStyle(
                      fontSize: 13,
                      color: colors.textSub,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
                const Spacer(),
                SizedBox(
                  width: 128,
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

/// Tab Thư viện của tôi — Personal Decks
class _PersonalDecksTab extends StatelessWidget {
  final List<Deck> decks;
  final int leechCount;
  final AppThemeColors colors;
  final Function(Deck) onStudy;
  final Function(Deck) onTap;
  final Function(Deck) onDelete;
  final Future<void> Function() onRefresh;
  final VoidCallback onCreateDeck;
  final VoidCallback onStartLeech;

  const _PersonalDecksTab({
    required this.decks,
    required this.leechCount,
    required this.colors,
    required this.onStudy,
    required this.onTap,
    required this.onDelete,
    required this.onRefresh,
    required this.onCreateDeck,
    required this.onStartLeech,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: colors.brand,
      onRefresh: onRefresh,
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          // Banner ôn tập SRS
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
              child: ChunkyCard(
                fillColor: colors.brand,
                borderColor: colors.brandDark,
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
                      shadowColor: colors.brandBorder,
                      textColor: colors.brand,
                      onPressed: () => context.push(RouteConstants.studySession),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Leech Rescue Banner (nếu có từ khó)
          SliverToBoxAdapter(
            child: LeechRescueSessionBanner(
              leechCount: leechCount,
              onStart: onStartLeech,
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Bộ từ vựng của bạn',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: colors.textMain,
                      ),
                    ),
                  ),
                  Text(
                    '${decks.length} bộ',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: colors.textSub,
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
                    Icon(
                      Icons.style_rounded,
                      size: 72,
                      color: colors.brandBorder,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Chưa có bộ từ vựng nào',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: colors.textMain,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Tạo bộ từ đầu tiên để bắt đầu học nhé!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: colors.textSub,
                      ),
                    ),
                    const SizedBox(height: 24),
                    ChunkyButton(
                      label: 'Tạo bộ từ mới',
                      onPressed: onCreateDeck,
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
                    onTap: () => onTap(deck),
                    onStudy: () => onStudy(deck),
                    onDelete: () => onDelete(deck),
                  );
                },
                childCount: decks.length,
              ),
            ),
          const SliverToBoxAdapter(child: SizedBox(height: 96)),
        ],
      ),
    );
  }
}
