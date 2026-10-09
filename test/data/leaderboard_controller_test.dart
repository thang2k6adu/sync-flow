import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pp191225/data/repositories/leaderboard_repository.dart';
import 'package:pp191225/domain/entities/users/user.dart';
import 'package:pp191225/presentation/auth/controllers/auth_controller.dart';
import 'package:pp191225/presentation/leaderboard/controllers/leaderboard_controller.dart';
import 'package:pp191225/presentation/leaderboard/models/leaderboard_entry.dart';

class TestAuthController extends AuthController {
  @override
  User? build() => null;
}

class PendingLeaderboardRepository implements LeaderboardRepository {
  final requests = <Completer<LeaderboardData>>[];

  @override
  Future<LeaderboardData> getLeaderboard() {
    final request = Completer<LeaderboardData>();
    requests.add(request);
    return request.future;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  test(
    'refresh clears an old standing and retry recovers from an API error',
    () async {
      final repository = PendingLeaderboardRepository();
      final container = ProviderContainer(
        overrides: [
          authControllerProvider.overrideWith(TestAuthController.new),
          leaderboardRepositoryProvider.overrideWithValue(repository),
        ],
      );
      addTearDown(container.dispose);
      final subscription = container.listen(
        leaderboardControllerProvider,
        (_, _) {},
        fireImmediately: true,
      );
      addTearDown(subscription.close);
      expect(container.read(leaderboardControllerProvider).isLoading, isTrue);
      repository.requests.last.complete(
        const LeaderboardData(
          myStanding: LeaderboardEntry(
            rank: 42,
            id: 'me',
            name: 'Mai',
            exp: 100,
            rankTitle: 'Novice',
          ),
        ),
      );
      await container.read(leaderboardControllerProvider.future);
      expect(
        container
            .read(leaderboardControllerProvider)
            .requireValue
            .myStanding!
            .rank,
        42,
      );

      final refresh = container
          .read(leaderboardControllerProvider.notifier)
          .refresh();
      await Future<void>.delayed(Duration.zero);
      repository.requests.last.complete(const LeaderboardData());
      await refresh;
      expect(
        container.read(leaderboardControllerProvider).requireValue.myStanding,
        isNull,
      );

      final failingRefresh = container
          .read(leaderboardControllerProvider.notifier)
          .refresh();
      await Future<void>.delayed(Duration.zero);
      repository.requests.last.completeError(Exception('Offline'));
      await failingRefresh;
      expect(container.read(leaderboardControllerProvider).hasError, isTrue);

      final retry = container
          .read(leaderboardControllerProvider.notifier)
          .refresh();
      await Future<void>.delayed(Duration.zero);
      repository.requests.last.complete(const LeaderboardData());
      await retry;
      expect(container.read(leaderboardControllerProvider).hasError, isFalse);
    },
  );
}
