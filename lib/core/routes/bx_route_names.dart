// Copyright (c) 2026 Tayara. All rights reserved.
//
/// Centralised route name constants used by [BxRouteGenerator] and
/// [BxAppRouter] to navigate between screens.
///
/// All route paths follow a lower‑case, hyphen‑separated convention
/// and are grouped into [publicRoutes] and [modalRoutes] lists.
/// This class also provides utility methods to extract path parameters,
/// match patterns and obtain display names for routes.
///
/// File: lib/core/routes/bx_route_names.dart
/// Architecture: Core Routes - Bx Route Names
/// Purpose: Centralized route name constants
library;

class BxRouteNames {
  // Initial routes
  /// The splash screen route, also used as the initial route (`/`).
  static const String bxSplashScreen = '/';

  /// Route for the onboarding flow.
  static const String bxOnBoardingScreen = '/bx-on-boarding-screen';

  /// Login screen route.
  static const String bxLoginScreen = '/bx-login-screen';

  /// update profile screen route.
  static const String bxUpdateProfileScreen = '/bx-update-profile-screen';

  /// Home screen route.
  static const String bxHomeScreen = '/bx-home-screen';

  // Auth flow routes
  /// Sign up screen route.
  static const String bxSignUpScreen = '/bx-sign-up-screen';

  /// Enter phone number screen route.
  static const String bxEnterPhoneScreen = '/bx-enter-phone-screen';

  // Trip routes
  /// Trip detail screen route.
  static const String bxTripDetailScreen = '/bx-trip-detail-screen';

  /// Booking detail screen route.
  static const String bxBookingDetailScreen = '/bx-booking-detail-screen';

  /// Payment screen route.
  static const String bxPaymentScreen = '/bx-payment-screen';

  /// Filter trips screen route.
  static const String bxFilterTripsScreen = '/bx-filter-trips-screen';

  /// Agencies screen route.
  static const String bxAgenciesScreen = '/bx-agencies-screen';

  /// Similar trips screen route.
  static const String bxSimilarTripsScreen = '/bx-similar-trips-screen';

  /// Custom trip screen route.
  static const String bxCustomTripScreen = '/bx-custom-trip-screen';

  /// Review travelers screen route.
  static const String bxReviewTravelersScreen = '/bx-review-travelers-screen';

  /// Search screen route.
  static const String bxSearchScreen = '/bx-search-screen';

  /// Package detail screen route.
  static const String bxPackageDetailScreen = '/bx-package-detail-screen';

  /// Error screen route.
  static const String bxErrorScreen = '/bx-error-screen';

  // Route groups
  /// All publicly accessible routes in the application.
  static const List<String> publicRoutes = [
    bxSplashScreen,
    bxOnBoardingScreen,
    bxLoginScreen,
    bxUpdateProfileScreen,
    bxSignUpScreen,
    bxEnterPhoneScreen,
    bxHomeScreen,
    bxBookingDetailScreen,
    bxPaymentScreen,
    bxFilterTripsScreen,
    bxAgenciesScreen,
    bxSimilarTripsScreen,
    bxCustomTripScreen,
    bxReviewTravelersScreen,
    bxTripDetailScreen,
    bxSearchScreen,
    bxPackageDetailScreen,
    bxErrorScreen,
  ];

  /// All authenticated (protected) routes in the application.
  static const List<String> protectedRoutes = [bxHomeScreen];

  /// Routes that are shown as modals (currently empty).
  static const List<String> modalRoutes = [];

  /// Returns `true` if [routeName] is one of the modal routes.
  static bool isModalRoute(String routeName) {
    return modalRoutes.contains(routeName);
  }

  // Route parameter extraction

  /// Extracts a single path parameter from [routeName] based on a [pattern].
  ///
  /// The [pattern] may contain segments prefixed with `:` that represent
  /// dynamic parameters. Returns the first matching parameter value, or
  /// `null` if the route does not match the pattern.
  ///
  /// Example:
  /// ```dart
  /// extractRouteParameter('/product/42', '/product/:id'); // returns '42'
  /// ```
  static String? extractRouteParameter(String routeName, String pattern) {
    final patternParts = pattern.split('/');
    final routeParts = routeName.split('/');

    if (patternParts.length != routeParts.length) {
      return null;
    }

    for (int i = 0; i < patternParts.length; i++) {
      if (patternParts[i].startsWith(':')) {
        // This is a parameter
        return routeParts[i];
      } else if (patternParts[i] != routeParts[i]) {
        // Path segments don't match
        return null;
      }
    }

    return null;
  }

  /// Extracts all path parameters from [routeName] using the given [pattern].
  ///
  /// Returns a map where each key is the parameter name (without the colon)
  /// and the value is the corresponding segment from the route.
  static Map<String, String> extractAllRouteParameters(
    String routeName,
    String pattern,
  ) {
    final parameters = <String, String>{};
    final patternParts = pattern.split('/');
    final routeParts = routeName.split('/');

    if (patternParts.length != routeParts.length) {
      return parameters;
    }

    for (int i = 0; i < patternParts.length; i++) {
      if (patternParts[i].startsWith(':')) {
        // Extract parameter name (remove colon)
        final paramName = patternParts[i].substring(1);
        parameters[paramName] = routeParts[i];
      }
    }

    return parameters;
  }

  // Route matching

  /// Returns `true` if [routeName] matches the given [pattern].
  ///
  /// Segments starting with `:` in the [pattern] are treated as wildcards
  /// that match any value. All other segments must match exactly.
  static bool matchesPattern(String routeName, String pattern) {
    final patternParts = pattern.split('/');
    final routeParts = routeName.split('/');

    if (patternParts.length != routeParts.length) {
      return false;
    }

    for (int i = 0; i < patternParts.length; i++) {
      if (!patternParts[i].startsWith(':')) {
        if (patternParts[i] != routeParts[i]) {
          return false;
        }
      }
    }

    return true;
  }

  // Get route display name

  /// Returns a human‑readable display name for the given [routeName],
  /// useful for analytics or debugging.
  static String getDisplayName(String routeName) {
    switch (routeName) {
      case bxSplashScreen:
        return 'Bx-Splash-screen';
      case bxOnBoardingScreen:
        return 'Bx-On-boarding-screen';
      case bxSignUpScreen:
        return 'Bx-Sign-Up-Screen';
      case bxEnterPhoneScreen:
        return 'Bx-Enter-Phone-Number-Screen';
      case bxLoginScreen:
        return 'Bx-Login-screen';
      case bxUpdateProfileScreen:
        return 'Bx-Update-Profile-Screen';
      case bxHomeScreen:
        return 'Bx-Home-screen';
      case bxBookingDetailScreen:
        return 'Bx-Booking-Detial-Screen';
      case bxPaymentScreen:
        return 'Bx-Payment-Screen';
      case bxFilterTripsScreen:
        return 'Bx-Filter-Trip-Screen';
      case bxAgenciesScreen:
        return 'Bx-Agencies-Screen';
      case bxSimilarTripsScreen:
        return 'Bx-Similar-Trip-Screen';
      case bxCustomTripScreen:
        return 'Bx-Custom-Trip-Screen';
      case bxReviewTravelersScreen:
        return 'Bx-Review-Travel-Screen';
      case bxTripDetailScreen:
        return 'Bx-Trip-Detail-Screen';
      case bxSearchScreen:
        return 'Bx-Search-Screen';
      case bxPackageDetailScreen:
        return 'Bx-Package-Detail-Screen';
      default:
        return 'Bx-Error-screen';
    }
  }
}

/// Categorises a route into one of the application's routing tiers.
enum RouteCategory {
  /// Routes that do not require authentication.
  public,

  /// Routes that require the user to be authenticated.
  protected,

  /// Routes that are presented as modal overlays.
  modal,

  /// Unknown or unmatched routes.
  unknown,
}
