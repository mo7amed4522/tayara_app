// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/views/bx_home_bottom_screen/bx_home_bottom_screen_mobile.dart
// Architecture: Presentation Layer - Bx Home Bottom Screen
// Purpose: Mobile home bottom screen implementation matching Figma design
//          Uses BLoC for all data fetching (ads, destinations, explore trips, recommended, top deals, top agents)
// ignore_for_file: unnecessary_underscores, deprecated_member_use

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tayara/core/constant/bx_app_constant.dart';
import 'package:tayara/core/routes/bx_app_routes.dart';
import 'package:tayara/core/routes/bx_route_names.dart';
import 'package:tayara/core/theme/bx_app_colors.dart';
import 'package:tayara/domain/model/response/bx_active_top_banner_ads_response.dart';
import 'package:tayara/domain/model/response/bx_get_destinations_response.dart';
import 'package:tayara/domain/model/response/bx_get_recommended_for_customer_response.dart';
import 'package:tayara/domain/model/response/bx_get_top_agent_response.dart';
import 'package:tayara/domain/model/response/bx_get_top_deals_response.dart';
import 'package:tayara/presentation/bloc/bx_home_bottom_screen_controller/bx_home_bottom_screen_controller_bloc.dart';

class BxHomeBottomScreenMobile extends StatelessWidget {
  const BxHomeBottomScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    // Trigger initial data load when widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BxHomeBottomScreenControllerBloc>().add(
        const BxLoadHomeContentEvent(),
      );
    });

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
              child:
                  BlocBuilder<
                    BxHomeBottomScreenControllerBloc,
                    BxHomeBottomScreenControllerState
                  >(
                    builder: (context, state) {
                      return SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const _SearchField(),
                            const SizedBox(height: 16),
                            _CategoryChips(
                              destinations: state.destinations,
                              selectedCategory: state.selectedCategory,
                            ),
                            const SizedBox(height: 16),
                            Visibility(
                              visible: state.ads.isNotEmpty,
                              child: const _AdCarousel(),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              'Discover Destinations',
                              style: textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 12),
                            _DestinationGrid(
                              destinations: state.destinations,
                              selectedCategory: state.selectedCategory,
                            ),
                            const SizedBox(height: 20),
                            Text(
                              'Top Deals',
                              style: textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 12),
                            _TopDealsList(topDeals: state.topDeals),
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
                            _AgenciesList(topAgents: state.topAgents),
                            const SizedBox(height: 20),
                            Text(
                              'Recommended For You',
                              style: textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 12),
                            _RecommendedList(recommended: state.recommended),
                            const SizedBox(height: 24),
                          ],
                        ),
                      );
                    },
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

// lib/presentation/views/bx_home_bottom_screen/bx_home_bottom_screen_mobile.dart
class _SearchField extends StatefulWidget {
  const _SearchField();

  @override
  State<_SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<_SearchField> {
  final TextEditingController _controller = TextEditingController();
  Timer? _debounceTimer;
  bool _hasNavigated = false;

  @override
  void dispose() {
    _controller.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _goToSearch() {
    if (_hasNavigated) return;
    final keyword = _controller.text.trim();
    if (keyword.isEmpty) return;
    _hasNavigated = true;
    BxAppRouter.push(
      context,
      BxRouteNames.bxSearchScreen,
      arguments: {'keyword': keyword},
    );
  }

  void _onChanged(String value) {
    _hasNavigated = false;
    _debounceTimer?.cancel();
    final keyword = value.trim();
    if (keyword.isNotEmpty) {
      _debounceTimer = Timer(const Duration(milliseconds: 500), () {
        if (mounted && !_hasNavigated && _controller.text.trim() == keyword) {
          _goToSearch();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      width: double.infinity,
      height: 48,
      child: TextField(
        controller: _controller,
        textInputAction: TextInputAction.search,
        onSubmitted: (_) => _goToSearch(),
        onChanged: _onChanged,
        onTap: () {
          // Optional: navigate immediately so the user lands on the search screen.
          // _goToSearch();
        },
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
          suffixIcon: IconButton(
            icon: Icon(
              Icons.search,
              color: colorScheme.onSurface.withOpacity(0.4),
              size: 20,
            ),
            onPressed: _goToSearch,
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
  final List<BxGetDestination> destinations;
  final String? selectedCategory;

  const _CategoryChips({required this.destinations, this.selectedCategory});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    // Extract unique destination names as categories
    final categories = destinations
        .map((d) => d.name ?? '')
        .where((name) => name.isNotEmpty)
        .toSet()
        .toList();

    // Always show "All" as the first option
    final allCategories = ['All', ...categories];

    return SizedBox(
      height: 36,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: allCategories.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final category = allCategories[index];
          final isSelected = selectedCategory == null
              ? index == 0
              : selectedCategory == category;

          return GestureDetector(
            onTap: () {
              context.read<BxHomeBottomScreenControllerBloc>().add(
                BxCategorySelectedEvent(category: index == 0 ? '' : category),
              );
            },
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
                category,
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
          currentPage: state.adCurrentPage,
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
  final List<BxActiveTopBannerAd> ads;
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
                  image:
                      ((ad.bannerImageUrl ?? '').isNotEmpty &&
                          (ad.bannerImageUrl ?? '').startsWith('http'))
                      ? NetworkImage(ad.bannerImageUrl!)
                      : AssetImage(
                          (ad.bannerImageUrl != null &&
                                  ad.bannerImageUrl!.isNotEmpty)
                              ? ad.bannerImageUrl!
                              : 'assets/images/recommend_image1.png',
                        ),
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
                          ad.overlayTitle ?? '',
                          style: textTheme.titleMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          ad.overlaySubtitle ?? '',
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
                            child: Text(ad.ctaLabel ?? 'Explore Now'),
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
  final List<BxGetDestination> destinations;
  final String? selectedCategory;

  const _DestinationGrid({required this.destinations, this.selectedCategory});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    // Filter destinations by selected category
    final filteredDestinations =
        selectedCategory == null || selectedCategory!.isEmpty
        ? destinations
        : destinations.where((d) => d.name == selectedCategory).toList();

    if (filteredDestinations.isEmpty) {
      return const SizedBox(
        height: 200,
        child: Center(child: Text('No destinations available')),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: filteredDestinations.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.85,
      ),
      itemBuilder: (context, index) {
        final item = filteredDestinations[index];

        return ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            fit: StackFit.expand,
            children: [
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
                      item.name ?? '',
                      style: textTheme.titleSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      // Using the priceLabel getter from the model
                      item.priceLabel ?? '',
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
  final List<BxGetTopDeal> topDeals;

  const _TopDealsList({required this.topDeals});

  @override
  Widget build(BuildContext context) {
    if (topDeals.isEmpty) {
      return const SizedBox(
        height: 100,
        child: Center(child: Text('No top deals available')),
      );
    }

    return SizedBox(
      height: 320,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: topDeals.length,
        separatorBuilder: (_, _) => const SizedBox(width: 12),
        itemBuilder: (context, index) => _TopDealCard(deal: topDeals[index]),
      ),
    );
  }
}

class _TopDealCard extends StatelessWidget {
  final BxGetTopDeal deal;

  const _TopDealCard({required this.deal});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    // Calculate discount percent if we have original and display price
    String? discountText;
    if (deal.originalPrice != null &&
        deal.displayPrice != null &&
        deal.originalPrice! > deal.displayPrice!) {
      final discount =
          ((deal.originalPrice! - deal.displayPrice!) /
                  deal.originalPrice! *
                  100)
              .round();
      discountText = 'Save $discount%';
    }

    // Format price from minor units (fils)
    String formatPrice(num? price) {
      if (price == null) return '';
      return '\$${(price / 100).toStringAsFixed(0)}';
    }

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
                child:
                    ((deal.coverImageUrl ?? '').isNotEmpty &&
                        (deal.coverImageUrl ?? '').startsWith('http'))
                    ? Image.network(
                        deal.coverImageUrl!,
                        width: 280,
                        height: 160,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Image.asset(
                          BxAppConstant.topDealsImage1,
                          width: 280,
                          height: 160,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Image.asset(
                        (deal.coverImageUrl != null &&
                                deal.coverImageUrl!.isNotEmpty)
                            ? deal.coverImageUrl!
                            : BxAppConstant.topDealsImage1,
                        width: 280,
                        height: 160,
                        fit: BoxFit.cover,
                      ),
              ),
              // Discount badge
              if (discountText != null)
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
                      discountText,
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
                    deal.name ?? '',
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
                    formatPrice(deal.displayPrice),
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
                        '${deal.viewCount ?? 0} people are viewing this trip',
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
  final List<BxGetTopAgent> topAgents;

  const _AgenciesList({required this.topAgents});

  @override
  Widget build(BuildContext context) {
    if (topAgents.isEmpty) {
      return const SizedBox(
        height: 100,
        child: Center(child: Text('No agencies available')),
      );
    }

    return SizedBox(
      height: 170,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: topAgents.length,
        separatorBuilder: (_, _) => const SizedBox(width: 12),
        itemBuilder: (context, index) => _AgencyCard(
          agent: topAgents[index],
          onTap: () {
            debugPrint("we are here now");
            BxAppRouter.push(context, BxRouteNames.bxAgenciesScreen);
          },
        ),
      ),
    );
  }
}

class _AgencyCard extends StatelessWidget {
  final BxGetTopAgent agent;
  final VoidCallback onTap;

  const _AgencyCard({required this.agent, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: 170,
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Circular logo placeholder
          Center(
            child: Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: BxAppColors.primary.withOpacity(0.12),
              ),
              child: (agent.headerImg ?? '').isNotEmpty
                  ? ClipOval(
                      child: (agent.headerImg ?? '').startsWith('http')
                          ? Image.network(
                              agent.headerImg!,
                              width: 64,
                              height: 64,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => const Center(
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
                            )
                          : Image.asset(
                              agent.headerImg!,
                              width: 64,
                              height: 64,
                              fit: BoxFit.cover,
                            ),
                    )
                  : const Center(
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
          ),
          const SizedBox(height: 8),
          // Name
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              agent.companyName ?? '',
              style: textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
                fontSize: 11,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.start,
            ),
          ),
          const SizedBox(height: 4),
          // Rating
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.star, size: 14, color: Colors.amber),
                const SizedBox(width: 2),
                Text(
                  agent.averageRating?.toStringAsFixed(1) ?? '0.0',
                  style: textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurface,
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          // View Trips button
          Center(
            child: SizedBox(
              width: 80,
              height: 28,
              child: ElevatedButton(
                onPressed: onTap,
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
          ),
        ],
      ),
    );
  }
}

// ─── Recommended List ─────────────────────────────────────────────────────────

class _RecommendedList extends StatelessWidget {
  final List<BxRecommendedForCustomerPackage> recommended;

  const _RecommendedList({required this.recommended});

  @override
  Widget build(BuildContext context) {
    if (recommended.isEmpty) {
      return const SizedBox(
        height: 100,
        child: Center(child: Text('No recommendations available')),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: recommended.length,
      separatorBuilder: (_, _) => const SizedBox(height: 10),
      itemBuilder: (context, index) =>
          _RecommendedCard(trip: recommended[index]),
    );
  }
}

class _RecommendedCard extends StatelessWidget {
  final BxRecommendedForCustomerPackage trip;

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
            child:
                ((trip.coverImageUrl ?? '').isNotEmpty &&
                    (trip.coverImageUrl ?? '').startsWith('http'))
                ? Image.network(
                    trip.coverImageUrl!,
                    width: 100,
                    height: 90,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, _) => Image.asset(
                      'assets/images/recommend_image1.png',
                      width: 100,
                      height: 90,
                      fit: BoxFit.cover,
                    ),
                  )
                : Image.asset(
                    (trip.coverImageUrl != null &&
                            trip.coverImageUrl!.isNotEmpty)
                        ? trip.coverImageUrl!
                        : 'assets/images/recommend_image1.png',
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
                    trip.name ?? '',
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
                      Text(
                        trip.rating?.toString() ?? '0',
                        style: textTheme.bodySmall,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        trip.reviewCount?.toString() ?? '0',
                        style: textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurface.withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    trip.displayPrice != null
                        ? '\$${(trip.displayPrice! / 100).toStringAsFixed(0)}'
                        : '',
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
