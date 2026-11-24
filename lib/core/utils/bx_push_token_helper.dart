// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/core/utils/bx_push_token_helper.dart
// Architecture: Core Layer - Push token helper
// Purpose: Build a BxUpsertPushTokenRequest from the device and FCM token

import 'dart:io' show Platform;

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tayara/domain/model/request/bx_upsert_push_token_request.dart';
import 'package:uuid/uuid.dart';

/// Simple value object holding the device metadata we care about.
class BxDeviceInfo {
  const BxDeviceInfo({
    required this.platform,
    required this.deviceModel,
    required this.deviceBrand,
    required this.osVersion,
    this.appVersion,
  });

  final String platform; // 'ios' | 'android' | 'web'
  final String deviceModel; // e.g. 'iPhone 14 Pro', 'Pixel 7'
  final String deviceBrand; // e.g. 'Apple', 'Google'
  final String osVersion; // e.g. '17.2', '14'
  final String? appVersion; // e.g. '1.4.2'

  Map<String, dynamic> toJson() => {
    'platform': platform,
    'device_model': deviceModel,
    'device_brand': deviceBrand,
    'os_version': osVersion,
    if (appVersion != null) 'app_version': appVersion,
  };
}

/// Builds the upsert push token request payload using:
/// - a stable `device_id` persisted in SharedPreferences,
/// - the current platform (`ios` / `android`),
/// - the current FCM token,
/// - the app version.
///
/// Returns `null` when the FCM token cannot be obtained (e.g. iOS first
/// launch before APNs token is ready). Callers should simply skip the
/// upsert call in that case — the `onTokenRefresh` listener will retry.
class BxPushTokenHelper {
  static const String _deviceIdKey = 'bx_push_device_id';

  /// Builds the request, or returns `null` if no FCM token is available yet.
  static Future<BxUpsertPushTokenRequest?> build() async {
    try {
      final String? token = await FirebaseMessaging.instance.getToken();
      if (token == null || token.isEmpty) {
        debugPrint('[BxPushTokenHelper] FCM token not available yet.');
        return null;
      }

      final deviceId = await _getOrCreateDeviceId();
      final deviceInfo = await getDeviceInfo();

      final packageInfo = await PackageInfo.fromPlatform();
      final appVersion = packageInfo.version;

      return BxUpsertPushTokenRequest(
        deviceId: deviceId,
        platform: deviceInfo.platform,
        token: token,
        appVersion: appVersion,
      );
    } catch (e) {
      debugPrint('[BxPushTokenHelper] Failed to build request: $e');
      return null;
    }
  }

  /// Collects platform-specific device info. Always returns a value —
  /// falls back to safe defaults if a plugin call fails.
  static Future<BxDeviceInfo> getDeviceInfo() async {
    // Web: no native device info.
    if (kIsWeb) {
      return const BxDeviceInfo(
        platform: 'web',
        deviceModel: 'web',
        deviceBrand: 'web',
        osVersion: 'web',
      );
    }

    final plugin = DeviceInfoPlugin();
    final packageInfo = await PackageInfo.fromPlatform();

    try {
      if (Platform.isIOS) {
        final ios = await plugin.iosInfo;
        return BxDeviceInfo(
          platform: 'ios',
          deviceModel: ios.utsname.machine, // e.g. 'iPhone15,2'
          deviceBrand: 'Apple',
          osVersion: ios.systemVersion,
          appVersion: packageInfo.version,
        );
      }

      if (Platform.isAndroid) {
        final android = await plugin.androidInfo;
        return BxDeviceInfo(
          platform: 'android',
          deviceModel: android.model, // e.g. 'Pixel 7'
          deviceBrand: android.brand, // e.g. 'google'
          osVersion: android.version.release, // e.g. '14'
          appVersion: packageInfo.version,
        );
      }
    } catch (e) {
      debugPrint('[BxPushTokenHelper] Failed to read device info: $e');
    }

    // Fallback for other platforms (macOS/Windows/Linux) or plugin errors.
    return BxDeviceInfo(
      platform: Platform.operatingSystem,
      deviceModel: 'unknown',
      deviceBrand: 'unknown',
      osVersion: Platform.operatingSystemVersion,
      appVersion: packageInfo.version,
    );
  }

  /// Returns a stable device id, creating and persisting one on first use.
  static Future<String> _getOrCreateDeviceId() async {
    final prefs = await SharedPreferences.getInstance();
    final existing = prefs.getString(_deviceIdKey);
    if (existing != null && existing.isNotEmpty) return existing;

    final newId = const Uuid().v4();
    await prefs.setString(_deviceIdKey, newId);
    return newId;
  }
}
