// File: lib/core/themes/bx_app_theme.dart
// Architecture: Core Layer - Bx App Theme
// Purpose: Define the app theme for the application

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'bx_app_colors.dart';

/// Provides the light and dark [ThemeData] for the application.
///
/// Both themes use Material 3 with colours from [BxAppColors], responsive
/// text sizes via [flutter_screenutil], and consistent component styles for
/// app bars, buttons, inputs, text, and cards.
///
/// This class cannot be instantiated.
class BxAppTheme {
  BxAppTheme._();

  /// Returns the light theme configuration.
  ///
  /// Uses [BxAppColors.primary] as the seed colour and defines:
  /// - A centred, flat [AppBar] with primary background and white text.
  /// - Full‑width elevated buttons with rounded corners and bold text.
  /// - Rounded, filled input fields with subtle borders that highlight on focus.
  /// - A [TextTheme] with scalable sizes (`.sp`) and appropriate contrast.
  /// - Elevated cards with a soft primary shadow.
  static ThemeData get lightTheme {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: BxAppColors.primary,
      brightness: Brightness.light,
      primary: BxAppColors.primary,
      secondary: BxAppColors.secondary,
      error: BxAppColors.error,
      surface: BxAppColors.surface,
      background: BxAppColors.background,
      onPrimary: BxAppColors.onPrimary,
      onSecondary: BxAppColors.onSecondary,
      onBackground: BxAppColors.onBackground,
      onSurface: BxAppColors.onSurface,
      onError: BxAppColors.onError,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: BxAppColors.background,
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: BxAppColors.primary,
        foregroundColor: BxAppColors.onPrimary,
        titleTextStyle: TextStyle(color: BxAppColors.onPrimary, fontSize: 20.sp, fontWeight: FontWeight.w600),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: BxAppColors.primary,
          foregroundColor: BxAppColors.onPrimary, // This ensures text is white
          minimumSize: const Size(double.infinity, 48),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          textStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, letterSpacing: 1.2),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: BxAppColors.surface,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: BxAppColors.onBackground.withOpacity(0.2), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: BxAppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: BxAppColors.error, width: 1.5),
        ),
        labelStyle: TextStyle(color: BxAppColors.onBackground.withOpacity(0.7)),
        hintStyle: TextStyle(color: BxAppColors.onBackground.withOpacity(0.5)),
      ),
      textTheme: TextTheme(
        displayLarge: TextStyle(color: BxAppColors.onBackground, fontSize: 57.sp),
        displayMedium: TextStyle(color: BxAppColors.onBackground, fontSize: 45.sp),
        displaySmall: TextStyle(color: BxAppColors.onBackground, fontSize: 36.sp),
        headlineLarge: TextStyle(color: BxAppColors.onBackground, fontSize: 32.sp),
        headlineMedium: TextStyle(color: BxAppColors.onBackground, fontSize: 28.sp),
        headlineSmall: TextStyle(color: BxAppColors.onBackground, fontSize: 24.sp),
        titleLarge: TextStyle(color: BxAppColors.onBackground, fontSize: 22.sp),
        titleMedium: TextStyle(color: BxAppColors.onBackground, fontSize: 18.sp),
        titleSmall: TextStyle(color: BxAppColors.onBackground, fontSize: 16.sp),
        bodyLarge: TextStyle(color: BxAppColors.onBackground, fontSize: 16.sp),
        bodyMedium: TextStyle(color: BxAppColors.onBackground, fontSize: 14.sp),
        bodySmall: TextStyle(color: BxAppColors.onBackground, fontSize: 12.sp),
        labelLarge: TextStyle(color: BxAppColors.onBackground, fontSize: 14.sp),
        labelMedium: TextStyle(color: BxAppColors.onBackground, fontSize: 12.sp),
        labelSmall: TextStyle(color: BxAppColors.onBackground, fontSize: 11.sp),
      ),
      cardTheme: CardThemeData(
        color: BxAppColors.surface,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        shadowColor: BxAppColors.primary.withOpacity(0.1),
      ),
    );
  }

  /// Returns the dark theme configuration.
  ///
  /// Mirrors the light theme but uses dark surface/background colours from
  /// [BxAppColors] and adjusts the shadow and text contrast accordingly.
  static ThemeData get darkTheme {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: BxAppColors.primary,
      brightness: Brightness.dark,
      primary: BxAppColors.primary,
      secondary: BxAppColors.secondary,
      error: BxAppColors.error,
      surface: BxAppColors.darkSurface,
      background: BxAppColors.darkBackground,
      onPrimary: BxAppColors.onPrimary,
      onSecondary: BxAppColors.onSecondary,
      onBackground: BxAppColors.darkOnBackground,
      onSurface: BxAppColors.darkOnSurface,
      onError: BxAppColors.onError,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: BxAppColors.darkBackground,
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: BxAppColors.primaryDark,
        foregroundColor: BxAppColors.onPrimary,
        titleTextStyle: TextStyle(color: BxAppColors.onPrimary, fontSize: 20.sp, fontWeight: FontWeight.w600),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: BxAppColors.primary,
          foregroundColor: BxAppColors.onPrimary, // This ensures text is white
          minimumSize: const Size(double.infinity, 48),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          textStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, letterSpacing: 1.2),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: BxAppColors.darkSurface,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: BxAppColors.darkOnBackground.withOpacity(0.2), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: BxAppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: BxAppColors.error, width: 1.5),
        ),
        labelStyle: TextStyle(color: BxAppColors.darkOnBackground.withOpacity(0.7)),
        hintStyle: TextStyle(color: BxAppColors.darkOnBackground.withOpacity(0.5)),
      ),
      textTheme: TextTheme(
        displayLarge: TextStyle(color: BxAppColors.darkOnBackground, fontSize: 57.sp),
        displayMedium: TextStyle(color: BxAppColors.darkOnBackground, fontSize: 45.sp),
        displaySmall: TextStyle(color: BxAppColors.darkOnBackground, fontSize: 36.sp),
        headlineLarge: TextStyle(color: BxAppColors.darkOnBackground, fontSize: 32.sp),
        headlineMedium: TextStyle(color: BxAppColors.darkOnBackground, fontSize: 28.sp),
        headlineSmall: TextStyle(color: BxAppColors.darkOnBackground, fontSize: 24.sp),
        titleLarge: TextStyle(color: BxAppColors.darkOnBackground, fontSize: 22.sp),
        titleMedium: TextStyle(color: BxAppColors.darkOnBackground, fontSize: 18.sp),
        titleSmall: TextStyle(color: BxAppColors.darkOnBackground, fontSize: 16.sp),
        bodyLarge: TextStyle(color: BxAppColors.darkOnBackground, fontSize: 16.sp),
        bodyMedium: TextStyle(color: BxAppColors.darkOnBackground, fontSize: 14.sp),
        bodySmall: TextStyle(color: BxAppColors.darkOnBackground, fontSize: 12.sp),
        labelLarge: TextStyle(color: BxAppColors.darkOnBackground, fontSize: 14.sp),
        labelMedium: TextStyle(color: BxAppColors.darkOnBackground, fontSize: 12.sp),
        labelSmall: TextStyle(color: BxAppColors.darkOnBackground, fontSize: 11.sp),
      ),
      cardTheme: CardThemeData(
        color: BxAppColors.darkSurface,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        shadowColor: BxAppColors.primary.withOpacity(0.2),
      ),
    );
  }
}
