import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pp191225/data/repositories/leaderboard_repository.dart';
import 'package:pp191225/presentation/auth/controllers/auth_controller.dart';
import 'package:pp191225/presentation/leaderboard/models/leaderboard_entry.dart';
import 'package:pp191225/providers/datasources_provider.dart';

class LeaderboardState {
  final List<LeaderboardEntry> topThree;
  final LeaderboardEntry? myStanding;
  final List<LeaderboardEntry> restList;
  final bool isLoading;
  final String? errorMessage;

  const LeaderboardState({
    this.topThree = const [],
    this.myStanding,
    this.restList = const [],
    this.isLoading = true,
    this.errorMessage,
  });
}

final leaderboardRepositoryProvider = Provider<LeaderboardRepository>(
  (ref) => LeaderboardRepository(ref.watch(apiServiceProvider)),
);

final leaderboardControllerProvider =
    AsyncNotifierProvider.autoDispose<LeaderboardController, LeaderboardData>(
      LeaderboardController.new,
    );

class LeaderboardController extends AutoDisposeAsyncNotifier<LeaderboardData> {
  @override
  Future<LeaderboardData> build() {
    ref.watch(authControllerProvider);
    return ref.watch(leaderboardRepositoryProvider).getLeaderboard();
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
    // The provider owns errors and cancels stale builds on account changes.
    try {
      await future;
    } catch (_) {
      // Render the AsyncError through the screen's retry state.
    }
  }
}
