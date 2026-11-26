// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: test/widget_test.dart
// Architecture: Tests – Widget smoke tests
// Purpose: Verify the app widget tree renders without crashing
//          after dependency injection is initialised.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tayara/bx_app_widget.dart';
import 'package:tayara/core/network/bx_api_endpoints.dart';
import 'package:tayara/injection/bx_dependency_injector.dart';

/// Main entry point for all widget tests.
///
/// [setUpAll] runs once before any test and ensures:
/// 1. Flutter bindings are initialised.
/// 2. [SharedPreferences] is available (required by the DI).
/// 3. [BxDependencyInjector] is registered with all core dependencies.
void main() {
  setUpAll(() async {
    // Required by the flutter_test binding.
    WidgetsFlutterBinding.ensureInitialized();
    dotenv.testLoad(fileInput: 'API_BASE_URL=https://api.example.com');

    // SharedPreferences must be initialised before the DI setup so the
    // injector can register it as a singleton.
    SharedPreferences.setMockInitialValues({});
    await BxDependencyInjector.instance.setup();
  });

  test('API base URL is loaded from environment configuration', () {
    expect(BxApiEndpoints.baseUrl, 'https://api.example.com');
  });

  /// Verifies that the root [BxAppWidget] builds without throwing when
  /// wrapped in [ScreenUtilInit], which is required because the theme
  /// uses [flutter_screenutil] size extensions (`.sp`).
  ///
  /// The splash-screen BLoC dispatches a 3-second timer; we fast-forward
  /// past it with [fakeAsync] so the tree reaches a steady state before
  /// asserting.
  testWidgets('BxAppWidget renders without crashing', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) => const BxAppWidget(),
      ),
    );

    // Advance past the 3-second splash-screen timer.
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();

    // The MaterialApp should be present in the rendered tree.
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
