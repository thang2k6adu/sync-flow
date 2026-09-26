import 'package:pp191225/core/utils/either.dart';
import 'package:pp191225/domain/entities/users/user.dart';
import 'package:pp191225/domain/failures/failures.dart';
import 'package:pp191225/domain/repositories/user_repository.dart';

/// Get current user profile use case
class GetCurrentUserUseCase {
  final UserRepository repository;

  GetCurrentUserUseCase(this.repository);

  Future<Either<Failure, User>> call() {
    return repository.getCurrentUser();
  }
}
