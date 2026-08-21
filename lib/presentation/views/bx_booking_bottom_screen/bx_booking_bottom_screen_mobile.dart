// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/views/bx_booking_bottom_screen/bx_booking_bottom_screen_mobile.dart
// Architecture: Presentation Layer - Booking Bottom Screen
// Purpose: Mobile booking bottom screen with tabbed booking list

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tayara/core/routes/bx_app_routes.dart';
import 'package:tayara/core/routes/bx_route_names.dart';
import 'package:tayara/core/theme/bx_app_colors.dart';
import 'package:tayara/presentation/bloc/bx_booking_bottom_screen_controller/bx_booking_bottom_screen_controller_bloc.dart';

class BxBookingBottomScreenMobile extends StatelessWidget {
  const BxBookingBottomScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          BxBookingBottomScreenControllerBloc()..add(const BxLoadBookings()),
      child: const _BookingBody(),
    );
  }
}

class _BookingBody extends StatelessWidget {
  const _BookingBody();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      color: colorScheme.background,
      child: SafeArea(
        child: Column(
          children: [
            // Tab bar
            _buildTabBar(context),
            // Booking list
            Expanded(
              child:
                  BlocBuilder<
                    BxBookingBottomScreenControllerBloc,
                    BxBookingBottomScreenControllerState
                  >(
                    builder: (context, state) {
                      if (state.status ==
                          BxBookingBottomScreenControllerStatus.loading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (state.status ==
                          BxBookingBottomScreenControllerStatus.failure) {
                        return const Center(
                          child: Text('Failed to load bookings'),
                        );
                      }
                      final allBookings = state.bookings;
                      final activeTab = state.selectedTab;
                      final filteredBookings = activeTab == 0
                          ? allBookings
                                .where(
                                  (b) =>
                                      b['status'] == 'pending' ||
                                      b['status'] == 'confirmed',
                                )
                                .toList()
                          : activeTab == 1
                          ? allBookings
                                .where((b) => b['status'] == 'confirmed')
                                .toList()
                          : allBookings
                                .where((b) => b['status'] == 'expired')
                                .toList();

                      if (filteredBookings.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.calendar_today_outlined,
                                size: 64,
                                color: colorScheme.onSurface.withOpacity(0.3),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'No bookings yet',
                                style: textTheme.titleMedium?.copyWith(
                                  color: colorScheme.onSurface.withOpacity(0.5),
                                  fontFamily: 'lao-mn',
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Book your first trip to see it here',
                                style: textTheme.bodyMedium?.copyWith(
                                  color: colorScheme.onSurface.withOpacity(0.4),
                                  fontFamily: 'lao-mn',
                                ),
                              ),
                            ],
                          ),
                        );
                      }

                      return ListView.separated(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        itemCount: filteredBookings.length,
                        separatorBuilder: (_, _) => const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final booking = filteredBookings.elementAt(index);
                          return _BookingCard(booking: booking);
                        },
                      );
                    },
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabBar(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return BlocBuilder<
      BxBookingBottomScreenControllerBloc,
      BxBookingBottomScreenControllerState
    >(
      builder: (context, state) {
        final tabs = const ['Upcoming', 'Confirmed', 'Expired'];
        return Row(
          children: List.generate(tabs.length, (index) {
            final isSelected = state.selectedTab == index;
            return Expanded(
              child: GestureDetector(
                onTap: () => context
                    .read<BxBookingBottomScreenControllerBloc>()
                    .add(BxFilterBookings(tabIndex: index)),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: isSelected
                            ? BxAppColors.primary
                            : colorScheme.outline.withOpacity(0.2),
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                  ),
                  child: Text(
                    tabs[index],
                    style: textTheme.bodyMedium?.copyWith(
                      color: isSelected
                          ? BxAppColors.primary
                          : colorScheme.onSurface.withOpacity(0.6),
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.w400,
                      fontFamily: 'lao-mn',
                    ),
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}

class _BookingCard extends StatelessWidget {
  final Map<String, String> booking;

  const _BookingCard({required this.booking});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final status = booking['status'] ?? 'pending';
    final statusColor = status == 'confirmed'
        ? BxAppColors.success
        : status == 'pending'
        ? BxAppColors.warning
        : const Color(0xFF6B7280);

    return InkWell(
      onTap: () {
        BxAppRouter.push(
          context,
          BxRouteNames.bxBookingDetailScreen,
          arguments: {'status': status},
        );
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(12),
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
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                booking['image'] ?? 'assets/images/recommend_image1.png',
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    booking['name'] ?? 'Trip',
                    style: textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'lao-mn',
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    booking['date'] ?? '',
                    style: textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurface.withOpacity(0.6),
                      fontFamily: 'lao-mn',
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    booking['price'] ?? '',
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'lao-mn',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                status.toUpperCase(),
                style: textTheme.labelSmall?.copyWith(
                  color: statusColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
