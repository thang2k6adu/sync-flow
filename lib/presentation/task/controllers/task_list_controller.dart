import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pp191225/core/core.dart';
import 'package:pp191225/data/models/base/api_response.dart' show PaginationMeta;
import 'package:pp191225/domain/entities/tasks/task.dart';
import 'package:pp191225/domain/usecases/task/create_task_usecase.dart';
import 'package:pp191225/domain/usecases/task/delete_task_usecase.dart';
import 'package:pp191225/domain/usecases/task/get_tasks_usecase.dart';
import 'package:pp191225/domain/usecases/task/update_task_usecase.dart';
import 'package:pp191225/providers/usecases_provider.dart';

final taskListControllerProvider =
    AsyncNotifierProvider<TaskListController, List<Task>>(
  TaskListController.new,
);

/// Adapter: một trang task từ UseCase -> PaginatedResponse mà BasePaginatedNotifier cần
class _TaskPage implements PaginatedResponse<Task> {
  final List<Task> items;
  final PaginationMeta meta;

  const _TaskPage(this.items, this.meta);

  @override
  List<Task> get data => items;

  @override
  bool get hasNext => meta.currentPage < meta.totalPages;
}

/// Danh sách task: phân trang, tìm kiếm, lọc theo trạng thái, thêm/sửa/xoá.
/// Controller chỉ gọi UseCase và cập nhật state, không biết Data layer.
class TaskListController extends BasePaginatedNotifier<Task>
    with ListItemUpdateMixin<Task> {
  late GetTasksUseCase _getTasks;
  late CreateTaskUseCase _createTask;
  late UpdateTaskUseCase _updateTask;
  late DeleteTaskUseCase _deleteTask;

  TaskStatus? _status;

  /// Trạng thái đang lọc (null = tất cả)
  TaskStatus? get statusFilter => _status;

  @override
  Future<List<Task>> build() {
    _getTasks = ref.read(getTasksUseCaseProvider);
    _createTask = ref.read(createTaskUseCaseProvider);
    _updateTask = ref.read(updateTaskUseCaseProvider);
    _deleteTask = ref.read(deleteTaskUseCaseProvider);
    return super.build();
  }

  @override
  Future<PaginatedResponse<Task>> fetchPage({
    required int page,
    required int limit,
    String? search,
  }) async {
    final result = await _getTasks(
      page: page,
      limit: limit,
      search: search,
      status: _status,
    );
    return result.fold(
      (failure) => throw Exception(failure.message),
      (paged) => _TaskPage(paged.items, paged.meta),
    );
  }

  /// Cache key phải gồm cả bộ lọc trạng thái
  @override
  String getCacheKey(String? search) => '${super.getCacheKey(search)}_${_status?.value}';

  /// Tìm kiếm theo từ khoá (rỗng = bỏ tìm kiếm)
  Future<void> search(String query) async {
    await fetchData(reset: true, search: query.trim().isEmpty ? null : query);
  }

  /// Lọc theo trạng thái (null = tất cả)
  Future<void> setStatusFilter(TaskStatus? status) async {
    if (_status == status) return;
    _status = status;
    await fetchData(reset: true, search: searchQuery);
  }

  /// Kéo để làm mới: giữ nguyên từ khoá và bộ lọc hiện tại
  @override
  Future<void> refresh() async {
    invalidateCache();
    await fetchData(reset: true, search: searchQuery);
  }

  /// Tạo task mới. Trả về thông báo lỗi, null nếu thành công.
  Future<String?> createTask({
    required String title,
    String? description,
    TaskStatus? status,
    DateTime? dueDate,
  }) async {
    final result = await _createTask(
      title: title,
      description: description,
      status: status,
      dueDate: dueDate,
    );
    if (result.isLeft) return result.left.message;

    await refresh();
    return null;
  }

  /// Sửa task. Trả về thông báo lỗi, null nếu thành công.
  Future<String?> updateTask({
    required String id,
    String? title,
    String? description,
    TaskStatus? status,
    DateTime? dueDate,
  }) async {
    final result = await _updateTask(
      id: id,
      title: title,
      description: description,
      status: status,
      dueDate: dueDate,
    );
    if (result.isLeft) return result.left.message;

    final updated = result.right;
    final filteredOut = _status != null && updated.status != _status;
    if (filteredOut) {
      // Đổi sang trạng thái khác bộ lọc hiện tại: bỏ khỏi danh sách
      _removeLocally(id);
    } else {
      updateItem((t) => t.id == id, (_) => updated);
    }
    return null;
  }

  /// Đổi trạng thái nhanh (checkbox / menu)
  Future<String?> changeStatus(Task task, TaskStatus status) {
    return updateTask(id: task.id, status: status);
  }

  /// Xoá task. Trả về thông báo lỗi, null nếu thành công.
  Future<String?> deleteTask(String id) async {
    final result = await _deleteTask(id);
    if (result.isLeft) return result.left.message;

    _removeLocally(id);
    return null;
  }

  void _removeLocally(String id) {
    final current = state.value ?? [];
    state = AsyncData(current.where((t) => t.id != id).toList());
    updateCacheWithCurrentState();
  }
}
