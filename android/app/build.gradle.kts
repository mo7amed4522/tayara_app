import java.util.Properties

plugins {
    id("com.android.application")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
    // NOTE: The Google Services plugin is intentionally omitted because the
    // Flutter Gradle plugin already places it on the classpath without a
    // known version, which conflicts with declaring an explicit version.
    // Firebase initialises at runtime via `firebase_options.dart`.
}

val releaseKeyProperties = Properties()
val releaseKeyPropertiesFile = rootProject.file("key.properties")
if (releaseKeyPropertiesFile.exists()) {
    releaseKeyPropertiesFile.inputStream().use { releaseKeyProperties.load(it) }
}

android {
    namespace = "com.app.taiyara"
    // flutter_local_notifications 23.x and androidx.core:core:1.19.0 require
    // compileSdk 37. Install it with:
    //   $ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager "platforms;android-37"
    compileSdk = 37
    ndkVersion = flutter.ndkVersion

    signingConfigs {
        create("release") {
            if (releaseKeyPropertiesFile.exists()) {
                storeFile = file(
                    requireNotNull(releaseKeyProperties.getProperty("storeFile")) {
                        "storeFile is missing from android/key.properties."
                    },
                )
                storePassword = requireNotNull(
                    releaseKeyProperties.getProperty("storePassword"),
                ) { "storePassword is missing from android/key.properties." }
                keyAlias = requireNotNull(
                    releaseKeyProperties.getProperty("keyAlias"),
                ) { "keyAlias is missing from android/key.properties." }
                keyPassword = requireNotNull(
                    releaseKeyProperties.getProperty("keyPassword"),
                ) { "keyPassword is missing from android/key.properties." }
            }
        }
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
        // Required by flutter_local_notifications 23.x (uses java.time APIs).
        isCoreLibraryDesugaringEnabled = true
    }

    defaultConfig {
        // Keep this aligned with the Android app registered in Firebase and OAuth.
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
            if (releaseKeyPropertiesFile.exists()) {
                signingConfig = signingConfigs.getByName("release")
            }
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

    // Core library desugaring for java.time APIs used by
    // flutter_local_notifications 23.x on older Android versions.
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
}

flutter {
    source = "../.."
}
