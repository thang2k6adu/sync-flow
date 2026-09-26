import 'package:pp191225/core/utils/either.dart';
import 'package:pp191225/domain/entities/users/user.dart';
import 'package:pp191225/domain/failures/failures.dart';

/// User repository interface
/// Defines the contract for user operations
/// This is implemented in the data layer
abstract class UserRepository {
  /// Get current user profile
  Future<Either<Failure, User>> getCurrentUser();

  /// Update user profile
  Future<Either<Failure, User>> updateProfile({
    String? name,
    String? avatar,
  });

  /// Get user by ID
  Future<Either<Failure, User>> getUserById(String userId);
}
