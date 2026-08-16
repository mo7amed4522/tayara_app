/// Apple authentication service using Firebase Auth.
///
/// This service wraps the [SignInWithApple] and [FirebaseAuth] packages to
/// provide a single entry point for signing in with an Apple ID.
/// It exchanges the Apple identity token for a Firebase credential and
/// signs the user into Firebase.
///
/// **Flow:**
/// 1. Request an identity token from Apple via [SignInWithApple.getAppleIDCredential].
/// 2. Create a [OAuthProvider("apple.com")] credential from the token.
/// 3. Sign in to Firebase with [FirebaseAuth.signInWithCredential].
/// 4. Return the resulting [BxAppleAuthResult].
///
/// File: lib/core/services/bx_apple_auth_firebase_services.dart
/// Architecture: Core Services – Authentication
/// Purpose: Handle Apple Sign‑In via Firebase Authentication
library;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

/// Represents the outcome of an Apple authentication attempt.
///
/// Fields:
/// - [success] – whether the sign‑in succeeded.
/// - [user] – the [UserCredential] returned by Firebase Auth, or `null`
///   if [success] is `false`.
/// - [error] – a human‑readable error message, or `null` on success.
/// - [appleUser] – the raw [AuthorizationCredentialAppleID] from Apple,
///   or `null` on failure. Useful for accessing Apple‑provided user
///   details such as email and name.
class BxAppleAuthResult {
  /// Whether the authentication succeeded.
  final bool success;

  /// The [UserCredential] from Firebase Auth, or `null` on failure.
  final UserCredential? user;

  /// An error message describing what went wrong, or `null` on success.
  final String? error;

  /// The raw [AuthorizationCredentialAppleID] from Apple, or `null` on
  /// failure.
  final AuthorizationCredentialAppleID? appleUser;

  /// Creates a successful [BxAppleAuthResult].
  BxAppleAuthResult.success(this.user, this.appleUser) : success = true, error = null;

  /// Creates a failed [BxAppleAuthResult] with an [error] message.
  BxAppleAuthResult.failure(this.error) : success = false, user = null, appleUser = null;
}

/// Service that performs Apple authentication using Firebase Auth.
///
/// Provides a singleton instance ([BxAppleAuthFirebaseServices.instance])
/// that can be resolved from the dependency injector or called directly.
///
/// The service uses:
/// - [SignInWithApple] to present the Apple sign‑in UI and obtain an
///   identity token.
/// - [FirebaseAuth] to exchange that token for a Firebase credential
///   and create / link a Firebase user.
///
/// **Platform note:** Apple Sign‑In is only available on iOS 13+,
/// macOS, and iPadOS. On unsupported platforms the service returns
/// a failure result immediately.
///
/// Usage:
/// ```dart
/// final result = await BxAppleAuthFirebaseServices.instance.signIn();
/// if (result.success) {
///   final user = result.user!.user;
///   // proceed to home screen
/// } else {
///   // handle error: result.error
/// }
/// ```
class BxAppleAuthFirebaseServices {
  // -- Singleton ----------------------------------------------------------

  static final BxAppleAuthFirebaseServices _instance = BxAppleAuthFirebaseServices._internal();

  /// Returns the singleton instance.
  static BxAppleAuthFirebaseServices get instance => _instance;

  BxAppleAuthFirebaseServices._internal();

  // -- Auth providers -----------------------------------------------------

  /// The underlying [FirebaseAuth] instance.
  FirebaseAuth get _auth => FirebaseAuth.instance;

  // -- Sign in ------------------------------------------------------------

  /// Signs the user in with Apple ID and authenticates with Firebase.
  ///
  /// **Steps:**
  /// 1. Requests an identity token from Apple via
  ///    [SignInWithApple.getAppleIDCredential] using the [email] and
  ///    [fullName] scopes.
  /// 2. Extracts the `identityToken` (JWT) string from the credential.
  /// 3. Creates a Firebase OAuth credential using
  ///    [OAuthProvider("apple.com")].
  /// 4. Calls [FirebaseAuth.signInWithCredential] to complete the
  ///    Firebase sign‑in.
  ///
  /// **Returns:** A [BxAppleAuthResult] indicating success or failure.
  ///
  /// **Errors handled:**
  /// - [Exception] from Apple sign‑in – user cancelled or framework error.
  /// - [FirebaseAuthException] – credential exchange or Firebase sign‑in
  ///   failed (e.g. account disabled, invalid token).
  /// - Generic exceptions – unexpected errors.
  ///
  /// **Requirements on iOS:**
  /// - The `Sign in with Apple` capability must be enabled in Xcode.
  /// - The reversed client ID must be registered in `Info.plist`
  ///   under `CFBundleURLSchemes`.
  Future<BxAppleAuthResult> signIn() async {
    try {
      // 1. Request credential from Apple with email and full name scopes.
      final AuthorizationCredentialAppleID appleCredential = await SignInWithApple.getAppleIDCredential(scopes: [AppleIDAuthorizationScopes.email, AppleIDAuthorizationScopes.fullName]);

      // 2. Convert the identity token (JWT) to a string.
      final String? idToken = appleCredential.identityToken;

      if (idToken == null) {
        return BxAppleAuthResult.failure('Failed to obtain Apple identity token.');
      }

      // 3. Create a Firebase OAuth credential from the Apple identity token.
      final OAuthCredential credential = OAuthProvider('apple.com').credential(idToken: idToken);

      // 4. Sign in to Firebase with the credential.
      final UserCredential userCredential = await _auth.signInWithCredential(credential);

      return BxAppleAuthResult.success(userCredential, appleCredential);
    } on Exception catch (e) {
      // Apple sign‑in was cancelled or failed at the OS level.
      return BxAppleAuthResult.failure(_appleSignInErrorMessage(e));
    } catch (e) {
      return BxAppleAuthResult.failure('Apple sign‑in failed: $e');
    }
  }

  /// Signs the current Firebase user out of Apple and Firebase.
  ///
  /// Calls [FirebaseAuth.signOut]. Apple sign‑in does not maintain a
  /// separate SDK session, so only Firebase needs to be cleared.
  /// Returns `true` if the operation succeeded.
  Future<bool> signOut() async {
    try {
      await _auth.signOut();
      return true;
    } catch (e) {
      return false;
    }
  }

  // -- Error message helpers ----------------------------------------------

  /// Returns a user‑friendly error message for Apple sign‑in failures.
  String _appleSignInErrorMessage(Exception e) {
    final String msg = e.toString().toLowerCase();
    if (msg.contains('cancel') || msg.contains('denied')) {
      return 'Apple sign‑in was cancelled.';
    }
    if (msg.contains('no-authorization')) {
      return 'Apple sign‑in is not authorised on this device.';
    }
    if (msg.contains('no-credentials')) {
      return 'No Apple ID credentials available. Make sure Sign in with Apple is configured.';
    }
    return 'Apple sign‑in error: ${e.toString()}';
  }
}
