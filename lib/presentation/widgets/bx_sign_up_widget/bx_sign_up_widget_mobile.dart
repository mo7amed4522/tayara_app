// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/widgets/bx_sign_up_widget/bx_sign_up_widget_mobile.dart
// Architecture: Presentation Layer - Sign Up Widget (Mobile)
// Purpose: Mobile UI for sign up screen — Figma design, no business logic

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:tayara/core/theme/bx_app_colors.dart';

class BxSignUpWidgetMobile extends StatelessWidget {
  const BxSignUpWidgetMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final tt = theme.textTheme;

    return Scaffold(
      backgroundColor: cs.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 375),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Logo
                Image.asset(
                  'assets/images/app_logo.png',
                  width: 80,
                  height: 80,
                ),
                const SizedBox(height: 16),
                Text(
                  'Create Account',
                  style: tt.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'lao-mn',
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Join us and start your journey',
                  style: tt.bodyMedium?.copyWith(
                    color: cs.onSurface.withOpacity(0.6),
                  ),
                ),
                const SizedBox(height: 32),

                // Full Name
                _buildField(
                  context,
                  tt,
                  cs,
                  'Full Name',
                  Icons.person_outline,
                  hint: 'Enter your full name',
                ),
                const SizedBox(height: 16),

                // Email
                _buildField(
                  context,
                  tt,
                  cs,
                  'Email',
                  Icons.email_outlined,
                  hint: 'Enter your email',
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),

                // Phone
                _buildField(
                  context,
                  tt,
                  cs,
                  'Phone Number',
                  Icons.phone_outlined,
                  hint: '+20 1xx xxx xxxx',
                ),
                const SizedBox(height: 16),

                // Password
                _buildField(
                  context,
                  tt,
                  cs,
                  'Password',
                  Icons.lock_outline,
                  hint: 'Create a password',
                  obscureText: true,
                ),
                const SizedBox(height: 16),

                // Confirm Password
                _buildField(
                  context,
                  tt,
                  cs,
                  'Confirm Password',
                  Icons.lock_outline,
                  hint: 'Confirm your password',
                  obscureText: true,
                ),
                const SizedBox(height: 24),

                // Sign Up Button
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: BxAppColors.primary,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Sign Up',
                      style: tt.labelLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'lao-mn',
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Divider
                Row(
                  children: [
                    Expanded(
                      child: Divider(color: cs.onSurface.withOpacity(0.15)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        'or',
                        style: tt.bodySmall?.copyWith(
                          color: cs.onSurface.withOpacity(0.5),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(color: cs.onSurface.withOpacity(0.15)),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Social buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _socialButton('assets/images/google_logo.png'),
                    const SizedBox(width: 16),
                    _socialButton('assets/images/apple_logo.png'),
                    const SizedBox(width: 16),
                    _socialButton('assets/images/facebook_logo.png'),
                  ],
                ),
                const SizedBox(height: 32),

                // Login link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: tt.bodyMedium?.copyWith(
                        color: cs.onSurface.withOpacity(0.6),
                      ),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        'Log In',
                        style: tt.bodyMedium?.copyWith(
                          color: BxAppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildField(
    BuildContext context,
    TextTheme tt,
    ColorScheme cs,
    String label,
    IconData icon, {
    String? hint,
    TextInputType? keyboardType,
    bool obscureText = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: tt.bodySmall?.copyWith(
            color: cs.onSurface.withOpacity(0.6),
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          obscureText: obscureText,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: tt.bodySmall?.copyWith(
              color: cs.onSurface.withOpacity(0.4),
            ),
            prefixIcon: Icon(
              icon,
              size: 20,
              color: cs.onSurface.withOpacity(0.4),
            ),
            filled: true,
            fillColor: cs.surface,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: cs.onSurface.withOpacity(0.12),
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: BxAppColors.primary,
                width: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _socialButton(String assetPath) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 52,
        height: 52,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE5E7EB)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Image.asset(
          assetPath,
          width: 26,
          height: 26,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
