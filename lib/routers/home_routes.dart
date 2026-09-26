import 'package:go_router/go_router.dart';
import '../../presentation/main/screens/main_screen.dart';
import '../../presentation/task/screens/task_form_screen.dart';
import 'package:pp191225/domain/entities/tasks/task.dart';
import '../core/core.dart';

final homeRoutes = <GoRoute>[
  GoRoute(
    path: RouteConstants.main,
    builder: (context, state) => const MainScreen(),
  ),
  GoRoute(
    path: RouteConstants.taskForm,
    builder: (context, state) => TaskFormScreen(task: state.extra as Task?),
  ),
];
