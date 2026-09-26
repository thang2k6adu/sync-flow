import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pp191225/data/repositories/auth_repository_impl.dart';
import 'package:pp191225/data/repositories/task_repository_impl.dart';
import 'package:pp191225/data/repositories/user_repository_impl.dart';
import 'package:pp191225/domain/repositories/auth_repository.dart';
import 'package:pp191225/domain/repositories/task_repository.dart';
import 'package:pp191225/domain/repositories/user_repository.dart';
import 'package:pp191225/providers/datasources_provider.dart';

// ============================================================================
// Repositories
// ============================================================================

/// Provide AuthRepository
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final remoteDataSource = ref.watch(authRemoteDataSourceProvider);
  final localDataSource = ref.watch(authLocalDataSourceProvider);
  
  return AuthRepositoryImpl(
    remoteDataSource: remoteDataSource,
    localDataSource: localDataSource,
  );
});

/// Provide UserRepository
final userRepositoryProvider = Provider<UserRepository>((ref) {
  final remoteDataSource = ref.watch(userRemoteDataSourceProvider);
  
  return UserRepositoryImpl(
    remoteDataSource: remoteDataSource,
  );
});

/// Provide TaskRepository
final taskRepositoryProvider = Provider<TaskRepository>((ref) {
  final remoteDataSource = ref.watch(taskRemoteDataSourceProvider);

  return TaskRepositoryImpl(
    remoteDataSource: remoteDataSource,
  );
});
