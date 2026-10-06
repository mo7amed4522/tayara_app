// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/views/bx_home_bottom_screen/bx_home_bottom_screen_mobile.dart
// Architecture: Presentation Layer - Bx Home Bottom Screen
// Purpose: Mobile home bottom screen implementation matching Figma design

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tayara/core/constant/bx_app_constant.dart';
import 'package:tayara/core/theme/bx_app_colors.dart';
import 'package:tayara/presentation/bloc/bx_home_bottom_screen_controller/bx_home_bottom_screen_controller_bloc.dart';

class BxHomeBottomScreenMobile extends StatelessWidget {
  const BxHomeBottomScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Column(
          children: [
            // Fixed header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: const _Header(),
            ),
            // Scrollable content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const _SearchField(),
                    const SizedBox(height: 16),
                    const _CategoryChips(),
                    const SizedBox(height: 16),
                    const _AdCarousel(),
                    const SizedBox(height: 20),
                    Text(
                      'Discover Destinations',
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const _DestinationGrid(),
                    const SizedBox(height: 20),
                    Text(
                      'Top Deals',
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const _TopDealsList(),
                    const SizedBox(height: 20),
                    const _InsightCard(),
                    const SizedBox(height: 20),
                    Text(
                      'Top Rated Agencies',
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const _AgenciesList(),
                    const SizedBox(height: 20),
                    Text(
                      'Recommended For You',
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const _RecommendedList(),
                    const SizedBox(height: 24),
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

// ─── Header ───────────────────────────────────────────────────────────────────

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Tayara logo text
        Text(
          'Tayara',
          style: textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: BxAppColors.primary,
            fontSize: 24,
          ),
        ),
        // Notification bell + Profile avatar
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
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
      ],
    );
  }
}

// ─── Search Field ─────────────────────────────────────────────────────────────

class _SearchField extends StatelessWidget {
  const _SearchField();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      width: double.infinity,
      height: 48,
      child: TextField(
        style: TextStyle(
          color: colorScheme.onSurface,
          fontSize: 14,
          fontFamily: 'Poppins',
        ),
        decoration: InputDecoration(
          hintText: 'Search destinations, trips, or agencies...',
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
    );
  }
}

// ─── Category Chips ───────────────────────────────────────────────────────────

class _CategoryChips extends StatelessWidget {
  const _CategoryChips();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    const categories = ['Egypt Nile Cruise', 'Bali Beach', 'Tokyo Adventure'];

    return SizedBox(
      height: 36,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final isSelected = index == 0;
          return GestureDetector(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? BxAppColors.primary : colorScheme.surface,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected
                      ? BxAppColors.primary
                      : colorScheme.onSurface.withOpacity(0.15),
                  width: 1,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: BxAppColors.primary.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ]
                    : null,
              ),
              child: Text(
                categories[index],
                style: textTheme.bodySmall?.copyWith(
                  color: isSelected ? Colors.white : colorScheme.onSurface,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// ─── Ad Carousel ──────────────────────────────────────────────────────────────

class _AdCarousel extends StatefulWidget {
  const _AdCarousel();

  @override
  State<_AdCarousel> createState() => _AdCarouselState();
}

class _AdCarouselState extends State<_AdCarousel> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    context.read<BxHomeBottomScreenControllerBloc>().add(
      const BxLoadAdsEvent(),
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
      BxHomeBottomScreenControllerBloc,
      BxHomeBottomScreenControllerState
    >(
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          height: 192,
          child: _buildBody(state),
        );
      },
    );
  }

  Widget _buildBody(BxHomeBottomScreenControllerState state) {
    switch (state.status) {
      case BxHomeBottomScreenControllerStatus.loading:
        return const Center(child: CircularProgressIndicator());
      case BxHomeBottomScreenControllerStatus.success:
        return _AdPageView(
          ads: state.ads,
          pageController: _pageController,
          currentPage: state.currentPage,
          onPageChanged: (index) {
            context.read<BxHomeBottomScreenControllerBloc>().add(
              BxAdPageChanged(pageIndex: index),
            );
          },
        );
      case BxHomeBottomScreenControllerStatus.failure:
      case BxHomeBottomScreenControllerStatus.initial:
        return const Center(child: Text('No ads available'));
    }
  }
}

class _AdPageView extends StatelessWidget {
  final List<Map<String, String>> ads;
  final PageController pageController;
  final int currentPage;
  final Function(int) onPageChanged;

  const _AdPageView({
    required this.ads,
    required this.pageController,
    required this.currentPage,
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
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image: ad['imageUrl']!.startsWith('http')
                      ? NetworkImage(ad['imageUrl']!)
                      : AssetImage(ad['imageUrl']!),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  // Content
                  Positioned(
                    left: 16,
                    bottom: 48,
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
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          ad['subtitle']!,
                          style: textTheme.bodySmall?.copyWith(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 25),
                        SizedBox(
                          height: 36,
                          width: 150,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: BxAppColors.primary,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              textStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            child: Text(ad['buttonText'] ?? 'Explore Now'),
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
          bottom: 12,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(ads.length, (index) {
              final isActive = index == currentPage;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3),
                child: _buildDot(active: isActive, context: context),
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildDot({required bool active, required BuildContext context}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: active ? 20 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: active
            ? Theme.of(context).colorScheme.primary
            : Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}

// ─── Destination Grid ─────────────────────────────────────────────────────────

class _DestinationGrid extends StatelessWidget {
  const _DestinationGrid();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final destinations = [
      {'image': BxAppConstant.baliImage, 'name': 'Bali', 'price': '\$750'},
      {'image': BxAppConstant.pairsImage, 'name': 'Paris', 'price': '\$1,200'},
      {'image': BxAppConstant.tokyoImage, 'name': 'Tokyo', 'price': '\$950'},
      {
        'image': BxAppConstant.swazirelandImage,
        'name': 'Switzerland',
        'price': '\$1,400',
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: destinations.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.85,
      ),
      itemBuilder: (context, index) {
        final item = destinations[index];
        return ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(item['image']!, fit: BoxFit.cover),
              // Gradient overlay
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.65),
                    ],
                    stops: const [0.5, 1.0],
                  ),
                ),
              ),
              // Text at bottom
              Positioned(
                left: 12,
                right: 12,
                bottom: 12,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      item['name']!,
                      style: textTheme.titleSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'From ${item['price']}',
                      style: textTheme.bodySmall?.copyWith(
                        color: Colors.white.withOpacity(0.9),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ─── Top Deals List ───────────────────────────────────────────────────────────

class _TopDealsList extends StatelessWidget {
  const _TopDealsList();

  @override
  Widget build(BuildContext context) {
    const deals = [
      {
        'image': BxAppConstant.topDealsImage1,
        'name': 'Paris Escape 4D/3N',
        'price': '\$950 - \$1,050',
        'discount': 'Save 8%',
        'views': '18',
      },
      {
        'image': BxAppConstant.topDealsImage2,
        'name': 'Rome Discovery 5D/4N',
        'price': '\$1,100 - \$1,250',
        'discount': 'Save 12%',
        'views': '24',
      },
      {
        'image': BxAppConstant.topDealsImage1,
        'name': 'Dubai Luxury 3D/2N',
        'price': '\$600 - \$800',
        'discount': 'Save 5%',
        'views': '31',
      },
    ];

    return SizedBox(
      height: 320,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: deals.length,
        separatorBuilder: (_, _) => const SizedBox(width: 12),
        itemBuilder: (context, index) => _TopDealCard(deal: deals[index]),
      ),
    );
  }
}

class _TopDealCard extends StatelessWidget {
  final Map<String, String> deal;

  const _TopDealCard({required this.deal});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: 280,
      height: 320,
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image section
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
                child: Image.asset(
                  deal['image']!,
                  width: 280,
                  height: 160,
                  fit: BoxFit.cover,
                ),
              ),
              // Discount badge
              Positioned(
                top: 10,
                left: 10,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: BxAppColors.error,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    deal['discount']!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ),
              // Wishlist heart
              Positioned(
                top: 10,
                right: 10,
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: colorScheme.surface,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.favorite_border,
                      size: 18,
                      color: BxAppColors.pink,
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    deal['name']!,
                    style: textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  // Price
                  Text(
                    deal['price']!,
                    style: textTheme.bodyMedium?.copyWith(
                      color: BxAppColors.primary,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const SizedBox(height: 4),
                  // Viewer count with eye icon
                  Row(
                    children: [
                      const Icon(
                        Icons.visibility,
                        size: 14,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${deal['views']} people are viewing this trip',
                        style: textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurface.withOpacity(0.6),
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  // Explore Deal button
                  SizedBox(
                    width: double.infinity,
                    height: 36,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: BxAppColors.primary,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        textStyle: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      child: const Text('Explore Deal'),
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

// ─── Insight Card ─────────────────────────────────────────────────────────────

class _InsightCard extends StatelessWidget {
  const _InsightCard();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      height: 110,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: BxAppColors.primary.withOpacity(0.12),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          // Bird mascot
          SizedBox(
            width: 80,
            height: 80,
            child: Image.asset(BxAppConstant.eyeBirdImage, fit: BoxFit.contain),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Badge row
                Row(
                  children: [
                    const Icon(
                      Icons.lightbulb_outline,
                      size: 14,
                      color: BxAppColors.primary,
                    ),
                    const SizedBox(width: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: BxAppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        'TAYARA INSIGHT',
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          color: BxAppColors.primary,
                          fontFamily: 'Poppins',
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                // Main text
                Text(
                  'Looking for a quick escape?',
                  style: textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    fontFamily: 'Poppins',
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Check out weekend trips in UAE.',
                  style: textTheme.bodySmall?.copyWith(
                    color: BxAppColors.primary,
                    fontSize: 12,
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Agencies List ────────────────────────────────────────────────────────────

class _AgenciesList extends StatelessWidget {
  const _AgenciesList();

  @override
  Widget build(BuildContext context) {
    const agencies = [
      {'name': 'Nile Voyages', 'rating': '4.9'},
      {'name': 'Tayara Travel', 'rating': '4.8'},
      {'name': 'Skyline Tours', 'rating': '4.7'},
      {'name': 'Oceanic', 'rating': '4.9'},
    ];

    return SizedBox(
      height: 170,
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
      width: 140,
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Circular logo placeholder
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: BxAppColors.primary.withOpacity(0.12),
            ),
            child: const Center(
              child: Text(
                'logo',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: BxAppColors.primary,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          // Name
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
          // Rating
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
          // View Trips button
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

// ─── Recommended List ─────────────────────────────────────────────────────────

class _RecommendedList extends StatelessWidget {
  const _RecommendedList();

  @override
  Widget build(BuildContext context) {
    const trips = [
      {
        'image': BxAppConstant.recommendImage1,
        'name': 'Thailand Getaway 8D/7N',
        'rating': '4.6',
        'reviews': '(95 reviews)',
        'price': 'From \$680',
      },
      {
        'image': BxAppConstant.recommendImage2,
        'name': 'Maldives Honeymoon 5D/4N',
        'rating': '4.8',
        'reviews': '(120 reviews)',
        'price': 'From \$1,200',
      },
      {
        'image': BxAppConstant.recommendImage1,
        'name': 'Japan Discovery 6D/5N',
        'rating': '4.7',
        'reviews': '(80 reviews)',
        'price': 'From \$1,450',
      },
    ];

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: trips.length,
      separatorBuilder: (_, _) => const SizedBox(height: 10),
      itemBuilder: (context, index) => _RecommendedCard(trip: trips[index]),
    );
  }
}

class _RecommendedCard extends StatelessWidget {
  final Map<String, String> trip;

  const _RecommendedCard({required this.trip});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      height: 90,
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          // Image
          ClipRRect(
            borderRadius: const BorderRadius.horizontal(
              left: Radius.circular(16),
            ),
            child: Image.asset(
              trip['image']!,
              width: 100,
              height: 90,
              fit: BoxFit.cover,
            ),
          ),
          // Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    trip['name']!,
                    style: textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.star, size: 14, color: Colors.amber),
                      const SizedBox(width: 4),
                      Text(trip['rating']!, style: textTheme.bodySmall),
                      const SizedBox(width: 4),
                      Text(
                        trip['reviews']!,
                        style: textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurface.withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    trip['price']!,
                    style: textTheme.bodyMedium?.copyWith(
                      color: BxAppColors.primary,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
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
