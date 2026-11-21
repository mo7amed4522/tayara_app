// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/views/bx_profile_bottom_screen/bx_profile_bottom_screen_mobile.dart
// Architecture: Presentation Layer - Bx Profile Bottom Screen
// Purpose: Mobile profile bottom screen implementation

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tayara/core/constant/bx_app_constant.dart';
import 'package:tayara/core/routes/bx_app_routes.dart';
import 'package:tayara/core/routes/bx_route_names.dart';
import '../../bloc/bx_profile_bottom_screen_controller/bx_profile_bottom_screen_controller_bloc.dart';
import '../../bloc/bx_theme_controller/bx_theme_controller_bloc.dart';

class BxProfileBottomScreenMobile extends StatelessWidget {
  const BxProfileBottomScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    if (BxAppData.currentUser == null) {
      return _buildLoggedOutState(context);
    } else {
      return const _LoggedInProfileView();
    }
  }

  // ===========================================================================
  // LOGGED OUT STATE
  // ===========================================================================
  Widget _buildLoggedOutState(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 35),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(BxAppConstant.settingLogo, width: 333, height: 313),
              const SizedBox(height: 16),
            ],
          ),
        ),
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
                        Text(
                          'Log in to start your journey',
                          textAlign: TextAlign.center,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'lao-mn',
                          ),
                        ),
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
                        SizedBox(
                          width: 324,
                          height: 48,
                          child: ElevatedButton(
                            onPressed: () => BxAppRouter.pushReplacement(
                              context,
                              BxRouteNames.bxLoginScreen,
                            ),
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
                        _buildSettingsRow(
                          context,
                          icon: Icons.notifications,
                          iconColor: theme.colorScheme.primary,
                          text: 'Notifications',
                          trailing: const Icon(Icons.chevron_right),
                        ),
                        _buildSettingsRow(
                          context,
                          icon: Icons.settings,
                          iconColor: theme.colorScheme.primary,
                          text: 'Settings',
                          trailing: const Icon(Icons.chevron_right),
                        ),
                        _buildSettingsRow(
                          context,
                          icon: Icons.help,
                          iconColor: theme.colorScheme.primary,
                          text: 'Help & Support',
                          trailing: const Icon(Icons.chevron_right),
                        ),
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

  // -- Helpers for Logged Out State -------------------------------------------

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

// =============================================================================
// LOGGED IN VIEW — StatelessWidget, all state handled by BLoC
// =============================================================================
class _LoggedInProfileView extends StatelessWidget {
  const _LoggedInProfileView();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocListener<
      BxProfileBottomScreenControllerBloc,
      BxProfileBottomScreenControllerState
    >(
      listenWhen: (prev, curr) =>
          (!prev.isAccountDeleted && curr.isAccountDeleted) ||
          (prev.status != BxProfileBottomScreenControllerStatus.failure &&
              curr.status == BxProfileBottomScreenControllerStatus.failure &&
              curr.errorMessage != null &&
              curr.errorMessage != prev.errorMessage),
      listener: (context, state) async {
        if (state.isAccountDeleted) {
          if (context.mounted) {
            BxAppRouter.pushReplacement(context, BxRouteNames.bxLoginScreen);
          }
          return;
        }
        if (state.errorMessage != null && state.errorMessage!.isNotEmpty) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(state.errorMessage!)));
        }
      },
      child:
          BlocBuilder<
            BxProfileBottomScreenControllerBloc,
            BxProfileBottomScreenControllerState
          >(
            builder: (context, state) {
              final isLoading =
                  state.status == BxProfileBottomScreenControllerStatus.loading;
              final headerImg =
                  state.user?.headerImg ??
                  BxAppData.currentUser?.data?.user?.headerImg ??
                  'https://i.pravatar.cc/150?img=47';
              final fullName =
                  state.user?.fullName ??
                  BxAppData.currentUser?.data?.user?.fullName ??
                  '';
              final email =
                  state.user?.email ??
                  BxAppData.currentUser?.data?.user?.email ??
                  '';

              return SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 1. Header
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 12.0,
                        ),
                        child: Center(
                          child: Text(
                            'Profile',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // 2. Avatar with Edit Icon
                      Center(
                        child: Stack(
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey.shade200,
                                image: DecorationImage(
                                  image: NetworkImage(headerImg),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: const BoxDecoration(
                                  color: Colors.blue,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.edit,
                                  size: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),

                      // 3. Name & Email
                      if (fullName.isNotEmpty)
                        Center(
                          child: Text(
                            fullName,
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      const SizedBox(height: 4),
                      Center(
                        child: Text(
                          email,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // 4. Stats Row — real counters from GET /user/profile
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildStatColumn(
                            context,
                            isLoading ? '—' : '${state.pastTrips}',
                            'Past Trips',
                            Colors.blue,
                          ),
                          Container(
                            height: 40,
                            width: 1,
                            color: Colors.grey.withOpacity(0.2),
                          ),
                          _buildStatColumn(
                            context,
                            isLoading ? '—' : '${state.upcoming}',
                            'Upcoming',
                            Colors.green,
                          ),
                          Container(
                            height: 40,
                            width: 1,
                            color: Colors.grey.withOpacity(0.2),
                          ),
                          _buildStatColumn(
                            context,
                            isLoading ? '—' : '${state.favorites}',
                            'Favorites',
                            Colors.orange,
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // 5. List Items (Cards)
                      _buildListItem(
                        context,
                        icon: Icons.calendar_month,
                        iconColor: Colors.blue,
                        iconBgColor: Colors.blue.withOpacity(0.1),
                        text: 'My Bookings',
                        trailing: const Icon(
                          Icons.chevron_right,
                          color: Colors.grey,
                        ),
                      ),
                      _buildListItem(
                        context,
                        icon: Icons.account_balance_wallet,
                        iconColor: Colors.green,
                        iconBgColor: Colors.green.withOpacity(0.1),
                        text: 'Payments & Wallet',
                        trailing: const Icon(
                          Icons.chevron_right,
                          color: Colors.grey,
                        ),
                      ),
                      _buildListItem(
                        context,
                        icon: Icons.favorite_border,
                        iconColor: Colors.orange,
                        iconBgColor: Colors.orange.withOpacity(0.1),
                        text: 'Saved Trips',
                        trailing: const Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // 6. Section header
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          'Settings & Support',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),

                      // 7. Settings List
                      _buildSettingsRow(
                        context,
                        icon: Icons.notifications_none,
                        iconColor: Colors.blue,
                        text: 'Notifications',
                        trailing: Switch(
                          value: state.isNotificationsEnabled,
                          onChanged: (_) {
                            context
                                .read<BxProfileBottomScreenControllerBloc>()
                                .add(const BxToggleNotificationsEvent());
                          },
                          activeColor: Colors.blue,
                        ),
                      ),
                      _buildSettingsRow(
                        context,
                        icon: Icons.brightness_6,
                        iconColor: theme.colorScheme.primary,
                        text: 'Dark/Light mode',
                        trailing: Switch(
                          value: state.isDarkMode,
                          onChanged: (_) {
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
                          activeColor: Colors.blue,
                        ),
                      ),
                      _buildSettingsRow(
                        context,
                        icon: Icons.settings_outlined,
                        iconColor: Colors.blue,
                        text: 'Settings',
                        trailing: const Icon(
                          Icons.chevron_right,
                          color: Colors.grey,
                        ),
                      ),
                      _buildSettingsRow(
                        context,
                        icon: Icons.headphones,
                        iconColor: Colors.blue,
                        text: 'Help & Support',
                        trailing: const Icon(
                          Icons.chevron_right,
                          color: Colors.grey,
                        ),
                      ),
                      _buildSettingsRow(
                        context,
                        icon: Icons.logout,
                        iconColor: const Color.fromARGB(255, 237, 126, 118),
                        text: 'Logout',
                        textColor: const Color.fromARGB(255, 237, 126, 118),
                        onTap: () {
                          if (context.mounted) {
                            BxAppRouter.pushReplacement(
                              context,
                              BxRouteNames.bxLoginScreen,
                            );
                          }
                        },
                        trailing: const Icon(
                          Icons.chevron_right,
                          color: Colors.grey,
                        ),
                      ),
                      _buildSettingsRow(
                        context,
                        icon: Icons.delete,
                        iconColor: Colors.red,
                        text: 'Delete Account',
                        textColor: Colors.red,
                        onTap: state.isDeleting
                            ? null
                            : () => _confirmDeleteAccount(context),
                        trailing: state.isDeleting
                            ? const SizedBox(
                                width: 18,
                                height: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : const Icon(
                                Icons.chevron_right,
                                color: Colors.grey,
                              ),
                      ),

                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              );
            },
          ),
    );
  }

  // -- Helpers for Logged In State --------------------------------------------

  Widget _buildStatColumn(
    BuildContext context,
    String value,
    String label,
    Color color,
  ) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Text(
          value,
          style: theme.textTheme.headlineSmall?.copyWith(
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildListItem(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    required String text,
    required Widget trailing,
  }) {
    final theme = Theme.of(context);
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: iconBgColor, shape: BoxShape.circle),
        child: Icon(icon, color: iconColor, size: 20),
      ),
      title: Text(
        text,
        style: theme.textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: trailing,
      onTap: () {},
    );
  }

  Widget _buildSettingsRow(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required String text,
    Color? textColor,
    required Widget trailing,
    VoidCallback? onTap,
  }) {
    final theme = Theme.of(context);
    return ListTile(
      leading: Icon(icon, color: iconColor),
      title: Text(
        text,
        style: theme.textTheme.bodyMedium?.copyWith(color: textColor),
      ),
      trailing: trailing,
      onTap: onTap ?? () {},
    );
  }

  Future<void> _confirmDeleteAccount(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        title: const Text('Delete Account'),
        content: const Text(
          'This action permanently deletes your account and cannot be undone. '
          'Are you sure you want to continue?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogCtx).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogCtx).pop(true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      context.read<BxProfileBottomScreenControllerBloc>().add(
        const BxDeleteAccountEvent(),
      );
    }
  }
}
