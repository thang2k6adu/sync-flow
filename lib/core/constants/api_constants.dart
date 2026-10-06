import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  ApiConstants._();

  static String get baseUrl {
    final url = dotenv.env['API_BASE_URL'] ?? 'http://10.0.2.2:3000/api';
    if (kIsWeb && url.contains('10.0.2.2')) {
      return url.replaceAll('10.0.2.2', 'localhost');
    }
    return url;
  }

  /// true: ApiService/FirebaseAuthService trả mock data (lib/data/mocks), không gọi backend/Firebase.
  static bool get useMockData {
    return dotenv.env['USE_MOCK_DATA']?.trim().toLowerCase() == 'true';
  }

  static String get webClientId {
    return dotenv.env['GOOGLE_WEB_CLIENT_ID'] ?? '';
  }

  static int get connectTimeout {
    final value = dotenv.env['API_CONNECT_TIMEOUT'];
    return value != null ? int.tryParse(value) ?? 10000 : 10000;
  }

  static int get receiveTimeout {
    final value = dotenv.env['API_RECEIVE_TIMEOUT'];
    return value != null ? int.tryParse(value) ?? 3000 : 3000;
  }

  static String get appName {
    return dotenv.env['APP_NAME'] ?? 'PP191225';
  }

  static String get appVersion {
    return dotenv.env['APP_VERSION'] ?? '1.0.0';
  }
}