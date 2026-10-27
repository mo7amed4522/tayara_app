// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/widgets/bx_agencies_widget/bx_agencies_widget_mobile.dart
// Architecture: Presentation Layer - Agencies Widget (Mobile)
// Purpose: Mobile UI for agency profile screen — Figma design, no business logic

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tayara/core/theme/bx_app_colors.dart';
import 'package:tayara/core/widgets/bx_safe_network_image.dart';
import 'package:tayara/domain/model/response/bx_agent_profile_details_response.dart';
import 'package:tayara/presentation/bloc/bx_agencies_detail_screen_controller/bx_agencies_detail_screen_controller_bloc.dart';

class BxAgenciesWidgetMobile extends StatelessWidget {
  const BxAgenciesWidgetMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: cs.background,
      body:
          BlocBuilder<
            BxAgenciesDetailScreenControllerBloc,
            BxAgenciesDetailScreenControllerState
          >(
            builder: (context, state) {
              switch (state.status) {
                case BxAgenciesDetailScreenControllerStatus.initial:
                case BxAgenciesDetailScreenControllerStatus.loading:
                  return const Center(child: CircularProgressIndicator());
                case BxAgenciesDetailScreenControllerStatus.failure:
                  return _ErrorView(
                    message: state.errorMessage ?? 'Something went wrong',
                    onRetry: () => context
                        .read<BxAgenciesDetailScreenControllerBloc>()
                        .add(BxLoadAgentProfileDetails(agentId: state.agentId)),
                  );
                case BxAgenciesDetailScreenControllerStatus.success:
                  final agent = state.agent;
                  if (agent == null) {
                    return const Center(child: Text('No agent data available'));
                  }
                  return CustomScrollView(
                    slivers: [
                      _HeroSliver(backgroundUrl: agent.backgroundImage),
                      SliverToBoxAdapter(child: _AgencyHeader(agent: agent)),
                      SliverToBoxAdapter(
                        child: _AboutAgencySection(agent: agent),
                      ),
                      const SliverToBoxAdapter(child: _CustomPlanPromoCard()),
                      SliverToBoxAdapter(
                        child: _TripPackagesSection(
                          packages: state.filteredPackages,
                          selectedCategory: state.selectedCategory,
                          onCategoryChanged: (category) => context
                              .read<BxAgenciesDetailScreenControllerBloc>()
                              .add(BxChangePackageFilter(category: category)),
                        ),
                      ),
                      const SliverToBoxAdapter(child: _TayaraInsightBanner()),
                      SliverToBoxAdapter(
                        child: _ReviewsSection(
                          reviews: state.reviews,
                          averageRating: state.reviewAvgRating ?? 0.0,
                          reviewTotal: state.reviewTotal,
                        ),
                      ),
                      const SliverToBoxAdapter(child: SizedBox(height: 100)),
                    ],
                  );
              }
            },
          ),
    );
  }
}

class _HeroSliver extends StatelessWidget {
  const _HeroSliver({this.backgroundUrl});
  final String? backgroundUrl;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return SliverAppBar(
      expandedHeight: 220,
      pinned: true,
      backgroundColor: cs.background,
      elevation: 0,
      leading: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.35),
          shape: BoxShape.circle,
        ),
        child: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 22),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
      ),
      actions: [
        Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.35),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: const Icon(Icons.share, color: Colors.white, size: 20),
            onPressed: () {},
          ),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: BxSafeNetworkImage(
          url: backgroundUrl,
          fallbackAsset: 'assets/images/top_deals_image1.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Section 2: Agency Header
// ─────────────────────────────────────────────────────────────────────────────

class _AgencyHeader extends StatelessWidget {
  const _AgencyHeader({required this.agent});
  final BxAgentProfileAgent agent;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    final name = agent.companyName ?? '';
    final location = [
      agent.city,
      agent.country,
    ].where((e) => e != null && e.isNotEmpty).join(', ');
    final rating = agent.averageRating ?? 0;
    final reviewCount = agent.reviewCount ?? 0;
    final tripCount = agent.trustedTravelersCount ?? 0;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: BxAppColors.primary.withOpacity(0.12),
                  shape: BoxShape.circle,
                  border: Border.all(color: BxAppColors.primary, width: 1.5),
                ),
                child: (agent.headerImg ?? '').startsWith('http')
                    ? ClipOval(
                        child: Image.network(
                          agent.headerImg!,
                          fit: BoxFit.cover,
                          errorBuilder: (_, _, _) => const Icon(
                            Icons.business,
                            color: BxAppColors.primary,
                            size: 28,
                          ),
                        ),
                      )
                    : const Icon(
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
                        Flexible(
                          child: Text(
                            name,
                            style: tt.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'lao-mn',
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 6),
                        if (agent.status == 'active')
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
                    if (location.isNotEmpty)
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 14,
                            color: BxAppColors.muted,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            location,
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
          Row(
            children: [
              Row(children: List.generate(5, (i) => _starIcon(i, rating))),
              const SizedBox(width: 8),
              Text(
                rating.toStringAsFixed(1),
                style: tt.titleSmall?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 4),
              Text(
                '($reviewCount reviews)',
                style: tt.bodySmall?.copyWith(
                  color: cs.onSurface.withOpacity(0.5),
                ),
              ),
              const Spacer(),
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
                  '$tripCount travellers',
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
  const _AboutAgencySection({required this.agent});
  final BxAgentProfileAgent agent;

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
            agent.longDescription ?? agent.shortDescription ?? '',
            style: tt.bodyMedium?.copyWith(
              color: cs.onSurface.withOpacity(0.7),
              height: 1.6,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              _statItem(
                context,
                '${agent.trustedCount ?? 0}+',
                'Trusted',
                tt,
                cs,
              ),
              const SizedBox(width: 24),
              _statItem(
                context,
                '${agent.trustedTravelersCount ?? 0}+',
                'Happy Clients',
                tt,
                cs,
              ),
              const SizedBox(width: 24),
              _statItem(
                context,
                '${agent.reviewCount ?? 0}',
                'Reviews',
                tt,
                cs,
              ),
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
class _TripPackagesSection extends StatelessWidget {
  const _TripPackagesSection({
    required this.packages,
    required this.selectedCategory,
    required this.onCategoryChanged,
  });

  final List<BxAgentProfilePackage> packages;
  final String selectedCategory;
  final ValueChanged<String> onCategoryChanged;

  static const _tabs = [
    'All',
    'cultural',
    'adventure',
    'beach',
    'family',
    'luxury',
    'safari',
    'city_break',
    'religious',
  ];

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
          SizedBox(
            height: 36,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _tabs.length,
              separatorBuilder: (_, _) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final tab = _tabs[index];
                final isSelected =
                    tab.toLowerCase() == selectedCategory.toLowerCase();
                return GestureDetector(
                  onTap: () => onCategoryChanged(tab),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected ? BxAppColors.primary : cs.surface,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected
                            ? BxAppColors.primary
                            : cs.onSurface.withOpacity(0.15),
                      ),
                    ),
                    child: Text(
                      _prettyLabel(tab),
                      style: tt.labelMedium?.copyWith(
                        color: isSelected ? Colors.white : cs.onSurface,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          if (packages.isEmpty)
            const SizedBox(
              height: 120,
              child: Center(child: Text('No packages in this category')),
            )
          else
            ...packages.map((p) => _TripCard(trip: p)),
        ],
      ),
    );
  }

  String _prettyLabel(String raw) {
    if (raw == 'All') return raw;
    return raw
        .split('_')
        .map((w) => w.isEmpty ? w : '${w[0].toUpperCase()}${w.substring(1)}')
        .join(' ');
  }
}

class _TripCard extends StatelessWidget {
  const _TripCard({required this.trip});
  final BxAgentProfilePackage trip;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    final imageUrl = trip.coverImageUrl ?? '';
    final title = trip.name ?? '';
    final route = trip.destination ?? trip.location ?? '';
    final duration = trip.timeDisplay ?? '';
    final rating = trip.rating ?? 0;
    final reviews = trip.reviewCount ?? 0;
    final price = trip.displayPrice ?? trip.salePrice ?? 0;
    final priceText = '\$${(price / 100).toStringAsFixed(0)}';

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
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              ),
              child: imageUrl.startsWith('http')
                  ? Image.network(
                      imageUrl,
                      width: 110,
                      height: 110,
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) => Container(
                        width: 110,
                        height: 110,
                        color: cs.surface,
                        child: const Icon(Icons.image_not_supported),
                      ),
                    )
                  : Image.asset(
                      'assets/images/top_deals_image1.png',
                      width: 110,
                      height: 110,
                      fit: BoxFit.cover,
                    ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        if (duration.isNotEmpty)
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
                              duration,
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
                          rating.toStringAsFixed(1),
                          style: tt.labelSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 2),
                        Text(
                          '($reviews)',
                          style: tt.labelSmall?.copyWith(
                            color: cs.onSurface.withOpacity(0.45),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      title,
                      style: tt.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'lao-mn',
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    if (route.isNotEmpty)
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
                              route,
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
                    Text(
                      'From $priceText',
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
  const _ReviewsSection({
    required this.reviews,
    required this.averageRating,
    required this.reviewTotal,
  });

  final List<BxAgentProfileReview> reviews;
  final double averageRating;
  final int reviewTotal;

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
                Column(
                  children: [
                    Text(
                      averageRating.toStringAsFixed(1),
                      style: tt.displaySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: BxAppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: List.generate(
                        5,
                        (i) => _starIcon(i, averageRating),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '$reviewTotal reviews',
                      style: tt.labelSmall?.copyWith(
                        color: cs.onSurface.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 20),
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
          ...reviews.map((r) => _ReviewCard(review: r)),
        ],
      ),
    );
  }

  Widget _starIcon(int index, double rating) => Icon(
    index < rating
        ? Icons.star
        : (index < rating.floor() + 1 && index > rating.floor()
              ? Icons.star_half
              : Icons.star_border),
    size: 14,
    color: BxAppColors.amber,
  );

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
}

class _ReviewCard extends StatelessWidget {
  const _ReviewCard({required this.review});
  final BxAgentProfileReview review;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final name = review.userName ?? 'Anonymous';
    final avatar = name.isNotEmpty ? name[0].toUpperCase() : '?';
    final rating = review.rating ?? 0;
    final dateText = _formatDate(review.createdAt);

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
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: BxAppColors.primary.withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  avatar,
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
                          name,
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
                      dateText,
                      style: tt.bodySmall?.copyWith(
                        color: cs.onSurface.withOpacity(0.45),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: List.generate(
                  5,
                  (i) => Icon(
                    Icons.star,
                    size: 14,
                    color: i < rating
                        ? BxAppColors.amber
                        : cs.onSurface.withOpacity(0.2),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            review.reviewText ?? '',
            style: tt.bodyMedium?.copyWith(
              color: cs.onSurface.withOpacity(0.75),
              height: 1.55,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(String? iso) {
    if (iso == null) return '';
    try {
      final d = DateTime.parse(iso).toLocal();
      final diff = DateTime.now().difference(d);
      if (diff.inDays >= 30) {
        final months = (diff.inDays / 30).floor();
        return '$months month${months == 1 ? '' : 's'} ago';
      }
      if (diff.inDays >= 7) {
        final weeks = (diff.inDays / 7).floor();
        return '$weeks week${weeks == 1 ? '' : 's'} ago';
      }
      if (diff.inDays >= 1) {
        return '${diff.inDays} day${diff.inDays == 1 ? '' : 's'} ago';
      }
      if (diff.inHours >= 1) {
        return '${diff.inHours} hour${diff.inHours == 1 ? '' : 's'} ago';
      }
      return 'just now';
    } catch (_) {
      return '';
    }
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message, required this.onRetry});
  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline,
              size: 48,
              color: cs.onSurface.withOpacity(0.4),
            ),
            const SizedBox(height: 12),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(color: cs.onSurface.withOpacity(0.7)),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: onRetry,
              style: ElevatedButton.styleFrom(
                backgroundColor: BxAppColors.primary,
                foregroundColor: Colors.white,
              ),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
