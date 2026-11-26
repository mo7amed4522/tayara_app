// File: lib/core/services/bx_notification_services.dart
// Architecture: Core Layer - Bx Notification services
// Purpose: Define local notification services for the application
//          Handles foreground, background and terminated (killed) states.
//          Notification appearance is customised using the app's primary colour
//          and displays the app icon. Full light/dark theming of native
//          notifications is not supported, but the accent colour on Android
//          and the app's UI when opened from a notification will reflect the current theme.

// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:tayara/core/theme/bx_app_colors.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz_data;

/// A service that manages local notifications using [flutter_local_notifications].
///
/// - Works in foreground, background and when the app is killed.
/// - Uses the app's primary colour as the Android notification accent colour.
/// - Displays the app icon in notifications.
/// - When the user taps a notification, the callback receives the [NotificationResponse].
///   Inside that callback you have access to [Theme.of(context)] and can use the full
///   [ColorScheme] for navigation / UI updates.
class BxNotificationService {
  BxNotificationService._internal();
  factory BxNotificationService() => _instance;
  static final BxNotificationService _instance =
      BxNotificationService._internal();

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();
  Function(NotificationResponse)? _onNotificationTapCallback;

  // ---------------------------------------------------------------------------
  // Initialization
  // ---------------------------------------------------------------------------
  /// Initialises the plugin, requests permissions and sets up notification tap
  /// handling for all application states.
  ///
  /// [onNotificationTap] is called whenever a notification is tapped, regardless
  /// of whether the app was in the foreground, background or killed.
  /// Inside this callback you will have access to a valid [BuildContext] if you
  /// call it from a widget, so you can safely use `Theme.of(context).colorScheme`.
  Future<void> init({Function(NotificationResponse)? onNotificationTap}) async {
    // Initialise timezone database (should be done once in main(), but safe to call here)
    tz_data.initializeTimeZones();

    _onNotificationTapCallback = onNotificationTap;

    // Android initialisation settings - uses the app launcher icon
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // iOS/macOS initialisation settings
    const DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
        );

    const InitializationSettings settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _plugin.initialize(
      settings: settings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        _onNotificationTapCallback?.call(response);
      },
      onDidReceiveBackgroundNotificationResponse: _backgroundHandler,
    );

    // Check if the app was launched from a notification while killed.
    final NotificationAppLaunchDetails? launchDetails = await _plugin
        .getNotificationAppLaunchDetails();
    if (launchDetails?.didNotificationLaunchApp ?? false) {
      final NotificationResponse? response =
          launchDetails!.notificationResponse;
      if (response != null && _onNotificationTapCallback != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _onNotificationTapCallback!(response);
        });
      }
    }
  }

  // ---------------------------------------------------------------------------
  // Show / schedule / cancel
  // ---------------------------------------------------------------------------

  /// Shows an immediate notification with the app icon.
  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
  }) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          'default_channel',
          'General',
          channelDescription: 'General notifications from the app',
          importance: Importance.high,
          priority: Priority.high,
          color: BxAppColors.primary,
          icon: '@mipmap/ic_launcher', // Small icon (status bar)
          largeIcon: DrawableResourceAndroidBitmap(
            '@mipmap/ic_launcher',
          ), // Large icon (notification card)
          // Optional: Customise the small icon with a specific colour
          // iconColor: BxAppColors.primary,
        );

    const DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const NotificationDetails details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _plugin.show(
      id: id,
      title: title,
      body: body,
      notificationDetails: details,
      payload: payload,
    );
  }

  /// Schedules a notification to appear at [scheduledDate] (local time) with the app icon.
  /// The method converts the [DateTime] to a [TZDateTime] internally.
  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
    String? payload,
  }) async {
    // Convert DateTime to TZDateTime using the local time zone
    final tz.TZDateTime tzScheduled = tz.TZDateTime.from(
      scheduledDate,
      tz.local,
    );

    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          'scheduled_channel',
          'Scheduled',
          channelDescription: 'Scheduled notifications',
          importance: Importance.high,
          priority: Priority.high,
          color: BxAppColors.primary,
          icon: '@mipmap/ic_launcher', // Small icon
          largeIcon: DrawableResourceAndroidBitmap(
            '@mipmap/ic_launcher',
          ), // Large icon
        );

    const DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const NotificationDetails details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _plugin.zonedSchedule(
      id: id,
      title: title,
      body: body,
      scheduledDate: tzScheduled,
      notificationDetails: details,
      payload: payload,
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  /// Cancels a specific notification by its [id].
  Future<void> cancelNotification(int id) async {
    await _plugin.cancel(id: id);
  }

  /// Cancels all pending notifications.
  Future<void> cancelAllNotifications() async {
    await _plugin.cancelAll();
  }
}

// ---------------------------------------------------------------------------
// Top-level background handler
// ---------------------------------------------------------------------------

@pragma('vm:entry-point')
void _backgroundHandler(NotificationResponse response) {
  debugPrint('Background notification tapped: ${response.payload}');
  // Navigate using a global navigator key if needed
}
