import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pp191225/domain/entities/settings/app_settings.dart';

class SettingsLocalDataSource {
  static const String _key = 'syncflow_app_settings';
  final FlutterSecureStorage storage;

  SettingsLocalDataSource(this.storage);

  Future<AppSettings> getSettings() async {
    try {
      final jsonStr = await storage.read(key: _key);
      if (jsonStr == null || jsonStr.isEmpty) {
        return const AppSettings();
      }
      return AppSettings.fromJson(jsonDecode(jsonStr));
    } catch (_) {
      return const AppSettings();
    }
  }

  Future<void> saveSettings(AppSettings settings) async {
    final jsonStr = jsonEncode(settings.toJson());
    await storage.write(key: _key, value: jsonStr);
  }
}
