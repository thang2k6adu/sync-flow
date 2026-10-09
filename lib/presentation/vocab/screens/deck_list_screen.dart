import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:pp191225/core/constants/route_constants.dart';
import 'package:pp191225/core/theme/app_theme.dart';
import 'package:pp191225/domain/entities/vocab/deck.dart';
import 'package:pp191225/presentation/vocab/controllers/deck_list_controller.dart';
import 'package:pp191225/presentation/vocab/widgets/create_deck_dialog.dart';
import 'package:pp191225/presentation/vocab/widgets/deck_card_item.dart';
import 'package:pp191225/presentation/vocab/widgets/leech_rescue_widgets.dart';
import 'package:pp191225/shared/widgets/common/chunky_card.dart';
import 'package:pp191225/shared/widgets/feedback/overlay.dart';

enum DeckSortOption {
  none('Mới nhất (Mặc định)'),
  category('Theo Chủ đề (Tags)'),
  cefr('Theo Trình độ (CEFR)');

  final String label;
  const DeckSortOption(this.label);
}

final deckSortProvider = StateProvider<DeckSortOption>((ref) => DeckSortOption.none);
final selectedCategoryProvider = StateProvider<String?>((ref) => null);
final selectedCefrProvider = StateProvider<String?>((ref) => null);

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
    final sortOption = ref.watch(deckSortProvider);

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
            PopupMenuButton<DeckSortOption>(
              icon: Icon(Icons.sort_rounded, color: colors.brand),
              tooltip: 'Sắp xếp',
              onSelected: (option) => ref.read(deckSortProvider.notifier).state = option,
              itemBuilder: (context) => DeckSortOption.values
                  .map((opt) => PopupMenuItem(
                        value: opt,
                        child: Row(
                          children: [
                            Icon(
                              sortOption == opt ? Icons.check_circle_rounded : Icons.radio_button_unchecked_rounded,
                              color: sortOption == opt ? colors.brand : colors.textSub,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              opt.label,
                              style: TextStyle(
                                color: sortOption == opt ? colors.brand : colors.textMain,
                                fontWeight: sortOption == opt ? FontWeight.w700 : FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ))
                  .toList(),
            ),
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
            final categories = decks.map((d) => d.category).whereType<String>().toSet().toList()..sort();
            final cefrLevels = decks.map((d) => d.cefrLevel).whereType<String>().toSet().toList()..sort();

            final selectedCat = ref.watch(selectedCategoryProvider);
            final selectedCefr = ref.watch(selectedCefrProvider);

            var filteredDecks = List<Deck>.from(decks);

            if (selectedCat != null) {
              filteredDecks = filteredDecks.where((d) => d.category == selectedCat).toList();
            }
            if (selectedCefr != null) {
              filteredDecks = filteredDecks.where((d) => d.cefrLevel == selectedCefr).toList();
            }

            if (sortOption == DeckSortOption.category) {
              filteredDecks.sort((a, b) => (a.category ?? 'z').compareTo(b.category ?? 'z'));
            } else if (sortOption == DeckSortOption.cefr) {
              filteredDecks.sort((a, b) => (a.cefrLevel ?? 'z').compareTo(b.cefrLevel ?? 'z'));
            }

            final systemDecks = filteredDecks.where((d) => d.isSystem).toList();
            final personalDecks = filteredDecks.where((d) => !d.isSystem).toList();

            return Column(
              children: [
                if (categories.isNotEmpty || cefrLevels.isNotEmpty)
                  _FiltersSection(
                    categories: categories,
                    cefrLevels: cefrLevels,
                    selectedCat: selectedCat,
                    selectedCefr: selectedCefr,
                    colors: colors,
                  ),
                Expanded(
                  child: TabBarView(
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
                  ),
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

class _FiltersSection extends ConsumerWidget {
  final List<String> categories;
  final List<String> cefrLevels;
  final String? selectedCat;
  final String? selectedCefr;
  final AppThemeColors colors;

  const _FiltersSection({
    required this.categories,
    required this.cefrLevels,
    required this.selectedCat,
    required this.selectedCefr,
    required this.colors,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border(bottom: BorderSide(color: colors.border, width: 1)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (categories.isNotEmpty) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Text(
                'Lọc theo chủ đề',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: colors.textSub,
                ),
              ),
            ),
            SizedBox(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _buildChip('Tất cả', selectedCat == null, () {
                    ref.read(selectedCategoryProvider.notifier).state = null;
                  }),
                  ...categories.map((cat) => _buildChip(cat, selectedCat == cat, () {
                        ref.read(selectedCategoryProvider.notifier).state = cat;
                      })),
                ],
              ),
            ),
          ],
          if (categories.isNotEmpty && cefrLevels.isNotEmpty) const SizedBox(height: 12),
          if (cefrLevels.isNotEmpty) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Text(
                'Lọc theo trình độ',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: colors.textSub,
                ),
              ),
            ),
            SizedBox(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _buildChip('Tất cả', selectedCefr == null, () {
                    ref.read(selectedCefrProvider.notifier).state = null;
                  }),
                  ...cefrLevels.map((lvl) => _buildChip(lvl, selectedCefr == lvl, () {
                        ref.read(selectedCefrProvider.notifier).state = lvl;
                      })),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildChip(String label, bool isSelected, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (_) => onTap(),
        selectedColor: colors.brandSoft,
        backgroundColor: colors.background,
        labelStyle: TextStyle(
          color: isSelected ? colors.brand : colors.textSub,
          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
          fontSize: 13,
        ),
        side: BorderSide(
          color: isSelected ? colors.brand : colors.border,
          width: isSelected ? 2 : 1,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        showCheckmark: false,
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
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Bộ từ chuẩn hóa',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            'Lộ trình CEFR, IELTS, TOEIC. Được biên soạn bởi chuyên gia.',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Cậu có thể thay link .json này bằng link Lottie bất kỳ nhé!
                    Lottie.network(
                      'https://assets4.lottiefiles.com/packages/lf20_u4yrau.json', // Thay link Lottie (JSON) vào đây
                      width: 80,
                      height: 80,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.auto_stories_rounded, size: 64, color: Colors.white54),
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
                    Lottie.network(
                      'https://assets9.lottiefiles.com/packages/lf20_k9wsvz.json', // Thay Lottie ngộ nghĩnh
                      width: 120,
                      height: 120,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) =>
                          Icon(Icons.explore_rounded, size: 72, color: colors.brandBorder),
                    ),
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
            SliverToBoxAdapter(
              child: CarouselSlider.builder(
                itemCount: decks.length,
                options: CarouselOptions(
                  height: 500,
                  enlargeCenterPage: true,
                  viewportFraction: 0.85,
                  enableInfiniteScroll: false,
                ),
                itemBuilder: (context, index, realIndex) {
                  final deck = decks[index];
                  return DeckCardItem(
                    deck: deck,
                    isSystem: true,
                    onTap: () => onTap(deck),
                    onStudy: () => onStudy(deck),
                  );
                },
              ),
            ),

          const SliverToBoxAdapter(child: SizedBox(height: 96)),
        ],
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
                child: Row(
                  children: [
                    Expanded(
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
                    const SizedBox(width: 12),
                    // Cậu có thể thay bằng link Lottie (.json) khác nếu muốn!
                    Lottie.network(
                      'https://assets3.lottiefiles.com/packages/lf20_1LhsaB.json', // Thay link Lottie
                      width: 80,
                      height: 80,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.school_rounded, size: 64, color: Colors.white54),
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
                    Lottie.network(
                      'https://assets9.lottiefiles.com/packages/lf20_UJNc2t.json', // Thay Lottie box empty
                      width: 120,
                      height: 120,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) =>
                          Icon(Icons.style_rounded, size: 72, color: colors.brandBorder),
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
            SliverToBoxAdapter(
              child: CarouselSlider.builder(
                itemCount: decks.length,
                options: CarouselOptions(
                  height: 500,
                  enlargeCenterPage: true,
                  viewportFraction: 0.85,
                  enableInfiniteScroll: false,
                ),
                itemBuilder: (context, index, realIndex) {
                  final deck = decks[index];
                  return DeckCardItem(
                    deck: deck,
                    onTap: () => onTap(deck),
                    onStudy: () => onStudy(deck),
                    onDelete: () => onDelete(deck),
                  );
                },
              ),
            ),
          const SliverToBoxAdapter(child: SizedBox(height: 96)),
        ],
      ),
    );
  }
}
