// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/widgets/bx_payment_widget/bx_payment_widget_mobile.dart
// Architecture: Presentation Layer - Payment Widget (Mobile)
// Purpose: Mobile UI for payment screen

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:tayara/core/theme/bx_app_colors.dart';

class BxPaymentWidgetMobile extends StatelessWidget {
  const BxPaymentWidgetMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        title: Text(
          'Payment',
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
            // Order summary
            _sectionTitle(context, 'Order Summary'),
            const SizedBox(height: 12),
            _orderRow(context, 'Trip', 'Bali Paradise 5D/4N'),
            _orderRow(context, 'Date', '15 Jan – 19 Jan 2026'),
            _orderRow(context, 'Travelers', '2 adults'),
            const Divider(height: 24),
            _orderRow(context, 'Subtotal', '\$2,000'),
            _orderRow(context, 'Service Fee', '\$300'),
            _orderRow(context, 'Taxes', '\$200'),
            const Divider(height: 24),
            _orderRow(context, 'Total', '\$2,500', isTotal: true),
            const SizedBox(height: 24),
            // Payment method
            _sectionTitle(context, 'Payment Method'),
            const SizedBox(height: 12),
            _paymentMethodCard(
              context,
              icon: Icons.credit_card,
              label: 'Credit / Debit Card',
              subtitle: 'Visa •••• 4242',
              selected: true,
            ),
            const SizedBox(height: 12),
            _paymentMethodCard(
              context,
              icon: Icons.account_balance_wallet,
              label: 'Wallet',
              subtitle: 'Balance: \$150.00',
              selected: false,
            ),
            const SizedBox(height: 12),
            _paymentMethodCard(
              context,
              icon: Icons.phone_android,
              label: 'Mobile Payment',
              subtitle: 'Pay with your phone',
              selected: false,
            ),
            const SizedBox(height: 32),
            // Pay button
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: BxAppColors.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Pay \$2,500',
                  style: TextStyle(
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

  Widget _orderRow(
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

  Widget _paymentMethodCard(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String subtitle,
    required bool selected,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected
                ? BxAppColors.primary
                : colorScheme.outline.withOpacity(0.2),
            width: selected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: selected
                  ? BxAppColors.primary
                  : colorScheme.onSurface.withOpacity(0.6),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      fontFamily: 'lao-mn',
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurface.withOpacity(0.5),
                      fontFamily: 'lao-mn',
                    ),
                  ),
                ],
              ),
            ),
            Radio<bool>(
              value: true,
              groupValue: selected,
              onChanged: (_) {},
              activeColor: BxAppColors.primary,
            ),
          ],
        ),
      ),
    );
  }
}
