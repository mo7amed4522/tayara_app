// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/widgets/bx_booking_detail_widget/bx_booking_detail_widget_tablet.dart
// Architecture: Presentation Layer - Booking Detail Widget (Tablet)
// Purpose: Tablet UI for booking detail screen — stub, no business logic

import 'package:flutter/material.dart';
import 'bx_booking_detail_widget_mobile.dart';

class BxBookingDetailWidgetTablet extends StatelessWidget {
  final String status;
  const BxBookingDetailWidgetTablet({super.key, this.status = 'pending'});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: BxBookingDetailWidgetMobile(status: status),
        ),
      ),
    );
  }
}
