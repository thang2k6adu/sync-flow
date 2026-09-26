import 'package:pp191225/core/constants/api_constants.dart';

/// Chuỗi hiển thị của các màn auth (Welcome / Login)
class AppStrings {
  AppStrings._();

  // Welcome
  static const String welcomeTitle = 'Welcome Back!';
  static String get welcomeSubtitle =>
      'Turn distractions into meaningful progress every single day with ${ApiConstants.appName}.';
  static const String login = 'Login';
  static const String signUp = 'Sign Up';

  // Login
  static const String loginTerms = 'By logging in, you agree to our ';
  static const String termsOfUse = 'Terms of Use';
  static const String email = 'Email';
  static const String emailHint = 'Your Email';
  static const String password = 'Password';
  static const String passwordHint = 'Your Password';
  static const String forgotPassword = 'Forgot password?';
  static const String orContinueWith = 'or continue with';
  static const String notAMember = 'Not a member? ';
  static const String registerNow = 'Register now!';

  // Validation
  static const String emailRequired = 'Please enter your email';
  static const String emailInvalid = 'Please enter a valid email';
  static const String passwordRequired = 'Please enter your password';

  // Social
  static const String continueWithGoogle = 'Continue with Google';
  static const String continueWithFacebook = 'Continue with Facebook';
  static const String continueWithGithub = 'Continue with GitHub';
  static const String continueWithApple = 'Continue with Apple';
  static const String githubNotSupported = 'GitHub login is not supported yet';
}
