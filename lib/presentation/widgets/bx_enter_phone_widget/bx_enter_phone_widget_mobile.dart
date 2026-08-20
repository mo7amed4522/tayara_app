// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/widgets/bx_enter_phone_widget/bx_enter_phone_widget_mobile.dart
// Architecture: Presentation Layer - Enter Phone Widget (Mobile)
// Purpose: Mobile UI for phone number entry screen — Figma design, no business logic

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:tayara/core/theme/bx_app_colors.dart';

class BxEnterPhoneWidgetMobile extends StatelessWidget {
  const BxEnterPhoneWidgetMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final tt = theme.textTheme;

    return Scaffold(
      backgroundColor: cs.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 48),
              // Back button
              Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: cs.surface,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.arrow_back,
                      color: BxAppColors.muted,
                    ),
                  ),
                ),
              ),
              const Spacer(),

              // Phone icon
              Container(
                width: 88,
                height: 88,
                decoration: BoxDecoration(
                  color: BxAppColors.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.phone, size: 44, color: BxAppColors.primary),
              ),
              const SizedBox(height: 24),

              Text(
                'Enter Phone Number',
                style: tt.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'lao-mn',
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'We will send you a verification code',
                style: tt.bodyMedium?.copyWith(
                  color: cs.onSurface.withOpacity(0.6),
                ),
              ),
              const SizedBox(height: 32),

              // Phone input
              Container(
                decoration: BoxDecoration(
                  color: cs.surface,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        border: Border(
                          right: BorderSide(
                            color: cs.onSurface.withOpacity(0.12),
                          ),
                        ),
                      ),
                      child: const Text(
                        '+20',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          hintText: '1xx xxx xxxx',
                          border: InputBorder.none,
                          hintStyle: TextStyle(color: BxAppColors.mutedLight),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),

              // Send OTP button
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
                    'Send OTP',
                    style: tt.labelLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'lao-mn',
                    ),
                  ),
                ),
              ),

              const Spacer(),
              Text(
                'This number is already registered',
                style: tt.bodySmall?.copyWith(
                  color: cs.onSurface.withOpacity(0.5),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
