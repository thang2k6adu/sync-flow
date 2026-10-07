import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pp191225/core/constants/route_constants.dart';
import 'package:pp191225/core/theme/app_theme.dart';
import 'package:pp191225/presentation/auth/controllers/auth_controller.dart';
import 'package:pp191225/presentation/profile/widgets/achievement_list.dart';
import 'package:pp191225/presentation/profile/widgets/edit_profile_dialog.dart';
import 'package:pp191225/presentation/profile/widgets/level_progress_card.dart';
import 'package:pp191225/presentation/profile/widgets/stats_grid.dart';
import 'package:pp191225/presentation/progression/controllers/progression_controller.dart';
import 'package:pp191225/shared/widgets/common/chunky_card.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.themeColors;
    final user = ref.watch(authControllerProvider);
    final progressionState = ref.watch(progressionControllerProvider);
    final progression = progressionState.progression;

    final name = (user != null && user.name.isNotEmpty) ? user.name : 'Người dùng';
    final initial = name.substring(0, 1).toUpperCase();

    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        top: false,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              pinned: true,
              backgroundColor: colors.surface,
              surfaceTintColor: Colors.transparent,
              elevation: 0,
              scrolledUnderElevation: 0,
              centerTitle: true,
              title: Text(
                'Hồ sơ',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: colors.textMain,
                ),
              ),
              actions: [
                IconButton(
                  icon: Icon(Icons.settings_rounded, color: colors.textSub),
                  tooltip: 'Cài đặt',
                  onPressed: () => context.push(RouteConstants.settings),
                ),
                const SizedBox(width: 4),
              ],
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(2),
                child: Divider(height: 2, thickness: 2, color: colors.border),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 40),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  // Avatar + tên
                  Center(
                    child: Container(
                      width: 104,
                      height: 104,
                      decoration: BoxDecoration(
                        color: colors.brand,
                        shape: BoxShape.circle,
                        border: Border.all(color: colors.brandDark, width: 4),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        initial,
                        style: const TextStyle(
                          fontSize: 44,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: colors.textMain,
                    ),
                  ),
                  if ((user?.email ?? '').isNotEmpty) ...[
                    const SizedBox(height: 2),
                    Text(
                      user!.email,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: colors.textSub,
                      ),
                    ),
                  ],
                  if (user != null) ...[
                    const SizedBox(height: 20),
                    ChunkyButton.outlined(
                      label: 'Chỉnh sửa hồ sơ',
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) => EditProfileDialog(user: user),
                        );
                      },
                    ),
                  ],
                  const SizedBox(height: 28),

                  LevelProgressCard(progression: progression),
                  const SizedBox(height: 28),

                  StatsGrid(progression: progression),
                  const SizedBox(height: 28),

                  AchievementList(progression: progression),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
