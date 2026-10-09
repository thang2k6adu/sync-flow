import 'package:flutter_test/flutter_test.dart';
import 'package:pp191225/data/repositories/leaderboard_repository.dart';
import 'package:pp191225/data/services/api_service.dart';

class FakeLeaderboardApi implements ApiService {
  dynamic response;
  String? requestedPath;
  Map<String, dynamic>? requestedQuery;

  @override
  Future<dynamic> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    requestedPath = path;
    requestedQuery = queryParameters;
    return response;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  test(
    'reads leaderboard endpoint and preserves server ranks and current user',
    () async {
      final api = FakeLeaderboardApi()
        ..response = {
          'data': {
            'topThree': [
              {'id': 'a', 'name': 'An', 'rank': 1, 'exp': '1200'},
            ],
            'myStanding': {
              'id': 'me',
              'name': 'Mai',
              'rank': 42,
              'exp': 300,
              'isCurrentUser': true,
              'masteredWords': 15,
            },
            'restList': [
              {'id': 'b', 'name': 'Bình', 'rank': 4, 'exp': 800},
            ],
          },
        };
      final result = await LeaderboardRepository(api).getLeaderboard();
      expect(api.requestedPath, '/users/leaderboard');
      expect(api.requestedQuery, {'limit': 20});
      expect(result.topThree.single.exp, 1200);
      expect(result.topThree.single.rankTitle, 'Tập Sự (Novice)');
      expect(result.myStanding!.rank, 42);
      expect(result.myStanding!.isCurrentUser, isTrue);
      expect(result.myStanding!.masteredWords, 15);
      expect(result.restList.single.rank, 4);
    },
  );

  test('empty response data has no invented standing or students', () async {
    final api = FakeLeaderboardApi()..response = {'data': <String, dynamic>{}};
    final result = await LeaderboardRepository(api).getLeaderboard();
    expect(result.topThree, isEmpty);
    expect(result.restList, isEmpty);
    expect(result.myStanding, isNull);
  });

  test(
    'API errors and missing data fail instead of displaying fake scores',
    () async {
      final api = FakeLeaderboardApi()
        ..response = {'error': true, 'message': 'Unauthorized'};
      final repository = LeaderboardRepository(api);
      await expectLater(repository.getLeaderboard(), throwsException);
      api.response = {'error': false};
      await expectLater(repository.getLeaderboard(), throwsException);
    },
  );
}
