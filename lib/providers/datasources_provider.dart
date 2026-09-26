import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pp191225/data/datasources/local/auth_local_datasource.dart';
import 'package:pp191225/data/datasources/local/auth_local_datasource_impl.dart';
import 'package:pp191225/data/datasources/remote/auth_remote_datasource.dart';
import 'package:pp191225/data/datasources/remote/auth_remote_datasource_impl.dart';
import 'package:pp191225/data/datasources/remote/task_remote_datasource.dart';
import 'package:pp191225/data/datasources/remote/task_remote_datasource_impl.dart';
import 'package:pp191225/data/datasources/remote/user_remote_datasource.dart';
import 'package:pp191225/data/datasources/remote/user_remote_datasource_impl.dart';
import 'package:pp191225/data/services/api_service.dart';
import 'package:pp191225/data/services/firebase_auth_service.dart';

final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService();
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
