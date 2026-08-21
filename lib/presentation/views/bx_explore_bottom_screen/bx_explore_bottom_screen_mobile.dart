// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/views/bx_explore_bottom_screen/bx_explore_bottom_screen_mobile.dart
// Architecture: Presentation Layer - Explore Bottom Screen
// Purpose: Mobile explore bottom screen matching Figma design with hero carousel,
//          theme grid, popular trips, trusted agencies, bottom CTA & nav bar

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tayara/core/constant/bx_app_constant.dart';
import 'package:tayara/core/theme/bx_app_colors.dart';
import 'package:tayara/presentation/bloc/bx_explore_bottom_screen_controller/bx_explore_bottom_screen_controller_bloc.dart';

class BxExploreBottomScreenMobile extends StatelessWidget {
  const BxExploreBottomScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          BxExploreBottomScreenControllerBloc()
            ..add(const BxLoadExploreContent()),
      child: const _ExploreBody(),
    );
  }
}

class _ExploreBody extends StatelessWidget {
  const _ExploreBody();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
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
            // Bottom navigation bar
            const _BottomNavBar(),
          ],
        ),
      ),
    );
  }
}

// ─── Top Bar (Search + Filter) ─────────────────────────────────────────────────

class _TopBar extends StatelessWidget {
  const _TopBar();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          // Tayara brand
          Text(
            'Tayara',
            style: textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: BxAppColors.primary,
              fontSize: 22,
            ),
          ),
          const Spacer(),
          // Notification bell
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.notifications_outlined,
              size: 24,
              color: colorScheme.onSurface,
            ),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
          const SizedBox(width: 8),
          // Profile avatar
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: BxAppColors.primary,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.person, size: 20, color: Colors.white),
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
    context.read<BxExploreBottomScreenControllerBloc>().add(
      const BxLoadExploreContent(),
    );
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
  final List<Map<String, String>> ads;
  final PageController pageController;
  final Function(int) onPageChanged;

  const _HeroPageView({
    required this.ads,
    required this.pageController,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Stack(
      children: [
        PageView.builder(
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
                  Image.asset(ad['imageUrl']!, fit: BoxFit.cover),
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
                          ad['title']!,
                          style: textTheme.titleMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          ad['subtitle']!,
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
              final themes = state.themes;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: themes.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.75,
                  ),
                  itemBuilder: (context, index) {
                    final theme = themes[index];
                    return _ThemeCard(
                      image: theme['image']!,
                      name: theme['name']!,
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
  final String image;
  final String name;

  const _ThemeCard({required this.image, required this.name});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(image, fit: BoxFit.cover),
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
            right: 0,
            bottom: 8,
            child: Text(
              name,
              textAlign: TextAlign.center,
              style: textTheme.labelSmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 11,
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
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SizedBox(
                  height: 180,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: trips.length,
                    separatorBuilder: (_, _) => const SizedBox(width: 12),
                    itemBuilder: (context, index) {
                      final trip = trips[index];
                      return _PopularTripCard(
                        image: trip['image']!,
                        name: trip['name']!,
                        price: trip['price']!,
                        rating: trip['rating']!,
                      );
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
  final String image;
  final String name;
  final String price;
  final String rating;

  const _PopularTripCard({
    required this.image,
    required this.name,
    required this.price,
    required this.rating,
  });

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
            child: Image.asset(
              image,
              width: 200,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  price,
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
                      rating,
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
    const agencies = [
      {'name': 'Nile Voyages', 'rating': '4.9'},
      {'name': 'Tayara Travel', 'rating': '4.8'},
      {'name': 'Skyline Tours', 'rating': '4.7'},
      {'name': 'Oceanic', 'rating': '4.9'},
    ];

    return SizedBox(
      height: 150,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: agencies.length,
        separatorBuilder: (_, _) => const SizedBox(width: 12),
        itemBuilder: (context, index) => _AgencyCard(
          name: agencies[index]['name']!,
          rating: agencies[index]['rating']!,
        ),
      ),
    );
  }
}

class _AgencyCard extends StatelessWidget {
  final String name;
  final String rating;

  const _AgencyCard({required this.name, required this.rating});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: 130,
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Circular logo placeholder
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: BxAppColors.primary.withOpacity(0.12),
            ),
            child: const Center(
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
          const SizedBox(height: 8),
          Text(
            name,
            style: textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
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
            width: 80,
            height: 28,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: BxAppColors.primary,
                foregroundColor: Colors.white,
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                textStyle: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
              ),
              child: const Text('View Trips'),
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
              "Didn't find what you need?",
              style: textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.w500,
                fontFamily: 'Poppins',
              ),
            ),
          ),
          const SizedBox(width: 12),
          SizedBox(
            width: 160,
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
              child: const Text('Build Custom Plan'),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Bottom Navigation Bar ─────────────────────────────────────────────────────

class _BottomNavBar extends StatelessWidget {
  const _BottomNavBar();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Home
          _NavItem(
            icon: BxAppConstant.homeIcon,
            label: 'Home',
            isActive: false,
          ),
          // Explore – active
          _NavItem(
            icon: BxAppConstant.exploreIcon,
            label: 'Explore',
            isActive: true,
          ),
          // Bookings
          _NavItem(
            icon: BxAppConstant.bookingsIcon,
            label: 'Bookings',
            isActive: false,
          ),
          // Profile
          _NavItem(
            icon: BxAppConstant.profileIcon,
            label: 'Profile',
            isActive: false,
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final String icon;
  final String label;
  final bool isActive;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Icon – TODO: replace with active-state icon assets
        // TODO: add home_icon_active.png, explore_icon_active.png,
        //       bookings_icon_active.png, profile_icon_active.png
        SizedBox(
          width: 28,
          height: 28,
          child: Image.asset(
            icon,
            fit: BoxFit.contain,
            color: isActive
                ? BxAppColors.primary
                : colorScheme.onSurface.withOpacity(0.5),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
            color: isActive
                ? BxAppColors.primary
                : colorScheme.onSurface.withOpacity(0.5),
            fontFamily: 'Poppins',
          ),
        ),
      ],
    );
  }
}
