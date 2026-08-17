// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/views/bx_home_bottom_screen/bx_home_bottom_screen_mobile.dart
// Architecture: Presentation Layer - Bx Home Bottom Screen
// Purpose: Mobile home bottom screen implementation

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
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      color: colorScheme.background,
      child: SafeArea(
        child: Column(
          children: [
            // Fixed header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: const _Header(),
            ),
            // Scrollable content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 4,
                ),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const _SearchField(),
                      const SizedBox(height: 16),
                      const _CategoryChips(),
                      const SizedBox(height: 16),
                      const _AdCarousel(),
                      const SizedBox(height: 16),
                      Text(
                        'Discover Destinations',
                        style: textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'lao-mn',
                        ),
                      ),
                      const SizedBox(height: 12),
                      const _DestinationGrid(),
                      const SizedBox(height: 24),
                      Text(
                        'Top Deals',
                        style: textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'lao-mn',
                        ),
                      ),
                      const SizedBox(height: 12),
                      const _TopDealsList(),
                      const SizedBox(height: 16),
                      Center(child: const _InsightCard()),
                      const SizedBox(height: 24),
                      Text(
                        'Top Rated Agencies',
                        style: textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'lao-mn',
                        ),
                      ),
                      const SizedBox(height: 12),
                      const _AgenciesList(),
                      const SizedBox(height: 24),
                      Text(
                        'Recommended For You',
                        style: textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'lao-mn',
                        ),
                      ),
                      const SizedBox(height: 12),
                      const _RecommendedList(),
                    ],
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

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return SizedBox(
      height: 56,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Tayara',
              style: textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                fontFamily: 'lao-mn',
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  BxAppConstant.billImage,
                  width: 24,
                  height: 24,
                  color: colorScheme.onSurface.withOpacity(0.8),
                ),
                const SizedBox(width: 12),
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: colorScheme.onSurface.withOpacity(0.8),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.person,
                      size: 14.58,
                      color: colorScheme.onPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      width: double.infinity,
      height: 52,
      child: TextField(
        style: TextStyle(color: colorScheme.onSurface, fontSize: 14),
        decoration: InputDecoration(
          hintText: 'Search destinations, trips, or agencies...',
          hintStyle: TextStyle(
            color: colorScheme.onSurface.withOpacity(0.5),
            fontSize: 14,
            fontFamily: 'lao-mn',
          ),
          suffixIcon: Icon(
            Icons.search,
            color: colorScheme.onSurface.withOpacity(0.6),
          ),
          filled: true,
          fillColor: colorScheme.surface,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
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
            borderSide: BorderSide(color: BxAppColors.primary, width: 2),
          ),
        ),
      ),
    );
  }
}

class _CategoryChips extends StatelessWidget {
  const _CategoryChips();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    const categories = [
      'All',
      'Beaches',
      'Adventure',
      'Culture',
      'Family',
      'Romantic',
    ];

    return SizedBox(
      height: 30,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(9999),
              border: Border.all(color: colorScheme.onSurface.withOpacity(0.1)),
            ),
            child: Text(
              categories[index],
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurface,
                fontFamily: 'lao-mn',
              ),
            ),
          );
        },
      ),
    );
  }
}

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
                  image: AssetImage(ad['imageUrl']!),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    left: 16,
                    bottom: 16,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          ad['title']!,
                          style: textTheme.titleMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          ad['subtitle']!,
                          style: textTheme.bodySmall?.copyWith(
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          width: 114,
                          height: 28,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                              textStyle: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            child: Text('Explore Now'),
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
                child: _buildDot(active: isActive),
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildDot({required bool active}) {
    return Container(
      width: active ? 16 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: active ? Colors.white : Colors.white.withOpacity(0.6),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}

class _DestinationGrid extends StatelessWidget {
  const _DestinationGrid();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final destinations = [
      {
        'image': BxAppConstant.swazirelandImage,
        'name': 'Santorini',
        'price': 'From \$750',
      },
      {'image': BxAppConstant.baliImage, 'name': 'Bali', 'price': 'From \$620'},
      {
        'image': BxAppConstant.pairsImage,
        'name': 'Paris',
        'price': 'From \$850',
      },
      {
        'image': BxAppConstant.tokyoImage,
        'name': 'Tokyo',
        'price': 'From \$980',
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: destinations.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 14,
        crossAxisSpacing: 12,
        childAspectRatio: 1.5,
      ),
      itemBuilder: (context, index) {
        final item = destinations[index];
        return ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Background image
              Image.asset(item['image']!, fit: BoxFit.cover),
              // Gradient overlay for better text visibility
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                    stops: const [0.5, 1.0],
                  ),
                ),
              ),
              // Text content at the bottom
              Positioned(
                left: 8,
                right: 8,
                bottom: 8,
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
                      item['price']!,
                      style: textTheme.bodySmall?.copyWith(
                        color: Colors.white.withOpacity(0.95),
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

class _TopDealsList extends StatelessWidget {
  const _TopDealsList();

  @override
  Widget build(BuildContext context) {
    const deals = [
      {
        'image': BxAppConstant.topDealsImage1,
        'name': 'Paris Escape 4D/3N',
        'price': '\$950 - \$1,050',
        'views': '18 people are viewing this trip',
      },
      {
        'image': BxAppConstant.topDealsImage2,
        'name': 'Rome Discovery 5D/4N',
        'price': '\$1,100 - \$1,250',
        'views': '12 people are viewing this trip',
      },
      {
        'image': BxAppConstant.topDealsImage1,
        'name': 'Dubai Luxury 3D/2N',
        'price': '\$600 - \$800',
        'views': '25 people are viewing this trip',
      },
    ];

    return SizedBox(
      height: 304,
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
      width: 288,
      height: 304,
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            height: 160,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
              color: colorScheme.primary.withOpacity(0.15),
            ),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    deal['image']!,
                    width: 48,
                    height: 48,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    width: 57.63,
                    height: 21,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [BxAppColors.warning, Colors.white],
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    child: const Text(
                      'Hot',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    width: 26,
                    height: 26,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.favorite_border,
                      size: 14.58,
                      color: colorScheme.error,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(
                      deal['name']!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    deal['price']!,
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${deal['views']}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurface.withOpacity(0.6),
                    ),
                  ),
                  const Spacer(),
                  Center(
                    child: SizedBox(
                      width: 256,
                      height: 36,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: BxAppColors.primary,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          textStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        child: Text(
                          'Explore Deal',
                          style: TextStyle(fontFamily: 'lao-mn'),
                        ),
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

class _InsightCard extends StatelessWidget {
  const _InsightCard();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: 400,
      height: 95,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary,
            const Color.fromARGB(255, 190, 205, 238),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 90,
                height: 87,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Image.asset(
                  BxAppConstant.eyeBirdImage,
                  width: 32,
                  height: 32,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          BxAppConstant.lightImage,
                          width: 16,
                          height: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Tayara Insight',
                          style: textTheme.bodySmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Looking for a quick escape?',
                      style: textTheme.bodySmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Check out weekend trips in UAE.',
                      style: textTheme.bodySmall?.copyWith(
                        color: BxAppColors.primaryDark,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            right: 8,
            bottom: 8,
            child: Container(
              width: 61,
              height: 22,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(4)),
              child: Image.asset(
                BxAppConstant.tayaraObjectImage,
                width: 16,
                height: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AgenciesList extends StatelessWidget {
  const _AgenciesList();

  @override
  Widget build(BuildContext context) {
    const agencies = [
      'Nile Voyages',
      'Tayara Travel',
      'Skyline Tours',
      'Oceanic',
    ];

    return SizedBox(
      height: 179,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: agencies.length,
        separatorBuilder: (_, _) => const SizedBox(width: 12),
        itemBuilder: (context, index) => _AgencyCard(name: agencies[index]),
      ),
    );
  }
}

class _AgencyCard extends StatelessWidget {
  final String name;

  const _AgencyCard({required this.name});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: 145.27,
      height: 176,
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: colorScheme.primary.withOpacity(0.1),
            ),
            child: Icon(Icons.business, color: colorScheme.primary, size: 32),
          ),
          const SizedBox(height: 8),
          Text(
            name,
            style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...List.generate(
                5,
                (_) => const Icon(Icons.star, size: 14, color: Colors.amber),
              ),
              const SizedBox(width: 4),
              Text('4.9', style: textTheme.bodySmall),
            ],
          ),
          const SizedBox(height: 8),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              foregroundColor: BxAppColors.primary,
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
            ),
            child: const Text('View Trips'),
          ),
        ],
      ),
    );
  }
}

class _RecommendedList extends StatelessWidget {
  const _RecommendedList();

  @override
  Widget build(BuildContext context) {
    const trips = [
      {
        'image': BxAppConstant.recommendImage1,
        'name': 'Thailand Getaway 8D/7N',
        'rating': '4.6 (95 reviews)',
        'price': 'From \$680',
      },
      {
        'image': BxAppConstant.recommendImage2,
        'name': 'Maldives Honeymoon 5D/4N',
        'rating': '4.8 (120 reviews)',
        'price': 'From \$1,200',
      },
      {
        'image': BxAppConstant.recommendImage1,
        'name': 'Japan Discovery 6D/5N',
        'rating': '4.7 (80 reviews)',
        'price': 'From \$1,450',
      },
    ];

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: trips.length,
      separatorBuilder: (_, _) => const SizedBox(height: 12),
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
      height: 88,
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 96,
            height: 88,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.horizontal(left: Radius.circular(16)),
              color: Color(0xFFE0E0E0),
            ),
            child: Image.asset(trip['image']!, fit: BoxFit.cover),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    trip['name']!,
                    style: textTheme.titleSmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.star, size: 14, color: Colors.amber),
                      const SizedBox(width: 4),
                      Text(trip['rating']!, style: textTheme.bodySmall),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    trip['price']!,
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.bold,
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
