// File: lib/presentation/widgets/bx_splash_widget/bx_splash_widget_mobile.dart
// Architecture: Presentation Layer - Bx Splash Widget
// Purpose: Professional Bx Splash widget for mobile devices with static blurred background

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:tayara/core/constant/bx_app_constant.dart';
import 'package:tayara/core/theme/bx_app_colors.dart';

class BxSplashWidgetMobile extends StatelessWidget {
  const BxSplashWidgetMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Theme-aware gradient: transparent at top, background colour at bottom.
    // This keeps the sky visible while ensuring text/logo contrast.
    final gradientColor = isDark ? BxAppColors.background.withOpacity(0.7) : BxAppColors.background.withOpacity(0.7);

    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(BxAppConstant.appBackground), fit: BoxFit.cover),
      ),
      child: Stack(
        children: [
          // Gradient overlay (top to bottom)
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Colors.white.withOpacity(0.01), gradientColor]),
            ),
          ),

          // Centered content
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Logo animation: comes from above
                FadeInDown(
                  duration: const Duration(milliseconds: 1000),
                  child: Image.asset(BxAppConstant.appLogo, width: 350, height: 350, fit: BoxFit.contain),
                ),
                // Text animation: comes from below
                FadeInUp(
                  duration: const Duration(milliseconds: 1000),
                  delay: const Duration(milliseconds: 200),
                  child: Text(
                    "Taiyara",
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: BxAppColors.primary, fontFamily: 'lao-mn'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
