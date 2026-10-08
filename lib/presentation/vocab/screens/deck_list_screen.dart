import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pp191225/core/constants/route_constants.dart';
import 'package:pp191225/core/theme/app_fonts.dart';
import 'package:pp191225/core/theme/app_theme.dart';
import 'package:pp191225/domain/entities/vocab/deck.dart';
import 'package:pp191225/presentation/vocab/controllers/deck_list_controller.dart';
import 'package:pp191225/presentation/vocab/widgets/create_deck_dialog.dart';
import 'package:pp191225/presentation/vocab/widgets/deck_card_item.dart';
import 'package:pp191225/presentation/vocab/widgets/deck_filter_toolbar.dart';
import 'package:pp191225/presentation/vocab/widgets/leech_rescue_widgets.dart';
import 'package:pp191225/shared/widgets/common/chunky_card.dart';
import 'package:pp191225/shared/widgets/feedback/overlay.dart';

class DeckListScreen extends ConsumerStatefulWidget {
  const DeckListScreen({super.key});

  @override
  ConsumerState<DeckListScreen> createState() => _DeckListScreenState();
}

class _DeckListScreenState extends ConsumerState<DeckListScreen> {
  String _searchQuery = '';
  DeckSortField _sortField = DeckSortField.name;
  bool _isAscending = true;

  void _showCreateDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => const CreateDeckDialog(),
    );
  }

  void _startLeechRescue(BuildContext context) {
    context.push(RouteConstants.studySession, extra: 'leech_rescue');
  }

  Future<void> _confirmDelete(BuildContext context, Deck deck) async {
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
      if (context.mounted) {
        overlay.showWithTimeout(message: 'Đã xoá bộ "${deck.name}"', type: ToastType.success);
      }
    } catch (e) {
      if (context.mounted) {
        overlay.showWithTimeout(message: 'Lỗi: $e', type: ToastType.error);
      }
    }
  }

  int _cefrRank(String? cefr) {
    switch (cefr?.toUpperCase()) {
      case 'A1':
        return 1;
      case 'A2':
        return 2;
      case 'B1':
        return 3;
      case 'B2':
        return 4;
      case 'C1':
        return 5;
      case 'C2':
        return 6;
      default:
        return 0;
    }
  }

  List<Deck> _filterAndSort(List<Deck> original) {
    var result = List<Deck>.from(original);

    // 1. Lọc theo search query
    if (_searchQuery.trim().isNotEmpty) {
      final q = _searchQuery.trim().toLowerCase();
      result = result.where((d) {
        final nameMatch = d.name.toLowerCase().contains(q);
        final descMatch = d.description?.toLowerCase().contains(q) ?? false;
        final catMatch = d.category?.toLowerCase().contains(q) ?? false;
        final cefrMatch = d.cefrLevel?.toLowerCase().contains(q) ?? false;
        return nameMatch || descMatch || catMatch || cefrMatch;
      }).toList();
    }

    // 2. Sắp xếp theo tiêu chí và chiều Tăng / Giảm
    result.sort((a, b) {
      int cmp = 0;
      switch (_sortField) {
        case DeckSortField.name:
          cmp = a.name.toLowerCase().compareTo(b.name.toLowerCase());
          break;
        case DeckSortField.cardCount:
          cmp = a.cardCount.compareTo(b.cardCount);
          break;
        case DeckSortField.cefr:
          cmp = _cefrRank(a.cefrLevel).compareTo(_cefrRank(b.cefrLevel));
          break;
        case DeckSortField.createdAt:
          final dateA = a.createdAt ?? DateTime(2000);
          final dateB = b.createdAt ?? DateTime(2000);
          cmp = dateA.compareTo(dateB);
          break;
      }
      return _isAscending ? cmp : -cmp;
    });

    return result;
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.themeColors;
    final decksAsync = ref.watch(deckListControllerProvider);

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
              fontFamily: AppFonts.poppins,
              fontWeight: FontWeight.w800,
              fontSize: 18,
              color: colors.textMain,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: ChunkyIconButton.circle(
                icon: Icons.school_rounded,
                size: ChunkyButtonSize.small,
                variant: FlowButtonVariant.secondary,
                tooltip: 'Học ngay (Toàn bộ)',
                onPressed: () => context.push(RouteConstants.studySession),
              ),
            ),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(48),
            child: Column(
              children: [
                TabBar(
                  labelColor: colors.brand,
                  unselectedLabelColor: colors.textSub,
                  labelStyle: const TextStyle(
                    fontFamily: AppFonts.poppins,
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                  unselectedLabelStyle: const TextStyle(
                    fontFamily: AppFonts.poppins,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                  indicatorColor: colors.brand,
                  indicatorWeight: 3,
                  dividerColor: colors.border,
                  dividerHeight: 1.5,
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
                          Text('Tất cả bộ từ'),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        body: Column(
          children: [
            // Thanh công cụ Tìm kiếm & Sắp xếp Tăng / Giảm cho cả trang kho từ
            DeckFilterToolbar(
              searchQuery: _searchQuery,
              onSearchChanged: (q) => setState(() => _searchQuery = q),
              sortField: _sortField,
              onSortFieldChanged: (field) => setState(() => _sortField = field),
              isAscending: _isAscending,
              onToggleDirection: () => setState(() => _isAscending = !_isAscending),
              totalCount: decksAsync.value?.length ?? 0,
            ),

            // Nội dung tab
            Expanded(
              child: decksAsync.when(
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
                  final allDecks = _filterAndSort(decks);
                  final systemDecks =
                      allDecks.where((d) => d.isSystem).toList();

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

                      // Tab 2: Tất cả bộ từ (mặc định hiện hết, search thì lọc)
                      _PersonalDecksTab(
                        decks: allDecks,
                        colors: colors,
                        onCreateDeck: () => _showCreateDialog(context),
                        onStudy: (deck) => context.push(
                          RouteConstants.studySession,
                          extra: deck.id,
                        ),
                        onTap: (deck) => context.push(
                          RouteConstants.deckDetail,
                          extra: deck,
                        ),
                        onDelete: (deck) => _confirmDelete(context, deck),
                        onRefresh: () =>
                            ref.read(deckListControllerProvider.notifier).refresh(),
                        onStartLeechRescue: () => _startLeechRescue(context),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 70), // Nổi lên trên đường cong navbar
          child: FloatingActionButton.extended(
            onPressed: () => _showCreateDialog(context),
            backgroundColor: colors.brand,
            foregroundColor: Colors.white,
            elevation: 4,
            icon: const Icon(Icons.add_rounded, size: 22),
            label: const Text(
              'Tạo bộ từ',
              style: TextStyle(
                fontFamily: AppFonts.poppins,
                fontWeight: FontWeight.w700,
                fontSize: 13,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Tab Khám phá — hiển thị System Decks
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
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [colors.brandDark, colors.brand],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: colors.brand.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Bộ từ chuẩn hóa',
                      style: TextStyle(
                        fontFamily: AppFonts.poppins,
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Lộ trình CEFR, Oxford cốt lõi và chủ đề giao tiếp đời sống.',
                      style: TextStyle(
                        fontFamily: AppFonts.poppins,
                        color: Colors.white.withOpacity(0.85),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Header danh sách
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Danh mục khám phá',
                    style: TextStyle(
                      fontFamily: AppFonts.poppins,
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: colors.textMain,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: colors.brandSoft,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '${decks.length} bộ từ',
                      style: TextStyle(
                        fontFamily: AppFonts.poppins,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: colors.brand,
                      ),
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
                child: Center(
                  child: Column(
                    children: [
                      Icon(Icons.search_off_rounded, size: 40, color: colors.textSub.withOpacity(0.4)),
                      const SizedBox(height: 8),
                      Text(
                        'Không có bộ từ hệ thống nào phù hợp',
                        style: TextStyle(
                          fontFamily: AppFonts.poppins,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: colors.textSub,
                        ),
                      ),
                    ],
                  ),
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

          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }
}

/// Tab Tất cả bộ từ — hiển thị Personal Decks + Banner Leech Rescue
class _PersonalDecksTab extends StatelessWidget {
  final List<Deck> decks;
  final AppThemeColors colors;
  final VoidCallback onCreateDeck;
  final Function(Deck) onStudy;
  final Function(Deck) onTap;
  final Function(Deck) onDelete;
  final Future<void> Function() onRefresh;
  final VoidCallback onStartLeechRescue;

  const _PersonalDecksTab({
    required this.decks,
    required this.colors,
    required this.onCreateDeck,
    required this.onStudy,
    required this.onTap,
    required this.onDelete,
    required this.onRefresh,
    required this.onStartLeechRescue,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: colors.brand,
      onRefresh: onRefresh,
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          // Banner Ôn tập mỗi ngày (SRS)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [colors.brandDark, colors.brand],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: colors.brand.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Ôn tập mỗi ngày',
                      style: TextStyle(
                        fontFamily: AppFonts.poppins,
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Học theo chu kỳ Spaced Repetition — ôn đúng lúc sắp quên để nhớ lâu hơn.',
                      style: TextStyle(
                        fontFamily: AppFonts.poppins,
                        color: Colors.white.withOpacity(0.85),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 14),
                    ElevatedButton.icon(
                      onPressed: () => context.push(RouteConstants.studySession),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: colors.brand,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      ),
                      icon: const Icon(Icons.bolt_rounded, size: 18),
                      label: const Text(
                        'Bắt đầu ôn tập',
                        style: TextStyle(
                          fontFamily: AppFonts.poppins,
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Banner Cứu trợ từ hay quên
          SliverToBoxAdapter(
            child: Consumer(
              builder: (context, ref, _) {
                final leechCount = ref.watch(leechCountProvider).value ?? 0;
                return LeechRescueSessionBanner(
                  leechCount: leechCount,
                  onStart: onStartLeechRescue,
                );
              },
            ),
          ),

          // Header danh sách bộ từ cá nhân
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Tất cả bộ từ',
                    style: TextStyle(
                      fontFamily: AppFonts.poppins,
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: colors.textMain,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: colors.brandSoft,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '${decks.length} bộ từ',
                      style: TextStyle(
                        fontFamily: AppFonts.poppins,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: colors.brand,
                      ),
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
                    Icon(Icons.auto_stories_outlined,
                        size: 56, color: colors.textSub.withOpacity(0.4)),
                    const SizedBox(height: 12),
                    Text(
                      'Không tìm thấy bộ từ phù hợp',
                      style: TextStyle(
                        fontFamily: AppFonts.poppins,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: colors.textMain,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Thử tìm với từ khóa khác hoặc tạo bộ từ mới theo nhu cầu của bạn.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: AppFonts.poppins,
                        fontSize: 12,
                        color: colors.textSub,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: onCreateDeck,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colors.brand,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      icon: const Icon(Icons.add_rounded, size: 18),
                      label: const Text('Tạo ngay'),
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
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    child: DeckCardItem(
                      deck: deck,
                      onTap: () => onTap(deck),
                      onStudy: () => onStudy(deck),
                      onDelete: () => onDelete(deck),
                    ),
                  );
                },
                childCount: decks.length,
              ),
            ),

          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }
}

/// Card riêng cho System Deck
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
        fillColor: colors.surface,
        borderColor: colors.border,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [colors.brand, colors.brandDark],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.auto_stories_rounded,
                      color: Colors.white, size: 22),
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
                                fontFamily: AppFonts.poppins,
                                fontSize: 15,
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
                                fontFamily: AppFonts.poppins,
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
                            fontFamily: AppFonts.poppins,
                            fontSize: 12,
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
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: colors.brandSoft,
                      borderRadius: BorderRadius.circular(8),
                      border:
                          Border.all(color: colors.brandBorder, width: 1.5),
                    ),
                    child: Text(
                      deck.cefrLevel!,
                      style: TextStyle(
                        fontFamily: AppFonts.poppins,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: colors.brand,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Icon(Icons.style_outlined, size: 16, color: colors.textSub),
                const SizedBox(width: 6),
                Text(
                  '${deck.cardCount} thẻ',
                  style: TextStyle(
                    fontFamily: AppFonts.poppins,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: colors.textSub,
                  ),
                ),
                const Spacer(),
                ChunkyButton(
                  label: 'Ôn tập',
                  size: ChunkyButtonSize.small,
                  onPressed: onStudy,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
