// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/widgets/bx_agencies_widget/bx_agencies_widget_mobile.dart
// Architecture: Presentation Layer - Agencies Widget (Mobile)
// Purpose: Mobile UI for agency profile screen — Figma design, no business logic

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:tayara/core/theme/bx_app_colors.dart';

class BxAgenciesWidgetMobile extends StatelessWidget {
  const BxAgenciesWidgetMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: cs.background,
      body: CustomScrollView(
        slivers: [
          // ── Section 1: Hero image with back & share ──
          SliverAppBar(
            expandedHeight: 220,
            floating: false,
            pinned: true,
            backgroundColor: cs.background,
            elevation: 0,
            leading: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.35),
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
                  color: Colors.black.withOpacity(0.35),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.share, color: Colors.white, size: 20),
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

          // ── Section 2: Agency header (name, verified, rating) ──
          const SliverToBoxAdapter(child: _AgencyHeader()),

          // ── Section 3: About Agency ──
          const SliverToBoxAdapter(child: _AboutAgencySection()),

          // ── Section 4: Custom Plan promo card ──
          const SliverToBoxAdapter(child: _CustomPlanPromoCard()),

          // ── Section 5: Trip Packages with filter tabs ──
          const SliverToBoxAdapter(child: _TripPackagesSection()),

          // ── Section 6: Tayara Insight banner ──
          const SliverToBoxAdapter(child: _TayaraInsightBanner()),

          // ── Section 7: Reviews & Ratings ──
          const SliverToBoxAdapter(child: _ReviewsSection()),

          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Section 2: Agency Header
// ─────────────────────────────────────────────────────────────────────────────

class _AgencyHeader extends StatelessWidget {
  const _AgencyHeader();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar + name + verified badge in a row
          Row(
            children: [
              // Agency avatar
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: BxAppColors.primary.withOpacity(0.12),
                  shape: BoxShape.circle,
                  border: Border.all(color: BxAppColors.primary, width: 1.5),
                ),
                child: const Icon(
                  Icons.business,
                  color: BxAppColors.primary,
                  size: 28,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Nile Voyages',
                          style: tt.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'lao-mn',
                          ),
                        ),
                        const SizedBox(width: 6),
                        // Verified badge
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: BxAppColors.success,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.verified,
                                color: Colors.white,
                                size: 12,
                              ),
                              const SizedBox(width: 3),
                              Text(
                                'Verified',
                                style: tt.labelSmall?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 9,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    // Location
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          size: 14,
                          color: BxAppColors.muted,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Cairo, Egypt',
                          style: tt.bodySmall?.copyWith(
                            color: cs.onSurface.withOpacity(0.55),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Rating row
          Row(
            children: [
              // Stars
              Row(children: List.generate(5, (i) => _starIcon(i, 4.8))),
              const SizedBox(width: 8),
              Text(
                '4.8',
                style: tt.titleSmall?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 4),
              Text(
                '(124 reviews)',
                style: tt.bodySmall?.copyWith(
                  color: cs.onSurface.withOpacity(0.5),
                ),
              ),
              const Spacer(),
              // Trip count badge
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: BxAppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '124 trips',
                  style: tt.bodySmall?.copyWith(
                    color: BxAppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _starIcon(int index, double rating) {
    return Icon(
      index < rating
          ? Icons.star
          : (index < rating.floor() + 1 && index > rating.floor()
                ? Icons.star_half
                : Icons.star_border),
      size: 18,
      color: BxAppColors.amber,
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Section 3: About Agency
// ─────────────────────────────────────────────────────────────────────────────

class _AboutAgencySection extends StatelessWidget {
  const _AboutAgencySection();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About Agency',
            style: tt.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              fontFamily: 'lao-mn',
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Nile Voyages is a premium travel agency based in Cairo, specializing in luxury Nile cruises, desert expeditions, and cultural tours across Egypt. With over 10 years of experience, we craft unforgettable journeys tailored to your dreams.',
            style: tt.bodyMedium?.copyWith(
              color: cs.onSurface.withOpacity(0.7),
              height: 1.6,
            ),
          ),
          const SizedBox(height: 14),
          // Stats row
          Row(
            children: [
              _statItem(context, '10+', 'Years', tt, cs),
              const SizedBox(width: 24),
              _statItem(context, '500+', 'Happy Clients', tt, cs),
              const SizedBox(width: 24),
              _statItem(context, '124', 'Trips', tt, cs),
            ],
          ),
        ],
      ),
    );
  }

  Widget _statItem(
    BuildContext context,
    String value,
    String label,
    TextTheme tt,
    ColorScheme cs,
  ) {
    return Column(
      children: [
        Text(
          value,
          style: tt.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: BxAppColors.primary,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: tt.bodySmall?.copyWith(color: cs.onSurface.withOpacity(0.5)),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Section 4: Custom Plan Promo Card
// ─────────────────────────────────────────────────────────────────────────────

class _CustomPlanPromoCard extends StatelessWidget {
  const _CustomPlanPromoCard();

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [BxAppColors.primary, BxAppColors.primaryLight],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: BxAppColors.primary.withOpacity(0.3),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.travel_explore,
                    color: Colors.white,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Custom Trip Plan',
                    style: tt.titleMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'lao-mn',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              'Tell us your dream trip and we\'ll build it just for you — custom itinerary, private guides, and exclusive experiences.',
              style: tt.bodySmall?.copyWith(
                color: Colors.white.withOpacity(0.88),
                height: 1.5,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: BxAppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 13),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Start Your Custom Plan',
                  style: tt.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
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
}

// ─────────────────────────────────────────────────────────────────────────────
// Section 5: Trip Packages with Filter Tabs
// ─────────────────────────────────────────────────────────────────────────────

class _TripPackagesSection extends StatefulWidget {
  const _TripPackagesSection();

  @override
  State<_TripPackagesSection> createState() => _TripPackagesSectionState();
}

class _TripPackagesSectionState extends State<_TripPackagesSection>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<String> _tabs = [
    'All',
    'Cruises',
    'Desert',
    'City Tours',
    'Adventure',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Trip Packages',
                style: tt.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'lao-mn',
                ),
              ),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  foregroundColor: BxAppColors.primary,
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(0, 0),
                ),
                child: Text(
                  'See All',
                  style: tt.bodySmall?.copyWith(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Filter tabs
          SizedBox(
            height: 36,
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              labelPadding: const EdgeInsets.only(right: 4),
              labelStyle: tt.labelMedium?.copyWith(
                fontWeight: FontWeight.w600,
                fontFamily: 'lao-mn',
              ),
              labelColor: cs.primary,
              unselectedLabelStyle: tt.labelMedium,
              unselectedLabelColor: cs.onSurface.withOpacity(0.5),
              indicatorColor: BxAppColors.primary,
              indicatorSize: TabBarIndicatorSize.label,
              tabs: _tabs.map((tab) => Tab(text: tab)).toList(),
            ),
          ),
          const SizedBox(height: 16),
          // Trip cards
          ...List.generate(3, (index) => _tripCard(context, index)),
        ],
      ),
    );
  }

  Widget _tripCard(BuildContext context, int index) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    final trips = [
      {
        'title': 'Luxury Nile Cruise – 5 Days',
        'route': 'Cairo → Luxor → Aswan',
        'price': '\$1,250',
        'duration': '5D/4N',
        'rating': '4.9',
        'reviews': '(86)',
        'image': 'assets/images/top_deals_image1.png',
      },
      {
        'title': 'Egyptian Wonders – 7 Days',
        'route': 'Cairo → Giza → Abu Simbel',
        'price': '\$1,890',
        'duration': '7D/6N',
        'rating': '4.8',
        'reviews': '(124)',
        'image': 'assets/images/top_deals_image2.png',
      },
      {
        'title': 'Desert Safari & Camp – 3 Days',
        'route': 'Cairo → White Desert',
        'price': '\$680',
        'duration': '3D/2N',
        'rating': '4.7',
        'reviews': '(52)',
        'image': 'assets/images/recommend_image1.png',
      },
    ];

    final trip = trips[index];

    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(16),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: cs.surface,
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
            // Image
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              ),
              child: Image.asset(
                trip['image'] as String,
                width: 110,
                height: 110,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            // Info
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Duration badge + rating
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: BxAppColors.warning.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            trip['duration'] as String,
                            style: tt.labelSmall?.copyWith(
                              color: BxAppColors.warning,
                              fontWeight: FontWeight.w600,
                              fontSize: 10,
                            ),
                          ),
                        ),
                        const Spacer(),
                        const Icon(
                          Icons.star,
                          size: 14,
                          color: BxAppColors.amber,
                        ),
                        const SizedBox(width: 3),
                        Text(
                          trip['rating'] as String,
                          style: tt.labelSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 2),
                        Text(
                          trip['reviews'] as String,
                          style: tt.labelSmall?.copyWith(
                            color: cs.onSurface.withOpacity(0.45),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    // Title
                    Text(
                      trip['title'] as String,
                      style: tt.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'lao-mn',
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    // Route
                    Row(
                      children: [
                        const Icon(
                          Icons.navigation,
                          size: 13,
                          color: BxAppColors.muted,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            trip['route'] as String,
                            style: tt.bodySmall?.copyWith(
                              color: cs.onSurface.withOpacity(0.55),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // Price
                    Text(
                      'From ${trip['price']}',
                      style: tt.titleSmall?.copyWith(
                        color: BxAppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Section 6: Tayara Insight Banner
// ─────────────────────────────────────────────────────────────────────────────

class _TayaraInsightBanner extends StatelessWidget {
  const _TayaraInsightBanner();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: cs.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: BxAppColors.border),
          boxShadow: [
            BoxShadow(
              color: cs.primary.withOpacity(0.06),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Tayara icon
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: BxAppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.insights,
                color: BxAppColors.primary,
                size: 22,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tayara Insight',
                    style: tt.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'lao-mn',
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'This agency has a 98% booking completion rate — rated "Excellent" by 124+ travelers.',
                    style: tt.bodySmall?.copyWith(
                      color: cs.onSurface.withOpacity(0.6),
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: BxAppColors.muted, size: 20),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Section 7: Reviews & Ratings
// ─────────────────────────────────────────────────────────────────────────────

class _ReviewsSection extends StatelessWidget {
  const _ReviewsSection();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section title + overall score
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Reviews & Ratings',
                style: tt.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'lao-mn',
                ),
              ),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  foregroundColor: BxAppColors.primary,
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(0, 0),
                ),
                child: Text(
                  'All Reviews',
                  style: tt.bodySmall?.copyWith(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Overall rating card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: cs.surface,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                // Big score
                Column(
                  children: [
                    Text(
                      '4.8',
                      style: tt.displaySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: BxAppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(children: List.generate(5, (i) => _starIcon(i, 4.8))),
                    const SizedBox(height: 4),
                    Text(
                      '124 reviews',
                      style: tt.labelSmall?.copyWith(
                        color: cs.onSurface.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 20),
                // Rating breakdown
                Expanded(
                  child: Column(
                    children: [
                      _ratingBar(context, tt, cs, '5', 80),
                      _ratingBar(context, tt, cs, '4', 14),
                      _ratingBar(context, tt, cs, '3', 4),
                      _ratingBar(context, tt, cs, '2', 1),
                      _ratingBar(context, tt, cs, '1', 1),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Individual review cards
          ...List.generate(2, (index) => _reviewCard(context, index)),
        ],
      ),
    );
  }

  Widget _starIcon(int index, double rating) {
    return Icon(
      index < rating
          ? Icons.star
          : (index < rating.floor() + 1 && index > rating.floor()
                ? Icons.star_half
                : Icons.star_border),
      size: 14,
      color: BxAppColors.amber,
    );
  }

  Widget _ratingBar(
    BuildContext context,
    TextTheme tt,
    ColorScheme cs,
    String rating,
    int percentage,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Text(
            rating,
            style: tt.labelSmall?.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 11,
            ),
          ),
          const SizedBox(width: 2),
          const Icon(Icons.star, size: 12, color: BxAppColors.amber),
          const SizedBox(width: 6),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: percentage / 100,
                minHeight: 6,
                borderRadius: BorderRadius.circular(4),
                color: BxAppColors.amber,
                backgroundColor: cs.onSurface.withOpacity(0.08),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '$percentage%',
            style: tt.labelSmall?.copyWith(
              color: cs.onSurface.withOpacity(0.5),
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  Widget _reviewCard(BuildContext context, int index) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    final reviews = [
      {
        'name': 'Ahmed M.',
        'avatar': 'A',
        'date': '2 weeks ago',
        'rating': 5,
        'text':
            'Amazing experience! The Nile cruise was breathtaking and the guide was incredibly knowledgeable. Highly recommend Nile Voyages for anyone visiting Egypt.',
      },
      {
        'name': 'Sara K.',
        'avatar': 'S',
        'date': '1 month ago',
        'rating': 5,
        'text':
            'Best travel agency we\'ve ever used. Everything was perfectly organized from start to finish. The desert camping trip was a highlight of our vacation!',
      },
    ];

    final review = reviews[index];

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Avatar
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: BxAppColors.primary.withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  review['avatar'] as String,
                  style: tt.labelMedium?.copyWith(
                    color: BxAppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          review['name'] as String,
                          style: tt.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: BxAppColors.success.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            'Verified',
                            style: tt.labelSmall?.copyWith(
                              color: BxAppColors.success,
                              fontWeight: FontWeight.w600,
                              fontSize: 9,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      review['date'] as String,
                      style: tt.bodySmall?.copyWith(
                        color: cs.onSurface.withOpacity(0.45),
                      ),
                    ),
                  ],
                ),
              ),
              // Stars
              Row(
                children: List.generate(
                  5,
                  (i) => Icon(
                    Icons.star,
                    size: 14,
                    color: i < (review['rating'] as int)
                        ? BxAppColors.amber
                        : cs.onSurface.withOpacity(0.2),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            review['text'] as String,
            style: tt.bodyMedium?.copyWith(
              color: cs.onSurface.withOpacity(0.75),
              height: 1.55,
            ),
          ),
        ],
      ),
    );
  }
}
