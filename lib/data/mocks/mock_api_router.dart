import 'package:pp191225/core/constants/api_endpoints.dart';
import 'package:pp191225/data/mocks/auth_mock.dart';
import 'package:pp191225/data/mocks/gamification_mock.dart';
import 'package:pp191225/data/mocks/task_mock.dart';
import 'package:pp191225/data/mocks/user_mock.dart';
import 'package:pp191225/data/mocks/vocab_mock.dart';

/// Thay thế Dio khi USE_MOCK_DATA=true: nhận (method, path) và trả về JSON
/// giống response của backend thật, y như `response.data` của Dio.
///
/// Route không có mock sẽ throw Exception để biết ngay còn thiếu.
class MockApiRouter {
  MockApiRouter._();

  static const _latency = Duration(milliseconds: 400);

  static final _userById = RegExp(r'^/users/([^/]+)$');
  static final _taskById = RegExp(r'^/tasks/([^/]+)$');
  static final _deckById = RegExp(r'^/decks/([^/]+)$');

  static Future<dynamic> handle(
    String method,
    String path, {
    dynamic data,
    Map<String, dynamic>? query,
  }) async {
    await Future<void>.delayed(_latency);

    final body = data is Map
        ? Map<String, dynamic>.from(data)
        : <String, dynamic>{};
    final params = query ?? const <String, dynamic>{};
    final route = '$method $path';
    print('[MOCK] $route query=$params body=$body');

    // Auth
    if (route == 'POST ${ApiEndpoints.authRegister}') {
      return AuthMock.register(body);
    }
    if (route == 'POST ${ApiEndpoints.authFirebaseLogin}') {
      return AuthMock.loginWithFirebase(body);
    }
    if (route == 'POST ${ApiEndpoints.authRefresh}') return AuthMock.refresh();
    if (route == 'POST ${ApiEndpoints.authLogout}') return AuthMock.logout();

    // Users
    if (route == 'GET ${ApiEndpoints.userProfile}') return UserMock.profile();
    if (route == 'PUT ${ApiEndpoints.userProfile}') {
      return UserMock.updateProfile(body);
    }
    if (route == 'PATCH ${ApiEndpoints.userProfile}') {
      return UserMock.updateProfile(body);
    }
    // Gamification (dev UI offline, response y hệt backend thật)
    if (route == 'GET ${ApiEndpoints.userProgression}') return GamificationMock.progression();
    if (route == 'POST ${ApiEndpoints.userProgressionAdd}') {
      return GamificationMock.addProgression(body);
    }
    if (route == 'GET ${ApiEndpoints.leaderboard}') {
      return GamificationMock.leaderboard(params);
    }

    final userId = _userById.firstMatch(path)?.group(1);
    if (method == 'GET' && userId != null) return UserMock.getById(userId);

    // Tasks
    if (route == 'GET ${ApiEndpoints.tasks}') return TaskMock.list(params);
    if (route == 'POST ${ApiEndpoints.tasks}') return TaskMock.create(body);
    final taskId = _taskById.firstMatch(path)?.group(1);
    if (taskId != null) {
      if (method == 'PATCH') return TaskMock.update(taskId, body);
      if (method == 'DELETE') return TaskMock.delete(taskId);
    }

    // Vocab
    if (route == 'GET ${ApiEndpoints.decks}') return VocabMock.listDecks();
    if (route == 'POST ${ApiEndpoints.decks}') return VocabMock.createDeck(body);
    final deckIdMatch = _deckById.firstMatch(path)?.group(1);
    if (method == 'GET' && deckIdMatch != null) return VocabMock.getDeck(deckIdMatch);
    if (method == 'DELETE' && deckIdMatch != null) return VocabMock.deleteDeck();
    if (route == 'GET ${ApiEndpoints.cards}') return VocabMock.listCards(params);
    if (route == 'POST ${ApiEndpoints.cards}') return VocabMock.createCard(body);
    if (route == 'GET ${ApiEndpoints.studyQueue}') return VocabMock.getStudyQueue(params);
    if (route == 'POST ${ApiEndpoints.studySubmit}') return VocabMock.submitStudy(body);

    throw Exception('Mock chưa có route: $route');
  }
}
