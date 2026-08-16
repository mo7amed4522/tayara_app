// Copyright (c) 2026 Tayara. All rights reserved.
//
/// Phone number authentication service using Firebase Auth.
///
/// This service wraps the [FirebaseAuth] phone authentication APIs to
/// provide a complete phone sign‑in flow: verification code send,
/// verification code verify, and auto‑retrieval (where supported).
///
/// **Flow:**
/// 1. Request Firebase to send a verification SMS to the user's phone
///    via [FirebaseAuth.verifyPhoneNumber].
/// 2. Wait for the user to enter the code (or auto‑retrieval on Android).
/// 3. Create a [PhoneAuthCredential] from the verification ID and code.
/// 4. Sign in to Firebase with [FirebaseAuth.signInWithCredential].
/// 5. Return the resulting [BxPhoneAuthResult].
///
/// File: lib/core/services/bx_phone_auth_firebase_services.dart
/// Architecture: Core Services – Authentication
/// Purpose: Handle Phone Number Sign‑In via Firebase Authentication
library;

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';

/// Returns `true` when running on the iOS simulator.
bool get _isSimulator =>
    Platform.isIOS &&
    Process.runSync('sysctl', [
      '-n',
      'hw.model',
    ]).stdout.toString().contains('Simulator');

/// Represents the outcome of a phone authentication attempt.
///
/// Fields:
/// - [success] – whether the sign‑in succeeded.
/// - [user] – the [UserCredential] returned by Firebase Auth, or `null`
///   if [success] is `false`.
/// - [error] – a human‑readable error message, or `null` on success.
/// - [verificationId] – the Firebase verification ID, or `null` if the
///   code was not yet received. Useful for resuming verification.
class BxPhoneAuthResult {
  /// Whether the authentication succeeded.
  final bool success;

  /// The [UserCredential] from Firebase Auth, or `null` on failure.
  final UserCredential? user;

  /// An error message describing what went wrong, or `null` on success.
  final String? error;

  /// The Firebase phone verification ID, or `null` if unavailable.
  final String? verificationId;

  /// Creates a successful [BxPhoneAuthResult].
  BxPhoneAuthResult.success(this.user, {this.verificationId})
    : success = true,
      error = null;

  /// Creates a failed [BxPhoneAuthResult] with an [error] message.
  BxPhoneAuthResult.failure(this.error, {this.verificationId})
    : success = false,
      user = null;
}

/// Callback invoked for each state change during phone number
/// verification, enabling the caller to react to code‑sent,
/// auto‑retrieval timeout, completion and failure events.
///
/// Fields:
/// - [credential] – the [PhoneAuthCredential] if verification completed
///   automatically (Android auto‑retrieval), or `null` otherwise.
/// - [verificationId] – the Firebase verification ID, or `null` if the
///   verification has not yet been initiated.
/// - [resendToken] – a resend token (Android only), or `null` if not
///   applicable.
/// - [error] – a [FirebaseAuthException] if verification failed, or
///   `null` on success.
class BxPhoneAuthState {
  /// The completed [PhoneAuthCredential], or `null` if not yet available.
  final PhoneAuthCredential? credential;

  /// The Firebase verification ID, or `null` if not yet available.
  final String? verificationId;

  /// A resend token (Android only), or `null` if not applicable.
  final int? resendToken;

  /// A [FirebaseAuthException] if verification failed, or `null`.
  final FirebaseAuthException? error;

  /// Creates a [BxPhoneAuthState].
  const BxPhoneAuthState({
    this.credential,
    this.verificationId,
    this.resendToken,
    this.error,
  });
}

/// Service that performs phone number authentication using Firebase Auth.
///
/// Provides a singleton instance ([BxPhoneAuthFirebaseServices.instance])
/// that can be resolved from the dependency injector or called directly.
///
/// The service uses:
/// - [FirebaseAuth.verifyPhoneNumber] to send an SMS verification code.
/// - [FirebaseAuth.signInWithCredential] to complete sign‑in with the
///   received code.
///
/// **Platform notes:**
/// - **Android**: Supports automatic SMS retrieval via the SMS Retriever API.
/// - **iOS**: SMS auto‑retrieval is not supported; the user must enter the
///   code manually.
/// - A real phone number is required for testing – emulators may not
///   receive SMS messages.
///
/// Usage:
/// ```dart
/// // Step 1: Send verification code
/// final sendResult = await BxPhoneAuthFirebaseServices.instance
///     .sendVerificationCode(phoneNumber: '+856 20 XXXX XXXX');
///
/// // Step 2: Verify the code entered by the user
/// final verifyResult = await BxPhoneAuthFirebaseServices.instance
///     .verifyCode(phoneNumber: '+856 20 XXXX XXXX', smsCode: '123456');
///
/// if (verifyResult.success) {
///   // signed in
/// }
/// ```
class BxPhoneAuthFirebaseServices {
  // -- Singleton ----------------------------------------------------------

  static final BxPhoneAuthFirebaseServices _instance =
      BxPhoneAuthFirebaseServices._internal();

  /// Returns the singleton instance.
  static BxPhoneAuthFirebaseServices get instance => _instance;

  BxPhoneAuthFirebaseServices._internal();

  // -- Auth provider ------------------------------------------------------

  /// The underlying [FirebaseAuth] instance.
  FirebaseAuth get _auth => FirebaseAuth.instance;

  // -- Send verification code ---------------------------------------------

  /// Sends a verification SMS to the given [phoneNumber].
  ///
  /// **Parameters:**
  /// - [phoneNumber]: The full international phone number
  ///   (e.g. `'+856 20 XXXX XXXX'`).
  /// - [verifyStateChanged]: Callback invoked for each state change
  ///   during the verification process (code sent, auto‑retrieval
  ///   timeout, completion, failure).
  /// - [timeout]: Duration to wait for the SMS code. Defaults to
  ///   30 seconds.
  ///
  /// **Returns:** A [BxPhoneAuthResult] containing the verification ID
  ///   on success, or an error message on failure.
  ///
  /// **Errors handled:**
  /// - [FirebaseAuthException] – invalid phone number, quota exceeded,
  ///   or provider not enabled.
  /// - Generic exceptions – unexpected errors.
  Future<BxPhoneAuthResult> sendVerificationCode({
    required String phoneNumber,
    void Function(BxPhoneAuthState state)? verifyStateChanged,
    Duration timeout = const Duration(seconds: 30),
  }) async {
    if (_isSimulator) {
      return BxPhoneAuthResult.failure(
        'Phone authentication is not available on the iOS simulator. Please use a physical device.',
      );
    }
    try {
      String? verificationId;

      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: timeout,
        verificationCompleted: (PhoneAuthCredential credential) async {
          verificationId = credential.verificationId;
          verifyStateChanged?.call(
            BxPhoneAuthState(
              credential: credential,
              verificationId: verificationId,
            ),
          );
        },
        verificationFailed: (FirebaseAuthException e) {
          verificationId = null;
          verifyStateChanged?.call(
            BxPhoneAuthState(error: e, verificationId: null),
          );
        },
        codeSent: (String vid, int? resendToken) {
          verificationId = vid;
          verifyStateChanged?.call(
            BxPhoneAuthState(verificationId: vid, resendToken: resendToken),
          );
        },
        codeAutoRetrievalTimeout: (String vid) {
          verificationId = vid;
          verifyStateChanged?.call(BxPhoneAuthState(verificationId: vid));
        },
      );

      if (verificationId != null) {
        return BxPhoneAuthResult.success(null, verificationId: verificationId);
      }

      return BxPhoneAuthResult.failure(
        'Verification completed without returning an ID.',
      );
    } on FirebaseAuthException catch (e) {
      return BxPhoneAuthResult.failure(_firebaseAuthErrorMessage(e));
    } catch (e) {
      return BxPhoneAuthResult.failure('Phone verification failed: $e');
    }
  }

  /// Verifies the SMS [smsCode] entered by the user against the
  /// [verificationId] obtained from [sendVerificationCode].
  ///
  /// **Parameters:**
  /// - [phoneNumber]: The phone number that was verified.
  /// - [smsCode]: The code received via SMS.
  /// - [verificationId]: The verification ID returned by
  ///   [sendVerificationCode].
  ///
  /// **Returns:** A [BxPhoneAuthResult] indicating success or failure.
  ///
  /// **Errors handled:**
  /// - [FirebaseAuthException] – invalid code, expired verification ID,
  ///   or too many attempts.
  /// - Generic exceptions – unexpected errors.
  Future<BxPhoneAuthResult> verifyCode({
    required String phoneNumber,
    required String smsCode,
    required String verificationId,
  }) async {
    if (_isSimulator) {
      return BxPhoneAuthResult.failure(
        'Phone authentication is not available on the iOS simulator. Please use a physical device.',
      );
    }
    try {
      // 1. Create a PhoneAuthCredential from the verification ID and code.
      final PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );

      // 2. Sign in to Firebase with the credential.
      final UserCredential userCredential = await _auth.signInWithCredential(
        credential,
      );

      return BxPhoneAuthResult.success(userCredential);
    } on FirebaseAuthException catch (e) {
      return BxPhoneAuthResult.failure(_firebaseAuthErrorMessage(e));
    } catch (e) {
      return BxPhoneAuthResult.failure('Phone code verification failed: $e');
    }
  }

  /// Signs the current Firebase user out.
  ///
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

  /// Returns a user‑friendly error message for a [FirebaseAuthException].
  String _firebaseAuthErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-phone-number':
        return 'The phone number is invalid. Please enter a valid number with country code.';
      case 'quota-exceeded':
        return 'SMS quota exceeded. Please try again later.';
      case 'weak-password':
        return 'The password is too weak.';
      case 'user-disabled':
        return 'This account has been disabled.';
      case 'user-not-found':
        return 'No account found for this phone number.';
      case 'invalid-verification-code':
        return 'Invalid verification code. Please check and try again.';
      case 'invalid-verification-id':
        return 'Verification ID has expired. Please request a new code.';
      case 'code-expired':
        return 'The verification code has expired. Please request a new one.';
      case 'too-many-requests':
        return 'Too many requests. Please wait and try again later.';
      case 'operation-not-allowed':
        return 'Phone sign‑in is not enabled for this project.';
      case 'network-request-failed':
        return 'Network error. Please check your connection.';
      default:
        return 'Firebase error: ${e.message}';
    }
  }
}
