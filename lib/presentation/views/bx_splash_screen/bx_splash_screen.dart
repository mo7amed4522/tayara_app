// File: lib/presentation/views/bx_splash_screen/bx_splash_screen.dart
// Architecture: Presentation Layer - Bx Splash Screen
// Purpose: Main bx splash screen that delegates to mobile/tablet widgets

import 'package:flutter/material.dart';
import 'package:tayara/core/responsive/bx_responsive_builder.dart';
import 'package:tayara/presentation/widgets/bx_splash_widget/bx_splash_widget_mobile.dart';
import 'package:tayara/presentation/widgets/bx_splash_widget/bx_splash_widget_tablet.dart';

class BxSplashScreen extends StatelessWidget {
  const BxSplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BxResponsiveBuilder(mobileBuilder: (context) => const BxSplashWidgetMobile(), tabletBuilder: (context) => const BxSplashWidgetTablet()),
    );
  }
}
