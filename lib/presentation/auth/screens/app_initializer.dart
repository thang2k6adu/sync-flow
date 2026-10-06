import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pp191225/core/core.dart';
import 'package:pp191225/presentation/auth/controllers/auth_controller.dart';
import 'package:pp191225/routers/app_router.dart';

class AppInitializer extends ConsumerStatefulWidget {
  final Widget child;
  const AppInitializer({super.key, required this.child});

  @override
  AppInitializerState createState() => AppInitializerState();
}

class AppInitializerState extends ConsumerState<AppInitializer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authControllerProvider);
    final router = ref.read(routerProvider);

    if (user != null) {
      return widget.child;
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        router.go(RouteConstants.welcome);
      });
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            color: AppColors.primary,
          ),
        ),
      );
    }
  }
}
