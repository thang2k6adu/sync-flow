import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pp191225/domain/entities/progression/user_progression.dart';

class ProgressionLocalDataSource {
  static const String _key = 'syncflow_user_progression';
  final FlutterSecureStorage storage;

  ProgressionLocalDataSource(this.storage);

  Future<UserProgression> getProgression() async {
    try {
      final jsonStr = await storage.read(key: _key);
      if (jsonStr == null || jsonStr.isEmpty) {
        return const UserProgression();
      }
      return UserProgression.fromJson(jsonDecode(jsonStr));
    } catch (_) {
      return const UserProgression();
    }
  }

  Future<void> saveProgression(UserProgression progression) async {
    final jsonStr = jsonEncode(progression.toJson());
    await storage.write(key: _key, value: jsonStr);
  }
}
