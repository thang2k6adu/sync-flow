# Quick Start Guide

This guide will help you set up and run the Flutter Clean Architecture Boilerplate project in minutes.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Configuration](#configuration)
- [Running the App](#running-the-app)
- [Common Commands](#common-commands)
- [Troubleshooting](#troubleshooting)

---

## Prerequisites

Before you begin, ensure you have the following installed:

### Required

- **Flutter SDK** `>=3.9.2`
  ```bash
  # Check your Flutter version
  flutter --version
  ```

- **Dart SDK** `>=3.9.2` (comes with Flutter)

- **Git**
  ```bash
  git --version
  ```

### Recommended

- **Android Studio** (for Android development)
- **Xcode** (for iOS development - macOS only)
- **VS Code** with Flutter extension
- **Chrome** (for web development)

### Verify Flutter Installation

```bash
# Run Flutter doctor to check your environment
flutter doctor

# Expected output:
# Flutter (Channel stable, 3.9.2+)
# Android toolchain
# Xcode (for macOS users)
# Chrome (for web development)
# VS Code or Android Studio
```

---

## Installation

### Step 1: Clone the Repository

```bash
# Clone the project
git clone <your-repository-url>
cd flutter-boilerplate
```

### Step 2: Install Dependencies

```bash
# Install Flutter packages
flutter pub get
```

**Expected output:**
```
Running "flutter pub get" in flutter-boilerplate...
Resolving dependencies... (2.5s)
Got dependencies!
```

### Step 3: Setup Environment Variables

```bash
# Create .env file from example
cp .env.example .env

# Edit .env with your configuration
# Update at minimum:
# - API_BASE_URL (your backend API URL)
# - GOOGLE_WEB_CLIENT_ID (from Firebase Console)
```

> ** Important**: The `.env` file is required for the app to run. See [Configuration](#configuration) section below for details.

### Step 4: Generate Code

This project uses code generation for Freezed models, JSON serialization, and Riverpod providers.

```bash
# Generate code (one-time)
dart run build_runner build --delete-conflicting-outputs
```

**Expected output:**
```
[INFO] Generating build script...
[INFO] Generating build script completed, took 500ms
[INFO] Creating build script snapshot...
[INFO] Creating build script snapshot completed, took 3.2s
[INFO] Building new asset graph...
[INFO] Building new asset graph completed, took 1.5s
[INFO] Running build...
[INFO] Running build completed, took 15.3s
[INFO] Succeeded after 20.5s with 234 outputs
```

> ** Tip:** Use watch mode during development to auto-generate code on file changes:
> ```bash
> dart run build_runner watch --delete-conflicting-outputs
> ```

---

## Configuration

### 1. Firebase Setup (Optional)

If you're using Firebase features:

#### a. Download Configuration Files

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Create a new project or select existing one
3. Add Android/iOS apps
4. Download configuration files:
   - **Android**: `google-services.json` → `android/app/`
   - **iOS**: `GoogleService-Info.plist` → `ios/Runner/`

#### b. Generate Firebase Options

```bash
# Install FlutterFire CLI (one-time)
dart pub global activate flutterfire_cli

# Configure Firebase for your project
flutterfire configure
```

See [FIREBASE_SETUP.md](FIREBASE_SETUP.md) for detailed Firebase configuration.

### 2. Environment Variables Setup

This project uses `.env` files for configuration. This is **REQUIRED** for the app to run.

#### Step 1: Create .env file

```bash
# Copy the example file
cp .env.example .env
```

#### Step 2: Configure your .env

Edit `.env` with your actual values:

```env
# API Configuration
API_BASE_URL=http://10.0.2.2:3000/api

# Firebase Configuration  
GOOGLE_WEB_CLIENT_ID=your-actual-web-client-id.apps.googleusercontent.com

# Network Configuration (optional - has defaults)
API_CONNECT_TIMEOUT=10000
API_RECEIVE_TIMEOUT=3000

# App Configuration (optional)
APP_NAME=Your App Name
APP_VERSION=1.0.0
```

#### Important Notes:

- **Android Emulator**: Use `http://10.0.2.2:3000/api` (special alias for localhost)
- **iOS Simulator**: Use `http://localhost:3000/api`
- **Physical Device**: Use `http://192.168.x.x:3000/api` (your computer's local IP)
- **Google Web Client ID**: Get from [Firebase Console](https://console.firebase.google.com/) → Project Settings → OAuth 2.0 Client IDs

#### Step 3: Verify configuration

The app will automatically load `.env` on startup. All API endpoints are managed through:
- `ApiConstants` - Configuration values (from .env)
- `ApiEndpoints` - Endpoint paths

```dart
// Access in code
import 'package:pp191225/core/constants/constants.dart';

final baseUrl = ApiConstants.baseUrl;        // from .env
final endpoint = ApiEndpoints.authLogin;     // '/auth/login'
```

> ** Detailed Guide**: See [ENV_SETUP.md](ENV_SETUP.md) for complete environment configuration guide and [API_ENDPOINTS.md](API_ENDPOINTS.md) for all available endpoints.

---

## Running the App

### Run on Connected Device

```bash
# Check connected devices
flutter devices

# Run on default device
flutter run

# Run on specific device
flutter run -d <device-id>

# Run on Chrome (web)
flutter run -d chrome

# Run on Android emulator
flutter run -d emulator-5554

# Run on iOS simulator
flutter run -d "iPhone 14 Pro"
```

### Run with Flavor (Environment)

```bash
# Development
flutter run --flavor dev -t lib/main_dev.dart

# Staging
flutter run --flavor staging -t lib/main_staging.dart

# Production
flutter run --flavor prod -t lib/main.dart
```

### Build Release

```bash
# Android APK
flutter build apk --release

# Android App Bundle (for Play Store)
flutter build appbundle --release

# iOS (requires macOS)
flutter build ios --release
```

---

## Common Commands

### Development

```bash
# Install dependencies
flutter pub get

# Clean build files
flutter clean

# Rebuild everything
flutter clean && flutter pub get && dart run build_runner build --delete-conflicting-outputs

# Run code generation in watch mode
dart run build_runner watch --delete-conflicting-outputs

# Check for outdated packages
flutter pub outdated

# Upgrade packages
flutter pub upgrade
```

### Code Quality

```bash
# Analyze code
flutter analyze

# Format code
dart format .

# Fix common issues
dart fix --apply
```

### Testing

```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage

# Run specific test file
flutter test test/domain/usecases/auth/login_usecase_test.dart
```

### Platform-Specific

#### Android

```bash
# Generate SHA-1 and SHA-256 keys (for Firebase)
cd android
./gradlew signingReport
cd ..

# Accept Android licenses
flutter doctor --android-licenses

# Clean Android build
cd android
./gradlew clean
cd ..
```

#### iOS

```bash
# Install CocoaPods dependencies
cd ios
rm -rf Pods Podfile.lock
pod install --repo-update
cd ..

# Open Xcode workspace
open ios/Runner.xcworkspace
```

---

## Troubleshooting

### Issue: "Build runner fails"

**Solution:**
```bash
# Delete generated files and rebuild
find . -name "*.g.dart" -delete
find . -name "*.freezed.dart" -delete
dart run build_runner build --delete-conflicting-outputs
```

### Issue: "Gradle build fails on Android"

**Solution:**
```bash
# Clean and rebuild
cd android
./gradlew clean
cd ..
flutter clean
flutter pub get
flutter run
```

### Issue: "Pod install fails on iOS"

**Solution:**
```bash
cd ios
rm -rf Pods Podfile.lock
pod cache clean --all
pod install --repo-update
cd ..
```

### Issue: "Module not found errors"

**Solution:**
```bash
# Clear Flutter cache
flutter clean
flutter pub get

# Delete build folders
rm -rf build/
rm -rf .dart_tool/

# Rebuild
flutter run
```

### Issue: "Firebase configuration not found"

**Solution:**
```bash
# Reconfigure Firebase
flutterfire configure

# Make sure you have:
# - android/app/google-services.json
# - ios/Runner/GoogleService-Info.plist
# - lib/firebase_options.dart
```

### Issue: "dotenv.env is null" or ".env file not found"

**Solution:**
```bash
# 1. Make sure .env file exists
ls -la .env

# 2. If not, create from example
cp .env.example .env

# 3. Edit .env with your actual values
# 4. Make sure .env is in assets (pubspec.yaml)

# 5. Clean and rebuild
flutter clean
flutter pub get
flutter run
```

### Issue: "API calls fail with connection error"

**Solution:**

Check your `.env` configuration:

```env
# For Android Emulator (use special alias)
API_BASE_URL=http://10.0.2.2:3000/api

# For iOS Simulator
API_BASE_URL=http://localhost:3000/api

# For Physical Device (use your computer's IP)
API_BASE_URL=http://192.168.1.100:3000/api
```

Make sure your backend server is running and accessible.

### Issue: "Flutter doctor shows issues"

**Solution:**
```bash
# Run doctor to see specific issues
flutter doctor -v

# Accept Android licenses
flutter doctor --android-licenses

# Update Flutter
flutter upgrade
```

---

## Next Steps

Now that your project is running:

1. Read [ENV_SETUP.md](ENV_SETUP.md) for detailed environment configuration
2. Check [API_ENDPOINTS.md](API_ENDPOINTS.md) for all available API endpoints
3. Read [CODING_GUIDE.md](CODING_GUIDE.md) to learn how to add features
4. Explore the project structure in [README.md](README.md)
5. Configure Firebase in [FIREBASE_SETUP.md](FIREBASE_SETUP.md)
6. Start building your features!

---

## Additional Resources

- [ENV_SETUP.md](ENV_SETUP.md) - Environment variables configuration
- [API_ENDPOINTS.md](API_ENDPOINTS.md) - Complete API endpoints documentation
- [CODING_GUIDE.md](CODING_GUIDE.md) - Feature implementation guide
- [FIREBASE_SETUP.md](FIREBASE_SETUP.md) - Firebase configuration guide
- [Flutter Documentation](https://flutter.dev/docs)
- [Riverpod Documentation](https://riverpod.dev/)
- [Go Router Documentation](https://pub.dev/packages/go_router)
- [Freezed Documentation](https://pub.dev/packages/freezed)
- [Clean Architecture Guide](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)

---

## Pro Tips

1. **Use watch mode** during development:
   ```bash
   dart run build_runner watch --delete-conflicting-outputs
   ```

2. **Enable hot reload** in your IDE for faster development

3. **Run analyzer** before committing:
   ```bash
   flutter analyze && flutter test
   ```

4. **Keep dependencies updated**:
   ```bash
   flutter pub upgrade --major-versions
   ```

---

## Need Help?

If you encounter any issues not covered here:

1. Check the [Troubleshooting](#troubleshooting) section
2. Run `flutter doctor -v` for detailed diagnostics
3. Check project issues on GitHub
4. Contact the development team

---

**Happy Coding! **
