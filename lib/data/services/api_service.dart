import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pp191225/core/constants/constants.dart';
import 'package:pp191225/data/mocks/mock_api_router.dart';
import 'package:pp191225/data/models/auth/token_dto.dart';

class ApiService {
  late Dio _dio;
  final _storage = const FlutterSecureStorage();

  ApiService() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: Duration(milliseconds: ApiConstants.connectTimeout),
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          try {
            final [accessToken, deviceKey] = await Future.wait([
              _storage.read(key: StorageConstants.accessTokenKey),
              _storage.read(key: StorageConstants.tokenDeviceKey),
            ]);

            options.headers.addAll({
              if (accessToken != null && accessToken.isNotEmpty)
                'Authorization': 'Bearer $accessToken',
              'device-name': AppConstants.deviceName,
              'device-token': deviceKey,
              'device-id': AppConstants.deviceId,
              'os-version': AppConstants.osVersion,
              'os-type': AppConstants.osType,
              'ip': AppConstants.ipAddress,
            });
            return handler.next(options);
          } catch (e) {
            return handler.reject(
              DioException(requestOptions: options, error: e),
            );
          }
        },
        onResponse: (response, handler) {
          print(
            "Response: \n- ${response.requestOptions.method} ${response.requestOptions.uri} \n body: ${response.requestOptions.data}",
          );
          print(
            "==> Status: ${response.statusCode} \n==> data: ${response.data}",
          );
          return handler.next(response);
        },
        onError: (DioException error, handler) async {
          final requestPath = error.requestOptions.uri.path;
          print(
            "Call API error: ${error.requestOptions.method} "
            "$requestPath status=${error.response?.statusCode} "
            "message=${error.response?.data?['message']}",
          );
          final refreshTokenValue = await _storage.read(
            key: StorageConstants.refreshTokenKey,
          );
          if (error.response?.statusCode == 401 &&
              !requestPath.startsWith('/auth/') &&
              error.requestOptions.headers['Authorization'] != null &&
              refreshTokenValue != null &&
              refreshTokenValue.isNotEmpty) {
            try {
              final newTokens = await refreshToken();
              error.requestOptions.headers['Authorization'] =
                  'Bearer ${newTokens.accessToken}';
              final response = await _dio.fetch(error.requestOptions);
              return handler.resolve(response);
            } catch (refreshError) {
              // Delete token and logout
              await clearTokens();
              //Todo: Send a event logout()
              return handler.reject(error);
            }
          }
          if (error.response?.statusCode == 403) {
            await clearTokens();
          }
          return handler.next(error);
        },
      ),
    );
  }

  Future<TokenDto> refreshToken() async {
    try {
      final refreshToken = await _storage.read(
        key: StorageConstants.refreshTokenKey,
      ); // create new Dio other than particularly to avoid infinite loops
      final refreshDio = Dio(BaseOptions(baseUrl: ApiConstants.baseUrl));

      final response = await refreshDio.post(
        '/auth/refresh',
        data: {'refreshToken': refreshToken},
      );

      final tokens = TokenDto.fromJson(response.data['data']);

      await _storage.write(
        key: StorageConstants.accessTokenKey,
        value: tokens.accessToken,
      );
      if (tokens.refreshToken != null) {
        await _storage.write(
          key: StorageConstants.refreshTokenKey,
          value: tokens.refreshToken,
        );
      }
      if (tokens.expiresIn != null) {
        await _storage.write(
          key: StorageConstants.tokenExpiredKey,
          value: tokens.expiresIn.toString(),
        );
      }

      return tokens;
    } catch (error) {
      throw Exception('Refresh token failed');
    }
  }

  Future<dynamic> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    if (ApiConstants.useMockData) {
      return MockApiRouter.handle('GET', path, query: queryParameters);
    }
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return response.data;
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response?.data['message']);
      } else {
        throw Exception("Failed to call API");
      }
    }
  }

  Future<void> clearTokens() async {
    await _storage.delete(key: StorageConstants.accessTokenKey);
    await _storage.delete(key: StorageConstants.refreshTokenKey);
    await _storage.delete(key: StorageConstants.tokenExpiredKey);
    // Trigger logout event
  }

  Future<dynamic> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? headers,
  }) async {
    if (ApiConstants.useMockData) {
      return MockApiRouter.handle('POST', path, data: data);
    }
    try {
      final response = await _dio.post(
        path,
        data: data,
        options: Options(headers: headers),
      );
      return response.data;
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response?.data['message']);
      } else {
        throw Exception("Failed to call API");
      }
    }
  }

  Future<dynamic> patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? headers,
  }) async {
    if (ApiConstants.useMockData) {
      return MockApiRouter.handle('PATCH', path, data: data);
    }
    try {
      final response = await _dio.patch(
        path,
        data: data,
        options: Options(headers: headers),
      );
      return response.data;
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response?.data['message']);
      } else {
        print("Failed to call API: ${e.toString()}");
        throw Exception("Failed to call API");
      }
    }
  }

  Future<dynamic> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? headers,
  }) async {
    if (ApiConstants.useMockData) {
      return MockApiRouter.handle('PUT', path, data: data);
    }
    try {
      final response = await _dio.put(
        path,
        data: data,
        options: Options(headers: headers),
      );
      return response.data;
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response?.data['message']);
      } else {
        throw Exception("Failed to call API");
      }
    }
  }

  Future<dynamic> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? headers,
  }) async {
    if (ApiConstants.useMockData) {
      return MockApiRouter.handle('DELETE', path, data: data);
    }
    try {
      final response = await _dio.delete(
        path,
        data: data,
        options: Options(headers: headers),
      );
      return response.data;
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response?.data['message']);
      } else {
        throw Exception("Failed to call API");
      }
    }
  }
}
