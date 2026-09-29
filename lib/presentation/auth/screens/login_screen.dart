import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pp191225/core/constants/app_icons.dart';
import 'package:pp191225/core/core.dart';
import 'package:pp191225/domain/usecases/auth/login_with_provider_usecase.dart';
import 'package:pp191225/presentation/auth/controllers/auth_controller.dart';
import 'package:pp191225/presentation/auth/widgets/auth_back_button.dart';
import 'package:pp191225/presentation/auth/widgets/auth_background.dart';
import 'package:pp191225/presentation/auth/widgets/auth_text_field.dart';
import 'package:pp191225/presentation/auth/widgets/brand_button.dart';
import 'package:pp191225/presentation/auth/widgets/social_login_button.dart';
import 'package:pp191225/shared/helpers/router_helper.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends ConsumerState<LoginScreen> {
  static final _emailPattern = RegExp(
    r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$",
  );

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _showMessage(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _onSignInWithProvider(ProviderLogin provider) async {
    final authController = ref.read(authControllerProvider.notifier);
    try {
      await authController.loginWithProvide(context, provider);
    } catch (e) {
      _showMessage('Login failed:  ${e.toString()}');
    }
  }

  Future<void> _onSignInWithPassword() async {
    if (!_formKey.currentState!.validate()) return;

    final authController = ref.read(authControllerProvider.notifier);
    try {
      await authController.loginWithPassword(
        context,
        _emailController.text,
        _passwordController.text,
      );
    } catch (e) {
      _showMessage('Login failed:  ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: AuthBackground(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(8, 8, 0, 0),
                child: AuthBackButton(),
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimens.pagePadding,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 24),
                      _buildHeader(),
                      const SizedBox(height: 24),
                      _buildForm(),
                      const SizedBox(height: 24),
                      BrandButton(
                        label: AppStrings.login,
                        onPressed: _onSignInWithPassword,
                      ),
                      const SizedBox(height: 24),
                      _buildDivider(),
                      const SizedBox(height: 24),
                      _buildSocialButtons(),
                      const SizedBox(height: 24),
                      _buildRegisterFooter(),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppStrings.login, style: AppTextStyles.screenTitle),
        const SizedBox(height: 4),
        Text.rich(
          TextSpan(
            style: AppTextStyles.body,
            children: [
              const TextSpan(text: AppStrings.loginTerms),
              TextSpan(text: AppStrings.termsOfUse, style: AppTextStyles.link),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AuthTextField(
            label: AppStrings.email,
            hintText: AppStrings.emailHint,
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty)
                return AppStrings.emailRequired;
              if (!_emailPattern.hasMatch(value))
                return AppStrings.emailInvalid;
              return null;
            },
          ),
          const SizedBox(height: 16),
          AuthTextField(
            label: AppStrings.password,
            hintText: AppStrings.passwordHint,
            controller: _passwordController,
            obscureText: _obscurePassword,
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword ? Icons.visibility_off : Icons.visibility,
                color: AppColors.gray[4],
              ),
              onPressed: () =>
                  setState(() => _obscurePassword = !_obscurePassword),
            ),
            validator: (value) => (value == null || value.isEmpty)
                ? AppStrings.passwordRequired
                : null,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                // Handle forgot password
              },
              child: Text(
                AppStrings.forgotPassword,
                style: AppTextStyles.smallLink,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    final line = Expanded(
      child: Divider(color: AppColors.brandLight, thickness: 1),
    );
    return Row(
      children: [
        line,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(AppStrings.orContinueWith, style: AppTextStyles.small),
        ),
        line,
      ],
    );
  }

  Widget _buildSocialButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SocialLoginButton(
          svgAsset: AppIcons.googleG,
          tooltip: AppStrings.continueWithGoogle,
          onPressed: () => _onSignInWithProvider(ProviderLogin.google),
        ),
        const SizedBox(width: 16),
        SocialLoginButton(
          svgAsset: AppIcons.facebookF,
          tooltip: AppStrings.continueWithFacebook,
          onPressed: () => _onSignInWithProvider(ProviderLogin.facebook),
        ),
        const SizedBox(width: 16),
        SocialLoginButton(
          svgAsset: AppIcons.githubMark,
          tooltip: AppStrings.continueWithGithub,
          onPressed: () => _showMessage(AppStrings.githubNotSupported),
        ),
        // Apple chỉ hiện trên iOS
        if (AppConstants.osType == 'iOS') ...[
          const SizedBox(width: 16),
          SocialLoginButton(
            icon: Icons.apple,
            tooltip: AppStrings.continueWithApple,
            onPressed: () => _onSignInWithProvider(ProviderLogin.apple),
          ),
        ],
      ],
    );
  }

  Widget _buildRegisterFooter() {
    return Center(
      child: Text.rich(
        TextSpan(
          style: AppTextStyles.body,
          children: [
            const TextSpan(text: AppStrings.notAMember),
            TextSpan(
              text: AppStrings.registerNow,
              style: AppTextStyles.link,
              recognizer: TapGestureRecognizer()
                ..onTap = () => pushScreen(context, RouteConstants.signUp),
            ),
          ],
        ),
      ),
    );
  }
}
