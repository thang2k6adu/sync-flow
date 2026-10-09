import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pp191225/presentation/auth/controllers/auth_controller.dart';
import 'package:pp191225/presentation/leaderboard/models/leaderboard_entry.dart';
import 'package:pp191225/providers/usecases_provider.dart';

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

  LeaderboardState copyWith({
    List<LeaderboardEntry>? topThree,
    LeaderboardEntry? myStanding,
    List<LeaderboardEntry>? restList,
    bool? isLoading,
    String? errorMessage,
  }) {
    return LeaderboardState(
      topThree: topThree ?? this.topThree,
      myStanding: myStanding ?? this.myStanding,
      restList: restList ?? this.restList,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}

final leaderboardControllerProvider =
    NotifierProvider<LeaderboardController, LeaderboardState>(
  LeaderboardController.new,
);

/// Bảng xếp hạng từ backend thật (GET /users/leaderboard).
/// Không còn dữ liệu giả hard-code: lỗi mạng sẽ hiển thị trạng thái lỗi để retry.
class LeaderboardController extends Notifier<LeaderboardState> {
  @override
  LeaderboardState build() {
    ref.watch(authControllerProvider);
    _load();
    return const LeaderboardState();
  }

  Future<void> _load() async {
    final useCase = ref.read(getLeaderboardUseCaseProvider);
    final result = await useCase(limit: 20);
    result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, errorMessage: failure.message);
      },
      (data) {
        state = state.copyWith(
          topThree: data.topThree,
          myStanding: data.myStanding,
          restList: data.restList,
          isLoading: false,
          errorMessage: null,
        );
      },
    );
  }

  Future<void> refresh() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    await _load();
  }
}
