import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pp191225/core/core.dart';

/// Nút quay lại ở góc trên trái của các màn auth.
/// Quay về màn trước nếu có, không thì về màn Welcome.
class AuthBackButton extends StatelessWidget {
  const AuthBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: const Icon(Icons.arrow_back_ios_new, size: 20, color: AppColors.black),
      onPressed: () {
        final router = GoRouter.of(context);
        if (router.canPop()) {
          router.pop();
        } else {
          router.go(RouteConstants.welcome);
        }
      },
    );
  }
}
