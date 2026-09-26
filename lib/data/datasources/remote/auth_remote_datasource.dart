import 'package:pp191225/data/models/auth/auth_response_dto.dart';
import 'package:pp191225/data/models/auth/token_dto.dart';
import 'package:pp191225/data/models/base/api_response.dart';

/// Authentication remote data source interface
/// Handles authentication API calls
abstract class AuthRemoteDataSource {
  /// Login with email and password
  Future<ApiResponse<AuthResponseDto>> login({
    required String email,
    required String password,
  });

  /// Register a new user
  Future<ApiResponse<AuthResponseDto>> register({
    required String email,
    required String password,
    String? name,
  });

  /// Login with Firebase ID token
  Future<ApiResponse<AuthResponseDto>> loginWithFirebase({
    required String idToken,
    String? deviceId,
    String? platform,
  });

  /// Refresh access token
  Future<ApiResponse<TokenDto>> refreshToken(String refreshToken);

  /// Logout user
  Future<ApiResponse<void>> logout();
}
