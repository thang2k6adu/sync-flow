import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pp191225/core/constants/route_constants.dart';
import 'package:pp191225/core/theme/app_theme.dart';
import 'package:pp191225/presentation/home/widgets/categorized_decks_section.dart';
import 'package:pp191225/presentation/home/widgets/continue_learning_hero_card.dart';
import 'package:pp191225/presentation/home/widgets/gamification_header_bar.dart';
import 'package:pp191225/presentation/home/widgets/srs_alert_card.dart';
import 'package:pp191225/presentation/vocab/controllers/deck_list_controller.dart';
import 'package:pp191225/shared/widgets/common/chunky_card.dart';

/// Màn hình chính Dashboard Học tập (Smart Learning Hub):
/// - Phân chia bố cục rõ ràng, mạch lạc, không đè chữ:
///   1. Ôn tập Spaced Repetition (chỉ hiện khi có từ cần ôn tập)
///   2. Tiếp tục học (In Progress Decks)
///   3. Kho bộ từ vựng & Khám phá (Categorized Tracks)
/// - 100% sử dụng icon chính thức từ Flutter Icons library, không dùng emoji.
class HomeScreen extends ConsumerWidget {
  final Function(int)? onSwitchTab;

  const HomeScreen({super.key, this.onSwitchTab});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.themeColors;
    final decksAsync = ref.watch(deckListControllerProvider);
    final summaryAsync = ref.watch(studySummaryProvider);

    return Scaffold(
      backgroundColor: colors.background,
      body: Column(
        children: [
          // Header: Thanh trạng thái học tập tinh gọn
          GamificationHeaderBar(
            onProfileTap: () => onSwitchTab?.call(2),
          ),

          // Vùng nội dung cuộn gồm các khối phân chia rành mạch
          Expanded(
            child: RefreshIndicator(
              color: colors.brand,
              onRefresh: () async {
                ref.invalidate(deckListControllerProvider);
                ref.invalidate(studySummaryProvider);
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Khối 1 & 2: Dựa trên trạng thái học tập
                    summaryAsync.when(
                      data: (summary) {
                        final hasDueReviews = summary.dueCount > 0;
                        final activeDeck = summary.recommendedDeck;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // 1. Ôn tập Spaced Repetition (chỉ hiển thị khi có thẻ đến hạn)
                            if (hasDueReviews) ...[
                              SrsAlertCard(
                                dueCount: summary.dueCount,
                                leechCount: summary.leechCount,
                                onStartLeechRescue: () => context.push(
                                  RouteConstants.studySession,
                                  extra: 'leech_rescue',
                                ),
                                onStartDueStudy: () => context.push(
                                  RouteConstants.studySession,
                                ),
                              ),
                              const SizedBox(height: 20),
                            ],

                            // 2. Tiếp tục học bộ từ đang học
                            if (activeDeck != null) ...[
                              ContinueLearningHeroCard(
                                deck: activeDeck,
                                onStudy: () => context.push(
                                  RouteConstants.studySession,
                                  extra: activeDeck.id,
                                ),
                              ),
                              const SizedBox(height: 20),
                            ],
                          ],
                        );
                      },
                      loading: () => const SizedBox.shrink(),
                      error: (err, stack) => const SizedBox.shrink(),
                    ),

                    // Khối 3: Kho bộ từ vựng & Khám phá
                    decksAsync.when(
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
                          onSeeAll: () => onSwitchTab?.call(1),
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
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
