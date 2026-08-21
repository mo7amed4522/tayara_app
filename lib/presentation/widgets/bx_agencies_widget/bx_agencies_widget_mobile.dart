// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/widgets/bx_agencies_widget/bx_agencies_widget_mobile.dart
// Architecture: Presentation Layer - Agencies Widget (Mobile)
// Purpose: Mobile UI for agencies listing screen

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:tayara/core/theme/bx_app_colors.dart';

class BxAgenciesWidgetMobile extends StatelessWidget {
  const BxAgenciesWidgetMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        title: Text(
          'Agencies',
          style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Search bar
            SizedBox(
              width: double.infinity,
              height: 48,
              child: TextField(
                style: TextStyle(color: colorScheme.onSurface, fontSize: 14),
                decoration: InputDecoration(
                  hintText: 'Search agencies...',
                  hintStyle: TextStyle(
                    color: colorScheme.onSurface.withOpacity(0.5),
                    fontSize: 14,
                    fontFamily: 'lao-mn',
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: colorScheme.onSurface.withOpacity(0.5),
                  ),
                  filled: true,
                  fillColor: colorScheme.surface,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 0,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(9999),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(9999),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(9999),
                    borderSide: BorderSide(
                      color: BxAppColors.primary,
                      width: 2,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Agency cards
            ...List.generate(6, (index) => _agencyCard(context, index: index)),
          ],
        ),
      ),
    );
  }

  Widget _agencyCard(BuildContext context, {required int index}) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final names = [
      'Nile Voyages',
      'Tayara Travel',
      'Skyline Tours',
      'Oceanic',
      'Desert Sands',
      'Alpine Expeditions',
    ];
    final ratings = ['4.9', '4.8', '4.7', '4.9', '4.6', '4.8'];
    final tripCounts = [
      '124 trips',
      '98 trips',
      '76 trips',
      '54 trips',
      '42 trips',
      '38 trips',
    ];

    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(16),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: BxAppColors.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.business, color: BxAppColors.primary, size: 28),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    names[index],
                    style: textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'lao-mn',
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.star, size: 14, color: Colors.amber),
                      const SizedBox(width: 4),
                      Text(
                        '${ratings[index]} · ${tripCounts[index]}',
                        style: textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurface.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                backgroundColor: BxAppColors.primary.withOpacity(0.1),
                foregroundColor: BxAppColors.primary,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'View',
                style: TextStyle(
                  fontFamily: 'lao-mn',
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
