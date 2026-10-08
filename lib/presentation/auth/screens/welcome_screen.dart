import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pp191225/core/constants/app_images.dart';
import 'package:pp191225/core/core.dart';
import 'package:pp191225/presentation/auth/widgets/auth_background.dart';
import 'package:pp191225/presentation/auth/widgets/brand_button.dart';
import 'package:pp191225/shared/helpers/router_helper.dart';

/// Màn hình chào chuẩn app hiện đại: nền trắng + blob pastel,
/// illustration trong card bo góc, tiêu đề căn giữa, CTA đầy đủ chiều rộng.
class WelcomeScreen extends ConsumerWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: AuthBackground(
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimens.pagePadding,
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 12),
                        _buildLogoPill(),
                        const SizedBox(height: 20),
                        _buildIllustrationCard(),
                        const SizedBox(height: 24),
                        _buildPageDots(),
                        const SizedBox(height: 16),
                        Text(
                          AppStrings.welcomeTitle,
                          textAlign: TextAlign.center,
                          style: AppTextStyles.sheetTitle.copyWith(
                            fontSize: 28,
                            height: 1.2,
                            letterSpacing: -0.3,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            AppStrings.welcomeSubtitle,
                            textAlign: TextAlign.center,
                            style: AppTextStyles.sheetSubtitle.copyWith(
                              fontSize: 14.5,
                              height: 1.6,
                            ),
                          ),
                        ),
                        const SizedBox(height: 28),
                        BrandButton(
                          label: AppStrings.login,
                          onPressed: () =>
                              pushScreen(context, RouteConstants.login),
                        ),
                        const SizedBox(height: 12),
                        BrandButton(
                          label: AppStrings.signUp,
                          filled: false,
                          onPressed: () =>
                              pushScreen(context, RouteConstants.signUp),
                        ),
                        const Spacer(),
                        const SizedBox(height: 20),
                        Text(
                          'By continuing, you agree to our Terms & Privacy Policy',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.small.copyWith(
                            fontSize: 12,
                            height: 1.5,
                            color: AppColors.neutral500,
                          ),
                        ),
                        const SizedBox(height: 12),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
  Widget _buildLogoPill() {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.secondary,
          borderRadius: BorderRadius.circular(100),
          border: Border.all(
            color: AppColors.primary.withValues(alpha: 0.18),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 22,
              height: 22,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.bolt_rounded,
                size: 14,
                color: AppColors.white,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'Sync Flow',
              style: AppTextStyles.buttonOutlined.copyWith(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIllustrationCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: AppColors.neutral200),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.08),
            blurRadius: 28,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: AspectRatio(
          aspectRatio: 1.35,
          child: Image.asset(
            AppImages.welcomeIllustration,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildPageDots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 24,
          height: 8,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        const SizedBox(width: 6),
        _dot(),
        const SizedBox(width: 6),
        _dot(),
      ],
    );
  }

  Widget _dot() {
    return Container(
      width: 8,
      height: 8,
      decoration: const BoxDecoration(
        color: AppColors.neutral200,
        shape: BoxShape.circle,
      ),
    );
  }
}
