import 'package:pp191225/data/models/auth/token_dto.dart';

/// Authentication local data source interface
/// Handles token storage in secure storage
abstract class AuthLocalDataSource {
  /// Get stored tokens from secure storage
  Future<TokenDto?> getToken();

  /// Save tokens to secure storage
  Future<void> saveToken(TokenDto token);

  /// Clear all stored tokens
  Future<void> clearTokens();

  /// Check if user has valid token
  Future<bool> isAuthenticated();
}
