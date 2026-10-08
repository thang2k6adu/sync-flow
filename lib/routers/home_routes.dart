import 'package:go_router/go_router.dart';
import '../../presentation/main/screens/main_screen.dart';
import '../../presentation/task/screens/task_form_screen.dart';
import 'package:pp191225/domain/entities/tasks/task.dart';
import '../../presentation/profile/screens/profile_screen.dart';
import '../../presentation/settings/screens/settings_screen.dart';
import '../../presentation/leaderboard/screens/leaderboard_screen.dart';
import 'package:pp191225/core/constants/route_constants.dart';
import 'vocab_routes.dart';

final homeRoutes = <GoRoute>[
  GoRoute(
    path: RouteConstants.main,
    builder: (context, state) => const MainScreen(),
  ),
  GoRoute(
    path: RouteConstants.taskForm,
    builder: (context, state) => TaskFormScreen(task: state.extra as Task?),
  ),
  GoRoute(
    path: RouteConstants.profile,
    builder: (context, state) => const ProfileScreen(),
  ),
  GoRoute(
    path: RouteConstants.settings,
    builder: (context, state) => const SettingsScreen(),
  ),
  GoRoute(
    path: RouteConstants.leaderboard,
    builder: (context, state) => const LeaderboardScreen(),
  ),
  ...vocabRoutes,
];


