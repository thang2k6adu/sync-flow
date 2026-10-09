import 'package:flutter_test/flutter_test.dart';
import 'package:pp191225/data/mocks/mock_api_router.dart';
import 'package:pp191225/data/models/auth/auth_response_dto.dart';
import 'package:pp191225/data/models/base/api_response.dart';
import 'package:pp191225/data/models/gamification/leaderboard_dto.dart';
import 'package:pp191225/data/models/tasks/task_dto.dart';
import 'package:pp191225/data/models/users/user_dto.dart';

void main() {
  test('login -> profile parse đúng DTO', () async {
    final login = await MockApiRouter.handle(
      'POST',
      '/auth/firebase/login',
      data: {'idToken': 'mock-firebase-id-token:abc@x.com'},
    ) as Map<String, dynamic>;
    final auth = ApiResponse<AuthResponseDto>.fromJson(
      login,
      (d) => AuthResponseDto.fromJson(d as Map<String, dynamic>),
    );
    expect(auth.data!.user.email, 'abc@x.com');
    expect(auth.data!.tokens.accessToken, isNotEmpty);

    final profile = await MockApiRouter.handle('GET', '/users/profile')
        as Map<String, dynamic>;
    final user = ApiResponse<UserDto>.fromJson(
      profile,
      (d) => UserDto.fromJson(d as Map<String, dynamic>),
    );
    expect(user.data!.email, 'abc@x.com');
  });

  test('tasks: phân trang, filter, CRUD', () async {
    PaginatedData<TaskDto> parse(dynamic json) => ApiResponse<PaginatedData<TaskDto>>.fromJson(
          json as Map<String, dynamic>,
          (d) => PaginatedData<TaskDto>.fromJson(
            d as Map<String, dynamic>,
            (i) => TaskDto.fromJson(i as Map<String, dynamic>),
          ),
        ).data!;

    final page1 = parse(await MockApiRouter.handle('GET', '/tasks',
        query: {'page': 1, 'limit': 10}));
    expect(page1.items.length, 10);
    expect(page1.meta.totalItems, 25);
    expect(page1.meta.totalPages, 3);

    final done = parse(await MockApiRouter.handle('GET', '/tasks',
        query: {'page': 1, 'limit': 50, 'status': 'DONE'}));
    expect(done.items.every((t) => t.status == 'DONE'), isTrue);

    final created = await MockApiRouter.handle('POST', '/tasks',
        data: {'title': 'Mới'}) as Map<String, dynamic>;
    final id = (created['data'] as Map)['id'] as String;
    await MockApiRouter.handle('PATCH', '/tasks/$id', data: {'status': 'DONE'});
    await MockApiRouter.handle('DELETE', '/tasks/$id');
    expect(
      () => MockApiRouter.handle('DELETE', '/tasks/$id'),
      throwsException,
    );
    expect(() => MockApiRouter.handle('GET', '/nope'), throwsException);
  });

  test('gamification: progression sync + leaderboard parse đúng DTO', () async {
    ProgressionDto parseProgression(dynamic json) =>
        ApiResponse<ProgressionDto>.fromJson(
          json as Map<String, dynamic>,
          (d) => ProgressionDto.fromJson(d as Map<String, dynamic>),
        ).data!;

    final before = parseProgression(
      await MockApiRouter.handle('GET', '/users/progression'),
    );
    expect(before.level, greaterThanOrEqualTo(1));

    final after = parseProgression(
      await MockApiRouter.handle(
        'POST',
        '/users/progression/add',
        data: {'expGained': 15, 'cardStudied': true, 'wordMastered': true},
      ),
    );
    expect(after.totalExp, before.totalExp + 15);
    expect(after.wordsMastered, before.wordsMastered + 1);

    final board =
        await MockApiRouter.handle('GET', '/users/leaderboard')
            as Map<String, dynamic>;
    final dto = ApiResponse<LeaderboardResponseDto>.fromJson(
      board,
      (d) => LeaderboardResponseDto.fromJson(d as Map<String, dynamic>),
    ).data!;
    expect(dto.topThree.length, 3);
    expect(dto.myStanding, isNotNull);
    expect(dto.myStanding!.isCurrentUser, isTrue);
    expect(dto.restList.every((e) => e.rank > 3), isTrue);
  });
}

