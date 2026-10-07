import 'package:pp191225/data/models/base/api_response.dart';
import 'package:pp191225/data/models/vocab/deck_dto.dart';
import 'package:pp191225/data/models/vocab/card_dto.dart';
import 'package:pp191225/data/models/vocab/study_queue_dto.dart';
import 'package:pp191225/data/models/vocab/study_submit_dto.dart';

class VocabMock {
  VocabMock._();

  static final List<Map<String, dynamic>> _mockDecks = [
    {
      'id': 'd-sys-1',
      'name': 'Giao tiếp hàng ngày',
      'description': 'Các mẫu câu và từ vựng giao tiếp cơ bản.',
      'category': 'topic',
      'iconUrl': 'https://example.com/icon1.png',
      'cefrLevel': 'A1',
      'isSystem': true,
      'cardCount': 50,
      'createdAt': DateTime.now().toIso8601String(),
      'updatedAt': DateTime.now().toIso8601String(),
    },
    {
      'id': 'd-sys-2',
      'name': '3000 từ vựng Oxford',
      'description': 'Bộ từ vựng cốt lõi.',
      'category': 'exam',
      'iconUrl': 'https://example.com/icon2.png',
      'cefrLevel': 'B1',
      'isSystem': true,
      'cardCount': 3000,
      'createdAt': DateTime.now().toIso8601String(),
      'updatedAt': DateTime.now().toIso8601String(),
    },
    {
      'id': 'd-per-1',
      'name': 'Sổ tay từ vựng',
      'description': 'Các từ mình tự thêm vào.',
      'category': 'personal',
      'isSystem': false,
      'cardCount': 5,
      'createdAt': DateTime.now().toIso8601String(),
      'updatedAt': DateTime.now().toIso8601String(),
    },
  ];

  static Map<String, dynamic> listDecks() {
    return ApiResponse<List<dynamic>>(
      data: _mockDecks,
      message: 'Success',
    ).toJson((data) => data);
  }

  static Map<String, dynamic> getDeck(String id) {
    final deck = _mockDecks.firstWhere((d) => d['id'] == id, orElse: () => _mockDecks.first);
    return ApiResponse<Map<String, dynamic>>(
      data: deck,
      message: 'Success',
    ).toJson((data) => data);
  }

  static Map<String, dynamic> getStudyQueue(Map<String, dynamic> query) {
    final queueItems = [
      {
        'card': {
          'id': 'c-1',
          'deckId': 'd-sys-1',
          'term': 'hello',
          'meanings': [
            {
              'partOfSpeech': 'noun',
              'translation': 'xin chào',
              'englishDefinition': 'greeting',
            }
          ],
          'exercises': [
            {
              'type': 'sentenceBuilder',
              'question': 'Say hi in English',
              'correctAnswer': 'hello',
              'options': ['hello', 'bye', 'good'],
            }
          ],
        },
        'srsData': {
          'isLeech': false,
          'lapsesCount': 0,
          'intervalDays': 1,
        },
      },
      {
        'card': {
          'id': 'c-2',
          'deckId': 'd-sys-1',
          'term': 'leech word',
          'meanings': [
            {
              'partOfSpeech': 'noun',
              'translation': 'từ khó nhớ',
            }
          ],
        },
        'srsData': {
          'isLeech': true,
          'lapsesCount': 6,
          'intervalDays': 0,
        },
      },
      {
        'card': {
          'id': 'c-3',
          'deckId': 'd-sys-1',
          'term': 'typing test',
          'meanings': [
            {
              'partOfSpeech': 'noun',
              'translation': 'bài kiểm tra gõ',
            }
          ],
          'exercises': [
            {
              'type': 'typingChallenge',
              'question': 'bài kiểm tra gõ',
              'correctAnswer': 'typing test',
            }
          ],
        },
        'srsData': {
          'isLeech': false,
          'lapsesCount': 0,
          'intervalDays': 1,
        },
      }
    ];

    return ApiResponse<Map<String, dynamic>>(
      data: {'queue': queueItems, 'hasMore': false},
      message: 'Success',
    ).toJson((data) => data);
  }

  static Map<String, dynamic> submitStudy(Map<String, dynamic> body) {
    return ApiResponse<Map<String, dynamic>>(
      data: {
        'nextReviewAt': DateTime.now().add(const Duration(days: 1)).toIso8601String(),
        'expGained': 10,
        'levelUp': false,
        'currentLevel': 1,
      },
      message: 'Success',
    ).toJson((data) => data);
  }
}
