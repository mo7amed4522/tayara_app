// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/widgets/bx_trip_detail_widget/bx_trip_detail_widget_mobile.dart
// Architecture: Presentation Layer - Trip Detail Widget (Mobile)
// Purpose: Mobile UI for trip detail screen — Figma design, no business logic

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:tayara/core/theme/bx_app_colors.dart';

class BxTripDetailWidgetMobile extends StatelessWidget {
  const BxTripDetailWidgetMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final tt = theme.textTheme;

    return Scaffold(
      backgroundColor: cs.background,
      body: CustomScrollView(
        slivers: [
          // ── Hero image with back button ──
          SliverAppBar(
            expandedHeight: 260,
            floating: false,
            pinned: true,
            backgroundColor: cs.background,
            elevation: 0,
            leading: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.4),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 22,
              ),
            ),
            actions: [
              Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.4),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.favorite_border,
                  color: Colors.white,
                  size: 22,
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                'assets/images/top_deals_image1.png',
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),

          // ── Title, rating, agency ──
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: BxAppColors.warning,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '4D/3N',
                          style: tt.bodySmall?.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            size: 16,
                            color: BxAppColors.amber,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '4.8',
                            style: tt.bodySmall?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '(120 reviews)',
                            style: tt.bodySmall?.copyWith(
                              color: cs.onSurface.withOpacity(0.5),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Luxury Cairo Getaway – 7 Days',
                    style: tt.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'lao-mn',
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        size: 16,
                        color: BxAppColors.muted,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Cairo, Egypt',
                        style: tt.bodySmall?.copyWith(
                          color: cs.onSurface.withOpacity(0.6),
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Icon(
                        Icons.business,
                        size: 16,
                        color: BxAppColors.muted,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Nile Voyages',
                        style: tt.bodySmall?.copyWith(
                          color: cs.onSurface.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // ── Price strip ──
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: cs.surface,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: cs.primary.withOpacity(0.1),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'From',
                        style: tt.bodySmall?.copyWith(
                          color: cs.onSurface.withOpacity(0.5),
                        ),
                      ),
                      Text(
                        '\$1,250',
                        style: tt.titleLarge?.copyWith(
                          color: cs.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'per person',
                        style: tt.bodySmall?.copyWith(
                          color: cs.onSurface.withOpacity(0.5),
                        ),
                      ),
                      Row(
                        children: List.generate(
                          5,
                          (i) => const Icon(
                            Icons.star,
                            size: 14,
                            color: BxAppColors.amber,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // ── Highlights ──
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Highlights',
                    style: tt.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'lao-mn',
                    ),
                  ),
                  const SizedBox(height: 8),
                  _highlightChip(context, 'Egyptian Museum Tour', Icons.place),
                  const SizedBox(height: 6),
                  _highlightChip(context, 'Karnak Temple Complex', Icons.place),
                  const SizedBox(height: 6),
                  _highlightChip(context, 'Abu Simbel Temples', Icons.place),
                  const SizedBox(height: 6),
                  _highlightChip(
                    context,
                    'Felucca Ride at Sunset',
                    Icons.water,
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // ── Itinerary ──
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Itinerary',
                    style: tt.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'lao-mn',
                    ),
                  ),
                  const SizedBox(height: 12),
                  _itineraryDay(
                    context,
                    1,
                    'Cairo – Welcome & City Tour',
                    [
                      'Check-in and welcome aboard luxury cruiser',
                      'Evening dinner cruise on the Nile',
                    ],
                    'Dinner',
                    'Four Seasons Hotel Cairo (3 nights)',
                  ),
                  const SizedBox(height: 8),
                  _itineraryDay(
                    context,
                    2,
                    'Cairo – Egyptian Museum & Pyramids',
                    [
                      'Guided tour of the Egyptian Museum',
                      'Visit to the Great Pyramids of Giza',
                    ],
                    'Breakfast & Lunch',
                    'Four Seasons Hotel Cairo (3 nights)',
                  ),
                  const SizedBox(height: 8),
                  _itineraryDay(
                    context,
                    3,
                    'Aswan – High Dam & Unfinished Obelisk',
                    [
                      'Early departure to Abu Simbel by coach',
                      'Visit the High Dam and Unfinished Obelisk',
                    ],
                    'Breakfast',
                    'Nile Cruise – Aswan',
                  ),
                  const SizedBox(height: 8),
                  _itineraryDay(
                    context,
                    4,
                    'Luxor – West Bank & Karnak',
                    [
                      'Cross the Nile to Luxor West Bank',
                      'Visit Valley of the Kings and Karnak Temple',
                    ],
                    'Breakfast & Dinner',
                    'Nile Cruise – Luxor',
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // ── Inclusions / Exclusions ──
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: _inclusionExclusionCard(
                      context,
                      title: 'Inclusions',
                      color: BxAppColors.success,
                      items: [
                        'All accommodations',
                        'Daily breakfast & dinner',
                        'Guided tours',
                        'Airport transfers',
                      ],
                      icon: Icons.check_circle,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _inclusionExclusionCard(
                      context,
                      title: 'Exclusions',
                      color: BxAppColors.error,
                      items: [
                        'Flight tickets',
                        'Personal expenses',
                        'Optional activities',
                        'Travel insurance',
                      ],
                      icon: Icons.close,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
        decoration: BoxDecoration(
          color: cs.surface,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 16,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: SafeArea(
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Total price',
                      style: tt.bodySmall?.copyWith(
                        color: cs.onSurface.withOpacity(0.5),
                      ),
                    ),
                    Text(
                      '\$1,250',
                      style: tt.titleLarge?.copyWith(
                        color: cs.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              SizedBox(
                width: 200,
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
                    'Book This Trip',
                    style: tt.labelLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'lao-mn',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _highlightChip(BuildContext context, String label, IconData icon) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withOpacity(0.08),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: BxAppColors.primary),
          const SizedBox(width: 8),
          Text(
            label,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _itineraryDay(
    BuildContext context,
    int day,
    String title,
    List<String> activities,
    String meal,
    String hotel,
  ) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final tt = theme.textTheme;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border(left: BorderSide(color: BxAppColors.primary, width: 4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: BxAppColors.primary,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  'D$day',
                  style: tt.bodySmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: tt.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'lao-mn',
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ...activities.map(
            (a) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.circle, size: 6, color: BxAppColors.primary),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      a,
                      style: tt.bodySmall?.copyWith(
                        color: cs.onSurface.withOpacity(0.7),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(
                Icons.restaurant,
                size: 14,
                color: cs.onSurface.withOpacity(0.5),
              ),
              const SizedBox(width: 4),
              Text(
                meal,
                style: tt.bodySmall?.copyWith(
                  color: cs.onSurface.withOpacity(0.5),
                ),
              ),
              const SizedBox(width: 16),
              Icon(Icons.hotel, size: 14, color: cs.onSurface.withOpacity(0.5)),
              const SizedBox(width: 4),
              Text(
                hotel,
                style: tt.bodySmall?.copyWith(
                  color: cs.onSurface.withOpacity(0.5),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _inclusionExclusionCard(
    BuildContext context, {
    required String title,
    required Color color,
    required List<String> items,
    required IconData icon,
  }) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final tt = theme.textTheme;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: color),
              const SizedBox(width: 6),
              Text(
                title,
                style: tt.titleSmall?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(icon, size: 12, color: color),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      item,
                      style: tt.bodySmall?.copyWith(
                        color: cs.onSurface.withOpacity(0.7),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
