// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/widgets/bx_booking_detail_widget/bx_booking_detail_widget_mobile.dart
// Architecture: Presentation Layer - Booking Detail Widget
// Purpose: Mobile UI for booking detail screen

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:tayara/core/theme/bx_app_colors.dart';

class BxBookingDetailWidgetMobile extends StatelessWidget {
  final String status;
  const BxBookingDetailWidgetMobile({super.key, this.status = 'pending'});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final statusColor = status == 'confirmed'
        ? BxAppColors.success
        : status == 'pending'
        ? BxAppColors.warning
        : const Color(0xFF6B7280);

    final statusLabel = status == 'confirmed'
        ? 'Confirmed'
        : status == 'pending'
        ? 'Pending'
        : 'Expired';

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        title: Text(
          'Booking Detail',
          style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Trip image
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                'assets/images/recommend_image1.png',
                width: double.infinity,
                height: 180,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            // Title and status
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Bali Paradise 5D/4N',
                    style: textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'lao-mn',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    statusLabel,
                    style: textTheme.labelMedium?.copyWith(
                      color: statusColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              'Organized by Tayara Travel Agency',
              style: textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
            const SizedBox(height: 20),
            // Trip details
            _sectionTitle(context, 'Trip Details'),
            const SizedBox(height: 8),
            _detailRow(context, 'Departure Date', '15 Jan 2026'),
            _detailRow(context, 'Return Date', '19 Jan 2026'),
            _detailRow(context, 'Duration', '5 Days / 4 Nights'),
            _detailRow(context, 'Group Size', '12 travelers'),
            _detailRow(context, 'Guide', 'English + Arabic'),
            const SizedBox(height: 20),
            // Price breakdown
            _sectionTitle(context, 'Price Breakdown'),
            const SizedBox(height: 8),
            _priceRow(context, 'Base Price', '\$1,000'),
            _priceRow(context, 'Service Fee', '\$150'),
            _priceRow(context, 'Taxes', '\$100'),
            const Divider(height: 24),
            _priceRow(context, 'Total', '\$1,250', isTotal: true),
            const SizedBox(height: 24),
            // Action button
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: status == 'pending' ? () {} : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: BxAppColors.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  status == 'pending' ? 'Cancel Booking' : 'Booking Confirmed',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'lao-mn',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleSmall?.copyWith(
        fontWeight: FontWeight.bold,
        fontFamily: 'lao-mn',
      ),
    );
  }

  Widget _detailRow(BuildContext context, String label, String value) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: colorScheme.onSurface.withOpacity(0.6),
              fontFamily: 'lao-mn',
            ),
          ),
          Text(value, style: const TextStyle(fontFamily: 'lao-mn')),
        ],
      ),
    );
  }

  Widget _priceRow(
    BuildContext context,
    String label,
    String value, {
    bool isTotal = false,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: colorScheme.onSurface.withOpacity(isTotal ? 1.0 : 0.6),
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              fontFamily: 'lao-mn',
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: isTotal ? colorScheme.primary : colorScheme.onSurface,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              fontSize: isTotal ? 18 : 14,
              fontFamily: 'lao-mn',
            ),
          ),
        ],
      ),
    );
  }
}
