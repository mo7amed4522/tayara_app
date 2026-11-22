// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/views/bx_booking_bottom_screen/bx_booking_bottom_screen_mobile.dart
// Architecture: Presentation Layer - Booking Bottom Screen
// Purpose: Mobile booking bottom screen with tabbed booking list — redesigned per Figma

// ignore_for_file: unrelated_type_equality_checks, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tayara/core/constant/bx_app_constant.dart';
import 'package:tayara/core/routes/bx_app_routes.dart';
import 'package:tayara/core/routes/bx_route_names.dart';
import 'package:tayara/core/theme/bx_app_colors.dart';
import 'package:tayara/presentation/bloc/bx_booking_bottom_screen_controller/bx_booking_bottom_screen_controller_bloc.dart';
import 'package:tayara/domain/model/response/bx_get_my_booking_list_response.dart';

class BxBookingBottomScreenMobile extends StatelessWidget {
  const BxBookingBottomScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return const _BookingBody();
  }
}

class _BookingBody extends StatefulWidget {
  const _BookingBody();

  @override
  State<_BookingBody> createState() => _BookingBodyState();
}

class _BookingBodyState extends State<_BookingBody> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Load initial bookings when screen opens
    context.read<BxBookingBottomScreenControllerBloc>().add(const BxLoadBookings(isRefresh: true));

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        context.read<BxBookingBottomScreenControllerBloc>().add(const BxLoadBookings());
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: Column(
        children: [
          // Pill-shaped segmented tab bar
          _buildTabBar(context),
          const SizedBox(height: 12),
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
                      if (state.bookings.isEmpty) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      // Show loading indicator at bottom while appending more
                      return Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              controller: _scrollController,
                              itemCount: state.bookings.length,
                              itemBuilder: (context, index) {
                                final booking = state.bookings[index];
                                return _BookingCard(
                                  booking: booking,
                                  textTheme: textTheme,
                                  colorScheme: colorScheme,
                                );
                              },
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(16),
                            child: Center(child: CircularProgressIndicator()),
                          ),
                        ],
                      );
                    }
                    if (state.status ==
                        BxBookingBottomScreenControllerStatus.failure) {
                      return const Center(
                        child: Text('Failed to load bookings'),
                      );
                    }

                    if (state.bookings.isEmpty) {
                      return _buildEmptyState(
                        context,
                        textTheme,
                        colorScheme,
                        state.selectedTab,
                      );
                    }

                    return ListView.separated(
                      controller: _scrollController,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      itemCount: state.bookings.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final booking = state.bookings[index];
                        return _BookingCard(
                          booking: booking,
                          textTheme: textTheme,
                          colorScheme: colorScheme,
                        );
                      },
                    );
                  },
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return BlocBuilder<
      BxBookingBottomScreenControllerBloc,
      BxBookingBottomScreenControllerState
    >(
      builder: (context, state) {
        final tabs = const ['Pending', 'Confirmed', 'Expired'];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: const Color(0x0f4b5563),
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: const Color(0x0f4b5563).withOpacity(0.06),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: List.generate(tabs.length, (index) {
                final isSelected = state.selectedTab == index;
                final isExpired = tabs[index] == 'Expired';
                return Expanded(
                  child: GestureDetector(
                    onTap: () => context
                        .read<BxBookingBottomScreenControllerBloc>()
                        .add(BxFilterBookings(tabIndex: index)),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? BxAppColors.onPrimary
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(26),
                      ),
                      child: isExpired
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (isSelected) // Only show image when selected
                                  Image.asset(
                                    BxAppConstant.expireLogo,
                                    width: 29,
                                    height: 28,
                                  ),
                                const SizedBox(width: 4), // Add some spacing
                                Text(
                                  tabs[index],
                                  style: textTheme.bodyMedium?.copyWith(
                                    color: isSelected
                                        ? BxAppColors.primary
                                        : BxAppColors.onPrimary,
                                    fontWeight: isSelected
                                        ? FontWeight.w600
                                        : FontWeight.w400,
                                  ),
                                ),
                              ],
                            )
                          : Text(
                              tabs[index],
                              style: textTheme.bodyMedium?.copyWith(
                                color: isSelected
                                    ? BxAppColors.primary
                                    : BxAppColors.onPrimary,
                                fontWeight: isSelected
                                    ? FontWeight.w600
                                    : FontWeight.w400,
                              ),
                            ),
                    ),
                  ),
                );
              }),
            ),
          ),
        );
      },
    );
  }

  Widget _buildEmptyState(
    BuildContext context,
    TextTheme textTheme,
    ColorScheme colorScheme,
    int activeTab,
  ) {
    final String title;
    final String subtitle;

    if (activeTab == 1) {
      title = 'No confirmed trips';
      subtitle = 'Your confirmed bookings will appear here';
    } else if (activeTab == 2) {
      title = 'No expired trips';
      subtitle = 'Your expired trips will appear here';
    } else {
      title = 'No upcoming trips';
      subtitle = 'Your pending and confirmed trips will appear here';
    }

    if (activeTab == 2) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              BxAppConstant.expireLogo,
              width: 200,
              height: 200,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 20),
            Text(
              title,
              style: textTheme.titleMedium?.copyWith(
                color: colorScheme.onSurface.withOpacity(0.5),
                fontFamily: 'lao-mn',
              ),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurface.withOpacity(0.4),
                fontFamily: 'lao-mn',
              ),
            ),
          ],
        ),
      );
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            activeTab == 1
                ? Icons.check_circle_outline
                : Icons.calendar_today_outlined,
            size: 64,
            color: colorScheme.onSurface.withOpacity(0.2),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: textTheme.titleMedium?.copyWith(
              color: colorScheme.onSurface.withOpacity(0.5),
              fontFamily: 'lao-mn',
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurface.withOpacity(0.4),
              fontFamily: 'lao-mn',
            ),
          ),
        ],
      ),
    );
  }
}

class _BookingCard extends StatelessWidget {
  final BxMyBookingItem booking;
  final TextTheme textTheme;
  final ColorScheme colorScheme;

  const _BookingCard({
    required this.booking,
    required this.textTheme,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    final status = booking.bookingStatus ?? 'unknown';
    final image = 'assets/images/recommend_image1.png';
    final name = booking.bookingCode ?? 'No Booking Code';
    final days = '';
    final date = booking.startDate != null && booking.endDate != null
        ? '${booking.startDate!.split('T').first} - ${booking.endDate!.split('T').first}'
        : 'No date';
    final agency = 'Agency Name';
    final agencyRating = '';
    final priceLabel = booking.currency ?? '';
    final price = booking.amountGross?.toStringAsFixed(2) ?? '0.00';
    final expiredDate = booking.holdExpiresAt;

    return InkWell(
      onTap: () {
        BxAppRouter.push(
          context,
          BxRouteNames.bxBookingDetailScreen,
          arguments: {'bookingId': booking.id, 'status': status},
        );
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (status == 'price_expired' || status == 'cancelled' || status == 'refunded')
              Padding(
                padding: const EdgeInsets.all(16),
                child: Center(
                  child: Image.asset(
                    BxAppConstant.expireLogoSec,
                    width: 120,
                    height: 120,
                    fit: BoxFit.contain,
                  ),
                ),
              )
            else
              _buildImageSection(image, status, null, expiredDate),
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          name,
                          style: textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'lao-mn',
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 6),
                      _buildDaysBadge(days),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    date,
                    style: textTheme.bodySmall?.copyWith(
                      color: (status == 'price_expired' || status == 'cancelled' || status == 'refunded')
                          ? BxAppColors.mutedLight
                          : colorScheme.onSurface.withOpacity(0.55),
                      fontFamily: 'lao-mn',
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(
                        Icons.business_rounded,
                        size: 13,
                        color: (status == 'price_expired' || status == 'cancelled' || status == 'refunded')
                            ? BxAppColors.mutedLight
                            : colorScheme.onSurface.withOpacity(0.5),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          agency,
                          style: textTheme.bodySmall?.copyWith(
                            color: (status == 'price_expired' || status == 'cancelled' || status == 'refunded')
                                ? BxAppColors.mutedLight
                                : colorScheme.onSurface.withOpacity(0.55),
                            fontFamily: 'lao-mn',
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (agencyRating.isNotEmpty) ...[
                        const SizedBox(width: 4),
                        Icon(
                          Icons.star_rounded,
                          size: 13,
                          color: BxAppColors.amber,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          agencyRating,
                          style: textTheme.labelSmall?.copyWith(
                            color: colorScheme.onSurface.withOpacity(0.6),
                            fontFamily: 'lao-mn',
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '$priceLabel $price',
                    style: textTheme.bodyMedium?.copyWith(
                      color: (status == 'price_expired' || status == 'cancelled' || status == 'refunded')
                          ? BxAppColors.mutedLight
                          : BxAppColors.primary,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'lao-mn',
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildActionButton(context, status, expiredDate),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSection(
    String image,
    String status,
    String? timeLeft,
    String? expiredDate,
  ) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      ),
      child: Stack(
        children: [
          Image.asset(
            image,
            width: double.infinity,
            height: 140,
            fit: BoxFit.cover,
          ),
          Positioned(
            top: 10,
            right: 10,
            child: _buildStatusBadge(status, timeLeft),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(String status, String? timeLeft) {
    if (status == 'requested' || status == 'agent_reviewing' || status == 'awaiting_payment' || status == 'docs_pending' || status == 'kyc_pending') {
      return _Badge(
        label: 'Pending',
        backgroundColor: const Color(0xFF374151).withOpacity(0.7),
      );
    }
    if (status == 'price_confirmed' || status == 'payment_authorized' || status == 'paid_confirmed' || status == 'docs_submitted' || status == 'kyc_approved' || status == 'booking_confirmed' || status == 'processing' || status == 'issued_ready' || status == 'completed') {
      return _Badge(label: 'Confirmed', backgroundColor: BxAppColors.success);
    }
    if (status == 'price_expired' || status == 'cancelled' || status == 'refunded') {
      return _Badge(
        label: 'Expired',
        backgroundColor: const Color(0xFF6B7280).withOpacity(0.8),
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildDaysBadge(String days) {
    if (days.isEmpty) return const SizedBox.shrink();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: BxAppColors.teal.withOpacity(0.12),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        days,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: BxAppColors.teal,
          fontFamily: 'lao-mn',
        ),
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    String status,
    String? expiredDate,
  ) {
    String label;
    Color backgroundColor;

    if (status == 'requested' || status == 'agent_reviewing' || status == 'awaiting_payment' || status == 'docs_pending' || status == 'kyc_pending') {
      label = 'Waiting for Agency';
      backgroundColor = BxAppColors.primary;
    } else if (status == 'price_confirmed' || status == 'payment_authorized' || status == 'paid_confirmed' || status == 'docs_submitted' || status == 'kyc_approved' || status == 'booking_confirmed' || status == 'processing' || status == 'issued_ready') {
      label = 'Proceed to Payment';
      backgroundColor = BxAppColors.brown;
    } else {
      label = 'Search Similar Trips';
      backgroundColor = BxAppColors.primary;
    }

    return SizedBox(
      width: double.infinity,
      height: 42,
      child: ElevatedButton(
        onPressed: () {
          if (status == 'price_expired' || status == 'cancelled' || status == 'refunded') {
            BxAppRouter.push(
              context,
              BxRouteNames.bxSimilarTripsScreen,
              arguments: {'tripName': booking.bookingCode ?? ''},
            );
          } else {
            BxAppRouter.push(
              context,
              BxRouteNames.bxBookingDetailScreen,
              arguments: {'bookingId': booking.id, 'status': status},
            );
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: BxAppColors.onPrimary,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          label,
          style: textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
            fontFamily: 'lao-mn',
          ),
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  final String label;
  final Color backgroundColor;

  const _Badge({required this.label, required this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: Colors.white,
          fontFamily: 'lao-mn',
        ),
      ),
    );
  }
}
