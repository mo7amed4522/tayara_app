// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/widgets/bx_login_widget/bx_login_widget_mobile.dart
// Architecture: Presentation Layer - Bx Login Widget
// Purpose: Professional Bx Login widget for mobile devices

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tayara/core/constant/bx_app_constant.dart';
import 'package:tayara/core/routes/bx_app_routes.dart';
import 'package:tayara/core/routes/bx_route_names.dart';
import 'package:tayara/core/widgets/bx_custom_snack_bar.dart';
import 'package:tayara/presentation/bloc/bx_login_controller/bx_login_controller_bloc.dart';

class BxLoginWidgetMobile extends StatelessWidget {
  const BxLoginWidgetMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return BlocConsumer<BxLoginControllerBloc, BxLoginControllerState>(
      listenWhen: (prev, curr) => prev.status != curr.status,
      listener: (context, state) {
        if (state.status == BxLoginControllerStatus.error) {
          BxCustomSnackBar.error(
            context: context,
            message: state.errorMessage ?? 'Loign faild',
          );
        } else if (state.status == BxLoginControllerStatus.success) {
          BxCustomSnackBar.success(
            context: context,
            message: state.errorMessage ?? 'Loign success',
          );
          BxAppRouter.pushReplacement(context, BxRouteNames.bxHomeScreen);
        }
      },
      builder: (context, state) {
        final isLoading = state.status == BxLoginControllerStatus.loading;

        return Scaffold(
          backgroundColor: theme.scaffoldBackgroundColor,
          body: Stack(
            children: [
              SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // 1. Top pill container
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: colorScheme.primary.withOpacity(0.2),
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: colorScheme.primary.withOpacity(0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Text(
                          "Ready for your next adventure ?",
                          style: TextStyle(
                            color: colorScheme.onBackground,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),

                      // 2. Login logo
                      Image.asset(
                        BxAppConstant.loginLogo,
                        width: 251,
                        height: 150,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: 32),

                      // 3. Welcome text
                      Text(
                        "Welcome to Taiyara",
                        textAlign: TextAlign.center,
                        style: theme.textTheme.headlineSmall?.copyWith(
                          color: colorScheme.onBackground,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'lao-mn',
                        ),
                      ),
                      const SizedBox(height: 12),

                      // 4. Subtitle
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Text(
                          "Discover amazing trips, compare trusted agencies, and book your next adventure in minutes.",
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: colorScheme.onBackground.withOpacity(0.7),
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),

                      // 5. Social login buttons (Google, Apple, Facebook)
                      _buildSocialButton(
                        context,
                        logo: BxAppConstant.googleLogo,
                        text: 'Continue with Google',
                        enabled: !isLoading,
                        onTap: () => context.read<BxLoginControllerBloc>().add(
                          BxLoginWithGoogle(),
                        ),
                      ),
                      const SizedBox(height: 12),
                      _buildSocialButton(
                        context,
                        logo: BxAppConstant.appleLogo,
                        text: 'Continue with Apple',
                        enabled: !isLoading,
                        onTap: () => context.read<BxLoginControllerBloc>().add(
                          BxLoginWithApple(),
                        ),
                      ),
                      const SizedBox(height: 12),
                      _buildSocialButton(
                        context,
                        logo: BxAppConstant.facebookLogo,
                        text: 'Continue with Facebook',
                        enabled: !isLoading,
                        onTap: () => context.read<BxLoginControllerBloc>().add(
                          BxLoginWithFacebook(),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // 6. Divider with OR
                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: colorScheme.onBackground.withOpacity(0.2),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              'OR',
                              style: TextStyle(
                                color: colorScheme.onBackground.withOpacity(
                                  0.6,
                                ),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              color: colorScheme.onBackground.withOpacity(0.2),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // 7. Phone number button with gradient
                      Opacity(
                        opacity: isLoading ? 0.5 : 1,
                        child: Container(
                          width: MediaQuery.of(context).size.width - 10,
                          height: 56,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF3B82F6), Color(0xFF2563EB)],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: isLoading
                                  ? null
                                  : () => context
                                        .read<BxLoginControllerBloc>()
                                        .add(BxLoginWithPhone(phoneNumber: '')),
                              borderRadius: BorderRadius.circular(16),
                              child: const Center(
                                child: Text(
                                  'Continue with Phone Number',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // 8. Security note
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.lock_outline,
                            size: 16,
                            color: colorScheme.onBackground.withOpacity(0.5),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            "Secure login • Your data is protected",
                            style: TextStyle(
                              color: colorScheme.onBackground.withOpacity(0.5),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // 9. Terms and privacy
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: TextStyle(
                              color: colorScheme.onBackground.withOpacity(0.7),
                              fontSize: 12,
                            ),
                            children: [
                              const TextSpan(
                                text: "By continuing, you agree to Tayara's ",
                              ),
                              TextSpan(
                                text: 'Terms of Service',
                                style: TextStyle(
                                  color: colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                                recognizer: null,
                              ),
                              const TextSpan(text: ' and '),
                              TextSpan(
                                text: 'Privacy Policy',
                                style: TextStyle(
                                  color: colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                                recognizer: null,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
              if (isLoading)
                const Positioned.fill(
                  child: ColoredBox(
                    color: Colors.black26,
                    child: Center(child: CircularProgressIndicator()),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  /// Helper to build a social login button with border and logo.
  Widget _buildSocialButton(
    BuildContext context, {
    required String logo,
    required String text,
    required VoidCallback onTap,
    bool enabled = true,
  }) {
    final theme = Theme.of(context);
    return Opacity(
      opacity: enabled ? 1 : 0.5,
      child: Container(
        width: MediaQuery.of(context).size.width - 10,
        height: 56,
        decoration: BoxDecoration(
          border: Border.all(
            color: theme.colorScheme.onBackground.withOpacity(0.2),
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: enabled ? onTap : null,
            borderRadius: BorderRadius.circular(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(width: 20),
                Image.asset(logo, width: 55, height: 30, fit: BoxFit.contain),
                const SizedBox(width: 40),
                Text(
                  text,
                  style: TextStyle(
                    color: theme.colorScheme.onBackground,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
