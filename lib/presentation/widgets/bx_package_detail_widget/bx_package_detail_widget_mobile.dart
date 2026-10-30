// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/widgets/bx_package_detail_widget/bx_package_detail_widget_mobile.dart
// Architecture: Presentation Layer - Bx package detail mobile Widget
// Purpose: Professional Bx package detail mobile widget for mobile devices

// ignore_for_file: unnecessary_underscores, unused_field, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BxPackageDetailWidgetMobile extends StatefulWidget {
  const BxPackageDetailWidgetMobile({super.key});

  @override
  State<BxPackageDetailWidgetMobile> createState() =>
      _BxPackageDetailWidgetMobileState();
}

class _BxPackageDetailWidgetMobileState
    extends State<BxPackageDetailWidgetMobile> {
  final PageController _imageController = PageController();
  int _currentImage = 0;
  int _selectedDateIndex = 0;
  int _userRating = 0;
  final List<int> _selectedAddOns = [];
  final TextEditingController _reviewController = TextEditingController();

  // Sample image list — replace with API data
  final List<String> _images = List.generate(
    5,
    (i) =>
        'https://images.unsplash.com/photo-1568322445389-f64ac2515020?w=800&q=80',
  );

  @override
  void dispose() {
    _imageController.dispose();
    _reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Theme.of(context);
    final p = _PackagePalette.of(context);

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
                      images: _images,
                      controller: _imageController,
                      currentIndex: _currentImage,
                      onPageChanged: (i) => setState(() => _currentImage = i),
                      p: p,
                    ),
                    SizedBox(height: 12.h),
                    _TagChipsRow(p: p),
                    SizedBox(height: 14.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: _TitleAndDescription(p: p),
                    ),
                    SizedBox(height: 10.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: _RatingRow(p: p),
                    ),
                    SizedBox(height: 12.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: _MetaRow(p: p),
                    ),
                    SizedBox(height: 16.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: _FeatureChips(p: p),
                    ),
                    SizedBox(height: 16.h),
                    _Divider(p: p),
                    SizedBox(height: 16.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: _PriceBlock(p: p),
                    ),
                    SizedBox(height: 20.h),
                    _SectionHeader(title: 'Image Gallery', p: p),
                    SizedBox(height: 10.h),
                    _GalleryGrid(p: p),
                    SizedBox(height: 22.h),
                    _SectionHeader(title: 'Daily Itinerary', p: p),
                    SizedBox(height: 10.h),
                    _ItineraryList(p: p),
                    SizedBox(height: 22.h),
                    _SectionHeader(title: "What's Included", p: p),
                    SizedBox(height: 10.h),
                    _IncludedSection(p: p),
                    SizedBox(height: 20.h),
                    _SectionHeader(title: 'Not Included', p: p),
                    SizedBox(height: 10.h),
                    _NotIncludedSection(p: p),
                    SizedBox(height: 22.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: _DocumentsCard(p: p),
                    ),
                    SizedBox(height: 22.h),
                    _SectionHeader(title: 'Optional Add-ons', p: p),
                    SizedBox(height: 10.h),
                    _AddOnsList(
                      p: p,
                      selected: _selectedAddOns,
                      onToggle: (i) => setState(() {
                        if (_selectedAddOns.contains(i)) {
                          _selectedAddOns.remove(i);
                        } else {
                          _selectedAddOns.add(i);
                        }
                      }),
                    ),
                    SizedBox(height: 22.h),
                    _SectionHeader(title: 'Ship Amenities', p: p),
                    SizedBox(height: 12.h),
                    _AmenitiesGrid(p: p),
                    SizedBox(height: 22.h),
                    _SectionHeader(title: 'Available Dates & Pricing', p: p),
                    SizedBox(height: 12.h),
                    _CalendarSection(
                      p: p,
                      selectedIndex: _selectedDateIndex,
                      onSelect: (i) => setState(() => _selectedDateIndex = i),
                    ),
                    SizedBox(height: 22.h),
                    _SectionHeader(title: 'Write a Review', p: p),
                    SizedBox(height: 10.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: _ReviewForm(
                        p: p,
                        rating: _userRating,
                        controller: _reviewController,
                        onRating: (r) => setState(() => _userRating = r),
                      ),
                    ),
                    SizedBox(height: 18.h),
                    _ReviewsList(p: p),
                    SizedBox(height: 22.h),
                    _SectionHeader(title: 'Book Your Cruise', p: p),
                    SizedBox(height: 12.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: _BookingForm(p: p),
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
      bottomSheet: _BottomPayBar(p: p),
    );
  }
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
// IMAGE CAROUSEL (Step 2)
// ═══════════════════════════════════════════════════════════
class _ImageCarousel extends StatelessWidget {
  final List<String> images;
  final PageController controller;
  final int currentIndex;
  final ValueChanged<int> onPageChanged;
  final _PackagePalette p;

  const _ImageCarousel({
    required this.images,
    required this.controller,
    required this.currentIndex,
    required this.onPageChanged,
    required this.p,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 256,
      child: Stack(
        children: [
          PageView.builder(
            controller: controller,
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
          // Top-left Popular badge + top-right heart (Step 2)
          Positioned(
            top: 12,
            left: 12,
            right: 12,
            child: Row(
              children: [
                Container(
                  width: 72.56,
                  height: 28,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: p.warning,
                    borderRadius: BorderRadius.circular(9999),
                  ),
                  child: Text(
                    'Popular',
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
          // Bottom-left dots (Step 2)
          Positioned(
            left: 16,
            bottom: 12,
            child: Row(
              children: List.generate(images.length, (i) {
                final active = i == currentIndex;
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
// TAG CHIPS (Step 3)
// ═══════════════════════════════════════════════════════════
class _TagChipsRow extends StatelessWidget {
  final _PackagePalette p;
  const _TagChipsRow({required this.p});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          _chip('Save 8%', p.success),
          SizedBox(width: 8.w),
          _chip('Limited Time', p.warning),
        ],
      ),
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
// TITLE + DESC (Steps 4-5)
// ═══════════════════════════════════════════════════════════
class _TitleAndDescription extends StatelessWidget {
  final _PackagePalette p;
  const _TitleAndDescription({required this.p});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Luxury Nile Cruise 5D/4N',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            color: p.textPrimary,
            fontFamily: 'lao-mn',
            height: 1.3,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          'Experience the ultimate luxury along the legendary Nile River. '
          'This premium 5-day cruise combines world-class amenities with '
          "expertly guided tours of Egypt's most magnificent temples and "
          'archaeological sites.',
          style: TextStyle(
            fontSize: 13.sp,
            color: p.textSecondary,
            fontFamily: 'lao-mn',
            height: 1.55,
          ),
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════
// RATING (Step 6)
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
// META ROW (Step 7)
// ═══════════════════════════════════════════════════════════
class _MetaRow extends StatelessWidget {
  final _PackagePalette p;
  const _MetaRow({required this.p});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.access_time, size: 16, color: p.primary),
        SizedBox(width: 6.w),
        Text(
          '5 Days / 4 Nights',
          style: TextStyle(
            fontSize: 12.sp,
            color: p.textSecondary,
            fontFamily: 'lao-mn',
          ),
        ),
        SizedBox(width: 16.w),
        Icon(Icons.location_on_outlined, size: 16, color: p.primary),
        SizedBox(width: 6.w),
        Text(
          'Luxor to Aswan',
          style: TextStyle(
            fontSize: 12.sp,
            color: p.textSecondary,
            fontFamily: 'lao-mn',
          ),
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════
// FEATURE CHIPS (Step 8)
// ═══════════════════════════════════════════════════════════
class _FeatureChips extends StatelessWidget {
  final _PackagePalette p;
  const _FeatureChips({required this.p});

  @override
  Widget build(BuildContext context) {
    final items = <String, Color>{
      'Full Board': p.primary,
      'Temple Tours': p.primary,
      'Expert Guide': p.primary,
      '5 Star Ship': p.success,
    };
    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      children: items.entries.map((e) {
        return Container(
          height: 28,
          width: 120,
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: e.value.withOpacity(0.12),
            borderRadius: BorderRadius.circular(9999),
            border: Border.all(color: e.value.withOpacity(0.4)),
          ),
          child: Text(
            e.key,
            style: TextStyle(
              color: e.value,
              fontSize: 11.sp,
              fontWeight: FontWeight.w500,
              fontFamily: 'lao-mn',
            ),
          ),
        );
      }).toList(),
    );
  }
}

// ═══════════════════════════════════════════════════════════
// DIVIDER (Step 9)
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
// PRICE BLOCK (Step 10)
// ═══════════════════════════════════════════════════════════
class _PriceBlock extends StatelessWidget {
  final _PackagePalette p;
  const _PriceBlock({required this.p});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '\$1,200',
          style: TextStyle(
            fontSize: 13.sp,
            color: p.textMuted,
            fontFamily: 'lao-mn',
            decoration: TextDecoration.lineThrough,
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          '\$1,104',
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
// GALLERY GRID (Step 12)
// ═══════════════════════════════════════════════════════════
class _GalleryGrid extends StatelessWidget {
  final _PackagePalette p;
  const _GalleryGrid({required this.p});

  @override
  Widget build(BuildContext context) {
    // 3 columns x 2 rows, last one "+15 images"
    const size = 127.00;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Wrap(
        spacing: 8.w,
        runSpacing: 8.h,
        children: List.generate(6, (i) {
          final isLast = i == 5;
          return ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Container(
              width: size,
              height: size,
              color: p.surface,
              child: isLast
                  ? Center(
                      child: Container(
                        padding: EdgeInsets.all(8.w),
                        height: 55,
                        width: 90,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.55),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          children: [
                            Text(
                              '+15',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'lao-mn',
                              ),
                            ),
                            Text(
                              'images',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'lao-mn',
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Icon(Icons.image, size: 32, color: p.textMuted),
            ),
          );
        }),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
// ITINERARY (Step 14)
// ═══════════════════════════════════════════════════════════
class _ItineraryList extends StatelessWidget {
  final _PackagePalette p;
  const _ItineraryList({required this.p});

  static const _days = <_DayData>[
    _DayData(
      title: 'Day 1: Luxor Embarkation',
      subtitle: 'Temple visits & welcome dinner',
      items: [
        '12:00 : Check-in and welcome aboard luxury cruise ship',
        '14:00 : Guided tour of Karnak Temple Complex',
        '17:00 : Luxor Temple visit at sunset',
        '19:30 : Welcome dinner and evening entertainment',
      ],
    ),
    _DayData(
      title: 'Day 2: Valley of the Kings',
      subtitle: 'Royal tombs & Hatshepsut Temple',
    ),
    _DayData(
      title: 'Day 3: Edfu & Kom Ombo',
      subtitle: 'Temple of Horus & Crocodile Temple',
    ),
    _DayData(title: 'Day 4: Abu Simbel', subtitle: 'Ramses II masterpiece'),
    _DayData(
      title: 'Day 5: Aswan Departure',
      subtitle: 'Philae Temple & farewell',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: List.generate(_days.length, (i) {
          return _DayTile(data: _days[i], p: p);
        }),
      ),
    );
  }
}

class _DayData {
  final String title;
  final String subtitle;
  final List<String> items;
  const _DayData({
    required this.title,
    required this.subtitle,
    this.items = const [],
  });
}

class _DayTile extends StatefulWidget {
  final _DayData data;
  final _PackagePalette p;
  const _DayTile({required this.data, required this.p});

  @override
  State<_DayTile> createState() => _DayTileState();
}

class _DayTileState extends State<_DayTile> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final p = widget.p;
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Material(
        color: p.cardSurface, // background now lives on Material, not Container
        clipBehavior: Clip.antiAlias, // keeps the rounded corners clipped
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: BorderSide(color: p.border),
        ),
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            tilePadding: EdgeInsets.symmetric(horizontal: 14.w),
            childrenPadding: EdgeInsets.fromLTRB(14.w, 0, 14.w, 14.h),
            onExpansionChanged: (v) => setState(() => _expanded = v),
            iconColor: p.primary,
            collapsedIconColor: p.textMuted,
            title: Text(
              widget.data.title,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: p.textPrimary,
                fontFamily: 'lao-mn',
              ),
            ),
            subtitle: Padding(
              padding: EdgeInsets.only(top: 4.h),
              child: Text(
                widget.data.subtitle,
                style: TextStyle(
                  fontSize: 11.sp,
                  color: p.textSecondary,
                  fontFamily: 'lao-mn',
                ),
              ),
            ),
            children: widget.data.items.map((t) {
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
// INCLUDED (Step 16)
// ═══════════════════════════════════════════════════════════
class _IncludedSection extends StatelessWidget {
  final _PackagePalette p;
  const _IncludedSection({required this.p});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          _IncludedCard(
            p: p,
            icon: Icons.home_work_outlined,
            title: 'Accommodation',
            color: p.success,
            items: const [
              '4 nights luxury cruise ship cabin',
              'Private bathroom with river view',
              'Daily housekeeping service',
            ],
          ),
          SizedBox(height: 10.h),
          _IncludedCard(
            p: p,
            icon: Icons.restaurant_outlined,
            title: 'Meals & Dining',
            color: p.success,
            items: const [
              'All meals: 4 breakfasts, 5 lunches, 4 dinners',
              'Welcome and farewell dinners',
              'Afternoon tea and snacks',
            ],
          ),
          SizedBox(height: 10.h),
          _IncludedCard(
            p: p,
            icon: Icons.place_outlined,
            title: 'Tours & Activities',
            color: p.success,
            items: const [
              'All temple visits with expert Egyptologist',
              'Abu Simbel excursion by air-conditioned coach',
              'All entrance fees and permits',
            ],
          ),
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
  final bool isCross; // for not-included

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
// NOT INCLUDED (Step 18)
// ═══════════════════════════════════════════════════════════
class _NotIncludedSection extends StatelessWidget {
  final _PackagePalette p;
  const _NotIncludedSection({required this.p});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: _IncludedCard(
        p: p,
        icon: Icons.info_outline,
        title: 'Not Included',
        color: p.error,
        isCross: true,
        items: const [
          'International flights to/from Egypt',
          'Alcoholic beverages',
          'Personal expenses and tips',
          'Travel insurance',
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
// DOCUMENTS (Step 19)
// ═══════════════════════════════════════════════════════════
class _DocumentsCard extends StatelessWidget {
  final _PackagePalette p;
  const _DocumentsCard({required this.p});

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
            children:
                const [
                      'Passport copy',
                      'National ID',
                      'Personal photo',
                      'Visa documents',
                    ]
                    .map(
                      (t) => Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.check, size: 14, color: p.success),
                          SizedBox(width: 4.w),
                          Text(
                            t,
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
          SizedBox(height: 12.h),
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: p.primary.withOpacity(0.08),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.info_outline, size: 14, color: p.primary),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    'Traveler details will be requested after payment to issue your tickets.',
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: p.textSecondary,
                      fontFamily: 'lao-mn',
                      height: 1.4,
                    ),
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

// ═══════════════════════════════════════════════════════════
// ADD-ONS (Steps 20-21)
// ═══════════════════════════════════════════════════════════
class _AddOnsList extends StatelessWidget {
  final _PackagePalette p;
  final List<int> selected;
  final ValueChanged<int> onToggle;

  const _AddOnsList({
    required this.p,
    required this.selected,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final items = <_AddOnData>[
      _AddOnData(
        'Airport VIP Service',
        'Fast-track & lounge access',
        '+\$85',
        'per person',
      ),
      _AddOnData(
        'Romantic Dinner',
        'Private sunset dinner for two',
        '+\$180',
        'per couple',
      ),
      _AddOnData(
        'Professional Photoshoot',
        '2-hour session with 50+ photos',
        '+\$220',
        'per session',
      ),
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          ...List.generate(items.length, (i) {
            final item = items[i];
            final isSelected = selected.contains(i);
            return Padding(
              padding: EdgeInsets.only(bottom: 10.h),
              child: GestureDetector(
                onTap: () => onToggle(i),
                child: Container(
                  width: 311,
                  height: 66,
                  padding: EdgeInsets.symmetric(horizontal: 14.w),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? p.primary.withOpacity(0.08)
                        : p.cardSurface,
                    borderRadius: BorderRadius.circular(66),
                    border: Border.all(
                      color: isSelected ? p.primary : p.border,
                      width: isSelected ? 1.5 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      // Checkbox
                      Container(
                        width: 22,
                        height: 22,
                        decoration: BoxDecoration(
                          color: isSelected ? p.primary : Colors.transparent,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: isSelected ? p.primary : p.textMuted,
                            width: 1.5,
                          ),
                        ),
                        child: isSelected
                            ? Icon(Icons.check, size: 14, color: Colors.white)
                            : null,
                      ),
                      SizedBox(width: 12.w),
                      // Texts
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.title,
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                                color: p.textPrimary,
                                fontFamily: 'lao-mn',
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              item.subtitle,
                              style: TextStyle(
                                fontSize: 10.sp,
                                color: p.textMuted,
                                fontFamily: 'lao-mn',
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 8.w),
                      // Price
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            item.price,
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w700,
                              color: p.primary,
                              fontFamily: 'lao-mn',
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            item.unit,
                            style: TextStyle(
                              fontSize: 9.sp,
                              color: p.textMuted,
                              fontFamily: 'lao-mn',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
          // Custom Plan card
          GestureDetector(
            onTap: () {},
            child: Container(
              width: 311,
              height: 66,
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              decoration: BoxDecoration(
                color: p.cardSurface,
                borderRadius: BorderRadius.circular(66),
                border: Border.all(color: p.border),
              ),
              child: Row(
                children: [
                  Container(
                    width: 22,
                    height: 22,
                    decoration: BoxDecoration(
                      color: p.primary.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Icon(
                      Icons.edit_outlined,
                      size: 14,
                      color: p.primary,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Build Custom Plan',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: p.textPrimary,
                            fontFamily: 'lao-mn',
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          'Personalize your entire itinerary',
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
          ),
        ],
      ),
    );
  }
}

class _AddOnData {
  final String title;
  final String subtitle;
  final String price;
  final String unit;
  const _AddOnData(this.title, this.subtitle, this.price, this.unit);
}

// ═══════════════════════════════════════════════════════════
// AMENITIES (Steps 22-23)
// ═══════════════════════════════════════════════════════════
class _AmenitiesGrid extends StatelessWidget {
  final _PackagePalette p;
  const _AmenitiesGrid({required this.p});

  @override
  Widget build(BuildContext context) {
    final items = <MapEntry<IconData, String>>[
      const MapEntry(Icons.wifi, 'Free WiFi'),
      const MapEntry(Icons.restaurant, 'Fine Dining'),
      const MapEntry(Icons.wb_sunny_outlined, 'Sun Deck Pool'),
      const MapEntry(Icons.spa_outlined, 'Spa Services'),
      const MapEntry(Icons.music_note_outlined, 'Live Entertainment'),
      const MapEntry(Icons.menu_book_outlined, 'Library Lounge'),
      const MapEntry(Icons.card_giftcard, 'Gift Shop'),
      const MapEntry(Icons.favorite_border, '24/7 Service'),
    ];

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
// CALENDAR (Steps 24-25)
// ═══════════════════════════════════════════════════════════
class _CalendarSection extends StatelessWidget {
  final _PackagePalette p;
  final int selectedIndex;
  final ValueChanged<int> onSelect;

  const _CalendarSection({
    required this.p,
    required this.selectedIndex,
    required this.onSelect,
  });

  static const _weekdays = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Weekday row
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
          // Dates 1-30 (start on Sunday = no offset for simplicity)
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
              // Simulate some peak-season days with orange
              final isPeak = day == 12 || day == 18 || day == 24;
              final highlightColor = isPeak ? p.warning : p.primary;

              return GestureDetector(
                onTap: () => onSelect(i),
                child: Container(
                  width: 38.7,
                  height: 36,
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
          // Legend
          Wrap(
            children: [
              Row(
                children: [
                  _legendDot(p.primary),
                  SizedBox(width: 6.w),
                  Text(
                    'Standard Rate: \$1,200',
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: p.textSecondary,
                      fontFamily: 'lao-mn',
                    ),
                  ),
                ],
              ),
              SizedBox(width: 16.w),
              Row(
                children: [
                  _legendDot(p.warning),
                  SizedBox(width: 6.w),
                  Text(
                    'Peak Season: \$1,500',
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: p.textSecondary,
                      fontFamily: 'lao-mn',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _legendDot(Color c) => Container(
    width: 10,
    height: 10,
    decoration: BoxDecoration(color: c, shape: BoxShape.circle),
  );
}

// ═══════════════════════════════════════════════════════════
// REVIEW FORM (Steps 26-27)
// ═══════════════════════════════════════════════════════════
class _ReviewForm extends StatelessWidget {
  final _PackagePalette p;
  final int rating;
  final TextEditingController controller;
  final ValueChanged<int> onRating;

  const _ReviewForm({
    required this.p,
    required this.rating,
    required this.controller,
    required this.onRating,
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
                onTap: () => onRating(i + 1),
                child: Padding(
                  padding: EdgeInsets.only(right: 4.w),
                  child: Icon(
                    i < rating ? Icons.star : Icons.star_border,
                    size: 26,
                    color: p.starFilled,
                  ),
                ),
              );
            }),
          ),
          SizedBox(height: 12.h),
          TextField(
            controller: controller,
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
// REVIEWS LIST (Step 28)
// ═══════════════════════════════════════════════════════════
class _ReviewsList extends StatelessWidget {
  final _PackagePalette p;
  const _ReviewsList({required this.p});

  @override
  Widget build(BuildContext context) {
    final reviews = [
      _ReviewData(
        name: 'Sarah Mitchell',
        rating: 5,
        date: 'March 2024',
        text:
            'Absolutely magical experience! The cruise ship was luxurious and '
            'the temple tours were incredibly informative. Our Egyptologist '
            'guide brought ancient history to life. The Abu Simbel excursion '
            'was the highlight of our trip.',
      ),
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: reviews.map((r) {
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
                    CircleAvatar(
                      radius: 18,
                      backgroundColor: p.primary.withOpacity(0.15),
                      child: Text(
                        r.name.isNotEmpty ? r.name[0] : '?',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          color: p.primary,
                          fontFamily: 'lao-mn',
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            r.name,
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: p.textPrimary,
                              fontFamily: 'lao-mn',
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Row(
                            children: List.generate(5, (i) {
                              return Icon(
                                i < r.rating ? Icons.star : Icons.star_border,
                                size: 12,
                                color: p.starFilled,
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      r.date,
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: p.textMuted,
                        fontFamily: 'lao-mn',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                Text(
                  r.text,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: p.textSecondary,
                    fontFamily: 'lao-mn',
                    height: 1.5,
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

class _ReviewData {
  final String name;
  final int rating;
  final String date;
  final String text;
  const _ReviewData({
    required this.name,
    required this.rating,
    required this.date,
    required this.text,
  });
}

// ═══════════════════════════════════════════════════════════
// BOOKING FORM (Steps 29-30)
// ═══════════════════════════════════════════════════════════
class _BookingForm extends StatefulWidget {
  final _PackagePalette p;
  const _BookingForm({required this.p});

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
  int _selectedCabin = 0;

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
    final cabins = const [
      ('Single room', '\$1,200'),
      ('Deluxe room', '\$1,400'),
    ];

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
        SizedBox(height: 14.h),
        _label('Cabin Type', p),
        SizedBox(height: 8.h),
        Row(
          children: List.generate(cabins.length, (i) {
            final isSel = i == _selectedCabin;
            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: i == 0 ? 8.w : 0),
                child: GestureDetector(
                  onTap: () => setState(() => _selectedCabin = i),
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
                          cabins[i].$1,
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: p.textPrimary,
                            fontFamily: 'lao-mn',
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          cabins[i].$2,
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
// NEED HELP TILE + BOTTOM SHEET (Step 30 end)
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
              SizedBox(height: 16.h),
              // summary card
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: p.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: p.border),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$2,208',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: p.textPrimary,
                        fontFamily: 'lao-mn',
                      ),
                    ),
                    Text(
                      '2 persons',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: p.textMuted,
                        fontFamily: 'lao-mn',
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 14.h),
              SizedBox(
                width: 118.97,
                height: 45,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
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
              SizedBox(height: 8.h),
              Text(
                'Secure payment via Stripe',
                style: TextStyle(
                  fontSize: 10.sp,
                  color: p.textMuted,
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
  const _BottomPayBar({required this.p});

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
                  '\$2,208',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: p.textPrimary,
                    fontFamily: 'lao-mn',
                  ),
                ),
                Text(
                  '2 persons',
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
