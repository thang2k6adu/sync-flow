import 'package:pp191225/data/models/base/api_response.dart';

class VocabMock {
  VocabMock._();

  static final List<Map<String, dynamic>> _mockDecks = [
    {
      'id': 'd-sys-1',
      'name': 'Giao tiếp hàng ngày',
      'description': 'Các mẫu câu và từ vựng giao tiếp căn bản trong đời sống.',
      'category': 'Giao tiếp',
      'iconUrl': 'https://example.com/icon1.png',
      'cefrLevel': 'A1',
      'isSystem': true,
      'cardCount': 50,
      'createdAt': '2026-01-01T08:00:00.000Z',
      'updatedAt': '2026-01-01T08:00:00.000Z',
    },
    {
      'id': 'd-sys-2',
      'name': '3000 từ vựng Oxford',
      'description': 'Bộ từ vựng cốt lõi bao quát 85% ngôn ngữ tiếng Anh thường nhật.',
      'category': 'Cốt lõi',
      'iconUrl': 'https://example.com/icon2.png',
      'cefrLevel': 'B1',
      'isSystem': true,
      'cardCount': 3000,
      'createdAt': '2026-01-05T09:00:00.000Z',
      'updatedAt': '2026-01-05T09:00:00.000Z',
    },
    {
      'id': 'd-sys-3',
      'name': 'Tiếng Anh Công Nghệ & IT',
      'description': 'Thuật ngữ phần mềm, công nghệ thông tin và quy trình phát triển dự án.',
      'category': 'Công nghệ',
      'iconUrl': 'https://example.com/icon3.png',
      'cefrLevel': 'B2',
      'isSystem': true,
      'cardCount': 120,
      'createdAt': '2026-01-10T10:00:00.000Z',
      'updatedAt': '2026-01-10T10:00:00.000Z',
    },
    {
      'id': 'd-sys-4',
      'name': 'IELTS Academic Core',
      'description': 'Từ vựng học thuật chuyên sâu phục vụ band điểm 6.5 - 8.0.',
      'category': 'Học thuật',
      'iconUrl': 'https://example.com/icon4.png',
      'cefrLevel': 'C1',
      'isSystem': true,
      'cardCount': 800,
      'createdAt': '2026-01-12T11:00:00.000Z',
      'updatedAt': '2026-01-12T11:00:00.000Z',
    },
    {
      'id': 'd-sys-5',
      'name': 'Thương Mại & Đàm Phán (Business)',
      'description': 'Từ vựng phỏng vấn, thương thảo hợp đồng, báo cáo kinh doanh.',
      'category': 'Kinh doanh',
      'iconUrl': 'https://example.com/icon5.png',
      'cefrLevel': 'B2',
      'isSystem': true,
      'cardCount': 250,
      'createdAt': '2026-01-15T08:30:00.000Z',
      'updatedAt': '2026-01-15T08:30:00.000Z',
    },
    {
      'id': 'd-sys-6',
      'name': 'Education & Pedagogy',
      'description': 'Phương pháp sư phạm, giáo dục học và kỹ năng giảng dạy hiện đại.',
      'category': 'Giáo dục',
      'iconUrl': 'https://example.com/icon6.png',
      'cefrLevel': 'B2',
      'isSystem': true,
      'cardCount': 110,
      'createdAt': '2026-01-18T14:00:00.000Z',
      'updatedAt': '2026-01-18T14:00:00.000Z',
    },
    {
      'id': 'd-sys-7',
      'name': 'Thành Ngữ & Collocations Thông Dụng',
      'description': 'Các cụm từ cố định giúp nói và viết tự nhiên như người bản xứ.',
      'category': 'Thành ngữ',
      'iconUrl': 'https://example.com/icon7.png',
      'cefrLevel': 'B2',
      'isSystem': true,
      'cardCount': 180,
      'createdAt': '2026-01-20T16:00:00.000Z',
      'updatedAt': '2026-01-20T16:00:00.000Z',
    },
    {
      'id': 'd-sys-8',
      'name': 'Tiếng Anh Du Lịch & Sân Bay',
      'description': 'Đặt vé, hỏi đường, giao tiếp khách sạn và xử lý tình huống du lịch.',
      'category': 'Du lịch',
      'iconUrl': 'https://example.com/icon8.png',
      'cefrLevel': 'A2',
      'isSystem': true,
      'cardCount': 95,
      'createdAt': '2026-01-22T09:15:00.000Z',
      'updatedAt': '2026-01-22T09:15:00.000Z',
    },
    {
      'id': 'd-per-1',
      'name': 'Sổ tay từ vựng của tôi',
      'description': 'Các từ vựng ghi chú cá nhân khi đọc sách và lướt tin tức.',
      'category': 'Cá nhân',
      'isSystem': false,
      'cardCount': 15,
      'createdAt': '2026-02-01T10:00:00.000Z',
      'updatedAt': '2026-02-01T10:00:00.000Z',
    },
    {
      'id': 'd-per-2',
      'name': 'Từ vựng xem phim & Podcast',
      'description': 'Ghi lại các câu thoại và từ lóng thực tế trong các series truyền hình.',
      'category': 'Cá nhân',
      'isSystem': false,
      'cardCount': 8,
      'createdAt': '2026-02-05T15:20:00.000Z',
      'updatedAt': '2026-02-05T15:20:00.000Z',
    },
  ];

  static final List<Map<String, dynamic>> _mockCards = [
    {
      'id': 'c-1',
      'deckId': 'd-sys-1',
      'term': 'Fluency',
      'phonetic': '/ˈfluː.ən.si/',
      'cefrLevel': 'B2',
      'meanings': [
        {
          'pos': 'noun',
          'meaning_vi': 'Sự lưu loát, trôi chảy',
          'definition_en': 'The ability to speak or write easily and smoothly',
        }
      ],
      'collocations': ['achieve fluency', 'oral fluency'],
    },
    {
      'id': 'c-2',
      'deckId': 'd-sys-1',
      'term': 'Synchronize',
      'phonetic': '/ˈsɪŋ.krə.naɪz/',
      'cefrLevel': 'C1',
      'meanings': [
        {
          'pos': 'verb',
          'meaning_vi': 'Đồng bộ hóa',
          'definition_en': 'To occur at the same time or cause to agree in time',
        }
      ],
      'collocations': ['synchronize data', 'synchronize clocks'],
    },
    {
      'id': 'c-3',
      'deckId': 'd-sys-2',
      'term': 'Resilience',
      'phonetic': '/rɪˈzɪl.jəns/',
      'cefrLevel': 'B2',
      'meanings': [
        {
          'pos': 'noun',
          'meaning_vi': 'Sức bền, khả năng phục hồi',
          'definition_en': 'Capacity to recover quickly from difficulties',
        }
      ],
      'collocations': ['build resilience', 'emotional resilience'],
    },
    {
      'id': 'c-4',
      'deckId': 'd-sys-2',
      'term': 'Accomplish',
      'phonetic': '/əˈkʌm.plɪʃ/',
      'cefrLevel': 'B1',
      'meanings': [
        {
          'pos': 'verb',
          'meaning_vi': 'Hoàn thành, đạt được mục tiêu',
          'definition_en': 'To achieve or complete successfully',
        }
      ],
      'collocations': ['accomplish a task', 'accomplish goal'],
    },
    {
      'id': 'c-5',
      'deckId': 'd-sys-2',
      'term': 'Consistency',
      'phonetic': '/kənˈsɪs.tən.si/',
      'cefrLevel': 'B2',
      'meanings': [
        {
          'pos': 'noun',
          'meaning_vi': 'Sự kiên định, tính nhất quán',
          'definition_en': 'Conformity in the application of something',
        }
      ],
      'collocations': ['maintain consistency', 'consistency in study'],
    },
    {
      'id': 'c-6',
      'deckId': 'd-sys-6',
      'term': 'Pedagogy',
      'phonetic': '/ˈped.ə.ɡɒdʒ.i/',
      'cefrLevel': 'C2',
      'meanings': [
        {
          'pos': 'noun',
          'meaning_vi': 'Phương pháp sư phạm, giáo dục',
          'definition_en': 'The method and practice of teaching',
        }
      ],
      'collocations': ['innovative pedagogy', 'critical pedagogy'],
    },
    {
      'id': 'c-7',
      'deckId': 'd-sys-1',
      'term': 'Perspective',
      'phonetic': '/pəˈspek.tɪv/',
      'cefrLevel': 'B2',
      'meanings': [
        {
          'pos': 'noun',
          'meaning_vi': 'Góc nhìn, quan điểm',
          'definition_en': 'A particular attitude towards or way of regarding something',
        }
      ],
      'collocations': ['broader perspective', 'different perspective'],
    },
    {
      'id': 'c-8',
      'deckId': 'd-sys-3',
      'term': 'Architecture',
      'phonetic': '/ˈɑː.kɪ.tek.tʃər/',
      'cefrLevel': 'B2',
      'meanings': [
        {
          'pos': 'noun',
          'meaning_vi': 'Kiến trúc hệ thống phần mềm',
          'definition_en': 'The complex or carefully designed structure of something',
        }
      ],
      'collocations': ['software architecture', 'clean architecture'],
    },
    {
      'id': 'c-9',
      'deckId': 'd-sys-4',
      'term': 'Ubiquitous',
      'phonetic': '/juːˈbɪk.wɪ.təs/',
      'cefrLevel': 'C1',
      'meanings': [
        {
          'pos': 'adj',
          'meaning_vi': 'Phổ biến khắp nơi',
          'definition_en': 'Present, appearing, or found everywhere',
        }
      ],
      'collocations': ['ubiquitous technology', 'ubiquitous presence'],
    },
    {
      'id': 'c-10',
      'deckId': 'd-sys-5',
      'term': 'Negotiation',
      'phonetic': '/nəˌɡəʊ.ʃiˈeɪ.ʃən/',
      'cefrLevel': 'B2',
      'meanings': [
        {
          'pos': 'noun',
          'meaning_vi': 'Đàm phán, thương lượng hợp đồng',
          'definition_en': 'Discussion aimed at reaching an agreement',
        }
      ],
      'collocations': ['enter negotiations', 'successful negotiation'],
    },
  ];

  static Map<String, dynamic> listDecks() {
    return ApiResponse<List<dynamic>>(
      data: _mockDecks,
      message: 'Success',
    ).toJson((data) => data);
  }

  static Map<String, dynamic> createDeck(Map<String, dynamic> body) {
    final newDeck = {
      'id': 'd-per-${DateTime.now().millisecondsSinceEpoch}',
      'name': body['name'] ?? 'Bộ từ mới',
      'description': body['description'] ?? '',
      'category': body['category'] ?? 'Cá nhân',
      'cefrLevel': body['cefrLevel'] ?? 'A1',
      'isSystem': false,
      'cardCount': 0,
      'createdAt': DateTime.now().toIso8601String(),
    };
    _mockDecks.add(newDeck);
    return ApiResponse<Map<String, dynamic>>(
      data: newDeck,
      message: 'Success',
    ).toJson((data) => data);
  }

  static Map<String, dynamic> deleteDeck() {
    return ApiResponse<Map<String, dynamic>>(
      data: {},
      message: 'Success',
    ).toJson((data) => data);
  }

  static Map<String, dynamic> listCards([Map<String, dynamic>? query]) {
    var list = _mockCards;
    if (query != null && query['deckId'] != null) {
      list = list.where((c) => c['deckId'] == query['deckId']).toList();
    }
    return ApiResponse<List<dynamic>>(
      data: list,
      message: 'Success',
    ).toJson((data) => data);
  }

  static Map<String, dynamic> createCard(Map<String, dynamic> body) {
    final newCard = {
      'id': 'c-${DateTime.now().millisecondsSinceEpoch}',
      'deckId': body['deckId'] ?? 'd-per-1',
      'term': body['term'] ?? '',
      'phonetic': body['phonetic'] ?? '',
      'cefrLevel': body['cefrLevel'] ?? 'A1',
      'meanings': body['meanings'] ?? [],
      'collocations': body['collocations'] ?? [],
    };
    _mockCards.add(newCard);
    return ApiResponse<Map<String, dynamic>>(
      data: newCard,
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
              'pos': 'noun',
              'meaning_vi': 'xin chào',
              'definition_en': 'greeting',
            }
          ],
          'exercises': [
            {
              'exerciseType': 'sentenceBuilder',
              'targetSentence': 'hello world',
              'vietnameseTranslation': 'xin chào thế giới',
              'tokens': ['hello', 'world'],
              'distractorTokens': ['bye', 'good'],
              'targetIndex': 0,
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
          'term': 'Resilience',
          'meanings': [
            {
              'pos': 'noun',
              'meaning_vi': 'khả năng phục hồi',
              'definition_en': 'capacity to recover',
            }
          ],
        },
        'srsData': {
          'isLeech': true,
          'lapsesCount': 5,
          'intervalDays': 0,
        },
      },
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
