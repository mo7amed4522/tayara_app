// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/views/bx_explore_bottom_screen/bx_explore_bottom_screen_mobile.dart
// Architecture: Presentation Layer - Explore Bottom Screen
// Purpose: Mobile explore bottom screen matching Figma design with hero carousel,
//          theme grid, popular trips, trusted agencies, bottom CTA & nav bar

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tayara/core/constant/bx_app_constant.dart';
import 'package:tayara/core/theme/bx_app_colors.dart';
import 'package:tayara/domain/model/response/bx_active_top_banner_ads_response.dart';
import 'package:tayara/domain/model/response/bx_get_explore_trips_response.dart';
import 'package:tayara/presentation/bloc/bx_explore_bottom_screen_controller/bx_explore_bottom_screen_controller_bloc.dart';

class BxExploreBottomScreenMobile extends StatelessWidget {
  const BxExploreBottomScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return const _ExploreBody();
  }
}

class _ExploreBody extends StatelessWidget {
  const _ExploreBody();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          // Top bar: search + filter
          const _TopBar(),
          const SizedBox(height: 12),
          // Scrollable content
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(child: const _HeroCarousel()),
                const SliverToBoxAdapter(child: SizedBox(height: 24)),
                const _ExploreByThemeSliver(),
                const SliverToBoxAdapter(child: SizedBox(height: 24)),
                const _PopularRightNowSliver(),
                const SliverToBoxAdapter(child: SizedBox(height: 24)),
                const _TrustedAgenciesSliver(),
                const SliverToBoxAdapter(child: SizedBox(height: 24)),
              ],
            ),
          ),
          // Bottom CTA bar
          const _BottomCtaBar(),
        ],
      ),
    );
  }
}

// ─── Top Bar (Search + Filter) ─────────────────────────────────────────────────

// ─── Top Bar (Search + Filter) ─────────────────────────────────────────────────

class _TopBar extends StatelessWidget {
  const _TopBar();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          // Search field – styled like _SearchField, responsive width
          SizedBox(
            width: MediaQuery.of(context).size.width - 105,
            height: 48,
            child: TextField(
              style: TextStyle(
                color: colorScheme.onSurface,
                fontSize: 14,
                fontFamily: 'Poppins',
              ),
              decoration: InputDecoration(
                hintText: 'Search destinations or experiences..',
                hintStyle: TextStyle(
                  color: colorScheme.onSurface.withOpacity(0.4),
                  fontSize: 14,
                  fontFamily: 'Poppins',
                ),
                suffixIcon: Icon(
                  Icons.search,
                  color: colorScheme.onSurface.withOpacity(0.4),
                  size: 20,
                ),
                filled: true,
                fillColor: colorScheme.surface,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 0,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide(color: BxAppColors.primary, width: 2),
                ),
              ),
            ),
          ),
          const SizedBox(width: 25),
          // Circular filter button – unchanged from your version
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onSecondary,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.filter_list,
              size: 16,
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Hero Carousel ─────────────────────────────────────────────────────────────

class _HeroCarousel extends StatefulWidget {
  const _HeroCarousel();

  @override
  State<_HeroCarousel> createState() => _HeroCarouselState();
}

class _HeroCarouselState extends State<_HeroCarousel> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      BxExploreBottomScreenControllerBloc,
      BxExploreBottomScreenControllerState
    >(
      builder: (context, state) {
        if (state.status == BxExploreBottomScreenControllerStatus.loading) {
          return const SizedBox(
            height: 180,
            child: Center(child: CircularProgressIndicator()),
          );
        }
        if (state.status == BxExploreBottomScreenControllerStatus.failure) {
          return const SizedBox(
            height: 180,
            child: Center(child: Text('Failed to load')),
          );
        }
        return SizedBox(
          height: 180,
          child: _HeroPageView(
            ads: state.heroAds,
            pageController: _pageController,
            onPageChanged: (index) {
              // hero carousel page changed – no BLoC event needed yet
            },
          ),
        );
      },
    );
  }
}

class _HeroPageView extends StatelessWidget {
  final List<BxActiveTopBannerAd> ads;
  final PageController pageController;
  final Function(int) onPageChanged;

  const _HeroPageView({
    required this.ads,
    required this.pageController,
    required this.onPageChanged,
  });

  Widget _buildImage(String imageUrl, {required BoxFit fit}) {
    if (imageUrl.startsWith('http')) {
      return Image.network(
        imageUrl,
        fit: fit,
        errorBuilder: (context, error, stackTrace) {
          return Image.asset(BxAppConstant.adsBackground, fit: fit);
        },
      );
    }
    return Image.asset(
      imageUrl,
      fit: fit,
      errorBuilder: (context, error, stackTrace) {
        return Image.asset(BxAppConstant.adsBackground, fit: fit);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: PageView.builder(
            controller: pageController,
            itemCount: ads.length,
            onPageChanged: onPageChanged,
            itemBuilder: (context, index) {
              final ad = ads[index];
              return ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    _buildImage(ad.bannerImageUrl ?? '', fit: BoxFit.cover),
                    // Gradient overlay
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.55),
                          ],
                          stops: const [0.4, 1.0],
                        ),
                      ),
                    ),
                    // Text content
                    Positioned(
                      left: 16,
                      bottom: 40,
                      right: 16,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            ad.overlayTitle ?? '',
                            style: textTheme.titleMedium?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            ad.overlaySubtitle ?? '',
                            style: textTheme.bodySmall?.copyWith(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        // Pagination dots
        Positioned(
          bottom: 8,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(ads.length, (index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3),
                child: Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: index == 0
                        ? Colors.white
                        : Colors.white.withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}

// ─── Explore by Theme (2×3 Grid) ───────────────────────────────────────────────

class _ExploreByThemeSliver extends StatelessWidget {
  const _ExploreByThemeSliver();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Explore by Theme',
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 12),
          BlocBuilder<
            BxExploreBottomScreenControllerBloc,
            BxExploreBottomScreenControllerState
          >(
            builder: (context, state) {
              if (state.status ==
                  BxExploreBottomScreenControllerStatus.loading) {
                return const SizedBox(
                  height: 200,
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              final topics = state.exploreTopics;
              if (topics.isEmpty) {
                return const SizedBox(
                  height: 200,
                  child: Center(child: Text('No themes available')),
                );
              }
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: topics.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 12,
                    childAspectRatio: 1.2,
                  ),
                  itemBuilder: (context, index) {
                    final topic = topics[index];
                    return _ThemeCard(
                      imageUrl: topic.imageUrl ?? '',
                      name: topic.name ?? topic.nameAr ?? '',
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ThemeCard extends StatelessWidget {
  final String imageUrl;
  final String name;

  const _ThemeCard({required this.imageUrl, required this.name});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Load image from network or asset
          imageUrl.startsWith('http')
              ? Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[300],
                      child: const Center(
                        child: Icon(Icons.image_not_supported),
                      ),
                    );
                  },
                )
              : Image.asset(
                  imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[300],
                      child: const Center(
                        child: Icon(Icons.image_not_supported),
                      ),
                    );
                  },
                ),
          // Dark gradient overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black.withOpacity(0.65)],
                stops: const [0.4, 1.0],
              ),
            ),
          ),
          // Theme name
          Positioned(
            left: 0,
            right: 17,
            bottom: 17,
            child: Text(
              name,
              textAlign: TextAlign.center,
              style: textTheme.labelSmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 17,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Popular Right Now (Horizontal Scroll) ─────────────────────────────────────

class _PopularRightNowSliver extends StatelessWidget {
  const _PopularRightNowSliver();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Popular Right Now',
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 12),
          BlocBuilder<
            BxExploreBottomScreenControllerBloc,
            BxExploreBottomScreenControllerState
          >(
            builder: (context, state) {
              if (state.status ==
                  BxExploreBottomScreenControllerStatus.loading) {
                return const SizedBox(
                  height: 180,
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              final trips = state.trendingTrips;
              if (trips.isEmpty) {
                return const SizedBox(
                  height: 180,
                  child: Center(child: Text('No trips available')),
                );
              }
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SizedBox(
                  height: 210,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: trips.length,
                    separatorBuilder: (_, _) => const SizedBox(width: 12),
                    itemBuilder: (context, index) {
                      final trip = trips[index];
                      return _PopularTripCard(trip: trip);
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _PopularTripCard extends StatelessWidget {
  final BxGetExploreTrip trip;

  const _PopularTripCard({required this.trip});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: 200,
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: trip.coverImageUrl != null && trip.coverImageUrl!.isNotEmpty
                ? Image.network(
                    trip.coverImageUrl!,
                    width: 200,
                    height: 100,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 200,
                        height: 100,
                        color: Colors.grey[300],
                        child: const Center(
                          child: Icon(Icons.image_not_supported),
                        ),
                      );
                    },
                  )
                : Container(
                    width: 200,
                    height: 100,
                    color: Colors.grey[300],
                    child: const Center(child: Icon(Icons.image_not_supported)),
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  trip.name ?? '',
                  style: textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  trip.displayPrice != null ? '\$${trip.displayPrice}' : '\$0',
                  style: textTheme.bodyMedium?.copyWith(
                    color: BxAppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.star, size: 12, color: Colors.amber),
                    const SizedBox(width: 4),
                    Text(
                      trip.rating != null
                          ? trip.rating!.toStringAsFixed(1)
                          : '0.0',
                      style: textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurface.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Trusted Agencies (Horizontal Scroll) ─────────────────────────────────────

class _TrustedAgenciesSliver extends StatelessWidget {
  const _TrustedAgenciesSliver();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Trusted Agencies',
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 12),
          const _TrustedAgenciesList(),
        ],
      ),
    );
  }
}

class _TrustedAgenciesList extends StatelessWidget {
  const _TrustedAgenciesList();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      BxExploreBottomScreenControllerBloc,
      BxExploreBottomScreenControllerState
    >(
      builder: (context, state) {
        if (state.status == BxExploreBottomScreenControllerStatus.loading) {
          return const SizedBox(
            height: 200,
            child: Center(child: CircularProgressIndicator()),
          );
        }
        final agents = state.topAgents;
        if (agents.isEmpty) {
          return const SizedBox(
            height: 200,
            child: Center(child: Text('No agencies available')),
          );
        }
        return SizedBox(
          height: 200,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: agents.length,
              separatorBuilder: (_, _) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final agent = agents[index];
                return _AgencyCard(
                  name: agent.companyName ?? 'Unknown',
                  rating: agent.averageRating?.toStringAsFixed(1) ?? '0.0',
                  imageUrl: agent.headerImg ?? agent.backgroundImage ?? '',
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class _AgencyCard extends StatelessWidget {
  final String name;
  final String rating;
  final String imageUrl;

  const _AgencyCard({
    required this.name,
    required this.rating,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: 180,
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          // Circular logo from image URL
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: BxAppColors.primary.withOpacity(0.12),
            ),
            child: ClipOval(
              child: imageUrl.isNotEmpty
                  ? Image.network(
                      imageUrl,
                      width: 56,
                      height: 56,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(
                          child: Text(
                            'logo',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: BxAppColors.primary,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        );
                      },
                    )
                  : const Center(
                      child: Text(
                        'logo',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: BxAppColors.primary,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            name,
            style: textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
              fontSize: 10.sp,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.star, size: 14, color: Colors.amber),
              const SizedBox(width: 2),
              Text(
                rating,
                style: textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurface,
                  fontFamily: 'Poppins',
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            child: TextButton(
              onPressed: () {},
              child: Text(
                "View Agencies",
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Bottom CTA Bar ────────────────────────────────────────────────────────────

class _BottomCtaBar extends StatelessWidget {
  const _BottomCtaBar();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "Didn't find what you need ?",
              style: textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.w100,
                fontFamily: 'Poppins',
              ),
            ),
          ),
          const SizedBox(width: 12),
          SizedBox(
            width: 180,
            height: 40,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: BxAppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                textStyle: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
              ),
              child: Row(
                children: [
                  Image.asset(BxAppConstant.buildCustomTrip),
                  const SizedBox(width: 5),
                  const Text('Build Custom Plan'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
