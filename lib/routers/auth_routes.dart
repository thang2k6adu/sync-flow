import 'package:go_router/go_router.dart';
import '../../presentation/auth/screens/login_screen.dart';
import '../../presentation/auth/screens/sign_up_screen.dart';
import '../../presentation/auth/screens/welcome_screen.dart';
import '../core/core.dart';

final authRoutes = <GoRoute>[
  GoRoute(
    path: RouteConstants.welcome,
    builder: (context, state) => const WelcomeScreen(),
  ),
  GoRoute(
    path: RouteConstants.login,
    builder: (context, state) => const LoginScreen(),
  ),
  GoRoute(
    path: RouteConstants.signUp,
    builder: (context, state) => const SignUpScreen(),
  ),
];
