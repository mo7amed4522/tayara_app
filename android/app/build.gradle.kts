plugins {
    id("com.android.application")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
    // Firebase Google Services plugin – reads google-services.json and injects
    // the required resources into the Android app at build time.
    id("com.google.gms.google-services")
}

android {
    namespace = "com.app.taiyara"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    defaultConfig {
        // Application ID must match the package name in google-services.json.
        applicationId = "com.app.taiyara"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

kotlin {
    compilerOptions {
        jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
    }
}

// Import the Firebase BoM – it pins compatible versions of all Firebase
// Android libraries without requiring individual version numbers.
dependencies {
    implementation(platform("com.google.firebase:firebase-bom:33.14.0"))
    // Individual Firebase services are added per-library (e.g. firebase_auth).
    // The Google Services plugin handles version resolution from the BOM.
}

flutter {
    source = "../.."
}
