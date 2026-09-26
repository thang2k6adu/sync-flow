import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pp191225/core/constants/constants.dart';
import 'package:pp191225/data/datasources/local/auth_local_datasource.dart';
import 'package:pp191225/data/models/auth/token_dto.dart';

/// Implementation of AuthLocalDataSource using FlutterSecureStorage
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final FlutterSecureStorage storage;

  AuthLocalDataSourceImpl(this.storage);

  @override
  Future<TokenDto?> getToken() async {
    try {
      final accessToken = await storage.read(
        key: StorageConstants.accessTokenKey,
      );
      final refreshToken = await storage.read(
        key: StorageConstants.refreshTokenKey,
      );
      final expiresIn = await storage.read(
        key: StorageConstants.tokenExpiredKey,
      );

      if (accessToken == null) {
        return null;
      }

      return TokenDto(
        accessToken: accessToken,
        refreshToken: refreshToken,
        expiresIn: expiresIn != null ? int.tryParse(expiresIn) : null,
      );
    } catch (e) {
      print("AuthLocalDataSource.getToken error: $e");
      rethrow;
    }
  }

  @override
  Future<void> saveToken(TokenDto token) async {
    try {
      await storage.write(
        key: StorageConstants.accessTokenKey,
        value: token.accessToken,
      );

      if (token.refreshToken != null) {
        await storage.write(
          key: StorageConstants.refreshTokenKey,
          value: token.refreshToken!,
        );
      }

      if (token.expiresIn != null) {
        await storage.write(
          key: StorageConstants.tokenExpiredKey,
          value: token.expiresIn.toString(),
        );
      }
    } catch (e) {
      print("AuthLocalDataSource.saveToken error: $e");
      rethrow;
    }
  }

  @override
  Future<void> clearTokens() async {
    try {
      await storage.delete(key: StorageConstants.accessTokenKey);
      await storage.delete(key: StorageConstants.refreshTokenKey);
      await storage.delete(key: StorageConstants.tokenExpiredKey);
    } catch (e) {
      print("AuthLocalDataSource.clearTokens error: $e");
      rethrow;
    }
  }

  @override
  Future<bool> isAuthenticated() async {
    final token = await getToken();
    return token?.accessToken != null && token!.accessToken.isNotEmpty;
  }
}
