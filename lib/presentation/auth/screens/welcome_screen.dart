import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pp191225/core/constants/app_images.dart';
import 'package:pp191225/core/core.dart';
import 'package:pp191225/presentation/auth/widgets/brand_button.dart';
import 'package:pp191225/shared/helpers/router_helper.dart';

/// Màn hình chào: minh hoạ trên nền tím, bảng trắng phía dưới có nút Login / Sign Up.
class WelcomeScreen extends ConsumerWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.brand,
      body: Column(
        children: [
          Expanded(
            child: SafeArea(
              bottom: false,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppDimens.pagePadding),
                  child: Image.asset(
                    AppImages.welcomeIllustration,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
            decoration: const BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
            ),
            child: SafeArea(
              top: false,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(AppStrings.welcomeTitle, style: AppTextStyles.sheetTitle),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      AppStrings.welcomeSubtitle,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.sheetSubtitle,
                    ),
                  ),
                  const SizedBox(height: 28),
                  BrandButton(
                    label: AppStrings.login,
                    onPressed: () => pushScreen(context, RouteConstants.login),
                  ),
                  const SizedBox(height: 12),
                  BrandButton(
                    label: AppStrings.signUp,
                    filled: false,
                    onPressed: () => pushScreen(context, RouteConstants.signUp),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
