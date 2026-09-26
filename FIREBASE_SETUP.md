# Firebase Setup Guide

## Prerequisites

- Flutter SDK installed
- Firebase CLI installed
- FlutterFire CLI installed

## Installation

### 1. Install Firebase CLI

```bash
# Using npm
npm install -g firebase-tools

# Or using curl (Linux/macOS)
curl -sL https://firebase.tools | bash
```

### 2. Install FlutterFire CLI

```bash
dart pub global activate flutterfire_cli
```

### 3. Login to Firebase

```bash
firebase login
```

## Configuration Steps

### Step 1: Create Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click "Add project" or select existing project
3. Follow the setup wizard

### Step 2: Configure Firebase for Flutter

Run the FlutterFire CLI configuration command in your project root:

```bash
cd /path/to/your/flutter-project
flutterfire configure
```

This command will:
- Show list of your Firebase projects
- Let you select which project to use
- Automatically register your Flutter app with Firebase
- Generate `firebase_options.dart` file
- Configure for all platforms (Android, iOS, Web, macOS, etc.)

**Follow the prompts:**

```
? Select a Firebase project to configure your Flutter application with:
  > your-project-name (your-project-id)

? Which platforms should your configuration support?
   android
   ios
   macos
   web
```

### Step 3: Verify Configuration Files

After running `flutterfire configure`, check these files were created/updated:

- `lib/firebase_options.dart` - Firebase configuration for Dart
- `android/app/google-services.json` - Android configuration
- `ios/Runner/GoogleService-Info.plist` - iOS configuration
- `macos/Runner/GoogleService-Info.plist` - macOS configuration

### Step 4: Update Dependencies

Ensure your `pubspec.yaml` has Firebase dependencies:

```yaml
dependencies:
  flutter:
    sdk: flutter
  
  # Firebase
  firebase_core: ^3.8.1
  firebase_auth: ^5.3.3
  
  # Optional: Add other Firebase services as needed
  # cloud_firestore: ^5.5.0
  # firebase_storage: ^12.3.8
  # firebase_messaging: ^15.1.5
```

Run:

```bash
flutter pub get
```

### Step 5: Initialize Firebase in Your App

Update your `lib/main.dart`:

```dart
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  runApp(const MyApp());
}
```

## Enable Firebase Authentication

### 1. Enable Auth in Firebase Console

1. Go to Firebase Console → Authentication
2. Click "Get Started"
3. Enable sign-in methods you want to use:
   - Email/Password
   - Google
   - Apple
   - Phone
   - Anonymous

### 2. Configure Sign-in Methods

#### Email/Password

Simply enable it in Firebase Console - no additional setup needed.

#### Google Sign-in

**Android:**
1. Enable Google sign-in in Firebase Console
2. Download `google-services.json`
3. Add SHA-1 fingerprint:

```bash
# Get debug SHA-1
cd android
./gradlew signingReport

# Add SHA-1 to Firebase Console → Project Settings → Your App
```

**iOS:**
1. Enable Google sign-in in Firebase Console
2. Download `GoogleService-Info.plist`
3. Add URL scheme to `ios/Runner/Info.plist`:

```xml
<key>CFBundleURLTypes</key>
<array>
  <dict>
    <key>CFBundleTypeRole</key>
    <string>Editor</string>
    <key>CFBundleURLSchemes</key>
    <array>
      <string>com.googleusercontent.apps.YOUR-CLIENT-ID</string>
    </array>
  </dict>
</array>
```

Replace `YOUR-CLIENT-ID` with the value from `GoogleService-Info.plist`.

#### Apple Sign-in

**iOS:**
1. Enable Apple sign-in in Firebase Console
2. Add capability in Xcode:
   - Open `ios/Runner.xcworkspace`
   - Select Runner → Signing & Capabilities
   - Click + → Sign in with Apple

**Android:**
1. Configure in Firebase Console
2. Add service ID and redirect URL

## Platform-Specific Setup

### Android

1. **Update `android/build.gradle`:**

```gradle
buildscript {
    dependencies {
        classpath 'com.google.gms:google-services:4.4.0'
    }
}
```

2. **Update `android/app/build.gradle`:**

```gradle
apply plugin: 'com.google.gms.google-services'

android {
    defaultConfig {
        minSdkVersion 21  // Firebase requires min 21
    }
}
```

3. **Ensure `google-services.json` is in `android/app/`**

### iOS

1. **Update `ios/Podfile`:**

```ruby
platform :ios, '13.0'  # Firebase requires iOS 13+
```

2. **Install pods:**

```bash
cd ios
pod install
cd ..
```

3. **Ensure `GoogleService-Info.plist` is in `ios/Runner/`**

### Web

1. **Update `web/index.html`:**

```html
<body>
  <script src="https://www.gstatic.com/firebasejs/10.7.0/firebase-app-compat.js"></script>
  <script src="https://www.gstatic.com/firebasejs/10.7.0/firebase-auth-compat.js"></script>
  
  <script>
    // Your Firebase config will be in firebase_options.dart
    // FlutterFire handles initialization
  </script>
  
  <script src="main.dart.js" type="application/javascript"></script>
</body>
```

## Testing Firebase Setup

### Test Firebase Connection

Create a test file `lib/test_firebase.dart`:

```dart
import 'package:firebase_auth/firebase_auth.dart';

Future<void> testFirebase() async {
  try {
    // Test anonymous sign in
    final userCredential = await FirebaseAuth.instance.signInAnonymously();
    print(' Firebase Connected! User ID: ${userCredential.user?.uid}');
    
    // Sign out
    await FirebaseAuth.instance.signOut();
    print(' Sign out successful');
  } catch (e) {
    print(' Firebase Error: $e');
  }
}
```

Run in your app:

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  await testFirebase();  // Test connection
  
  runApp(const MyApp());
}
```

## Common Issues & Solutions

### Issue 1: "No Firebase App '[DEFAULT]' has been created"

**Solution:** Ensure `Firebase.initializeApp()` is called before using any Firebase service.

### Issue 2: Google Sign-in fails on Android

**Solution:** 
- Add SHA-1 fingerprint to Firebase Console
- Re-download `google-services.json`
- Clean and rebuild:

```bash
flutter clean
flutter pub get
flutter run
```

### Issue 3: iOS build fails

**Solution:**
```bash
cd ios
rm -rf Pods Podfile.lock
pod install
cd ..
flutter clean
flutter run
```

### Issue 4: "google-services.json not found"

**Solution:** Run `flutterfire configure` again and ensure file is in `android/app/`.

## Quick Commands Reference

```bash
# Login to Firebase
firebase login

# Configure Firebase for Flutter
flutterfire configure

# Reconfigure (if you change Firebase project)
flutterfire configure --project=your-project-id

# Update Firebase configuration
flutterfire configure --force

# List available Firebase projects
firebase projects:list

# Check Firebase CLI version
firebase --version

# Check FlutterFire CLI version
flutterfire --version
```

## Security Rules (Optional)

### Firestore Rules Example

In Firebase Console → Firestore Database → Rules:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Users can only read/write their own data
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
    
    // Public read for all authenticated users
    match /public/{document=**} {
      allow read: if request.auth != null;
      allow write: if false;
    }
  }
}
```

## Next Steps

1. Test authentication flows
2. Set up Firestore (if needed)
3. Configure Firebase Storage (if needed)
4. Set up Cloud Messaging (if needed)
5. Enable Firebase Analytics
6. Configure security rules

## Resources

- [Firebase Documentation](https://firebase.google.com/docs)
- [FlutterFire Documentation](https://firebase.flutter.dev/)
- [Firebase Console](https://console.firebase.google.com/)
- [FlutterFire CLI](https://firebase.flutter.dev/docs/cli)

---

**Note:** Always keep your `google-services.json` and `GoogleService-Info.plist` files secure and never commit them to public repositories with real production credentials.
