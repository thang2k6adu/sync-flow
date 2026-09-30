import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pp191225/domain/usecases/auth/login_with_password_usecase.dart';
import 'package:pp191225/domain/usecases/auth/login_with_provider_usecase.dart';
import 'package:pp191225/domain/usecases/auth/logout_usecase.dart';
import 'package:pp191225/domain/usecases/auth/register_usecase.dart';
import 'package:pp191225/domain/usecases/task/create_task_usecase.dart';
import 'package:pp191225/domain/usecases/task/delete_task_usecase.dart';
import 'package:pp191225/domain/usecases/task/get_tasks_usecase.dart';
import 'package:pp191225/domain/usecases/task/update_task_usecase.dart';
import 'package:pp191225/domain/usecases/user/get_current_user_usecase.dart';
import 'package:pp191225/domain/usecases/user/update_user_profile_usecase.dart';
import 'package:pp191225/providers/datasources_provider.dart';
import 'package:pp191225/providers/repositories_provider.dart';

// ============================================================================
// Auth UseCases
// ============================================================================

/// Provide RegisterUseCase
final registerUseCaseProvider = Provider<RegisterUseCase>((ref) {
  final firebaseAuthService = ref.watch(firebaseAuthServiceProvider);
  return RegisterUseCase(firebaseAuthService);
});

/// Provide LogoutUseCase (BE logout + Firebase sign out)
final logoutUseCaseProvider = Provider<LogoutUseCase>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  final firebaseAuthService = ref.watch(firebaseAuthServiceProvider);
  return LogoutUseCase(
    repository: repository,
    firebaseAuthService: firebaseAuthService,
  );
});

final loginWithProviderUseCaseProvider = Provider<LoginWithProviderUseCase>((
  ref,
) {
  final repository = ref.watch(authRepositoryProvider);
  final firebaseAuthService = ref.watch(firebaseAuthServiceProvider);
  return LoginWithProviderUseCase(
    repository: repository,
    firebaseAuthService: firebaseAuthService,
  );
});

final loginWithPasswordUseCaseProvider = Provider<LoginWithPasswordUseCase>((
  ref,
) {
  final repository = ref.watch(authRepositoryProvider);
  final firebaseAuthService = ref.watch(firebaseAuthServiceProvider);
  return LoginWithPasswordUseCase(
    repository: repository,
    firebaseAuthService: firebaseAuthService,
  );
});

final getCurrentUserUseCaseProvider = Provider<GetCurrentUserUseCase>((ref) {
  final repository = ref.watch(userRepositoryProvider);
  return GetCurrentUserUseCase(repository);
});

/// Provide UpdateUserProfileUseCase
final updateUserProfileUseCaseProvider = Provider<UpdateUserProfileUseCase>((
  ref,
) {
  final repository = ref.watch(userRepositoryProvider);
  return UpdateUserProfileUseCase(repository);
});

// ============================================================================
// Task UseCases
// ============================================================================

/// Provide GetTasksUseCase
final getTasksUseCaseProvider = Provider<GetTasksUseCase>((ref) {
  final repository = ref.watch(taskRepositoryProvider);
  return GetTasksUseCase(repository);
});

/// Provide CreateTaskUseCase
final createTaskUseCaseProvider = Provider<CreateTaskUseCase>((ref) {
  final repository = ref.watch(taskRepositoryProvider);
  return CreateTaskUseCase(repository);
});

/// Provide UpdateTaskUseCase
final updateTaskUseCaseProvider = Provider<UpdateTaskUseCase>((ref) {
  final repository = ref.watch(taskRepositoryProvider);
  return UpdateTaskUseCase(repository);
});

/// Provide DeleteTaskUseCase
final deleteTaskUseCaseProvider = Provider<DeleteTaskUseCase>((ref) {
  final repository = ref.watch(taskRepositoryProvider);
  return DeleteTaskUseCase(repository);
});
