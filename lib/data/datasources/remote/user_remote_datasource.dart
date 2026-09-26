import 'package:pp191225/data/models/users/user_dto.dart';
import 'package:pp191225/data/models/base/api_response.dart';

/// User remote data source interface
/// Handles user API calls
abstract class UserRemoteDataSource {
  /// Get current user profile
  Future<ApiResponse<UserDto>> getCurrentUser();

  /// Update user profile
  Future<ApiResponse<UserDto>> updateProfile({
    String? name,
    String? avatar,
  });

  /// Get user by ID
  Future<ApiResponse<UserDto>> getUserById(String userId);
}
