import 'package:pp191225/core/constants/api_endpoints.dart';
import 'package:pp191225/data/datasources/remote/task_remote_datasource.dart';
import 'package:pp191225/data/models/base/api_response.dart';
import 'package:pp191225/data/models/tasks/task_dto.dart';
import 'package:pp191225/data/services/api_service.dart';

/// Implementation of TaskRemoteDataSource using ApiService
class TaskRemoteDataSourceImpl implements TaskRemoteDataSource {
  final ApiService apiService;

  TaskRemoteDataSourceImpl(this.apiService);

  @override
  Future<ApiResponse<PaginatedData<TaskDto>>> getTasks({
    required int page,
    required int limit,
    String? search,
    String? status,
  }) async {
    try {
      final response = await apiService.get(
        ApiEndpoints.tasks,
        queryParameters: {
          'page': page,
          'limit': limit,
          if (search != null) 'search': search,
          if (status != null) 'status': status,
        },
      );
      return ApiResponse<PaginatedData<TaskDto>>.fromJson(
        response as Map<String, dynamic>,
        (data) => PaginatedData<TaskDto>.fromJson(
          data as Map<String, dynamic>,
          (item) => TaskDto.fromJson(item as Map<String, dynamic>),
        ),
      );
    } catch (e) {
      // Do not throw from data source; wrap as error response
      print("TaskRemoteDataSource.getTasks error: $e");
      return ApiResponse<PaginatedData<TaskDto>>(
        error: true,
        message: e.toString(),
      );
    }
  }

  @override
  Future<ApiResponse<TaskDto>> createTask({
    required String title,
    String? description,
    String? status,
    DateTime? dueDate,
  }) async {
    try {
      final response = await apiService.post(
        ApiEndpoints.tasks,
        data: {
          'title': title,
          if (description != null) 'description': description,
          if (status != null) 'status': status,
          if (dueDate != null) 'dueDate': dueDate.toUtc().toIso8601String(),
        },
      );
      return ApiResponse<TaskDto>.fromJson(
        response as Map<String, dynamic>,
        (data) => TaskDto.fromJson(data as Map<String, dynamic>),
      );
    } catch (e) {
      print("TaskRemoteDataSource.createTask error: $e");
      return ApiResponse<TaskDto>(error: true, message: e.toString());
    }
  }

  @override
  Future<ApiResponse<TaskDto>> updateTask({
    required String id,
    String? title,
    String? description,
    String? status,
    DateTime? dueDate,
  }) async {
    try {
      final response = await apiService.patch(
        ApiEndpoints.getTaskById(id),
        data: {
          if (title != null) 'title': title,
          if (description != null) 'description': description,
          if (status != null) 'status': status,
          if (dueDate != null) 'dueDate': dueDate.toUtc().toIso8601String(),
        },
      );
      return ApiResponse<TaskDto>.fromJson(
        response as Map<String, dynamic>,
        (data) => TaskDto.fromJson(data as Map<String, dynamic>),
      );
    } catch (e) {
      print("TaskRemoteDataSource.updateTask error: $e");
      return ApiResponse<TaskDto>(error: true, message: e.toString());
    }
  }

  @override
  Future<ApiResponse<void>> deleteTask(String id) async {
    try {
      final response = await apiService.delete(ApiEndpoints.getTaskById(id));
      return ApiResponse<void>.fromJson(
        response as Map<String, dynamic>,
        (_) => null,
      );
    } catch (e) {
      print("TaskRemoteDataSource.deleteTask error: $e");
      return ApiResponse<void>(error: true, message: e.toString());
    }
  }
}
