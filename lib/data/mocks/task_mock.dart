import 'package:pp191225/data/mocks/mock_api_response.dart';

/// Mock data cho /tasks. List giữ trong bộ nhớ: create/update/delete có hiệu lực
/// ngay cho tới khi restart app.
class TaskMock {
  TaskMock._();

  static const _titles = [
    'Thiết kế màn hình đăng nhập',
    'Review pull request',
    'Viết unit test cho AuthController',
    'Cập nhật README',
    'Fix lỗi hiển thị trên iOS',
    'Họp planning sprint',
    'Tối ưu tải ảnh avatar',
    'Tích hợp Google Sign-In',
    'Chuẩn bị demo cho khách hàng',
    'Refactor tầng datasource',
  ];
  static const _statuses = ['TODO', 'IN_PROGRESS', 'DONE'];

  static int _seq = 25;

  static final List<Map<String, dynamic>> _tasks = List.generate(25, (i) {
    final created = DateTime.now().toUtc().subtract(Duration(days: i));
    return {
      'id': 'task-${25 - i}',
      'title': '${_titles[i % _titles.length]} #${25 - i}',
      'description': 'Mô tả cho task số ${25 - i}.',
      'status': _statuses[i % _statuses.length],
      'dueDate': created.add(const Duration(days: 7)).toIso8601String(),
      'userId': 'mock-user-1',
      'createdAt': created.toIso8601String(),
      'updatedAt': created.toIso8601String(),
    };
  });

  static Map<String, dynamic> list(Map<String, dynamic> query) {
    final search = '${query['search'] ?? ''}'.trim().toLowerCase();
    final status = '${query['status'] ?? ''}'.trim().toUpperCase();

    final filtered = _tasks.where((t) {
      if (status.isNotEmpty && t['status'] != status) return false;
      if (search.isEmpty) return true;
      return '${t['title']} ${t['description'] ?? ''}'
          .toLowerCase()
          .contains(search);
    }).toList();

    return mockPaginated(
      filtered,
      page: mockToInt(query['page'], 1),
      limit: mockToInt(query['limit'], 10),
    );
  }

  static Map<String, dynamic> create(Map<String, dynamic> body) {
    final now = DateTime.now().toUtc().toIso8601String();
    final task = {
      'id': 'task-${++_seq}',
      'title': body['title'],
      'description': body['description'],
      'status': body['status'] ?? 'TODO',
      'dueDate': body['dueDate'],
      'userId': 'mock-user-1',
      'createdAt': now,
      'updatedAt': now,
    };
    _tasks.insert(0, task);
    return mockSuccess(data: task, code: 201, message: 'Task created');
  }

  static Map<String, dynamic> update(String id, Map<String, dynamic> body) {
    final index = _tasks.indexWhere((t) => t['id'] == id);
    if (index < 0) throw Exception('Task not found');
    _tasks[index] = {
      ..._tasks[index],
      for (final key in const ['title', 'description', 'status', 'dueDate'])
        if (body.containsKey(key)) key: body[key],
      'updatedAt': DateTime.now().toUtc().toIso8601String(),
    };
    return mockSuccess(data: _tasks[index], message: 'Task updated');
  }

  static Map<String, dynamic> delete(String id) {
    final before = _tasks.length;
    _tasks.removeWhere((t) => t['id'] == id);
    if (_tasks.length == before) throw Exception('Task not found');
    return mockSuccess(message: 'Task deleted');
  }
}
