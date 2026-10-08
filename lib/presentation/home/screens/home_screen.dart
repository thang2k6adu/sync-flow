import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pp191225/core/constants/route_constants.dart';
import 'package:pp191225/core/theme/app_theme.dart';
import 'package:pp191225/presentation/home/controllers/unified_search_controller.dart';
import 'package:pp191225/presentation/home/widgets/categorized_decks_section.dart';
import 'package:pp191225/presentation/home/widgets/continue_learning_hero_card.dart';
import 'package:pp191225/presentation/home/widgets/home_curved_header.dart';
import 'package:pp191225/presentation/home/widgets/home_quick_grid.dart';
import 'package:pp191225/presentation/home/widgets/home_search_bar.dart';
import 'package:pp191225/presentation/home/widgets/search_results_view.dart';
import 'package:pp191225/presentation/vocab/controllers/deck_list_controller.dart';
import 'package:pp191225/shared/widgets/common/chunky_card.dart';

/// Màn hình chính Dashboard Học tập (Sync Flow Hub):
/// - Header vát cong thương hiệu với Carousel, chuông thông báo & nút Profile góc trên
/// - Thanh tìm kiếm thông minh: Tìm cả Bộ từ & Thẻ từ vựng
/// - Bento Quick Grid (3x2) phím tắt học tập
/// - Thẻ tiếp tục phiên học gần nhất tinh giản, hiện đại
/// - Danh mục các bộ từ (Kho từ vựng)
class HomeScreen extends ConsumerStatefulWidget {
  final Function(int)? onSwitchTab;

  const HomeScreen({super.key, this.onSwitchTab});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _startDueStudy() {
    context.push(RouteConstants.studySession);
  }

  void _startLeechRescue() {
    context.push(RouteConstants.studySession, extra: 'leech_rescue');
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.themeColors;
    final decksAsync = ref.watch(deckListControllerProvider);
    final searchState = ref.watch(unifiedSearchControllerProvider);
    final searchNotifier = ref.read(unifiedSearchControllerProvider.notifier);

    return Scaffold(
      backgroundColor: colors.background,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Header uốn cong thương hiệu (Top Bar + Lời chào + Profile góc trên + Carousel Slider)
            HomeCurvedHeader(
              onStartDueStudy: _startDueStudy,
            ),

            const SizedBox(height: 16),

            // 2. Thanh tìm kiếm thông minh
            HomeSearchBar(
              controller: _searchController,
              onChanged: (q) => searchNotifier.onQueryChanged(q),
              onClear: () => searchNotifier.clearSearch(),
            ),

            const SizedBox(height: 16),

            // NẾU ĐANG TÌM KIẾM: Hiển thị giao diện kết quả phân chia (Bộ từ / Từ vựng)
            if (searchState.isSearching) ...[
              const SearchResultsView(),
            ] else ...[
              // NẾU KHÔNG TÌM KIẾM: Hiển thị các khối học tập mặc định

              // 3. Lưới 6 phím tắt học tập (Bento Quick Grid 3x2)
              decksAsync.when(
                data: (decks) => HomeQuickGrid(
                  decks: decks,
                  onStartDueStudy: _startDueStudy,
                  onStartLeechRescue: _startLeechRescue,
                ),
                loading: () => const SizedBox.shrink(),
                error: (_, _) => const SizedBox.shrink(),
              ),

              const SizedBox(height: 24),

              // 4. Khối Tiếp tục học (In-Progress Deck)
              decksAsync.maybeWhen(
                data: (decks) {
                  if (decks.isEmpty) return const SizedBox.shrink();
                  final recentDeck = decks.firstWhere(
                    (d) => d.cardCount > 0,
                    orElse: () => decks.first,
                  );
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ContinueLearningHeroCard(
                      deck: recentDeck,
                      onStudy: () => context.push(
                        RouteConstants.studySession,
                        extra: recentDeck.id,
                      ),
                    ),
                  );
                },
                orElse: () => const SizedBox.shrink(),
              ),

              const SizedBox(height: 24),

              // 5. Danh mục các bộ từ vựng & Khám phá
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: decksAsync.when(
                  data: (decks) {
                    return CategorizedDecksSection(
                      decks: decks,
                      onStudy: (deck) => context.push(
                        RouteConstants.studySession,
                        extra: deck.id,
                      ),
                      onTap: (deck) => context.push(
                        RouteConstants.deckDetail,
                        extra: deck,
                      ),
                      onSeeAll: () => widget.onSwitchTab?.call(1),
                    );
                  },
                  loading: () => Center(
                    child: Padding(
                      padding: const EdgeInsets.all(32),
                      child: CircularProgressIndicator(color: colors.brand),
                    ),
                  ),
                  error: (err, _) => Center(
                    child: Column(
                      children: [
                        Text(
                          'Lỗi tải bộ từ: $err',
                          style: TextStyle(color: colors.coral),
                        ),
                        const SizedBox(height: 8),
                        ChunkyButton.primary(
                          label: 'Tải lại',
                          size: ChunkyButtonSize.small,
                          onPressed: () => ref
                              .read(deckListControllerProvider.notifier)
                              .refresh(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],

            // Đệm khoảng trống phía dưới để không bị che bởi navbar lượn sóng
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
