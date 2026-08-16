// Copyright (c) 2026 Tayara. All rights reserved.
//
/// Google authentication service using Firebase Auth.
///
/// This service wraps the [GoogleSignIn] and [FirebaseAuth] packages to
/// provide a single entry point for signing in with a Google account.
/// It exchanges the Google ID token for a Firebase credential and
/// signs the user into Firebase.
///
/// **Flow:**
/// 1. Initialize [GoogleSignIn.instance] with the web client ID.
/// 2. Call [GoogleSignIn.authenticate] to show the Google sign‑in UI.
/// 3. Extract the ID token from the sign‑in result.
/// 4. Create a [GoogleAuthProvider.credential] from the token.
/// 5. Sign in to Firebase with [FirebaseAuth.signInWithCredential].
/// 6. Return the resulting [BxGoogleAuthResult].
///
/// File: lib/core/services/bx_google_auth_firebase_services.dart
/// Architecture: Core Services – Authentication
/// Purpose: Handle Google Sign‑In via Firebase Authentication
library;

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

/// Returns `true` when running on the iOS simulator.
bool get _isSimulator =>
    Platform.isIOS &&
    Process.runSync('sysctl', [' -n', 'hw.model']).stdout.toString().contains(
      'Simulator',
    );

/// Represents the outcome of a Google authentication attempt.
///
/// Fields:
/// - [success] – whether the sign‑in succeeded.
/// - [user] – the [UserCredential] returned by Firebase Auth, or `null`
///   if [success] is `false`.
/// - [error] – a human‑readable error message, or `null` on success.
class BxGoogleAuthResult {
  /// Whether the authentication succeeded.
  final bool success;

  /// The [UserCredential] from Firebase Auth, or `null` on failure.
  final UserCredential? user;

  /// An error message describing what went wrong, or `null` on success.
  final String? error;

  /// Creates a successful [BxGoogleAuthResult].
  BxGoogleAuthResult.success(this.user) : success = true, error = null;

  /// Creates a failed [BxGoogleAuthResult] with an [error] message.
  BxGoogleAuthResult.failure(this.error) : success = false, user = null;
}

/// Service that performs Google authentication using Firebase Auth.
///
/// Provides a singleton instance ([BxGoogleAuthFirebaseServices.instance])
/// that can be resolved from the dependency injector or called directly.
///
/// The service uses:
/// - [GoogleSignIn.instance] to present the Google sign‑in UI and obtain
///   tokens.
/// - [FirebaseAuth] to exchange those tokens for a Firebase credential
///   and create / link a Firebase user.
///
/// **Note:** The iOS client ID is read automatically from
/// `GoogleService-Info.plist`. No manual initialization is required.
///
/// Usage:
/// ```dart
/// final result = await BxGoogleAuthFirebaseServices.instance.signIn();
/// if (result.success) {
///   final user = result.user!.user;
///   // proceed to home screen
/// } else {
///   // handle error: result.error
/// }
/// ```
class BxGoogleAuthFirebaseServices {
  // -- Singleton ----------------------------------------------------------

  static final BxGoogleAuthFirebaseServices _instance =
      BxGoogleAuthFirebaseServices._internal();

  /// Returns the singleton instance.
  static BxGoogleAuthFirebaseServices get instance => _instance;

  BxGoogleAuthFirebaseServices._internal();

  // -- Providers ----------------------------------------------------------

  /// The underlying [GoogleSignIn] singleton.
  ///
  /// The [GoogleSignIn] package uses a singleton pattern, so we access
  /// it via [GoogleSignIn.instance] rather than constructing a new
  /// instance.
  GoogleSignIn get _googleSignIn => GoogleSignIn.instance;

  /// The underlying [FirebaseAuth] instance.
  FirebaseAuth get _auth => FirebaseAuth.instance;

  // -- Sign in ------------------------------------------------------------

  /// Signs the user in with Google and authenticates with Firebase.
  ///
  /// **Steps:**
  /// 1. Triggers the Google sign‑in UI via [GoogleSignIn.authenticate].
  ///    The iOS client ID is read automatically from
  ///    `GoogleService-Info.plist`.
  /// 2. Extracts the `idToken` from the sign‑in result.
  /// 3. Creates a [GoogleAuthProvider.credential] from the token.
  /// 4. Calls [FirebaseAuth.signInWithCredential] to complete the
  ///    Firebase sign‑in.
  ///
  /// **Returns:** A [BxGoogleAuthResult] indicating success or failure.
  ///
  /// **Errors handled:**
  /// - [GoogleSignInException] – user cancelled or network error during
  ///   the Google sign‑in flow.
  /// - [FirebaseAuthException] – credential exchange or Firebase sign‑in
  ///   failed (e.g. account disabled, invalid token).
  /// - Generic exceptions – unexpected errors.
  Future<BxGoogleAuthResult> signIn() async {
    if (_isSimulator) {
      return BxGoogleAuthResult.failure(
        'Google Sign‑In is not available on the iOS simulator. Please use a physical device.',
      );
    }
    try {
      // 1. Trigger the Google sign‑in flow.
      //    The iOS client ID is read automatically from GoogleService-Info.plist.
      final GoogleSignInAccount googleUser = await _googleSignIn.authenticate();

      // 2. Extract the ID token.
      final String? idToken = googleUser.authentication.idToken;

      if (idToken == null) {
        return BxGoogleAuthResult.failure('Failed to obtain Google ID token.');
      }

      // 4. Create a Firebase credential from the Google ID token.
      final OAuthCredential credential = GoogleAuthProvider.credential(
        idToken: idToken,
      );

      // 5. Sign in to Firebase with the credential.
      final UserCredential userCredential = await _auth.signInWithCredential(
        credential,
      );

      return BxGoogleAuthResult.success(userCredential);
    } on GoogleSignInException catch (e) {
      return BxGoogleAuthResult.failure(_googleSignInErrorMessage(e));
    } on FirebaseAuthException catch (e) {
      return BxGoogleAuthResult.failure(_firebaseAuthErrorMessage(e));
    } catch (e) {
      return BxGoogleAuthResult.failure('Google sign‑in failed: $e');
    }
  }

  /// Signs the current Firebase user out of Google and Firebase.
  ///
  /// Calls [GoogleSignIn.signOut] and [FirebaseAuth.signOut] in sequence.
  /// Returns `true` if both operations succeeded.
  Future<bool> signOut() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
      return true;
    } catch (e) {
      return false;
    }
  }

  // -- Error message helpers ----------------------------------------------

  /// Returns a user‑friendly error message for a [GoogleSignInException].
  String _googleSignInErrorMessage(GoogleSignInException e) {
    switch (e.code) {
      case GoogleSignInExceptionCode.canceled:
        return 'Sign‑in was cancelled.';
      case GoogleSignInExceptionCode.interrupted:
        return 'Sign‑in was interrupted.';
      case GoogleSignInExceptionCode.clientConfigurationError:
        return 'Google Sign‑In is misconfigured. Please check the app settings.';
      case GoogleSignInExceptionCode.providerConfigurationError:
        return 'Google services are not available. Please try again later.';
      case GoogleSignInExceptionCode.uiUnavailable:
        return 'Sign‑In UI could not be displayed.';
      case GoogleSignInExceptionCode.userMismatch:
        return 'User mismatch. Please sign in with the correct account.';
      default:
        return 'Google sign‑in error: ${e.description}';
    }
  }

  /// Returns a user‑friendly error message for a [FirebaseAuthException].
  String _firebaseAuthErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'account-exists-with-different-credential':
        return 'An account already exists with the same email but a different sign‑in method.';
      case 'invalid-credential':
        return 'The Google credential is invalid or expired.';
      case 'user-disabled':
        return 'This account has been disabled.';
      case 'user-not-found':
        return 'No account found with these credentials.';
      case 'wrong-password':
        return 'Incorrect credentials.';
      case 'invalid-email':
        return 'The email address is malformed.';
      case 'operation-not-allowed':
        return 'Google sign‑in is not enabled for this project.';
      case 'too-many-requests':
        return 'Too many attempts. Please try again later.';
      default:
        return 'Firebase error: ${e.message}';
    }
  }
}
