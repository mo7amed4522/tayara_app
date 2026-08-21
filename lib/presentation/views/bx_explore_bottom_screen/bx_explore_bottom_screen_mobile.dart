// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/views/bx_explore_bottom_screen/bx_explore_bottom_screen_mobile.dart
// Architecture: Presentation Layer - Explore Bottom Screen
// Purpose: Mobile explore bottom screen with destinations and trending trips

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tayara/core/theme/bx_app_colors.dart';
import 'package:tayara/presentation/bloc/bx_explore_bottom_screen_controller/bx_explore_bottom_screen_controller_bloc.dart';

class BxExploreBottomScreenMobile extends StatelessWidget {
  const BxExploreBottomScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BxExploreBottomScreenControllerBloc()
        ..add(const BxLoadExploreContent()),
      child: _ExploreBody(),
    );
  }
}

class _ExploreBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      color: colorScheme.background,
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search bar
              _SearchBar(),
              const SizedBox(height: 20),
              // Popular Destinations
              Text(
                'Popular Destinations',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'lao-mn',
                ),
              ),
              const SizedBox(height: 12),
              _DestinationGrid(),
              const SizedBox(height: 24),
              // Trending Trips
              Text(
                'Trending Trips',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'lao-mn',
                ),
              ),
              const SizedBox(height: 12),
              _TrendingTripsList(),
            ],
          ),
        ),
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      width: double.infinity,
      height: 52,
      child: TextField(
        style: TextStyle(color: colorScheme.onSurface, fontSize: 14),
        decoration: InputDecoration(
          hintText: 'Where do you want to go?',
          hintStyle: TextStyle(
            color: colorScheme.onSurface.withOpacity(0.5),
            fontSize: 14,
            fontFamily: 'lao-mn',
          ),
          suffixIcon: Icon(
            Icons.tune,
            color: colorScheme.onSurface.withOpacity(0.6),
          ),
          filled: true,
          fillColor: colorScheme.surface,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
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

class _DestinationGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      BxExploreBottomScreenControllerBloc,
      BxExploreBottomScreenControllerState
    >(
      builder: (context, state) {
        if (state.status == BxExploreBottomScreenControllerStatus.loading) {
          return const SizedBox(height: 160, child: Center(child: CircularProgressIndicator()));
        }
        if (state.status == BxExploreBottomScreenControllerStatus.failure) {
          return const SizedBox(height: 160, child: Center(child: Text('Failed to load')));
        }
        final destinations = state.destinations;
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: destinations.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.3,
          ),
          itemBuilder: (context, index) {
            final item = destinations[index];
            return _DestinationCard(
              image: item['image']!,
              name: item['name']!,
              trips: item['trips']!,
            );
          },
        );
      },
    );
  }
}

class _DestinationCard extends StatelessWidget {
  final String image;
  final String name;
  final String trips;

  const _DestinationCard({
    required this.image,
    required this.name,
    required this.trips,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(image, fit: BoxFit.cover),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                stops: const [0.4, 1.0],
              ),
            ),
          ),
          Positioned(
            left: 10,
            right: 10,
            bottom: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  name,
                  style: textTheme.titleSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  trips,
                  style: textTheme.bodySmall?.copyWith(
                    color: Colors.white.withOpacity(0.9),
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

class _TrendingTripsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      BxExploreBottomScreenControllerBloc,
      BxExploreBottomScreenControllerState
    >(
      builder: (context, state) {
        if (state.status == BxExploreBottomScreenControllerStatus.loading) {
          return const SizedBox(height: 120, child: Center(child: CircularProgressIndicator()));
        }
        if (state.status == BxExploreBottomScreenControllerStatus.failure) {
          return const SizedBox(height: 120, child: Center(child: Text('Failed to load')));
        }
        final trips = state.trendingTrips;
        return SizedBox(
          height: 120,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: trips.length,
            separatorBuilder: (_, _) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final trip = trips[index];
              return _TrendingTripCard(
                image: trip['image']!,
                name: trip['name']!,
                price: trip['price']!,
                rating: trip['rating']!,
              );
            },
          ),
        );
      },
    );
  }
}

class _TrendingTripCard extends StatelessWidget {
  final String image;
  final String name;
  final String price;
  final String rating;

  const _TrendingTripCard({
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
      width: 220,
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
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.asset(image, width: 220, height: 80, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  price,
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
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
