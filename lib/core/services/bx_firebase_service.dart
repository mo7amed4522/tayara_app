// File: lib/core/services/bx_firebase_service.dart
// Architecture: Core Layer - Bx Firebase services
// Purpose: Define the firebase func for the application

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:tayara/core/constant/bx_app_constant.dart';
import 'package:tayara/core/utils/bx_custom_notification_widget.dart';
import 'package:tayara/core/utils/bx_push_token_helper.dart';
import 'package:tayara/domain/usecase/bx_upsert_push_token_usecase.dart';
import 'dart:io' show Platform;

import 'package:tayara/firebase_options.dart';
import 'package:tayara/injection/bx_dependency_injector.dart';

final FlutterLocalNotificationsPlugin
_backgroundFlutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

// Top-level function for background message handling
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
  await _initializeBackgroundNotifications();
  await _showBackgroundNotification(message);
  debugPrint('Handling background message: ${message.messageId}');
}

Future<void> _initializeBackgroundNotifications() async {
  const AndroidInitializationSettings androidInitializationSettings =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  const DarwinInitializationSettings iosInitializationSettings =
      DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
      );
  const InitializationSettings settings = InitializationSettings(
    android: androidInitializationSettings,
    iOS: iosInitializationSettings,
  );
  await _backgroundFlutterLocalNotificationsPlugin.initialize(
    settings: settings,
  );

  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications.',
    importance: Importance.high,
    enableVibration: true,
    playSound: true,
  );
  await _backgroundFlutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin
      >()
      ?.createNotificationChannel(channel);
}

Future<void> _showBackgroundNotification(RemoteMessage message) async {
  final notification = message.notification;
  final String title =
      notification?.title ?? message.data['title'] ?? 'Notification';
  final String body = notification?.body ?? message.data['body'] ?? '';
  final String? payload = message.data.isNotEmpty
      ? message.data.toString()
      : null;

  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
        'high_importance_channel',
        'High Importance Notifications',
        channelDescription: 'This channel is used for important notifications.',
        importance: Importance.high,
        priority: Priority.high,
        showWhen: true,
        enableVibration: true,
        playSound: true,
      );

  const DarwinNotificationDetails iosPlatformChannelSpecifics =
      DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      );

  const NotificationDetails platformChannelSpecifics = NotificationDetails(
    android: androidPlatformChannelSpecifics,
    iOS: iosPlatformChannelSpecifics,
  );

  await _backgroundFlutterLocalNotificationsPlugin.show(
    id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
    title: title,
    body: body,
    notificationDetails: platformChannelSpecifics,
    payload: payload,
  );
}

/// A service that manages Firebase Cloud Messaging (FCM) and push notifications.
///
/// - Initializes Firebase and handles both foreground and background push messages.
/// - Manages local notifications via [flutter_local_notifications].
/// - Provides access to Firebase configuration values (projectId, appId, apiKey, etc.)
///   even before token is available (useful for iOS first launch).
/// - Handles FCM token refresh and allows subscription to topics.
/// - Shows custom in-app notification overlays when the app is in foreground.
/// - Static config values are always accessible without waiting for token.
class BxFirebaseService {
  static final BxFirebaseService _instance = BxFirebaseService._internal();
  factory BxFirebaseService() => _instance;
  BxFirebaseService._internal();

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static GlobalKey<NavigatorState>? _navigatorKey;
  bool _initialized = false;

  // ---------------------------------------------------------------------------
  // Navigator key management
  // ---------------------------------------------------------------------------
  /// Sets the global navigator key from the app widget.
  /// Used for navigation when notifications are tapped.
  static void setNavigatorKey(GlobalKey<NavigatorState> key) {
    _navigatorKey = key;
    debugPrint('BxFirebaseService navigator key set');
  }

  static GlobalKey<NavigatorState>? get navigatorKey => _navigatorKey;

  // ---------------------------------------------------------------------------
  // Static Firebase configuration values (always available, no waiting)
  // ---------------------------------------------------------------------------
  static FirebaseOptions get firebaseOptions =>
      DefaultFirebaseOptions.currentPlatform;

  static String get projectId => firebaseOptions.projectId;
  static String get appId => firebaseOptions.appId;
  static String get apiKey => firebaseOptions.apiKey;
  static String get messagingSenderId => firebaseOptions.messagingSenderId;

  static String? get iosBundleId {
    if (!kIsWeb && Platform.isIOS) {
      return firebaseOptions.iosBundleId;
    }
    return null;
  }

  // ---------------------------------------------------------------------------
  // Public initialization
  // ---------------------------------------------------------------------------
  /// Initializes Firebase, local notifications, and messaging.
  ///
  /// Should be called at app startup. Handles permission requests,
  /// token retrieval (with graceful fallback for iOS first launch),
  /// and sets up all message listeners (foreground, background, terminated).
  Future<void> init() async {
    if (_initialized) return;
    try {
      if (Firebase.apps.isEmpty) {
        await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        );
      }
      await _initLocalNotifications();
      await _initMessaging();
      _initialized = true;
    } catch (e) {
      debugPrint('Error initializing Firebase: $e');
    }
  }

  // ---------------------------------------------------------------------------
  // Local notifications setup
  // ---------------------------------------------------------------------------
  /// Initialises the local notifications plugin, sets up the notification channel,
  /// and requests permissions on Android.
  Future<void> _initLocalNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
        );
    const InitializationSettings initializationSettings =
        InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: initializationSettingsIOS,
        );

    await _flutterLocalNotificationsPlugin.initialize(
      settings: initializationSettings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );

    if (!kIsWeb && Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
          _flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin
              >();
      await androidImplementation?.requestNotificationsPermission();
    }

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      description: 'This channel is used for important notifications.',
      importance: Importance.high,
      enableVibration: true,
      playSound: true,
    );

    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(channel);
  }

  // ---------------------------------------------------------------------------
  // Notification tap handling
  // ---------------------------------------------------------------------------
  /// Called when a local notification is tapped.
  /// Extracts the payload and triggers navigation.
  void _onNotificationTapped(NotificationResponse notificationResponse) {
    debugPrint('Notification tapped: ${notificationResponse.payload}');
    if (notificationResponse.payload != null &&
        notificationResponse.payload!.isNotEmpty) {
      _handleNotificationNavigation(notificationResponse.payload!);
    }
  }

  /// Handles navigation based on notification payload.
  /// Uses the global navigator key if available.
  void _handleNotificationNavigation(String payload) {
    debugPrint('Navigating based on payload: $payload');
    final context = _navigatorKey?.currentContext;
    if (context != null) {
      // Your navigation logic here
      debugPrint('Navigation context available');
    } else {
      debugPrint('Warning: Navigation context not available');
    }
  }

  // ---------------------------------------------------------------------------
  // Firebase Messaging setup
  // ---------------------------------------------------------------------------
  /// Initializes Firebase Messaging, requests permissions, handles token refresh,
  /// and sets up message listeners for all app states.
  Future<void> _initMessaging() async {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    final messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );

    if (settings.authorizationStatus != AuthorizationStatus.authorized &&
        settings.authorizationStatus != AuthorizationStatus.provisional) {
      debugPrint(
        'Notification permission not granted '
        '(status: ${settings.authorizationStatus}); '
        'FCM listeners will still be registered.',
      );
    }
    // Try to get token, but don't crash if not available (expected on iOS first launch)
    try {
      String? token = await messaging.getToken();
      if (token != null) {
        debugPrint('FCM registration token is available.');
      } else {
        debugPrint('FCM Token not available yet - using static config values');
      }
    } catch (e) {
      // This is expected on iOS first launch - use static values instead
      debugPrint('Token not available (expected on iOS): $e');
      debugPrint('Using static Firebase config values:');
      debugPrint('  Project ID: $projectId');
      debugPrint('  App ID: $appId');
      debugPrint('  Sender ID: $messagingSenderId');
      if (Platform.isIOS) {
        debugPrint('  iOS Bundle ID: ${iosBundleId ?? 'Not set'}');
      }
    }

    messaging.onTokenRefresh.listen((String newToken) async {
      debugPrint('FCM registration token refreshed.');
      // Only sync when a user is logged in.
      if (BxAppData.currentUser?.data?.token == null) return;

      final request = await BxPushTokenHelper.build(
        authToken: BxAppData.currentUser?.data?.token,
      );
      if (request == null) return;

      final response = await BxDependencyInjector.instance
          .get<BxUpsertPushTokenUsecase>()
          .execute(request);
      if (response.code != 0) {
        debugPrint('Token refresh sync failed: ${response.msg}');
      }
    });

    await messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint(
        'Received foreground FCM message: ${message.messageId}, '
        'hasNotification=${message.notification != null}, '
        'dataKeys=${message.data.keys.toList()}',
      );
      _showCustomNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint('Notification opened app: ${message.messageId}');
      _handleNotificationNavigation(message.data.toString());
    });

    RemoteMessage? initialMessage = await messaging.getInitialMessage();
    if (initialMessage != null) {
      debugPrint(
        'App opened from killed state by notification: ${initialMessage.messageId}',
      );
      _handleNotificationNavigation(initialMessage.data.toString());
    }
  }

  // ---------------------------------------------------------------------------
  // Helper methods
  // ---------------------------------------------------------------------------
  /// Returns a map of Firebase configuration info, including token if available.
  /// Useful for debugging or sending config to backend.
  Map<String, String?> getFirebaseInfo() {
    return {
      'projectId': projectId,
      'appId': appId,
      'apiKey': apiKey,
      'messagingSenderId': messagingSenderId,
      'iosBundleId': iosBundleId,
      'fcmToken': _getCurrentToken(), // May be null on iOS initially
    };
  }

  /// Attempts to get the current FCM token.
  /// Returns null if token retrieval fails (graceful fallback).
  String? _getCurrentToken() {
    try {
      // This might throw, so we catch and return null
      return FirebaseMessaging.instance.getToken() as String?;
    } catch (e) {
      return null;
    }
  }

  // ---------------------------------------------------------------------------
  // Notification display
  // ---------------------------------------------------------------------------
  /// Shows a custom notification for foreground messages.
  /// Displays both a system notification and an in-app overlay.
  void _showCustomNotification(RemoteMessage message) {
    final notification = message.notification;
    final title = notification?.title ?? message.data['title']?.toString();
    final body = notification?.body ?? message.data['body']?.toString();
    if ((title == null || title.isEmpty) && (body == null || body.isEmpty)) {
      debugPrint(
        'Foreground FCM message has no notification title/body '
        'and no title/body data fields.',
      );
      return;
    }

    debugPrint('Showing notification: title=$title, body=$body');
    _showLocalNotification(
      title: title ?? 'Notification',
      body: body ?? '',
      payload: message.data.toString(),
    );

    final context = _navigatorKey?.currentContext;
    if (context != null) {
      debugPrint('Showing in-app notification overlay');
      NotificationHelper.show(
        context: context,
        title: title ?? 'Notification',
        message: body ?? '',
        priority: NotificationPriority.normal,
        onTap: () => _handleNotificationNavigation(message.data.toString()),
        duration: const Duration(seconds: 5),
      );
    } else {
      debugPrint(
        'App context not available - only showing system notification',
      );
    }
  }

  /// Shows a local system notification via flutter_local_notifications.
  Future<void> _showLocalNotification({
    required String title,
    required String body,
    String? payload,
  }) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
          'high_importance_channel',
          'High Importance Notifications',
          channelDescription:
              'This channel is used for important notifications.',
          importance: Importance.high,
          priority: Priority.high,
          showWhen: true,
          enableVibration: true,
          playSound: true,
        );

    const DarwinNotificationDetails iOSPlatformChannelSpecifics =
        DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    await _flutterLocalNotificationsPlugin.show(
      id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title: title,
      body: body,
      notificationDetails: platformChannelSpecifics,
      payload: payload,
    );
  }

  // ---------------------------------------------------------------------------
  // Topic subscription management
  // ---------------------------------------------------------------------------
  /// Subscribes the device to a specific FCM topic.
  /// Useful for group or role-based notifications.
  Future<void> subscribeToTopic(String topic) async {
    await FirebaseMessaging.instance.subscribeToTopic(topic);
    debugPrint('Subscribed to topic: $topic');
  }

  /// Unsubscribes the device from a specific FCM topic.
  Future<void> unsubscribeFromTopic(String topic) async {
    await FirebaseMessaging.instance.unsubscribeFromTopic(topic);
    debugPrint('Unsubscribed from topic: $topic');
  }

  // ---------------------------------------------------------------------------
  // Token info retrieval
  // ---------------------------------------------------------------------------
  /// Attempts to get the FCM token and returns a result object with success status.
  /// Also returns static config values even if token retrieval fails.
  Future<Map<String, dynamic>> getTokenInfo() async {
    try {
      String? token = await FirebaseMessaging.instance.getToken();
      return {
        'success': true,
        'fcmToken': token,
        'staticConfig': {
          'projectId': projectId,
          'appId': appId,
          'senderId': messagingSenderId,
        },
      };
    } catch (e) {
      return {
        'success': false,
        'error': e.toString(),
        'staticConfig': {
          'projectId': projectId,
          'appId': appId,
          'senderId': messagingSenderId,
        },
      };
    }
  }
}
