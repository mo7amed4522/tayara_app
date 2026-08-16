// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/widgets/bx_splash_widget/bx_splash_widget_mobile.dart
// Architecture: Presentation Layer - Bx Splash Widget
// Purpose: Professional Bx Splash widget for mobile devices with static blurred background

// ignore_for_file: unnecessary_null_comparison, use_build_context_synchronously, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tayara/core/constant/bx_app_constant.dart';
import 'package:tayara/core/routes/bx_app_routes.dart';
import 'package:tayara/core/routes/bx_route_names.dart';
import 'package:tayara/core/theme/bx_app_colors.dart';
import 'package:tayara/presentation/bloc/bx_splash_screen_controller/bx_splash_screen_controller_bloc.dart';

class BxSplashWidgetMobile extends StatelessWidget {
  const BxSplashWidgetMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Theme-aware gradient: transparent at top, background colour at bottom.
    // This keeps the sky visible while ensuring text/logo contrast.
    final gradientColor = isDark ? BxAppColors.background.withOpacity(0.7) : BxAppColors.background.withOpacity(0.7);

    return BlocListener<BxSplashScreenControllerBloc, BxSplashScreenControllerState>(
      listener: (context, state) {
        // Only proceed if status is success
        if (state.status == BxSplashScreenStatus.success) {
          // Use WidgetsBinding to ensure the widget tree is ready
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Future.delayed(const Duration(seconds: 3), () {
              // For StatelessWidget, we need to check via Navigator
              if (Navigator.of(context, rootNavigator: true).canPop() || Navigator.of(context, rootNavigator: true).widget != null) {
                if (state.onBoardingCompleted == true) {
                  BxAppRouter.pushReplacement(context, BxRouteNames.bxLoginScreen);
                } else {
                  BxAppRouter.pushReplacement(context, BxRouteNames.bxOnBoardingScreen);
                }
              }
            });
          });
        }
      },
      child: Container(
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
      ),
    );
  }
}
