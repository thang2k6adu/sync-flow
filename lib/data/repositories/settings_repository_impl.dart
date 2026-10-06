import 'package:pp191225/data/datasources/local/settings_local_datasource.dart';
import 'package:pp191225/domain/entities/settings/app_settings.dart';
import 'package:pp191225/domain/repositories/settings_repository.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsLocalDataSource localDataSource;

  SettingsRepositoryImpl({required this.localDataSource});

  @override
  Future<AppSettings> getSettings() => localDataSource.getSettings();

  @override
  Future<void> saveSettings(AppSettings settings) =>
      localDataSource.saveSettings(settings);
}
