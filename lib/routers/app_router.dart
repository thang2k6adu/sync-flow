import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pp191225/domain/entities/users/user.dart';
import '../presentation/auth/controllers/auth_controller.dart';
import '../presentation/auth/screens/app_initializer.dart';
import 'auth_routes.dart';
import 'home_routes.dart';
import '../core/constants/route_constants.dart';

class RouterRefreshNotifier extends ChangeNotifier {
  void refresh() => notifyListeners();
}

final routerRefreshNotifier = RouterRefreshNotifier();

final routerProvider = Provider<GoRouter>((ref) {
  ref.listen<User?>(
    authControllerProvider,
    (previous, next) => routerRefreshNotifier.refresh(),
  );

  return GoRouter(
    initialLocation: RouteConstants.main,
    debugLogDiagnostics: true,
    refreshListenable: routerRefreshNotifier,
    routes: [
      ...authRoutes,
      ShellRoute(
        builder: (context, state, child) => AppInitializer(child: child),
        routes: [
          ...homeRoutes,
        ],
      ),
    ],
  );
});
