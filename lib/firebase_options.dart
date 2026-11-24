/// Firebase options for the Tayara application.
///
/// This file reads the per-platform configuration required to initialise
/// [FirebaseCore] from the local `.env` file.
///
/// File: lib/core/services/firebase_options.dart
/// Architecture: Core Services – Firebase Configuration
/// Purpose: Provide platform‑agnostic Firebase default platform
///          options for use with [Firebase.initializeApp].
library;

// ignore_for_file: lines_longer_than_80_chars

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Default [FirebaseOptions] used for all platforms.
///
/// Values are loaded only after `.env` has been initialized at app startup.
class DefaultFirebaseOptions {
  /// Private constructor prevents instantiation.
  DefaultFirebaseOptions._();

  static FirebaseOptions get android => FirebaseOptions(
    apiKey: _required('FIREBASE_ANDROID_API_KEY'),
    appId: _required('FIREBASE_ANDROID_APP_ID'),
    messagingSenderId: _required('FIREBASE_MESSAGING_SENDER_ID'),
    projectId: _required('FIREBASE_PROJECT_ID'),
    storageBucket: _required('FIREBASE_STORAGE_BUCKET'),
  );

  static FirebaseOptions get ios => FirebaseOptions(
    apiKey: _required('FIREBASE_IOS_API_KEY'),
    appId: _required('FIREBASE_IOS_APP_ID'),
    messagingSenderId: _required('FIREBASE_MESSAGING_SENDER_ID'),
    projectId: _required('FIREBASE_PROJECT_ID'),
    storageBucket: _required('FIREBASE_STORAGE_BUCKET'),
    iosBundleId: _required('FIREBASE_IOS_BUNDLE_ID'),
  );

  /// Firebase options for **Web**.
  ///
  /// Not yet configured. Replace placeholder values with those from
  /// the Firebase Console before using on web.
  static FirebaseOptions get web => FirebaseOptions(
    apiKey: _required('FIREBASE_WEB_API_KEY'),
    appId: _required('FIREBASE_WEB_APP_ID'),
    messagingSenderId: _required('FIREBASE_MESSAGING_SENDER_ID'),
    projectId: _required('FIREBASE_PROJECT_ID'),
    storageBucket: _required('FIREBASE_STORAGE_BUCKET'),
    authDomain: _required('FIREBASE_WEB_AUTH_DOMAIN'),
    measurementId: _required('FIREBASE_WEB_MEASUREMENT_ID'),
  );

  static String _required(String key) {
    final value = dotenv.env[key];
    if (value == null || value.isEmpty) {
      throw StateError('Missing $key in the local .env file.');
    }
    return value;
  }

  /// Returns the correct [FirebaseOptions] for the current platform.
  ///
  /// Throws a [FallbackException] if the platform is not supported.
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
      case TargetPlatform.windows:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return ios; // macOS shares iOS options
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux.',
        );
      default:
        throw FallbackException(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }
}

/// Exception thrown when the current platform is not supported by
/// [DefaultFirebaseOptions].
class FallbackException implements Exception {
  /// Message explaining the unsupported platform.
  final String message;

  /// Creates a [FallbackException] with the given [message].
  const FallbackException(this.message);

  @override
  String toString() => 'FallbackException: $message';
}
