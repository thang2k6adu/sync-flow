import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pp191225/domain/entities/tasks/task.dart';

part 'task_dto.freezed.dart';
part 'task_dto.g.dart';

/// Task Data Transfer Object
/// Used for JSON serialization/deserialization
@freezed
abstract class TaskDto with _$TaskDto {
  const TaskDto._();

  const factory TaskDto({
    required String id,
    required String title,
    String? description,
    @Default('TODO') String status,
    DateTime? dueDate,
    String? userId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _TaskDto;

  factory TaskDto.fromJson(Map<String, Object?> json) =>
      _$TaskDtoFromJson(json);

  /// Convert DTO to Domain Entity
  Task toEntity() {
    return Task(
      id: id,
      title: title,
      description: description,
      status: TaskStatus.fromValue(status),
      dueDate: dueDate?.toLocal(),
      createdAt: createdAt?.toLocal(),
    );
  }
}
