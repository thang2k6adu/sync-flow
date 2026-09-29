import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pp191225/core/constants/constants.dart';
import 'package:pp191225/data/services/firebase_auth_service.dart';
import 'package:pp191225/domain/entities/users/user.dart';
import 'package:pp191225/domain/failures/failures.dart';
import 'package:pp191225/domain/usecases/auth/login_usecase.dart';
import 'package:pp191225/domain/usecases/auth/login_with_password_usecase.dart';
import 'package:pp191225/domain/usecases/auth/login_with_provider_usecase.dart';
import 'package:pp191225/domain/usecases/auth/logout_usecase.dart';
import 'package:pp191225/domain/usecases/auth/register_usecase.dart';
import 'package:pp191225/providers/usecases_provider.dart';
import 'package:pp191225/shared/components.dart';

class AuthController extends AutoDisposeNotifier<User?> {
  late final LoginWithProviderUseCase _loginWithProviderUseCase;
  late final LoginWithPasswordUseCase _loginWithPasswordUseCase;
  late final LoginUseCase _loginUseCase;
  late final RegisterUseCase _registerUseCase;
  late final LogoutUseCase _logoutUseCase;

  @override
  User? build() {
    _loginWithProviderUseCase = ref.read(loginWithProviderUseCaseProvider);
    _loginWithPasswordUseCase = ref.read(loginWithPasswordUseCaseProvider);
    _loginUseCase = ref.read(loginUseCaseProvider);
    _registerUseCase = ref.read(registerUseCaseProvider);
    _logoutUseCase = ref.read(logoutUseCaseProvider);
    return null;
  }

  Future<void> loginWithPassword(
    BuildContext context,
    String username,
    String password,
  ) async {
    final overlay = UOverlay(context);

    try {
      overlay.show(message: "Đang đăng nhập...", loading: true);

      final result = await _loginWithPasswordUseCase(
        username: username,
        password: password,
      );

      result.fold(
        (failure) {
          overlay.showWithTimeout(
            message: "Đăng nhập thất bại: ${failure.message}",
          );
        },
        (authResponse) async {
          state = authResponse.user;

          overlay.showWithTimeout(message: "Đăng nhập thành công");
          await Future.delayed(const Duration(milliseconds: 500));

          if (context.mounted) {
            goScreen(context, RouteConstants.main);
          }
        },
      );
    } catch (e) {
      if (context.mounted) {
        overlay.showWithTimeout(message: "Đăng nhập thất bại: $e");
      }
    }
  }

  Future<void> register(
    BuildContext context,
    String name,
    String email,
    String password,
  ) async {
    final overlay = UOverlay(context);

    try {
      overlay.show(message: "Đang đăng ký...", loading: true);
      final result = await _registerUseCase(
        email: email.trim(),
        password: password,
        name: name.trim(),
      );

      result.fold(
        (failure) {
          overlay.showWithTimeout(
            message: "Đăng ký thất bại: ${failure.message}",
          );
        },
        (_) {
          state = null;
          overlay.showWithTimeout(message: "Đăng ký thành công");
          if (context.mounted) {
            goScreen(context, RouteConstants.login);
          }
        },
      );
    } catch (e) {
      if (context.mounted) {
        overlay.showWithTimeout(message: "Đăng ký thất bại: $e");
      }
    }
  }

  Future<void> loginWithEmailAndPassword(
    BuildContext context,
    String email,
    String password,
  ) async {
    final overlay = UOverlay(context);

    try {
      overlay.show(message: "Đang đăng nhập...", loading: true);

      final result = await _loginUseCase(email: email, password: password);

      result.fold(
        (failure) async {
          if (await _tryLinkGoogleAccount(context, overlay, failure)) return;

          overlay.showWithTimeout(
            message: "Đăng nhập thất bại: ${failure.message}",
          );
        },
        (authResponse) async {
          state = authResponse.user;

          overlay.showWithTimeout(message: "Đăng nhập thành công");
          await Future.delayed(const Duration(milliseconds: 500));

          if (context.mounted) {
            goScreen(context, RouteConstants.main);
          }
        },
      );
    } catch (e) {
      if (context.mounted) {
        overlay.showWithTimeout(message: "Đăng nhập thất bại: $e");
      }
    }
  }

  Future<void> loginWithProvide(
    BuildContext context,
    ProviderLogin provider,
  ) async {
    final overlay = UOverlay(context);

    try {
      overlay.show(message: "Đang đăng nhập...", loading: true);

      final result = await _loginWithProviderUseCase(provider);

      result.fold(
        (failure) {
          overlay.showWithTimeout(
            message: "Đăng nhập thất bại: ${failure.message}",
          );
        },
        (authResponse) async {
          state = authResponse.user;

          overlay.showWithTimeout(message: "Đăng nhập thành công");
          await Future.delayed(const Duration(milliseconds: 500));

          if (context.mounted) {
            goScreen(context, RouteConstants.main);
          }
        },
      );
    } catch (e) {
      if (context.mounted) {
        overlay.showWithTimeout(message: "Đăng nhập thất bại: $e");
      }
    }
  }

  Future<bool> _tryLinkGoogleAccount(
    BuildContext context,
    UOverlay overlay,
    Failure failure,
  ) async {
    final linkRequest = failure.details;
    if (linkRequest is! GoogleAccountLinkRequiredException) return false;

    final password = await _askForGoogleLinkPassword(context);
    if (password == null || password.isEmpty) return true;

    overlay.show(message: "Đang liên kết Google...", loading: true);
    final linkResult = await _loginWithProviderUseCase.linkGoogleWithPassword(
      email: linkRequest.email,
      password: password,
      googleCredential: linkRequest.credential,
    );

    linkResult.fold(
      (linkFailure) {
        overlay.showWithTimeout(
          message: "Đăng nhập thất bại: ${linkFailure.message}",
        );
      },
      (authResponse) async {
        state = authResponse.user;
        overlay.showWithTimeout(message: "Đăng nhập thành công");
        await Future.delayed(const Duration(milliseconds: 500));
        if (context.mounted) {
          goScreen(context, RouteConstants.main);
        }
      },
    );
    return true;
  }

  Future<String?> _askForGoogleLinkPassword(BuildContext context) async {
    final passwordController = TextEditingController();
    final password = await showDialog<String>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Liên kết tài khoản Google'),
        content: TextField(
          controller: passwordController,
          obscureText: true,
          autofocus: true,
          decoration: const InputDecoration(labelText: 'Mật khẩu email'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Hủy'),
          ),
          FilledButton(
            onPressed: () =>
                Navigator.of(dialogContext).pop(passwordController.text),
            child: const Text('Liên kết'),
          ),
        ],
      ),
    );
    passwordController.dispose();
    return password;
  }

  Future<void> logout(BuildContext context) async {
    final overlay = UOverlay(context);

    try {
      overlay.show(message: "Đang đăng xuất...", loading: true);

      final result = await _logoutUseCase();

      result.fold(
        (failure) {
          overlay.showWithTimeout(
            message: "Đăng xuất thất bại: ${failure.message}",
          );
        },
        (_) async {
          state = null;

          overlay.showWithTimeout(message: "Đăng xuất thành công");
          await Future.delayed(const Duration(milliseconds: 500));

          if (context.mounted) {
            goScreen(context, RouteConstants.login);
          }
        },
      );
    } catch (e) {
      if (context.mounted) {
        overlay.showWithTimeout(message: "Đăng xuất thất bại: $e");
      }
    }
  }
}

final authControllerProvider =
    AutoDisposeNotifierProvider<AuthController, User?>(AuthController.new);
