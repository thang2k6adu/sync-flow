import 'package:pp191225/core/utils/either.dart';
import 'package:pp191225/domain/entities/users/user.dart';
import 'package:pp191225/domain/failures/failures.dart';
import 'package:pp191225/domain/repositories/user_repository.dart';

/// Update user profile use case
class UpdateUserProfileUseCase {
  final UserRepository repository;

  UpdateUserProfileUseCase(this.repository);

  Future<Either<Failure, User>> call({
    String? name,
    String? avatar,
  }) {
    return repository.updateProfile(name: name, avatar: avatar);
  }
}
