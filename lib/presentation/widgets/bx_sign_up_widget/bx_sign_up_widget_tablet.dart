// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/widgets/bx_sign_up_widget/bx_sign_up_widget_tablet.dart
// Architecture: Presentation Layer - Sign Up Widget (Tablet)
// Purpose: Tablet UI for sign up screen — Figma design, no business logic

import 'package:flutter/material.dart';
import 'bx_sign_up_widget_mobile.dart';

class BxSignUpWidgetTablet extends StatelessWidget {
  const BxSignUpWidgetTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: const BxSignUpWidgetMobile(),
        ),
      ),
    );
  }
}
