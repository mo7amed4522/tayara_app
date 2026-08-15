// File: lib/core/themes/bx_app_colors.dart
// Architecture: Core Layer - Bx App Colors
// Purpose: Define the colors for the application

import 'package:flutter/material.dart';

/// Defines the application's colour palette, including brand primary and
/// secondary colours, semantic status colours, and neutral colours for
/// both light and dark themes.
///
/// All colours are [Color] constants. This class cannot be instantiated.
class BxAppColors {
  BxAppColors._();

  // Main color (0xFF2563EB -> #2563EB)
  /// The primary brand colour used for app bars, buttons, and key accents.
  static const Color primary = Color(0xFF2563EB);

  // Light variant for gradients / surfaces
  /// Lighter variant of the primary colour, suitable for gradients or
  /// elevated surfaces.
  static const Color primaryLight = Color(0xFF6B9BFF);

  // Dark variant for pressed states / contrast
  /// Darker variant of the primary colour, used for pressed states or
  /// high-contrast elements.
  static const Color primaryDark = Color(0xFF1E4FBB);

  // Secondary color (complementary to primary – can be adjusted)
  /// Complementary secondary colour, used for floating action buttons,
  /// selection controls, and other secondary UI elements.
  static const Color secondary = Color(0xFFC49A6C);

  /// Lighter variant of the secondary colour, for hover or subtle
  /// secondary backgrounds.
  static const Color secondaryLight = Color(0xFFE0BC97);

  /// Darker variant of the secondary colour, for active/pressed
  /// secondary states.
  static const Color secondaryDark = Color(0xFF9E7648);

  // Semantic colors
  /// Colour indicating a successful action or positive status.
  static const Color success = Color(0xFF2E7D32);

  /// Colour indicating a warning or cautionary state.
  static const Color warning = Color(0xFFED6C02);

  /// Colour indicating an error or destructive action.
  static const Color error = Color(0xFFD32F2F);

  /// Colour used for informational messages or highlights.
  static const Color info = Color(0xFF0288D1);

  // Neutral colors (light theme)
  /// Default scaffold background colour for the light theme.
  static const Color background = Color(0xFFF5F7FA);

  /// Surface colour for cards, dialogs, and sheets in the light theme.
  static const Color surface = Color(0xFFFFFFFF);

  /// Colour of text and icons displayed on [primary] backgrounds.
  static const Color onPrimary = Color(0xFFFFFFFF);

  /// Colour of text and icons displayed on [secondary] backgrounds.
  static const Color onSecondary = Color(0xFFFFFFFF);

  /// Default text colour on the light theme's background.
  static const Color onBackground = Color(0xFF1C1E24);

  /// Default text colour on the light theme's surfaces.
  static const Color onSurface = Color(0xFF1C1E24);

  /// Colour of text and icons displayed on [error] backgrounds.
  static const Color onError = Color(0xFFFFFFFF);

  // Dark theme variants
  /// Scaffold background colour for the dark theme.
  static const Color darkBackground = Color(0xFF121212);

  /// Surface colour for cards, dialogs, and sheets in the dark theme.
  static const Color darkSurface = Color(0xFF1E1E1E);

  /// Default text colour on the dark theme's background.
  static const Color darkOnBackground = Color(0xFFE0E0E0);

  /// Default text colour on the dark theme's surfaces.
  static const Color darkOnSurface = Color(0xFFE0E0E0);
}
