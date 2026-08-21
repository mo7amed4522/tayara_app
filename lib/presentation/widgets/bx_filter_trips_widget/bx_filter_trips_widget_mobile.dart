// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/widgets/bx_filter_trips_widget/bx_filter_trips_widget_mobile.dart
// Architecture: Presentation Layer - Filter Trips Widget (Mobile)
// Purpose: Mobile UI for filter trips screen

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:tayara/core/theme/bx_app_colors.dart';

class BxFilterTripsWidgetMobile extends StatelessWidget {
  const BxFilterTripsWidgetMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        title: Text(
          'Filter Trips',
          style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              'Reset',
              style: TextStyle(color: BxAppColors.primary, fontFamily: 'lao-mn'),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Destination filter
            _filterSection(context, 'Destination'),
            const SizedBox(height: 8),
            _filterChips(context, ['All', 'Bali', 'Paris', 'Tokyo', 'Dubai']),
            const SizedBox(height: 20),
            // Price range
            _filterSection(context, 'Price Range'),
            const SizedBox(height: 12),
            _priceRangeSlider(context),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('\$0', style: textTheme.bodyMedium),
                Text('\$5,000+', style: textTheme.bodyMedium),
              ],
            ),
            const SizedBox(height: 20),
            // Duration
            _filterSection(context, 'Duration'),
            const SizedBox(height: 8),
            _filterChips(context, ['Any', '1-3 Days', '4-7 Days', '8+ Days']),
            const SizedBox(height: 20),
            // Rating
            _filterSection(context, 'Minimum Rating'),
            const SizedBox(height: 8),
            _ratingChips(context),
            const SizedBox(height: 20),
            // Trip type
            _filterSection(context, 'Trip Type'),
            const SizedBox(height: 8),
            _filterChips(context, ['All', 'Adventure', 'Beach', 'Cultural', 'Family']),
            const SizedBox(height: 32),
            // Apply button
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
                  'Apply Filters',
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

  Widget _filterSection(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleSmall?.copyWith(
        fontWeight: FontWeight.bold,
        fontFamily: 'lao-mn',
      ),
    );
  }

  Widget _filterChips(BuildContext context, List<String> items) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: items.map((item) {
          final isFirst = item == items.first;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterChip(
              label: Text(item, style: const TextStyle(fontFamily: 'lao-mn')),
              selected: isFirst,
              onSelected: (_) {},
              backgroundColor: Theme.of(context).colorScheme.surface,
              selectedColor: BxAppColors.primary.withOpacity(0.12),
              checkmarkColor: BxAppColors.primary,
              labelStyle: TextStyle(
                color: isFirst ? BxAppColors.primary : Theme.of(context).colorScheme.onSurface,
                fontWeight: isFirst ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _priceRangeSlider(BuildContext context) {
    return Slider(
      value: 0.5,
      min: 0,
      max: 1,
      activeColor: BxAppColors.primary,
      onChanged: (_) {},
    );
  }

  Widget _ratingChips(BuildContext context) {
    return Row(
      children: [4, 3, 2, 1].map((stars) {
        return Padding(
          padding: const EdgeInsets.only(right: 8),
          child: FilterChip(
            label: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ...List.generate(stars, (_) => const Icon(Icons.star, size: 14, color: Colors.amber)),
                const SizedBox(width: 4),
                Text('$stars+', style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
            selected: stars == 4,
            onSelected: (_) {},
            backgroundColor: Theme.of(context).colorScheme.surface,
            selectedColor: BxAppColors.primary.withOpacity(0.12),
            checkmarkColor: BxAppColors.primary,
          ),
        );
      }).toList(),
    );
  }
}
