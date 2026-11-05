// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/widgets/bx_package_detail_widget/bx_package_detail_widget_mobile.dart
// Architecture: Presentation Layer - Bx package detail mobile Widget
// Purpose: Professional Bx package detail mobile widget (stateless, BLoC-driven)

// ignore_for_file: unnecessary_underscores, unused_field, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tayara/domain/model/response/bx_get_package_detail_response.dart';
import 'package:tayara/presentation/bloc/bx_package_detail_screen_controller/bx_package_detail_screen_controller_bloc.dart';

class BxPackageDetailWidgetMobile extends StatelessWidget {
  const BxPackageDetailWidgetMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final p = _PackagePalette.of(context);

    return BlocBuilder<
      BxPackageDetailScreenControllerBloc,
      BxPackageDetailScreenControllerState
    >(
      builder: (context, state) {
        switch (state.status) {
          case BxPackageDetailScreenControllerStatus.initial:
          case BxPackageDetailScreenControllerStatus.loading:
            return Scaffold(
              backgroundColor: p.background,
              body: const Center(child: CircularProgressIndicator()),
            );
          case BxPackageDetailScreenControllerStatus.failure:
            return Scaffold(
              backgroundColor: p.background,
              body: _ErrorView(p: p, packageId: state.packageId),
            );
          case BxPackageDetailScreenControllerStatus.success:
            final data = state.packageDetail?.data;
            if (data == null) {
              return Scaffold(
                backgroundColor: p.background,
                body: _ErrorView(p: p, packageId: state.packageId),
              );
            }
            return _MobileBody(p: p, data: data, state: state);
        }
      },
    );
  }
}

// ═══════════════════════════════════════════════════════════
// BODY
// ═══════════════════════════════════════════════════════════
class _MobileBody extends StatelessWidget {
  final _PackagePalette p;
  final BxGetPackageDetailData data;
  final BxPackageDetailScreenControllerState state;

  const _MobileBody({required this.p, required this.data, required this.state});

  static List<String> _imagesFor(BxGetPackageDetailData d) {
    final list = <String>[];
    final cover = d.coverImageUrl;
    if (cover != null && cover.trim().isNotEmpty) list.add(cover);
    final gallery = d.galleryImages?.images ?? const <String>[];
    for (final url in gallery) {
      if (url.trim().isNotEmpty && !list.contains(url)) list.add(url);
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<BxPackageDetailScreenControllerBloc>();
    final images = _imagesFor(data);
    final nights = (data.daysDuration ?? 1) - 1;

    return Scaffold(
      backgroundColor: p.background,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _AppBar(p: p),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(bottom: 32.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _ImageCarousel(
                      images: images,
                      currentIndex: state.currentImageIndex,
                      onPageChanged: (i) => bloc.add(BxChangeImage(i)),
                      p: p,
                      badge: data.promoTag,
                    ),
                    SizedBox(height: 12.h),
                    _TagChipsRow(p: p, data: data),
                    SizedBox(height: 14.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: _TitleAndDescription(p: p, data: data),
                    ),
                    SizedBox(height: 10.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: _RatingRow(p: p),
                    ),
                    SizedBox(height: 12.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: _MetaRow(
                        p: p,
                        days: data.daysDuration,
                        location: data.location,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: _FeatureChips(p: p, highlights: data.highlights),
                    ),
                    SizedBox(height: 16.h),
                    _Divider(p: p),
                    SizedBox(height: 16.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: _PriceBlock(p: p, data: data),
                    ),
                    if (images.length > 1) ...[
                      SizedBox(height: 20.h),
                      _SectionHeader(title: 'Image Gallery', p: p),
                      SizedBox(height: 10.h),
                      _GalleryGrid(p: p, images: images),
                    ],
                    if (data.itineraryDays.isNotEmpty) ...[
                      SizedBox(height: 22.h),
                      _SectionHeader(title: 'Daily Itinerary', p: p),
                      SizedBox(height: 10.h),
                      _ItineraryList(p: p, days: data.itineraryDays),
                    ],
                    if (data.includes.isNotEmpty) ...[
                      SizedBox(height: 22.h),
                      _SectionHeader(title: "What's Included", p: p),
                      SizedBox(height: 10.h),
                      _IncludedSection(p: p, includes: data.includes),
                    ],
                    if (data.excludes.isNotEmpty) ...[
                      SizedBox(height: 20.h),
                      _SectionHeader(title: 'Not Included', p: p),
                      SizedBox(height: 10.h),
                      _NotIncludedSection(p: p, excludes: data.excludes),
                    ],
                    if (data.documentRequirements.isNotEmpty) ...[
                      SizedBox(height: 22.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: _DocumentsCard(
                          p: p,
                          requirements: data.documentRequirements,
                        ),
                      ),
                    ],
                    if (data.addons.isNotEmpty) ...[
                      SizedBox(height: 22.h),
                      _SectionHeader(title: 'Optional Add-ons', p: p),
                      SizedBox(height: 10.h),
                      _AddOnsList(
                        p: p,
                        addons: data.addons,
                        selected: state.selectedAddOns,
                        onToggle: (i) => bloc.add(BxToggleAddOn(i)),
                      ),
                    ],
                    if (data.highlights.isNotEmpty) ...[
                      SizedBox(height: 22.h),
                      _SectionHeader(title: 'Highlights', p: p),
                      SizedBox(height: 12.h),
                      _AmenitiesGrid(p: p, highlights: data.highlights),
                    ],
                    if (data.availability.isNotEmpty) ...[
                      SizedBox(height: 22.h),
                      _SectionHeader(title: 'Available Dates & Pricing', p: p),
                      SizedBox(height: 12.h),
                      _CalendarSection(
                        p: p,
                        availability: data.availability,
                        basePrice: data.displayPrice,
                        selectedIndex: state.selectedDateIndex,
                        onSelect: (i) => bloc.add(BxSelectDate(i)),
                      ),
                    ],
                    SizedBox(height: 22.h),
                    _SectionHeader(title: 'Write a Review', p: p),
                    SizedBox(height: 10.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: _ReviewForm(
                        p: p,
                        rating: state.userRating,
                        onRating: (r) => bloc.add(BxSetUserRating(r)),
                      ),
                    ),
                    SizedBox(height: 22.h),
                    _SectionHeader(title: 'Book Your Cruise', p: p),
                    SizedBox(height: 12.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: _BookingForm(
                        p: p,
                        hotels: data.hotels,
                        selectedCabinIndex: state.selectedCabinIndex,
                        onCabinSelected: (i) => bloc.add(BxSelectCabin(i)),
                        nights: nights,
                      ),
                    ),
                    SizedBox(height: 22.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: _NeedHelpTile(p: p),
                    ),
                    SizedBox(height: 100.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomSheet: _BottomPayBar(p: p, data: data),
    );
  }
}

// ═══════════════════════════════════════════════════════════
// SHARED FORMATTING
// ═══════════════════════════════════════════════════════════
String _fmtPrice(num? value) {
  if (value == null) return '—';
  final s = value.toString();
  final buf = StringBuffer();
  for (int i = 0; i < s.length; i++) {
    if (i > 0 && (s.length - i) % 3 == 0) buf.write(',');
    buf.write(s[i]);
  }
  return '\$${buf.toString()}';
}

// ═══════════════════════════════════════════════════════════
// PALETTE
// ═══════════════════════════════════════════════════════════
class _PackagePalette {
  final bool isDark;
  final Color background;
  final Color surface;
  final Color cardSurface;
  final Color border;
  final Color divider;
  final Color textPrimary;
  final Color textSecondary;
  final Color textMuted;
  final Color primary;
  final Color success;
  final Color warning;
  final Color error;
  final Color starFilled;
  final Color starEmpty;

  const _PackagePalette({
    required this.isDark,
    required this.background,
    required this.surface,
    required this.cardSurface,
    required this.border,
    required this.divider,
    required this.textPrimary,
    required this.textSecondary,
    required this.textMuted,
    required this.primary,
    required this.success,
    required this.warning,
    required this.error,
    required this.starFilled,
    required this.starEmpty,
  });

  factory _PackagePalette.of(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return _PackagePalette(
      isDark: isDark,
      background: isDark ? const Color(0xFF0F1115) : const Color(0xFFFFFFFF),
      surface: isDark ? const Color(0xFF1A1D22) : const Color(0xFFF9FAFB),
      cardSurface: isDark ? const Color(0xFF1A1D22) : Colors.white,
      border: isDark ? const Color(0xFF2A2D33) : const Color(0xFFE5E7EB),
      divider: isDark ? const Color(0xFF2A2D33) : const Color(0xFFE5E7EB),
      textPrimary: isDark ? const Color(0xFFF3F4F6) : const Color(0xFF111827),
      textSecondary: isDark ? const Color(0xFF9CA3AF) : const Color(0xFF4A5462),
      textMuted: isDark ? const Color(0xFF6B7280) : const Color(0xFF9CA3AF),
      primary: const Color(0xFF2563EB),
      success: const Color(0xFF10B981),
      warning: const Color(0xFFEA580C),
      error: const Color(0xFFEF4444),
      starFilled: const Color(0xFFF59E0B),
      starEmpty: isDark ? const Color(0xFF374151) : const Color(0xFFD1D5DB),
    );
  }
}

// ═══════════════════════════════════════════════════════════
// ERROR VIEW
// ═══════════════════════════════════════════════════════════
class _ErrorView extends StatelessWidget {
  final _PackagePalette p;
  final int packageId;
  const _ErrorView({required this.p, required this.packageId});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, size: 48, color: p.error),
            SizedBox(height: 12.h),
            Text(
              'Unable to load package details',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
                color: p.textPrimary,
                fontFamily: 'lao-mn',
              ),
            ),
            SizedBox(height: 16.h),
            SizedBox(
              height: 42,
              child: ElevatedButton(
                onPressed: () => context
                    .read<BxPackageDetailScreenControllerBloc>()
                    .add(BxLoadPackageDetail(packageId: packageId)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: p.primary,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Retry'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
// APP BAR
// ═══════════════════════════════════════════════════════════
class _AppBar extends StatelessWidget {
  final _PackagePalette p;
  const _AppBar({required this.p});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.of(context).maybePop(),
            icon: Icon(Icons.arrow_back, size: 18, color: p.textPrimary),
          ),
          Expanded(
            child: Center(
              child: Text(
                'Package Details',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: p.textPrimary,
                  fontFamily: 'lao-mn',
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.ios_share, size: 20, color: p.textPrimary),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.favorite_border, size: 22, color: p.textPrimary),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
// IMAGE CAROUSEL (stateless, index from BLoC)
// ═══════════════════════════════════════════════════════════
class _ImageCarousel extends StatelessWidget {
  final List<String> images;
  final int currentIndex;
  final ValueChanged<int> onPageChanged;
  final _PackagePalette p;
  final String? badge;

  const _ImageCarousel({
    required this.images,
    required this.currentIndex,
    required this.onPageChanged,
    required this.p,
    this.badge,
  });

  @override
  Widget build(BuildContext context) {
    if (images.isEmpty) {
      return Container(
        height: 256,
        width: double.infinity,
        color: p.surface,
        alignment: Alignment.center,
        child: Icon(Icons.image, size: 48, color: p.textMuted),
      );
    }

    final safeIndex = currentIndex.clamp(0, images.length - 1);

    return SizedBox(
      height: 256,
      child: Stack(
        children: [
          PageView.builder(
            controller: PageController(initialPage: safeIndex),
            onPageChanged: onPageChanged,
            itemCount: images.length,
            itemBuilder: (_, i) => Image.network(
              images[i],
              width: double.infinity,
              height: 256,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                color: p.surface,
                child: Icon(Icons.image, size: 48, color: p.textMuted),
              ),
            ),
          ),
          Positioned(
            top: 12,
            left: 12,
            right: 12,
            child: Row(
              children: [
                if (badge != null && badge!.isNotEmpty)
                  Container(
                    height: 28,
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: p.warning,
                      borderRadius: BorderRadius.circular(9999),
                    ),
                    child: Text(
                      badge!,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'lao-mn',
                      ),
                    ),
                  ),
                const Spacer(),
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.favorite, size: 18, color: p.error),
                ),
              ],
            ),
          ),
          Positioned(
            left: 16,
            bottom: 12,
            child: Row(
              children: List.generate(images.length, (i) {
                final active = i == safeIndex;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: EdgeInsets.only(right: 6.w),
                  width: active ? 18 : 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: active ? Colors.white : Colors.white54,
                    borderRadius: BorderRadius.circular(99),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
// TAG CHIPS
// ═══════════════════════════════════════════════════════════
class _TagChipsRow extends StatelessWidget {
  final _PackagePalette p;
  final BxGetPackageDetailData data;
  const _TagChipsRow({required this.p, required this.data});

  @override
  Widget build(BuildContext context) {
    final chips = <Widget>[];
    final discount = data.discountPercent ?? 0;
    if (discount > 0) {
      chips.add(_chip('Save $discount%', p.success));
    }
    if ((data.promoTag ?? '').isNotEmpty) {
      if (chips.isNotEmpty) chips.add(SizedBox(width: 8.w));
      chips.add(_chip(data.promoTag!, p.warning));
    }
    if (chips.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(children: chips),
    );
  }

  Widget _chip(String text, Color color) => Container(
    height: 28,
    padding: EdgeInsets.symmetric(horizontal: 12.w),
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(9999),
    ),
    child: Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontSize: 11.sp,
        fontWeight: FontWeight.w600,
        fontFamily: 'lao-mn',
      ),
    ),
  );
}

// ═══════════════════════════════════════════════════════════
// TITLE + DESC
// ═══════════════════════════════════════════════════════════
class _TitleAndDescription extends StatelessWidget {
  final _PackagePalette p;
  final BxGetPackageDetailData data;
  const _TitleAndDescription({required this.p, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          data.name ?? '',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            color: p.textPrimary,
            fontFamily: 'lao-mn',
            height: 1.3,
          ),
        ),
        if ((data.description ?? '').isNotEmpty) ...[
          SizedBox(height: 8.h),
          Text(
            data.description!,
            style: TextStyle(
              fontSize: 13.sp,
              color: p.textSecondary,
              fontFamily: 'lao-mn',
              height: 1.55,
            ),
          ),
        ],
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════
// RATING ROW
// ═══════════════════════════════════════════════════════════
class _RatingRow extends StatelessWidget {
  final _PackagePalette p;
  const _RatingRow({required this.p});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ...List.generate(
          5,
          (_) => Icon(Icons.star, size: 16, color: p.starFilled),
        ),
        SizedBox(width: 8.w),
        Text(
          '4.9',
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
            color: p.textPrimary,
            fontFamily: 'lao-mn',
          ),
        ),
        SizedBox(width: 6.w),
        Text(
          '(127 reviews)',
          style: TextStyle(
            fontSize: 12.sp,
            color: p.textMuted,
            fontFamily: 'lao-mn',
          ),
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════
// META ROW
// ═══════════════════════════════════════════════════════════
class _MetaRow extends StatelessWidget {
  final _PackagePalette p;
  final int? days;
  final String? location;
  const _MetaRow({required this.p, this.days, this.location});

  @override
  Widget build(BuildContext context) {
    final parts = <Widget>[];
    if (days != null && days! > 0) {
      parts.add(Icon(Icons.access_time, size: 16, color: p.primary));
      parts.add(SizedBox(width: 6.w));
      parts.add(
        Text(
          '$days Days / ${days! - 1} Nights',
          style: TextStyle(
            fontSize: 12.sp,
            color: p.textSecondary,
            fontFamily: 'lao-mn',
          ),
        ),
      );
    }
    if ((location ?? '').isNotEmpty) {
      if (parts.isNotEmpty) parts.add(SizedBox(width: 16.w));
      parts.add(Icon(Icons.location_on_outlined, size: 16, color: p.primary));
      parts.add(SizedBox(width: 6.w));
      parts.add(
        Text(
          location!,
          style: TextStyle(
            fontSize: 12.sp,
            color: p.textSecondary,
            fontFamily: 'lao-mn',
          ),
        ),
      );
    }
    return Row(children: parts);
  }
}

// ═══════════════════════════════════════════════════════════
// FEATURE CHIPS (from highlights)
// ═══════════════════════════════════════════════════════════
class _FeatureChips extends StatelessWidget {
  final _PackagePalette p;
  final List<BxPackageHighlight> highlights;
  const _FeatureChips({required this.p, required this.highlights});

  @override
  Widget build(BuildContext context) {
    final names = highlights
        .map((h) => h.name ?? '')
        .where((s) => s.isNotEmpty)
        .take(6)
        .toList();
    if (names.isEmpty) return const SizedBox.shrink();
    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      children: [
        for (final n in names)
          Container(
            height: 28,
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: p.primary.withOpacity(0.12),
              borderRadius: BorderRadius.circular(9999),
              border: Border.all(color: p.primary.withOpacity(0.4)),
            ),
            child: Text(
              n,
              style: TextStyle(
                color: p.primary,
                fontSize: 11.sp,
                fontWeight: FontWeight.w500,
                fontFamily: 'lao-mn',
              ),
            ),
          ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════
// DIVIDER
// ═══════════════════════════════════════════════════════════
class _Divider extends StatelessWidget {
  final _PackagePalette p;
  const _Divider({required this.p});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      color: p.divider,
    );
  }
}

// ═══════════════════════════════════════════════════════════
// PRICE BLOCK
// ═══════════════════════════════════════════════════════════
class _PriceBlock extends StatelessWidget {
  final _PackagePalette p;
  final BxGetPackageDetailData data;
  const _PriceBlock({required this.p, required this.data});

  @override
  Widget build(BuildContext context) {
    final display = data.displayPrice;
    final original = data.originalPrice;
    final showStrike =
        original != null && display != null && original > display;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showStrike) ...[
          Text(
            _fmtPrice(original),
            style: TextStyle(
              fontSize: 13.sp,
              color: p.textMuted,
              fontFamily: 'lao-mn',
              decoration: TextDecoration.lineThrough,
            ),
          ),
          SizedBox(height: 2.h),
        ],
        Text(
          _fmtPrice(display),
          style: TextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.w700,
            color: p.primary,
            fontFamily: 'lao-mn',
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          'per person • All inclusive',
          style: TextStyle(
            fontSize: 11.sp,
            color: p.textMuted,
            fontFamily: 'lao-mn',
          ),
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════
// SECTION HEADER
// ═══════════════════════════════════════════════════════════
class _SectionHeader extends StatelessWidget {
  final String title;
  final _PackagePalette p;
  const _SectionHeader({required this.title, required this.p});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w700,
          color: p.textPrimary,
          fontFamily: 'lao-mn',
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
// GALLERY GRID
// ═══════════════════════════════════════════════════════════
class _GalleryGrid extends StatelessWidget {
  final _PackagePalette p;
  final List<String> images;
  const _GalleryGrid({required this.p, required this.images});

  static const int _maxVisible = 6;

  @override
  Widget build(BuildContext context) {
    final gallery = images.length > 1 ? images.sublist(1) : images;
    final shown = gallery.take(_maxVisible).toList();
    final extra = gallery.length - shown.length;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: LayoutBuilder(
        builder: (context, c) {
          const spacing = 8.0;
          final cols = 3;
          final size = (c.maxWidth - spacing * (cols - 1)) / cols;
          return Wrap(
            spacing: spacing,
            runSpacing: spacing,
            children: [
              for (final url in shown)
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    url,
                    width: size,
                    height: size,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      width: size,
                      height: size,
                      color: p.surface,
                      child: Icon(Icons.image, size: 32, color: p.textMuted),
                    ),
                  ),
                ),
              if (extra > 0)
                Container(
                  width: size,
                  height: size,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.55),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '+$extra\nimages',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'lao-mn',
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
// ITINERARY
// ═══════════════════════════════════════════════════════════
class _ItineraryList extends StatelessWidget {
  final _PackagePalette p;
  final List<BxPackageItineraryDay> days;
  const _ItineraryList({required this.p, required this.days});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          for (final d in days)
            _DayTile(
              title: d.title ?? 'Day ${d.dayNumber ?? ''}',
              subtitle: d.description ?? '',
              items: [
                for (final it in d.items)
                  if ((it.time ?? '').isNotEmpty)
                    '${it.time} : ${it.title ?? it.description ?? ''}'
                  else
                    (it.title ?? it.description ?? ''),
              ],
              p: p,
            ),
        ],
      ),
    );
  }
}

class _DayTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<String> items;
  final _PackagePalette p;
  const _DayTile({
    required this.title,
    required this.subtitle,
    required this.items,
    required this.p,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Material(
        color: p.cardSurface,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: BorderSide(color: p.border),
        ),
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            tilePadding: EdgeInsets.symmetric(horizontal: 14.w),
            childrenPadding: EdgeInsets.fromLTRB(14.w, 0, 14.w, 14.h),
            iconColor: p.primary,
            collapsedIconColor: p.textMuted,
            title: Text(
              title,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: p.textPrimary,
                fontFamily: 'lao-mn',
              ),
            ),
            subtitle: subtitle.isEmpty
                ? null
                : Padding(
                    padding: EdgeInsets.only(top: 4.h),
                    child: Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: p.textSecondary,
                        fontFamily: 'lao-mn',
                      ),
                    ),
                  ),
            children: items.map((t) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 6.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 6.h),
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: p.primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Text(
                        t,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: p.textSecondary,
                          fontFamily: 'lao-mn',
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
// INCLUDED (grouped by category)
// ═══════════════════════════════════════════════════════════
class _IncludedSection extends StatelessWidget {
  final _PackagePalette p;
  final List<BxPackageInclude> includes;
  const _IncludedSection({required this.p, required this.includes});

  static IconData _iconForCategory(String c) {
    final s = c.toLowerCase();
    if (s.contains('meal') || s.contains('dining') || s.contains('food')) {
      return Icons.restaurant_outlined;
    }
    if (s.contains('tour') || s.contains('activity')) {
      return Icons.place_outlined;
    }
    if (s.contains('hotel') ||
        s.contains('accommodation') ||
        s.contains('stay')) {
      return Icons.home_work_outlined;
    }
    return Icons.check_circle_outline;
  }

  @override
  Widget build(BuildContext context) {
    final groups = <String, List<String>>{};
    for (final inc in includes) {
      final cat = (inc.category ?? '').trim();
      final key = cat.isEmpty ? 'Included' : cat;
      final text = inc.itemText ?? '';
      if (text.isEmpty) continue;
      groups.putIfAbsent(key, () => []).add(text);
    }
    final entries = groups.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key));

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          for (int i = 0; i < entries.length; i++) ...[
            if (i > 0) SizedBox(height: 10.h),
            _IncludedCard(
              p: p,
              icon: _iconForCategory(entries[i].key),
              title: entries[i].key,
              color: p.success,
              items: entries[i].value,
            ),
          ],
        ],
      ),
    );
  }
}

class _IncludedCard extends StatelessWidget {
  final _PackagePalette p;
  final IconData icon;
  final String title;
  final Color color;
  final List<String> items;
  final bool isCross;

  const _IncludedCard({
    required this.p,
    required this.icon,
    required this.title,
    required this.color,
    required this.items,
    this.isCross = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: p.cardSurface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: p.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, size: 18, color: color),
              ),
              SizedBox(width: 10.w),
              Text(
                title,
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w700,
                  color: p.textPrimary,
                  fontFamily: 'lao-mn',
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          ...items.map(
            (t) => Padding(
              padding: EdgeInsets.symmetric(vertical: 4.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    isCross ? Icons.close : Icons.check,
                    size: 16,
                    color: color,
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      t,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: p.textSecondary,
                        fontFamily: 'lao-mn',
                        height: 1.4,
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

// ═══════════════════════════════════════════════════════════
// NOT INCLUDED
// ═══════════════════════════════════════════════════════════
class _NotIncludedSection extends StatelessWidget {
  final _PackagePalette p;
  final List<BxPackageExclude> excludes;
  const _NotIncludedSection({required this.p, required this.excludes});

  @override
  Widget build(BuildContext context) {
    final items = excludes
        .map((e) => e.itemText ?? '')
        .where((s) => s.isNotEmpty)
        .toList();
    if (items.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: _IncludedCard(
        p: p,
        icon: Icons.info_outline,
        title: 'Not Included',
        color: p.error,
        isCross: true,
        items: items,
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
// DOCUMENTS
// ═══════════════════════════════════════════════════════════
class _DocumentsCard extends StatelessWidget {
  final _PackagePalette p;
  final List<BxPackageDocumentRequirement> requirements;
  const _DocumentsCard({required this.p, required this.requirements});

  static String _labelForType(int? id) {
    switch (id) {
      case 1:
        return 'Passport copy';
      case 2:
        return 'National ID';
      case 3:
        return 'Personal photo';
      case 4:
        return 'Visa documents';
      default:
        return 'Document #${id ?? '—'}';
    }
  }

  @override
  Widget build(BuildContext context) {
    final docs = requirements
        .where((r) => r.isRequired == true || r.isOptional == true)
        .toList();
    if (docs.isEmpty) return const SizedBox.shrink();

    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: p.cardSurface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: p.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Documents Required for This Trip',
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w700,
              color: p.textPrimary,
              fontFamily: 'lao-mn',
            ),
          ),
          SizedBox(height: 6.h),
          Row(
            children: [
              Icon(Icons.access_time, size: 13, color: p.textMuted),
              SizedBox(width: 4.w),
              Text(
                'Most travelers complete this in 2–3 minutes',
                style: TextStyle(
                  fontSize: 11.sp,
                  color: p.textMuted,
                  fontFamily: 'lao-mn',
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Wrap(
            spacing: 40.w,
            runSpacing: 8.h,
            children: docs
                .map(
                  (r) => Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.check, size: 14, color: p.success),
                      SizedBox(width: 4.w),
                      Text(
                        _labelForType(r.documentTypeId),
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: p.textSecondary,
                          fontFamily: 'lao-mn',
                        ),
                      ),
                    ],
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
// ADD-ONS
// ═══════════════════════════════════════════════════════════
class _AddOnsList extends StatelessWidget {
  final _PackagePalette p;
  final List<BxPackageAddon> addons;
  final List<int> selected;
  final ValueChanged<int> onToggle;

  const _AddOnsList({
    required this.p,
    required this.addons,
    required this.selected,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final visible = addons.where((a) => a.active != false).toList();
    if (visible.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          for (var i = 0; i < visible.length; i++)
            Padding(
              padding: EdgeInsets.only(bottom: 10.h),
              child: GestureDetector(
                onTap: () => onToggle(i),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 14.w,
                    vertical: 12.h,
                  ),
                  decoration: BoxDecoration(
                    color: selected.contains(i)
                        ? p.primary.withOpacity(0.08)
                        : p.cardSurface,
                    borderRadius: BorderRadius.circular(66),
                    border: Border.all(
                      color: selected.contains(i) ? p.primary : p.border,
                      width: selected.contains(i) ? 1.5 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 22,
                        height: 22,
                        decoration: BoxDecoration(
                          color: selected.contains(i)
                              ? p.primary
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: selected.contains(i)
                                ? p.primary
                                : p.textMuted,
                            width: 1.5,
                          ),
                        ),
                        child: selected.contains(i)
                            ? Icon(Icons.check, size: 14, color: Colors.white)
                            : null,
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              visible[i].addonType ?? 'Add-on',
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                                color: p.textPrimary,
                                fontFamily: 'lao-mn',
                              ),
                            ),
                            if ((visible[i].priceModel ?? '').isNotEmpty) ...[
                              SizedBox(height: 2.h),
                              Text(
                                visible[i].priceModel!,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  color: p.textMuted,
                                  fontFamily: 'lao-mn',
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      SizedBox(width: 8.w),
                      if (visible[i].estimatedPrice != null)
                        Text(
                          '+${_fmtPrice(visible[i].estimatedPrice)}',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w700,
                            color: p.primary,
                            fontFamily: 'lao-mn',
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
// AMENITIES (from highlights)
// ═══════════════════════════════════════════════════════════
class _AmenitiesGrid extends StatelessWidget {
  final _PackagePalette p;
  final List<BxPackageHighlight> highlights;
  const _AmenitiesGrid({required this.p, required this.highlights});

  static IconData _iconFor(String? name) {
    final s = (name ?? '').toLowerCase();
    if (s.contains('wifi') || s.contains('internet')) return Icons.wifi;
    if (s.contains('dining') || s.contains('restaurant')) {
      return Icons.restaurant;
    }
    if (s.contains('pool') || s.contains('sun')) {
      return Icons.wb_sunny_outlined;
    }
    if (s.contains('spa')) return Icons.spa_outlined;
    if (s.contains('entertain') || s.contains('music')) {
      return Icons.music_note_outlined;
    }
    if (s.contains('library') || s.contains('book')) {
      return Icons.menu_book_outlined;
    }
    if (s.contains('gift') || s.contains('shop')) return Icons.card_giftcard;
    return Icons.star_outline;
  }

  @override
  Widget build(BuildContext context) {
    final items = highlights
        .map((h) => MapEntry(_iconFor(h.name), h.name ?? ''))
        .where((e) => e.value.isNotEmpty)
        .toList();
    if (items.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Wrap(
        spacing: 12.w,
        runSpacing: 12.h,
        children: items.map((e) {
          return SizedBox(
            width: (MediaQuery.of(context).size.width - 32.w - 12.w) / 2,
            child: Row(
              children: [
                Icon(e.key, size: 18, color: p.primary),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    e.value,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: p.textSecondary,
                      fontFamily: 'lao-mn',
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
// CALENDAR (stateless — selection via BLoC)
// ═══════════════════════════════════════════════════════════
class _CalendarSection extends StatelessWidget {
  final _PackagePalette p;
  final List<BxPackageAvailability> availability;
  final int? basePrice;
  final int selectedIndex;
  final ValueChanged<int> onSelect;

  const _CalendarSection({
    required this.p,
    required this.availability,
    required this.basePrice,
    required this.selectedIndex,
    required this.onSelect,
  });

  static const _weekdays = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

  @override
  Widget build(BuildContext context) {
    if (availability.isEmpty) return const SizedBox.shrink();

    final departureDays = <int>{
      for (final a in availability)
        if (DateTime.tryParse(a.startDate ?? '') != null)
          DateTime.parse(a.startDate!).day,
    };

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: _weekdays
                .map(
                  (d) => Expanded(
                    child: Center(
                      child: Text(
                        d,
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w600,
                          color: p.textMuted,
                          fontFamily: 'lao-mn',
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          SizedBox(height: 8.h),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 30,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisSpacing: 6,
              crossAxisSpacing: 6,
              childAspectRatio: 38.7 / 36,
            ),
            itemBuilder: (_, i) {
              final day = i + 1;
              final isSelected = i == selectedIndex;
              final hasStart = departureDays.contains(day);
              final highlightColor = hasStart ? p.warning : p.primary;

              return GestureDetector(
                onTap: () => onSelect(i),
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isSelected ? highlightColor : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isSelected ? highlightColor : p.border,
                    ),
                  ),
                  child: Text(
                    '$day',
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: isSelected
                          ? FontWeight.w700
                          : FontWeight.w500,
                      color: isSelected ? Colors.white : p.textPrimary,
                      fontFamily: 'lao-mn',
                    ),
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 14.h),
          Wrap(
            spacing: 16.w,
            runSpacing: 8.h,
            children: [
              _legend(p.primary, 'Standard Rate: ${_fmtPrice(basePrice)}'),
              if (departureDays.isNotEmpty)
                _legend(p.warning, 'Departures marked in orange'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _legend(Color c, String text) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(color: c, shape: BoxShape.circle),
      ),
      SizedBox(width: 6.w),
      Text(
        text,
        style: TextStyle(
          fontSize: 11.sp,
          color: p.textSecondary,
          fontFamily: 'lao-mn',
        ),
      ),
    ],
  );
}

// ═══════════════════════════════════════════════════════════
// REVIEW FORM (stateful ONLY for its TextEditingController)
// ═══════════════════════════════════════════════════════════
class _ReviewForm extends StatefulWidget {
  final _PackagePalette p;
  final int rating;
  final ValueChanged<int> onRating;

  const _ReviewForm({
    required this.p,
    required this.rating,
    required this.onRating,
  });

  @override
  State<_ReviewForm> createState() => _ReviewFormState();
}

class _ReviewFormState extends State<_ReviewForm> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.p;
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: p.cardSurface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: p.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Rating:',
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: p.textPrimary,
              fontFamily: 'lao-mn',
            ),
          ),
          SizedBox(height: 6.h),
          Row(
            children: List.generate(5, (i) {
              return GestureDetector(
                onTap: () => widget.onRating(i + 1),
                child: Padding(
                  padding: EdgeInsets.only(right: 4.w),
                  child: Icon(
                    i < widget.rating ? Icons.star : Icons.star_border,
                    size: 26,
                    color: p.starFilled,
                  ),
                ),
              );
            }),
          ),
          SizedBox(height: 12.h),
          TextField(
            controller: _controller,
            maxLines: 4,
            maxLength: 500,
            style: TextStyle(
              fontSize: 12.sp,
              color: p.textPrimary,
              fontFamily: 'lao-mn',
            ),
            decoration: InputDecoration(
              hintText: 'Share your experience...',
              hintStyle: TextStyle(
                fontSize: 12.sp,
                color: p.textMuted,
                fontFamily: 'lao-mn',
              ),
              counterStyle: TextStyle(
                fontSize: 10.sp,
                color: p.textMuted,
                fontFamily: 'lao-mn',
              ),
              filled: true,
              fillColor: p.surface,
              contentPadding: EdgeInsets.all(12.w),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: p.border),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: p.border),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: p.primary),
              ),
            ),
          ),
          SizedBox(height: 10.h),
          SizedBox(
            width: double.infinity,
            height: 44,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: p.primary,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(26),
                ),
              ),
              child: Text(
                'Submit Review',
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'lao-mn',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
// BOOKING FORM (stateful ONLY for its TextEditingControllers)
// ═══════════════════════════════════════════════════════════
class _BookingForm extends StatefulWidget {
  final _PackagePalette p;
  final List<BxPackageHotel> hotels;
  final int selectedCabinIndex;
  final ValueChanged<int> onCabinSelected;
  final int nights;

  const _BookingForm({
    required this.p,
    required this.hotels,
    required this.selectedCabinIndex,
    required this.onCabinSelected,
    required this.nights,
  });

  @override
  State<_BookingForm> createState() => _BookingFormState();
}

class _BookingFormState extends State<_BookingForm> {
  final _dateCtrl = TextEditingController();
  final _nameCtrl = TextEditingController();
  final _adultsCtrl = TextEditingController(text: '2');
  final _childrenCtrl = TextEditingController(text: '0');
  final _requestsCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();

  @override
  void dispose() {
    _dateCtrl.dispose();
    _nameCtrl.dispose();
    _adultsCtrl.dispose();
    _childrenCtrl.dispose();
    _requestsCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.p;
    final cabins = widget.hotels;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _label('Travel Date', p),
        _field(
          _dateCtrl,
          'mm/dd/yyyy',
          icon: Icons.calendar_today_outlined,
          p: p,
        ),
        SizedBox(height: 14.h),
        _label('Full Name', p),
        _field(_nameCtrl, 'John Doe', p: p),
        SizedBox(height: 14.h),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _label('Adults', p),
                  _field(
                    _adultsCtrl,
                    '2',
                    keyboard: TextInputType.number,
                    p: p,
                  ),
                ],
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _label('Children', p),
                  _field(
                    _childrenCtrl,
                    '0',
                    keyboard: TextInputType.number,
                    p: p,
                  ),
                ],
              ),
            ),
          ],
        ),
        if (cabins.isNotEmpty) ...[
          SizedBox(height: 14.h),
          _label('Cabin Type', p),
          SizedBox(height: 8.h),
          Row(
            children: List.generate(cabins.length, (i) {
              final isSel = i == widget.selectedCabinIndex;
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: i == 0 ? 8.w : 0),
                  child: GestureDetector(
                    onTap: () => widget.onCabinSelected(i),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 12.h,
                        horizontal: 12.w,
                      ),
                      decoration: BoxDecoration(
                        color: isSel
                            ? p.primary.withOpacity(0.08)
                            : p.cardSurface,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSel ? p.primary : p.border,
                          width: isSel ? 1.5 : 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            cabins[i].optionName ??
                                cabins[i].roomType ??
                                'Room',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: p.textPrimary,
                              fontFamily: 'lao-mn',
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            cabins[i].pricePerNightEst != null
                                ? _fmtPrice(cabins[i].pricePerNightEst)
                                : '—',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w700,
                              color: p.primary,
                              fontFamily: 'lao-mn',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
        SizedBox(height: 14.h),
        _label('Special Requests', p),
        _field(_requestsCtrl, 'Any special requests...', maxLines: 3, p: p),
        SizedBox(height: 14.h),
        _label('Contact Information', p),
        SizedBox(height: 8.h),
        _field(
          _emailCtrl,
          'Email address',
          keyboard: TextInputType.emailAddress,
          p: p,
        ),
        SizedBox(height: 10.h),
        _field(_phoneCtrl, 'Phone number', keyboard: TextInputType.phone, p: p),
      ],
    );
  }

  Widget _label(String t, _PackagePalette p) => Padding(
    padding: EdgeInsets.only(bottom: 6.h),
    child: Text(
      t,
      style: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w600,
        color: p.textPrimary,
        fontFamily: 'lao-mn',
      ),
    ),
  );

  Widget _field(
    TextEditingController c,
    String hint, {
    int maxLines = 1,
    TextInputType? keyboard,
    IconData? icon,
    required _PackagePalette p,
  }) {
    return TextField(
      controller: c,
      maxLines: maxLines,
      keyboardType: keyboard,
      style: TextStyle(
        fontSize: 12.sp,
        color: p.textPrimary,
        fontFamily: 'lao-mn',
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          fontSize: 12.sp,
          color: p.textMuted,
          fontFamily: 'lao-mn',
        ),
        suffixIcon: icon != null
            ? Icon(icon, size: 16, color: p.textMuted)
            : null,
        filled: true,
        fillColor: p.surface,
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: p.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: p.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: p.primary),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
// NEED HELP TILE
// ═══════════════════════════════════════════════════════════
class _NeedHelpTile extends StatelessWidget {
  final _PackagePalette p;
  const _NeedHelpTile({required this.p});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showHelpSheet(context, p),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: p.cardSurface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: p.border),
        ),
        child: Row(
          children: [
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: p.primary.withOpacity(0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(Icons.support_agent, size: 18, color: p.primary),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Need Help?',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: p.textPrimary,
                      fontFamily: 'lao-mn',
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    'Our support team is here for you',
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: p.textMuted,
                      fontFamily: 'lao-mn',
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 14, color: p.textMuted),
          ],
        ),
      ),
    );
  }

  void _showHelpSheet(BuildContext context, _PackagePalette p) {
    showModalBottomSheet(
      context: context,
      backgroundColor: p.cardSurface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: p.border,
                  borderRadius: BorderRadius.circular(99),
                ),
              ),
              SizedBox(height: 16.h),
              Icon(Icons.support_agent, size: 40, color: p.primary),
              SizedBox(height: 12.h),
              Text(
                'Need Help?',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: p.textPrimary,
                  fontFamily: 'lao-mn',
                ),
              ),
              SizedBox(height: 6.h),
              Text(
                'Our support team is here for you',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: p.textSecondary,
                  fontFamily: 'lao-mn',
                ),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        );
      },
    );
  }
}

// ═══════════════════════════════════════════════════════════
// BOTTOM PAY BAR
// ═══════════════════════════════════════════════════════════
class _BottomPayBar extends StatelessWidget {
  final _PackagePalette p;
  final BxGetPackageDetailData data;
  const _BottomPayBar({required this.p, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 16.h),
      decoration: BoxDecoration(
        color: p.cardSurface,
        border: Border(top: BorderSide(color: p.border)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _fmtPrice(data.displayPrice),
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: p.textPrimary,
                    fontFamily: 'lao-mn',
                  ),
                ),
                Text(
                  'per person',
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: p.textMuted,
                    fontFamily: 'lao-mn',
                  ),
                ),
              ],
            ),
            const Spacer(),
            SizedBox(
              width: 118.97,
              height: 45,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: p.primary,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Pay Now',
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
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
