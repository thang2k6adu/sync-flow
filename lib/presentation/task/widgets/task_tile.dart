import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pp191225/core/core.dart';
import 'package:pp191225/domain/entities/tasks/task.dart';

/// Một dòng task trong danh sách: checkbox hoàn thành, tiêu đề, mô tả, trạng thái, hạn chót.
class TaskTile extends StatelessWidget {
  final Task task;
  final VoidCallback onTap;
  final ValueChanged<bool> onToggleDone;
  final ValueChanged<TaskStatus> onChangeStatus;
  final VoidCallback onDelete;

  const TaskTile({
    super.key,
    required this.task,
    required this.onTap,
    required this.onToggleDone,
    required this.onChangeStatus,
    required this.onDelete,
  });

  static Color statusColor(TaskStatus status) {
    switch (status) {
      case TaskStatus.todo:
        return AppColors.gray[5];
      case TaskStatus.inProgress:
        return AppColors.primary;
      case TaskStatus.done:
        return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = statusColor(task.status);

    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: Checkbox(
        value: task.isDone,
        activeColor: AppColors.primary,
        onChanged: (value) => onToggleDone(value ?? false),
      ),
      title: Text(
        task.title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          decoration: task.isDone ? TextDecoration.lineThrough : null,
          color: task.isDone ? Colors.grey : Colors.black87,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (task.description != null && task.description!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Text(
                task.description!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          const SizedBox(height: 6),
          Wrap(
            spacing: 8,
            runSpacing: 4,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  task.status.label,
                  style: TextStyle(
                    fontSize: 12,
                    color: color,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              if (task.dueDate != null)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.event,
                      size: 14,
                      color: task.isOverdue ? Colors.red : Colors.grey,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      DateFormat('dd/MM/yyyy').format(task.dueDate!),
                      style: TextStyle(
                        fontSize: 12,
                        color: task.isOverdue ? Colors.red : Colors.grey,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ],
      ),
      trailing: PopupMenuButton<String>(
        onSelected: (value) {
          if (value == 'delete') {
            onDelete();
          } else {
            onChangeStatus(TaskStatus.fromValue(value));
          }
        },
        itemBuilder: (context) => [
          for (final status in TaskStatus.values)
            if (status != task.status)
              PopupMenuItem(
                value: status.value,
                child: Text('Mark as ${status.label.toLowerCase()}'),
              ),
          const PopupMenuItem(value: 'delete', child: Text('Delete')),
        ],
      ),
    );
  }
}
