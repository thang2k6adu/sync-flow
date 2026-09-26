import 'package:pp191225/data/models/base/api_response.dart';
import 'package:pp191225/data/models/tasks/task_dto.dart';

/// Task remote data source interface
/// Handles task API calls
abstract class TaskRemoteDataSource {
  /// Get a page of tasks
  Future<ApiResponse<PaginatedData<TaskDto>>> getTasks({
    required int page,
    required int limit,
    String? search,
    String? status,
  });

  /// Create a task
  Future<ApiResponse<TaskDto>> createTask({
    required String title,
    String? description,
    String? status,
    DateTime? dueDate,
  });

  /// Update a task
  Future<ApiResponse<TaskDto>> updateTask({
    required String id,
    String? title,
    String? description,
    String? status,
    DateTime? dueDate,
  });

  /// Delete a task
  Future<ApiResponse<void>> deleteTask(String id);
}
