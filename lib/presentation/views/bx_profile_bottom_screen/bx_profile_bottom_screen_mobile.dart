// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/views/bx_profile_bottom_screen/bx_profile_bottom_screen_mobile.dart
// Architecture: Presentation Layer - Bx Profile Bottom Screen
// Purpose: Mobile profile bottom screen implementation

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tayara/core/constant/bx_app_constant.dart';

import '../../bloc/bx_profile_bottom_screen_controller/bx_profile_bottom_screen_controller_bloc.dart';
import '../../bloc/bx_theme_controller/bx_theme_controller_bloc.dart';

class BxProfileBottomScreenMobile extends StatelessWidget {
  const BxProfileBottomScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        // Fixed top section (logo, title, button) — does not scroll
        Padding(
          padding: const EdgeInsets.only(top: 35),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 2. Top center logo
              Image.asset(BxAppConstant.settingLogo, width: 333, height: 313),
              const SizedBox(height: 16),
            ],
          ),
        ),
        // Scrollable section below the fixed header
        Expanded(
          child:
              BlocBuilder<
                BxProfileBottomScreenControllerBloc,
                BxProfileBottomScreenControllerState
              >(
                builder: (context, state) {
                  return SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // 3. Title
                        Text(
                          'Log in to start your journey',
                          textAlign: TextAlign.center,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'lao-mn',
                          ),
                        ),
                        // 4. Subtitle
                        Text(
                          'Access your trips, payments, and saved experiences',
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onBackground.withOpacity(
                              0.7,
                            ),
                            fontSize: 14,
                            fontFamily: 'lao-mn',
                          ),
                        ),
                        const SizedBox(height: 10),
                        // 5. Log In / Sign Up button
                        SizedBox(
                          width: 324,
                          height: 48,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: theme.colorScheme.primary,
                              foregroundColor: theme.colorScheme.onPrimary,
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ),
                            child: Text(
                              'Log In / Sign Up',
                              style: theme.textTheme.labelLarge?.copyWith(
                                color: theme.colorScheme.onPrimary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),
                        // 6. My Bookings card
                        _buildProfileCard(
                          context,
                          shadowColor: theme.colorScheme.primary,
                          icon: Icons.calendar_today,
                          iconColor: theme.colorScheme.primary,
                          text: 'My Bookings',
                          trailing: Icon(
                            Icons.lock,
                            size: 18,
                            color: theme.colorScheme.onSurface.withOpacity(0.6),
                          ),
                        ),
                        const SizedBox(height: 12),
                        // 7. Payments & Wallet card
                        _buildProfileCard(
                          context,
                          shadowColor: const Color(0xFF10B981),
                          icon: Icons.account_balance_wallet,
                          iconColor: const Color(0xFF10B981),
                          text: 'Payments & Wallet',
                          trailing: Icon(
                            Icons.lock,
                            size: 18,
                            color: theme.colorScheme.onSurface.withOpacity(0.6),
                          ),
                        ),
                        const SizedBox(height: 12),
                        // 8. Dark/Light mode card
                        _buildProfileCard(
                          context,
                          shadowColor: theme.colorScheme.primary,
                          icon: Icons.brightness_6,
                          iconColor: theme.colorScheme.primary,
                          text: 'Dark/Light mode',
                          trailing: Icon(
                            state.isDarkMode
                                ? Icons.light_mode_outlined
                                : Icons.dark_mode_outlined,
                            size: 18,
                            color: theme.colorScheme.onSurface.withOpacity(0.6),
                          ),
                          onTap: () {
                            final isDark = context
                                .read<BxProfileBottomScreenControllerBloc>()
                                .state
                                .isDarkMode;
                            context
                                .read<BxProfileBottomScreenControllerBloc>()
                                .add(BxToggleProfileThemeEvent());
                            context.read<BxThemeControllerBloc>().add(
                              BxChangeThemeEvent(
                                isDark ? ThemeMode.light : ThemeMode.dark,
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 12),
                        // 9. Saved Trips card
                        _buildProfileCard(
                          context,
                          shadowColor: const Color(0xFFFFEDD5),
                          icon: Icons.favorite,
                          iconColor: const Color(0xFFFFEDD5),
                          text: 'Saved Trips',
                          trailing: Icon(
                            Icons.keyboard_arrow_down,
                            size: 20,
                            color: theme.colorScheme.onSurface.withOpacity(0.6),
                          ),
                        ),
                        const SizedBox(height: 32),
                        // 10. Settings & Support section header
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Settings & Support',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        // 11. Notifications row
                        _buildSettingsRow(
                          context,
                          icon: Icons.notifications,
                          iconColor: theme.colorScheme.primary,
                          text: 'Notifications',
                          trailing: const Icon(Icons.chevron_right),
                        ),
                        // 12. Settings row
                        _buildSettingsRow(
                          context,
                          icon: Icons.settings,
                          iconColor: theme.colorScheme.primary,
                          text: 'Settings',
                          trailing: const Icon(Icons.chevron_right),
                        ),
                        // 13. Help & Support row
                        _buildSettingsRow(
                          context,
                          icon: Icons.help,
                          iconColor: theme.colorScheme.primary,
                          text: 'Help & Support',
                          trailing: const Icon(Icons.chevron_right),
                        ),
                        // 14. Logout row
                        _buildSettingsRow(
                          context,
                          icon: Icons.logout,
                          iconColor: const Color(0xFFDC2626),
                          text: 'Logout',
                          trailing: const Icon(Icons.chevron_right),
                        ),
                      ],
                    ),
                  );
                },
              ),
        ),
      ],
    );
  }

  Widget _buildProfileCard(
    BuildContext context, {
    required Color shadowColor,
    required IconData icon,
    required Color iconColor,
    required String text,
    required Widget trailing,
    VoidCallback? onTap,
  }) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: shadowColor.withOpacity(0.25),
              blurRadius: 20,
              offset: const Offset(0, 6),
            ),
            BoxShadow(
              color: shadowColor.withOpacity(0.12),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Icon(icon, size: 18.75, color: iconColor),
              const SizedBox(width: 12),
              Text(
                text,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              trailing,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsRow(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required String text,
    required Widget trailing,
  }) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      child: Row(
        children: [
          Icon(icon, size: 20, color: iconColor),
          const SizedBox(width: 12),
          Text(text, style: theme.textTheme.bodyMedium),
          const Spacer(),
          trailing,
        ],
      ),
    );
  }
}
