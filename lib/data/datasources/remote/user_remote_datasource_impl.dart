import 'package:pp191225/core/constants/api_endpoints.dart';
import 'package:pp191225/data/datasources/remote/user_remote_datasource.dart';
import 'package:pp191225/data/models/users/user_dto.dart';
import 'package:pp191225/data/models/base/api_response.dart';
import 'package:pp191225/data/services/api_service.dart';

/// Implementation of UserRemoteDataSource using ApiService
class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final ApiService apiService;

  UserRemoteDataSourceImpl(this.apiService);

  @override
  Future<ApiResponse<UserDto>> getCurrentUser() async {
    try {
      final response = await apiService.get(ApiEndpoints.userProfile);
      return ApiResponse<UserDto>.fromJson(
        response as Map<String, dynamic>,
        (data) => UserDto.fromJson(data as Map<String, dynamic>),
      );
    } catch (e) {
      // Do not throw from data source; wrap as error response
      print("UserRemoteDataSource.getCurrentUser error: $e");
      return ApiResponse<UserDto>(
        error: true,
        message: e.toString(),
      );
    }
  }

  @override
  Future<ApiResponse<UserDto>> updateProfile({
    String? name,
    String? avatar,
  }) async {
    try {
      final response = await apiService.put(
        ApiEndpoints.userProfile,
        data: {
          if (name != null) 'name': name,
          if (avatar != null) 'avatar': avatar,
        },
      );

      return ApiResponse<UserDto>.fromJson(
        response as Map<String, dynamic>,
        (data) => UserDto.fromJson(data as Map<String, dynamic>),
      );
    } catch (e) {
      print("UserRemoteDataSource.updateProfile error: $e");
      return ApiResponse<UserDto>(
        error: true,
        message: e.toString(),
      );
    }
  }

  @override
  Future<ApiResponse<UserDto>> getUserById(String userId) async {
    try {
      final response = await apiService.get(ApiEndpoints.getUserById(userId));
      return ApiResponse<UserDto>.fromJson(
        response as Map<String, dynamic>,
        (data) => UserDto.fromJson(data as Map<String, dynamic>),
      );
    } catch (e) {
      print("UserRemoteDataSource.getUserById error: $e");
      return ApiResponse<UserDto>(
        error: true,
        message: e.toString(),
      );
    }
  }
}
