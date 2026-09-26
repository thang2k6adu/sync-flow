plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android")
    // Flutter plugin must be placed after Android & Kotlin
    id("dev.flutter.flutter-gradle-plugin")
    // Firebase / Google Services
    id("com.google.gms.google-services")
}

android {
    namespace = "com.example.temp"
    compileSdk = 36  // ✅ Should be fixed instead of taken from flutter.compileSdkVersion

    ndkVersion = "27.0.12077973" // ✅ Matches the latest NDK (if not used, you can delete this line)

    defaultConfig {
        applicationId = "com.kruzetech.pp191225_mobile"
        minSdk = flutter.minSdkVersion       // ✅ Recommended for Firebase / Google Sign-In
        targetSdk = 36    // ✅ sync with compileSdk
        versionCode = flutter.versionCode
        versionName = flutter.versionName
        multiDexEnabled = true // ✅ Supports multiple libraries if needed
    }

    buildTypes {
        release {
            //When you don't have your own keystore, use debug temporarily to test
            signingConfig = signingConfigs.getByName("debug")
            // ✅ When building PRODUCTION, replace it with a separate release signingConfig
            // minifyEnabled true
            // shrinkResources true
            // proguardFiles(
            //     getDefaultProguardFile("proguard-android-optimize.txt"),
            //     "proguard-rules.pro"
            // )
        }
        debug {
            signingConfig = signingConfigs.getByName("debug")
        }
    }

    // ✅ Upgrade Java & Kotlin to 17 (or 21 if your machine is using JDK 21)
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
        //ignore warning “obsolete options”

    }
    //✅ JDK 21 will still work — Gradle will automatically compile at 17
    kotlinOptions {
        jvmTarget = "17"
    }

    // ✅ Improve build performance
    packagingOptions {
        resources {
            excludes += listOf(
                "META-INF/AL2.0",
                "META-INF/LGPL2.1"
            )
        }
    }

    // ✅ Fix bug: new Gradle plugin requires explicit namespace
    buildFeatures {
        buildConfig = true
    }
}

flutter {
    source = "../.."
}


dependencies {
     // ✅ Google Sign-In
    implementation("com.google.android.gms:play-services-auth:21.2.0")

    // ✅ Firebase Core & Auth
    implementation(platform("com.google.firebase:firebase-bom:33.3.0")) // 🔥 BOM quản lý version đồng bộ
    implementation("com.google.firebase:firebase-auth")
    implementation("com.google.firebase:firebase-analytics")
}