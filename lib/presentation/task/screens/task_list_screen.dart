import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pp191225/core/core.dart';
import 'package:pp191225/domain/entities/tasks/task.dart';
import 'package:pp191225/presentation/task/controllers/task_list_controller.dart';
import 'package:pp191225/presentation/task/widgets/task_tile.dart';
import 'package:pp191225/shared/components.dart';

/// Màn hình danh sách task: tìm kiếm, lọc trạng thái, kéo để làm mới, cuộn để tải thêm.
class TaskListScreen extends ConsumerStatefulWidget {
  const TaskListScreen({super.key});

  @override
  ConsumerState<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends ConsumerState<TaskListScreen>
    with
        ScrollPaginationMixin<TaskListScreen>,
        SearchWithDebounceMixin<TaskListScreen> {
  final TextEditingController _searchController = TextEditingController();

  TaskListController get _controller =>
      ref.read(taskListControllerProvider.notifier);

  @override
  Future<void> Function() get onLoadMore => () => _controller.loadMore();

  @override
  bool Function() get hasNext => () => _controller.hasNext;

  @override
  bool Function() get isLoadingMore => () => _controller.isLoadingMore;

  @override
  void onSearchDebounced(String query) => _controller.search(query);

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Future<void> _changeStatus(Task task, TaskStatus status) async {
    final error = await _controller.changeStatus(task, status);
    if (error != null && mounted) _showMessage(error);
  }

  Future<void> _confirmDelete(Task task) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete task'),
        content: Text('Delete "${task.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;

    final error = await _controller.deleteTask(task.id);
    if (error != null && mounted) _showMessage(error);
  }

  Widget _buildStatusFilter(TaskStatus? selected) {
    return SizedBox(
      height: 44,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: const Text('All'),
              selected: selected == null,
              onSelected: (_) => _controller.setStatusFilter(null),
            ),
          ),
          for (final status in TaskStatus.values)
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: ChoiceChip(
                label: Text(status.label),
                selected: selected == status,
                onSelected: (_) => _controller.setStatusFilter(status),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildList(List<Task> tasks) {
    if (tasks.isEmpty) {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: const [
          SizedBox(height: 80),
          NoMatchingResults(
            title: 'No tasks',
            message: 'Tap + to create your first task.',
          ),
        ],
      );
    }

    final notifier = _controller;
    return ListView.separated(
      controller: scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.only(bottom: 88),
      itemCount: tasks.length + (notifier.hasNext ? 1 : 0),
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (context, index) {
        if (index >= tasks.length) {
          return const Padding(
            padding: EdgeInsets.all(16),
            child: Center(child: CircularProgressIndicator()),
          );
        }
        final task = tasks[index];
        return TaskTile(
          task: task,
          onTap: () => context.push(RouteConstants.taskForm, extra: task),
          onToggleDone: (done) =>
              _changeStatus(task, done ? TaskStatus.done : TaskStatus.todo),
          onChangeStatus: (status) => _changeStatus(task, status),
          onDelete: () => _confirmDelete(task),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final tasksAsync = ref.watch(taskListControllerProvider);
    final statusFilter = _controller.statusFilter;

    return Scaffold(
      body: Column(
        children: [
          AppSearchField(
            controller: _searchController,
            hintText: 'Search tasks',
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            onChanged: handleSearchChanged,
          ),
          _buildStatusFilter(statusFilter),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () => _controller.refresh(),
              child: tasksAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, _) => ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(24),
                  children: [
                    const SizedBox(height: 80),
                    Text(
                      error.toString().replaceFirst('Exception: ', ''),
                      textAlign: TextAlign.center,
                    ),
                    TextButton(
                      onPressed: () => _controller.refresh(),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
                data: (tasks) {
                  checkLoadMoreIfListNotFull();
                  return _buildList(tasks);
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        onPressed: () => context.push(RouteConstants.taskForm),
        child: const Icon(Icons.add),
      ),
    );
  }
}
