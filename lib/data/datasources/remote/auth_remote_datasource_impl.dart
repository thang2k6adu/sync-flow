import 'package:pp191225/core/constants/api_endpoints.dart';
import 'package:pp191225/data/datasources/remote/auth_remote_datasource.dart';
import 'package:pp191225/data/models/auth/auth_response_dto.dart';
import 'package:pp191225/data/models/auth/token_dto.dart';
import 'package:pp191225/data/models/base/api_response.dart';
import 'package:pp191225/data/services/api_service.dart';

/// Implementation of AuthRemoteDataSource using ApiService
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiService apiService;

  AuthRemoteDataSourceImpl(this.apiService);

  @override
  Future<ApiResponse<AuthResponseDto>> register({
    required String email,
    required String password,
    String? name,
  }) async {
    final nameParts = name?.trim().split(RegExp(r'\s+')) ?? const <String>[];
    final response = await apiService.post(
      ApiEndpoints.authRegister,
      data: {
        'email': email,
        'password': password,
        if (nameParts.isNotEmpty) 'firstName': nameParts.first,
        if (nameParts.length > 1) 'lastName': nameParts.sublist(1).join(' '),
      },
    );

    return ApiResponse<AuthResponseDto>.fromJson(
      response,
      (data) => AuthResponseDto.fromJson(data as Map<String, dynamic>),
    );
  }

  @override
  Future<ApiResponse<AuthResponseDto>> loginWithFirebase({
    required String idToken,
    String? deviceId,
    String? platform,
  }) async {
    final response = await apiService.post(
      ApiEndpoints.authFirebaseLogin,
      data: {
        'idToken': idToken,
        if (deviceId != null) 'deviceId': deviceId,
        if (platform != null) 'platform': platform,
      },
    );

    return ApiResponse<AuthResponseDto>.fromJson(
      response,
      (data) => AuthResponseDto.fromJson(data as Map<String, dynamic>),
    );
  }

  @override
  Future<ApiResponse<TokenDto>> refreshToken(String refreshToken) async {
    final response = await apiService.post(
      ApiEndpoints.authRefresh,
      data: {'refreshToken': refreshToken},
    );

    return ApiResponse<TokenDto>.fromJson(
      response,
      (data) => TokenDto.fromJson(data as Map<String, dynamic>),
    );
  }

  @override
  Future<ApiResponse<void>> logout() async {
    final response = await apiService.post(ApiEndpoints.authLogout);

    // data thường null, mapper chỉ dùng khi có data
    return ApiResponse<void>.fromJson(response, (_) => null);
  }
}
