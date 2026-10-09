import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pp191225/data/datasources/local/auth_local_datasource.dart';
import 'package:pp191225/data/datasources/local/auth_local_datasource_impl.dart';
import 'package:pp191225/data/datasources/local/progression_local_datasource.dart';
import 'package:pp191225/data/datasources/local/settings_local_datasource.dart';
import 'package:pp191225/data/datasources/remote/auth_remote_datasource.dart';
import 'package:pp191225/data/datasources/remote/auth_remote_datasource_impl.dart';
import 'package:pp191225/data/datasources/remote/gamification_remote_datasource.dart';
import 'package:pp191225/data/datasources/remote/gamification_remote_datasource_impl.dart';
import 'package:pp191225/data/datasources/remote/task_remote_datasource.dart';
import 'package:pp191225/data/datasources/remote/task_remote_datasource_impl.dart';
import 'package:pp191225/data/datasources/remote/user_remote_datasource.dart';
import 'package:pp191225/data/datasources/remote/user_remote_datasource_impl.dart';
import 'package:pp191225/data/datasources/remote/vocab_remote_datasource.dart';
import 'package:pp191225/data/datasources/remote/vocab_remote_datasource_impl.dart';
import 'package:pp191225/data/services/api_service.dart';
import 'package:pp191225/data/services/firebase_auth_service.dart';
import 'package:pp191225/data/services/tts_service.dart';

final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService();
});

final ttsServiceProvider = Provider<TtsService>((ref) {
  return TtsService();
});

final secureStorageProvider = Provider<FlutterSecureStorage>((ref) {
  return const FlutterSecureStorage();
});

final firebaseAuthServiceProvider = Provider<FirebaseAuthService>((ref) {
  return FirebaseAuthService();
});


final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return AuthRemoteDataSourceImpl(apiService);
});

final authLocalDataSourceProvider = Provider<AuthLocalDataSource>((ref) {
  final storage = ref.watch(secureStorageProvider);
  return AuthLocalDataSourceImpl(storage);
});

final userRemoteDataSourceProvider = Provider<UserRemoteDataSource>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return UserRemoteDataSourceImpl(apiService);
});

final taskRemoteDataSourceProvider = Provider<TaskRemoteDataSource>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return TaskRemoteDataSourceImpl(apiService);
});

final vocabRemoteDataSourceProvider = Provider<VocabRemoteDataSource>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return VocabRemoteDataSourceImpl(apiService);
});

final gamificationRemoteDataSourceProvider = Provider<GamificationRemoteDataSource>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return GamificationRemoteDataSourceImpl(apiService);
});

final progressionLocalDataSourceProvider = Provider<ProgressionLocalDataSource>((ref) {
  final storage = ref.watch(secureStorageProvider);
  return ProgressionLocalDataSource(storage);
});

final settingsLocalDataSourceProvider = Provider<SettingsLocalDataSource>((ref) {
  final storage = ref.watch(secureStorageProvider);
  return SettingsLocalDataSource(storage);
});


