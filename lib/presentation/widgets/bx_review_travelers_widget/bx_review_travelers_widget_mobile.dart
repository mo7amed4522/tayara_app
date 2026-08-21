// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/widgets/bx_review_travelers_widget/bx_review_travelers_widget_mobile.dart
// Architecture: Presentation Layer - Review Travelers Widget (Mobile)
// Purpose: Mobile UI for review travelers screen — shows traveler reviews and ratings

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:tayara/core/theme/bx_app_colors.dart';

class BxReviewTravelersWidgetMobile extends StatelessWidget {
  const BxReviewTravelersWidgetMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final reviews = const [
      {'name': 'Ahmed M.', 'avatar': 'A', 'rating': '5.0', 'date': '2 weeks ago', 'text': 'Absolutely amazing trip! The guide was knowledgeable and the itinerary was well planned. Highly recommend!'},
      {'name': 'Sarah K.', 'avatar': 'S', 'rating': '4.5', 'date': '1 month ago', 'text': 'Great experience overall. The hotels were comfortable and the activities were fun. Only minor issue was the flight schedule.'},
      {'name': 'Mohamed R.', 'avatar': 'M', 'rating': '5.0', 'date': '1 month ago', 'text': 'Best trip I have ever taken with Tayara. Everything was perfect from start to finish. Will definitely book again!'},
      {'name': 'Lisa T.', 'avatar': 'L', 'rating': '4.0', 'date': '2 months ago', 'text': 'Good value for money. The destinations were beautiful and the group was friendly. Would love to see more free time in the itinerary.'},
      {'name': 'Omar H.', 'avatar': 'O', 'rating': '5.0', 'date': '3 months ago', 'text': 'Wonderful memories made on this trip. The local guides added so much value. Thank you Tayara!'},
    ];

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        title: Text(
          'Review Travelers',
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
            _ratingSummary(context, textTheme),
            const SizedBox(height: 20),
            Text(
              'All Reviews',
              style: textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
                fontFamily: 'lao-mn',
              ),
            ),
            const SizedBox(height: 12),
            ...reviews.map((review) => _reviewCard(
              context,
              name: review['name']!,
              avatar: review['avatar']!,
              rating: review['rating']!,
              date: review['date']!,
              text: review['text']!,
            )),
          ],
        ),
      ),
    );
  }

  Widget _ratingSummary(BuildContext context, TextTheme textTheme) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(20),
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
          Column(
            children: [
              Text(
                '4.8',
                style: textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: BxAppColors.primary,
                  fontFamily: 'lao-mn',
                ),
              ),
              const SizedBox(height: 4),
              const Row(
                children: [
                  Icon(Icons.star, size: 16, color: Color(0xFFF59E0B)),
                  Icon(Icons.star, size: 16, color: Color(0xFFF59E0B)),
                  Icon(Icons.star, size: 16, color: Color(0xFFF59E0B)),
                  Icon(Icons.star, size: 16, color: Color(0xFFF59E0B)),
                  Icon(Icons.star_half, size: 16, color: Color(0xFFF59E0B)),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                'Based on 210 reviews',
                style: textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurface.withOpacity(0.5),
                  fontFamily: 'lao-mn',
                ),
              ),
            ],
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              children: [
                _ratingBar(context, '5', 80),
                _ratingBar(context, '4', 15),
                _ratingBar(context, '3', 3),
                _ratingBar(context, '2', 1),
                _ratingBar(context, '1', 1),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _ratingBar(BuildContext context, String stars, int percentage) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Text(
            stars,
            style: TextStyle(
              fontSize: 12,
              color: colorScheme.onSurface,
              fontFamily: 'lao-mn',
            ),
          ),
          const SizedBox(width: 4),
          const Icon(Icons.star, size: 12, color: Color(0xFFF59E0B)),
          const SizedBox(width: 8),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: percentage / 100,
                minHeight: 6,
                backgroundColor: colorScheme.onSurface.withOpacity(0.1),
                valueColor: AlwaysStoppedAnimation<Color>(BxAppColors.primary),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '$percentage%',
            style: TextStyle(
              fontSize: 11,
              color: colorScheme.onSurface,
              fontFamily: 'lao-mn',
            ),
          ),
        ],
      ),
    );
  }

  IconData _starIcon(double rating, int index) {
    if (index < rating.round()) return Icons.star;
    if (index < rating) return Icons.star_half;
    return Icons.star_border;
  }

  Widget _reviewCard(
    BuildContext context, {
    required String name,
    required String avatar,
    required String rating,
    required String date,
    required String text,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final ratingValue = double.parse(rating);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: BxAppColors.primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                avatar,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: BxAppColors.primary,
                  fontFamily: 'lao-mn',
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      name,
                      style: textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontFamily: 'lao-mn',
                      ),
                    ),
                    Text(
                      date,
                      style: textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurface.withOpacity(0.4),
                        fontFamily: 'lao-mn',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    for (int i = 0; i < 5; i++)
                      Icon(
                        _starIcon(ratingValue, i),
                        size: 14,
                        color: const Color(0xFFF59E0B),
                      ),
                    const SizedBox(width: 6),
                    Text(
                      rating,
                      style: textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurface.withOpacity(0.6),
                        fontFamily: 'lao-mn',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  text,
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurface.withOpacity(0.75),
                    fontFamily: 'lao-mn',
                    height: 1.4,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
