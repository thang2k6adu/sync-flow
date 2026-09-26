/// Trạng thái của task (khớp với enum TaskStatus phía backend: TODO / IN_PROGRESS / DONE)
enum TaskStatus {
  todo('TODO', 'To do'),
  inProgress('IN_PROGRESS', 'In progress'),
  done('DONE', 'Done');

  const TaskStatus(this.value, this.label);

  /// Giá trị gửi/nhận qua API
  final String value;

  /// Nhãn hiển thị trên UI
  final String label;

  static TaskStatus fromValue(String? value) {
    return TaskStatus.values.firstWhere(
      (s) => s.value == value,
      orElse: () => TaskStatus.todo,
    );
  }
}

/// Task entity (pure Dart)
class Task {
  final String id;
  final String title;
  final String? description;
  final TaskStatus status;
  final DateTime? dueDate;
  final DateTime? createdAt;

  const Task({
    required this.id,
    required this.title,
    this.description,
    this.status = TaskStatus.todo,
    this.dueDate,
    this.createdAt,
  });

  bool get isDone => status == TaskStatus.done;

  /// Quá hạn khi có hạn chót, đã qua và task chưa xong
  bool get isOverdue =>
      !isDone && dueDate != null && dueDate!.isBefore(DateTime.now());
}
