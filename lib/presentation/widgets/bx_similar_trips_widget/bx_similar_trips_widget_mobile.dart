// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/widgets/bx_similar_trips_widget/bx_similar_trips_widget_mobile.dart
// Architecture: Presentation Layer - Similar Trips Widget (Mobile)
// Purpose: Mobile UI for similar trips screen — shows trip cards in a grid

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:tayara/core/theme/bx_app_colors.dart';

class BxSimilarTripsWidgetMobile extends StatelessWidget {
  const BxSimilarTripsWidgetMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final trips = const [
      {'name': 'Bali Paradise 5D/4N', 'price': '\$890', 'rating': '4.8', 'reviews': '210', 'image': 'assets/images/recommend_image1.png'},
      {'name': 'Paris Romance 4D/3N', 'price': '\$1,100', 'rating': '4.9', 'reviews': '185', 'image': 'assets/images/recommend_image2.png'},
      {'name': 'Tokyo Discovery 6D/5N', 'price': '\$1,350', 'rating': '4.7', 'reviews': '142', 'image': 'assets/images/recommend_image1.png'},
      {'name': 'Dubai Luxury 5D/4N', 'price': '\$1,500', 'rating': '4.9', 'reviews': '98', 'image': 'assets/images/recommend_image2.png'},
      {'name': 'Istanbul Cultural 4D/3N', 'price': '\$780', 'rating': '4.6', 'reviews': '167', 'image': 'assets/images/recommend_image1.png'},
      {'name': 'Santorini Sunset 3D/2N', 'price': '\$1,200', 'rating': '4.8', 'reviews': '203', 'image': 'assets/images/recommend_image2.png'},
    ];

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        title: Text(
          'Similar Trips',
          style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.72,
          physics: const NeverScrollableScrollPhysics(),
          children: trips.map((trip) => _TripCard(trip: trip, textTheme: textTheme)).toList(),
        ),
      ),
    );
  }
}

class _TripCard extends StatelessWidget {
  final Map<String, String> trip;
  final TextTheme textTheme;
  const _TripCard({required this.trip, required this.textTheme});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.07),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            Expanded(
              flex: 3,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.asset(
                  trip['image']!,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => Container(
                    color: const Color(0xFFF3F4F6),
                    child: const Icon(Icons.tour, color: Color(0xFF9CA3AF), size: 32),
                  ),
                ),
              ),
            ),
            // Info
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    trip['name']!,
                    style: textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF111827),
                      fontFamily: 'lao-mn',
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.star, size: 12, color: Color(0xFFF59E0B)),
                      const SizedBox(width: 2),
                      Text(
                        '${trip['rating']} (${trip['reviews']})',
                        style: textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurface.withOpacity(0.5),
                          fontFamily: 'lao-mn',
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Text(
                    trip['price']!,
                    style: textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: BxAppColors.primary,
                      fontFamily: 'lao-mn',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
