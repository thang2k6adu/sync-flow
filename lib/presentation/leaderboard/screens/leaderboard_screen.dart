import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pp191225/core/theme/app_fonts.dart';
import 'package:pp191225/core/theme/app_theme.dart';
import 'package:pp191225/presentation/leaderboard/controllers/leaderboard_controller.dart';
import 'package:pp191225/presentation/leaderboard/widgets/leaderboard_tile.dart';
import 'package:pp191225/presentation/leaderboard/widgets/my_standing_card.dart';
import 'package:pp191225/presentation/leaderboard/widgets/podium_view.dart';

class LeaderboardScreen extends ConsumerWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.themeColors;
    final leaderboardState = ref.watch(leaderboardControllerProvider);
    final canPop = Navigator.canPop(context);

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        leading: canPop
            ? IconButton(
                icon: Icon(Icons.arrow_back_rounded, color: colors.textMain),
                onPressed: () => Navigator.pop(context),
              )
            : null,
        title: Text(
          'Bảng xếp hạng',
          style: TextStyle(
            fontFamily: AppFonts.poppins,
            fontWeight: FontWeight.w800,
            fontSize: 18,
            color: colors.textMain,
          ),
        ),
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Bục vinh quang Top 3
          SliverToBoxAdapter(
            child: PodiumView(topThree: leaderboardState.topThree),
          ),

          // Thẻ thứ hạng của bạn
          SliverToBoxAdapter(
            child: MyStandingCard(myStanding: leaderboardState.myStanding),
          ),

          const SliverToBoxAdapter(
            child: SizedBox(height: 8),
          ),

          // Tiêu đề danh sách xếp hạng
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
              child: Text(
                'Tất cả học viên',
                style: TextStyle(
                  fontFamily: AppFonts.poppins,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: colors.textSub,
                ),
              ),
            ),
          ),

          // Danh sách xếp hạng từ top 4 trở đi
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final entry = leaderboardState.restList[index];
                return LeaderboardTile(entry: entry);
              },
              childCount: leaderboardState.restList.length,
            ),
          ),

          // Đệm phía dưới tránh che bởi navbar
          const SliverToBoxAdapter(
            child: SizedBox(height: 100),
          ),
        ],
      ),
    );
  }
}
