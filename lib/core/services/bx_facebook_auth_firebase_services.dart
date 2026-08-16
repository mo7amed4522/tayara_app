// Copyright (c) 2026 Tayara. All rights reserved.
//
/// Facebook authentication service using Firebase Auth.
///
/// This service wraps the [FlutterFacebookAuth] and [FirebaseAuth] packages
/// to provide a single entry point for signing in with a Facebook account.
/// It exchanges the Facebook access token for a Firebase credential and
/// signs the user into Firebase.
///
/// **Flow:**
/// 1. Log in to Facebook via [FacebookAuth.login].
/// 2. Extract the access token from the [LoginResult].
/// 3. Create a [FacebookAuthProvider.credential] from the token.
/// 4. Sign in to Firebase with [FirebaseAuth.signInWithCredential].
/// 5. Return the resulting [BxFacebookAuthResult].
///
/// File: lib/core/services/bx_facebook_auth_firebase_services.dart
/// Architecture: Core Services – Authentication
/// Purpose: Handle Facebook Sign‑In via Firebase Authentication
library;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

/// Represents the outcome of a Facebook authentication attempt.
///
/// Fields:
/// - [success] – whether the sign‑in succeeded.
/// - [user] – the [UserCredential] returned by Firebase Auth, or `null`
///   if [success] is `false`.
/// - [error] – a human‑readable error message, or `null` on success.
/// - [loginResult] – the raw [LoginResult] from Facebook SDK, or `null`
///   on failure. Useful for accessing Facebook‑specific user data.
class BxFacebookAuthResult {
  /// Whether the authentication succeeded.
  final bool success;

  /// The [UserCredential] from Firebase Auth, or `null` on failure.
  final UserCredential? user;

  /// An error message describing what went wrong, or `null` on success.
  final String? error;

  /// The raw [LoginResult] from the Facebook SDK, or `null` on failure.
  final LoginResult? loginResult;

  /// Creates a successful [BxFacebookAuthResult].
  BxFacebookAuthResult.success(this.user, this.loginResult)
    : success = true,
      error = null;

  /// Creates a failed [BxFacebookAuthResult] with an [error] message.
  BxFacebookAuthResult.failure(this.error)
    : success = false,
      user = null,
      loginResult = null;
}

/// Service that performs Facebook authentication using Firebase Auth.
///
/// Provides a singleton instance ([BxFacebookAuthFirebaseServices.instance])
/// that can be resolved from the dependency injector or called directly.
///
/// The service uses:
/// - [FacebookAuth.instance] to present the Facebook login UI and obtain
///   an access token.
/// - [FirebaseAuth] to exchange that token for a Firebase credential
///   and create / link a Firebase user.
///
/// **Requirements on iOS:**
/// - Add `FacebookAppID`, `FacebookDisplayName`, and the reversed client ID
///   to `Info.plist`.
/// - Add the Facebook SDK to `Podfile`.
///
/// **Requirements on Android:**
/// - Add `facebook_app_id` and `facebook_display_name` to
///   `AndroidManifest.xml` or `strings.xml`.
///
/// Usage:
/// ```dart
/// final result = await BxFacebookAuthFirebaseServices.instance.signIn();
/// if (result.success) {
///   final user = result.user!.user;
///   // proceed to home screen
/// } else {
///   // handle error: result.error
/// }
/// ```
class BxFacebookAuthFirebaseServices {
  // -- Singleton ----------------------------------------------------------

  static final BxFacebookAuthFirebaseServices _instance =
      BxFacebookAuthFirebaseServices._internal();

  /// Returns the singleton instance.
  static BxFacebookAuthFirebaseServices get instance => _instance;

  BxFacebookAuthFirebaseServices._internal();

  // -- Auth providers -----------------------------------------------------

  /// The underlying [FacebookAuth] singleton from the `flutter_facebook_auth`
  /// package.
  FacebookAuth get _facebookAuth => FacebookAuth.instance;

  /// The underlying [FirebaseAuth] instance.
  FirebaseAuth get _auth => FirebaseAuth.instance;

  // -- Sign in ------------------------------------------------------------

  /// Signs the user in with Facebook and authenticates with Firebase.
  ///
  /// **Steps:**
  /// 1. Calls [FacebookAuth.login] to show the Facebook login dialog,
  ///    requesting `email` and `public_profile` permissions.
  /// 2. Checks that the login [LoginStatus] is [LoginStatus.success].
  /// 3. Extracts the access token string from the [LoginResult].
  /// 4. Creates a [FacebookAuthProvider.credential] from the token.
  /// 5. Calls [FirebaseAuth.signInWithCredential] to complete the
  ///    Firebase sign‑in.
  ///
  /// **Returns:** A [BxFacebookAuthResult] indicating success or failure.
  ///
  /// **Errors handled:**
  /// - Login cancelled or failed at the Facebook SDK level.
  /// - [FirebaseAuthException] – credential exchange or Firebase sign‑in
  ///   failed (e.g. account disabled, invalid token).
  /// - Generic exceptions – unexpected errors.
  Future<BxFacebookAuthResult> signIn() async {
    try {
      // 1. Trigger the Facebook login flow.
      final LoginResult facebookResult = await _facebookAuth.login(
        permissions: const ['email', 'public_profile'],
      );

      // 2. Check if the login was successful.
      if (facebookResult.status != LoginStatus.success) {
        return BxFacebookAuthResult.failure(
          _facebookLoginStatusMessage(facebookResult.status),
        );
      }

      // 3. Extract the access token string.
      final String? accessToken = facebookResult.accessToken?.tokenString;

      if (accessToken == null) {
        return BxFacebookAuthResult.failure(
          'Failed to obtain Facebook access token.',
        );
      }

      // 4. Create a Firebase credential from the Facebook access token.
      final OAuthCredential credential = FacebookAuthProvider.credential(
        accessToken,
      );

      // 5. Sign in to Firebase with the credential.
      final UserCredential userCredential = await _auth.signInWithCredential(
        credential,
      );

      return BxFacebookAuthResult.success(userCredential, facebookResult);
    } on Exception catch (e) {
      return BxFacebookAuthResult.failure(_facebookAuthErrorMessage(e));
    } catch (e) {
      return BxFacebookAuthResult.failure('Facebook sign‑in failed: $e');
    }
  }

  /// Logs out of Facebook and signs out of Firebase.
  ///
  /// Calls [FacebookAuth.logOut] and [FirebaseAuth.signOut]
  /// in sequence. Returns `true` if both operations succeeded.
  Future<bool> signOut() async {
    try {
      await _facebookAuth.logOut();
      await _auth.signOut();
      return true;
    } catch (e) {
      return false;
    }
  }

  // -- Error message helpers ----------------------------------------------

  /// Converts a [LoginStatus] into a user‑friendly message.
  String _facebookLoginStatusMessage(LoginStatus status) {
    switch (status) {
      case LoginStatus.success:
        return ''; // Should never reach here
      case LoginStatus.cancelled:
        return 'Facebook login was cancelled.';
      case LoginStatus.failed:
        return 'Facebook login failed. Please try again.';
      case LoginStatus.operationInProgress:
        return 'Facebook login is already in progress.';
    }
  }

  /// Returns a user‑friendly error message for Facebook login failures.
  String _facebookAuthErrorMessage(Exception e) {
    final String msg = e.toString().toLowerCase();
    if (msg.contains('cancel')) {
      return 'Facebook login was cancelled.';
    }
    if (msg.contains('network') || msg.contains('connection')) {
      return 'Network error. Please check your connection.';
    }
    return 'Facebook error: ${e.toString()}';
  }
}
