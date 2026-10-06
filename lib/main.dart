import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pp191225/routers/app_router.dart';

import 'firebase_options.dart';
import 'core/constants/constants.dart';
import 'core/theme/app_colors.dart';
import 'core/theme/app_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Load environment variables
  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    debugPrint("Failed to load .env file: $e");
  }
  
  try {
    await AppConstants.initialize();
  } catch (e) {
    debugPrint("AppConstants initialization error: $e");
  }

  if (!ApiConstants.useMockData) {
    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    } catch (e) {
      debugPrint("Firebase initialization error: $e");
    }
  }
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Setting status bar style
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    );
    
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'App Name',
      theme: ThemeData(
        fontFamily: AppFonts.poppins,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary).copyWith(
          primary: AppColors.primary,
          onPrimary: AppColors.white,
          secondary: AppColors.secondary,
          onSecondary: AppColors.primary,
          error: AppColors.error,
          onError: AppColors.white,
          surface: AppColors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppDimens.buttonRadius),
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.primary,
            side: const BorderSide(color: AppColors.primary),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppDimens.buttonRadius),
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(foregroundColor: AppColors.primary),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          iconTheme: IconThemeData(color: AppColors.neutral900),
          titleTextStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.neutral900,
          ),
        ),
        scaffoldBackgroundColor: Colors.white,
        textTheme: TextTheme(
          // Headings
          displayLarge: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.w700,
            height: 1.15,
            letterSpacing: -0.2,
            color: AppColors.gray[9],
          ),
          headlineLarge: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w600,
            height: 1.2,
            letterSpacing: -0.2,
            color: AppColors.gray[9],
          ),
          headlineMedium: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            height: 1.25,
            color: AppColors.gray[9],
          ),
          headlineSmall: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            height: 1.3,
            color: AppColors.gray[9],
          ),

          // System/UI
          titleLarge: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            height: 1.4,
            color: AppColors.gray[9],
          ),
          titleMedium: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            height: 1.4,
            color: AppColors.gray[8],
          ),
          titleSmall: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            height: 1.4,
            color: AppColors.gray[6],
          ),

          // Body
          bodyLarge: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            height: 1.55,
            letterSpacing: 0.15,
            color: AppColors.gray[9],
          ),
          bodyMedium: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            height: 1.5,
            letterSpacing: 0.15,
            color: AppColors.gray[9],
          ),
          bodySmall: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            height: 1.45,
            letterSpacing: 0.14,
            color: AppColors.gray[9],
          ),

          // Labels
          labelLarge: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            height: 1.4,
            letterSpacing: 0.4,
            color: AppColors.gray[9],
          ),
          labelMedium: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            height: 1.3,
            color: AppColors.gray[8],
          ),
          labelSmall: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            height: 1.2,
            letterSpacing: 0.4,
            color: AppColors.gray[7],
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
