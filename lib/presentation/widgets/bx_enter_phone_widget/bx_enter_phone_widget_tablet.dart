// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/widgets/bx_enter_phone_widget/bx_enter_phone_widget_tablet.dart
// Architecture: Presentation Layer - Enter Phone Widget (Tablet)
// Purpose: Tablet UI for phone number entry screen — Figma design, no business logic

import 'package:flutter/material.dart';
import 'bx_enter_phone_widget_mobile.dart';

class BxEnterPhoneWidgetTablet extends StatelessWidget {
  const BxEnterPhoneWidgetTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: const BxEnterPhoneWidgetMobile(),
        ),
      ),
    );
  }
}
