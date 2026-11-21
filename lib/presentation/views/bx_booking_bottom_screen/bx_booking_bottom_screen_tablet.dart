// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/views/bx_booking_bottom_screen/bx_booking_bottom_screen_tablet.dart
// Architecture: Presentation Layer - Booking Bottom Screen
// Purpose: Tablet booking bottom screen implementation

import 'package:flutter/material.dart';
import 'bx_booking_bottom_screen_mobile.dart';

class BxBookingBottomScreenTablet extends StatelessWidget {
  const BxBookingBottomScreenTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 480),
        child: const BxBookingBottomScreenMobile(),
      ),
    );
  }
}
