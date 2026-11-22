// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/widgets/bx_update_profile_widget/bx_update_profile_screen_body_mobile.dart
// Architecture: Presentation Layer - Update Profile (Mobile)
// Purpose: Mobile layout for the "Edit Profile" screen — adaptive dark/light + MediaQuery.

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_selector/intl_phone_selector.dart';
import 'package:tayara/presentation/bloc/bx_update_profile_screen_controller/bx_update_profile_screen_controller_bloc.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Responsive helper – all sizes scale relative to a 390 × 844 reference device.
// ─────────────────────────────────────────────────────────────────────────────
class _R {
  final double w;
  final double h;
  final bool isDark;
  final double textScale;

  _R(BuildContext context)
    : w = MediaQuery.sizeOf(context).width,
      h = MediaQuery.sizeOf(context).height,
      isDark = Theme.of(context).brightness == Brightness.dark,
      textScale = MediaQuery.textScalerOf(context).scale(1);

  // Horizontal scale factor (clamped so tablets don't explode).
  double get sx => (w / 390).clamp(0.75, 1.35);

  // Vertical scale factor.
  double get sy => (h / 844).clamp(0.75, 1.35);

  // Uniform scale (average of both axes).
  double get s => ((sx + sy) / 2).clamp(0.8, 1.3);

  // Convenience scaled values.
  double sp(double v) => v * sx; // horizontal padding / width
  double vp(double v) => v * sy; // vertical padding / height
  double r(double v) => v * s; // radius / icon size
  double fs(double v) => (v * s) / textScale.clamp(0.85, 1.4); // font size
}

// ─────────────────────────────────────────────────────────────────────────────
// Adaptive colour palette – derived from ColorScheme but with extra tokens.
// ─────────────────────────────────────────────────────────────────────────────
class _Palette {
  final ColorScheme cs;
  final bool dark;

  _Palette(this.cs, this.dark);

  Color get cardBg =>
      dark ? cs.surfaceContainerHigh : cs.surfaceContainerLowest;
  Color get cardBorder => dark
      ? cs.outlineVariant.withValues(alpha: 0.25)
      : cs.outlineVariant.withValues(alpha: 0.35);
  Color get fieldFill => dark
      ? cs.surfaceContainerHighest.withValues(alpha: 0.5)
      : cs.surfaceContainerLow;
  Color get fieldBorder => dark
      ? cs.outlineVariant.withValues(alpha: 0.3)
      : cs.outlineVariant.withValues(alpha: 0.45);
  Color get fieldFocused => cs.primary;
  Color get labelColor => cs.onSurfaceVariant;
  Color get hintColor => cs.onSurfaceVariant.withValues(alpha: 0.55);
  Color get sectionIconBg => cs.primary.withValues(alpha: dark ? 0.18 : 0.10);
  Color get avatarRing => cs.primary.withValues(alpha: dark ? 0.35 : 0.20);
  Color get avatarBg => cs.primary.withValues(alpha: dark ? 0.12 : 0.06);
  Color get shadowColor => dark
      ? Colors.black.withValues(alpha: 0.35)
      : Colors.black.withValues(alpha: 0.06);
  Color get buttonDisabledBg =>
      dark ? cs.surfaceContainerHighest : cs.surfaceContainerHigh;
  Color get buttonDisabledFg => cs.onSurface.withValues(alpha: 0.38);
  Color get dividerColor => cs.outlineVariant.withValues(alpha: 0.18);
}

// ─────────────────────────────────────────────────────────────────────────────
// Main widget
// ─────────────────────────────────────────────────────────────────────────────
class BxUpdateProfileScreenBodyMobile extends StatelessWidget {
  const BxUpdateProfileScreenBodyMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final r = _R(context);
    final p = _Palette(theme.colorScheme, r.isDark);
    final bloc = context.read<BxUpdateProfileScreenControllerBloc>();

    return BlocBuilder<
      BxUpdateProfileScreenControllerBloc,
      BxUpdateProfileScreenControllerState
    >(
      builder: (context, state) {
        final isLoading = state.isSubmitting;

        return SafeArea(
          top: false,
          child: Form(
            key: bloc.formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.fromLTRB(
                r.sp(20),
                r.vp(28),
                r.sp(20),
                r.vp(24),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // ── Avatar ──
                  _AvatarEditor(bloc: bloc, state: state, r: r, p: p),
                  SizedBox(height: r.vp(36)),

                  // ── Personal Information ──
                  _SectionCard(
                    title: 'Personal Information',
                    icon: Icons.badge_outlined,
                    r: r,
                    p: p,
                    children: [
                      _buildTextField(
                        controller: bloc.fullNameController,
                        label: 'Full Name',
                        hint: 'Enter your full name',
                        icon: Icons.person_outline_rounded,
                        enabled: !isLoading,
                        r: r,
                        p: p,
                        validator: (v) => (v == null || v.trim().isEmpty)
                            ? 'Full name is required'
                            : null,
                      ),
                      SizedBox(height: r.vp(18)),
                      _buildTextField(
                        controller: bloc.nickNameController,
                        label: 'Nick Name',
                        hint: 'Display name (optional)',
                        icon: Icons.alternate_email_rounded,
                        enabled: !isLoading,
                        r: r,
                        p: p,
                      ),
                      SizedBox(height: r.vp(18)),
                      _buildTextField(
                        controller: bloc.emailController,
                        label: 'Email',
                        hint: 'you@example.com',
                        icon: Icons.mail_outline_rounded,
                        keyboardType: TextInputType.emailAddress,
                        enabled: !isLoading,
                        r: r,
                        p: p,
                        validator: (v) {
                          if (v == null || v.trim().isEmpty) {
                            return 'Email is required';
                          }
                          final ok = RegExp(
                            r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
                          ).hasMatch(v.trim());
                          return ok ? null : 'Enter a valid email';
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: r.vp(18)),

                  // ── Contact Information ──
                  _SectionCard(
                    title: 'Contact Information',
                    icon: Icons.contact_phone_outlined,
                    r: r,
                    p: p,
                    children: [
                      _buildPhoneField(r, p, bloc),
                      SizedBox(height: r.vp(18)),
                      _buildNationalityField(r, p, bloc, state, isLoading),
                    ],
                  ),
                  SizedBox(height: r.vp(18)),

                  // ── Additional Information ──
                  _SectionCard(
                    title: 'Additional Information',
                    icon: Icons.info_outline_rounded,
                    r: r,
                    p: p,
                    children: [
                      _buildDateOfBirthField(
                        context,
                        r,
                        p,
                        bloc,
                        state,
                        isLoading,
                      ),
                    ],
                  ),
                  SizedBox(height: r.vp(36)),

                  // ── Save Button ──
                  _SaveButton(isLoading: isLoading, bloc: bloc, r: r, p: p),
                  SizedBox(height: r.vp(24)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // ───────────────────────────────────────────────────────────────────────────
  // Field builders
  // ───────────────────────────────────────────────────────────────────────────

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    required bool enabled,
    required _R r,
    required _Palette p,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      enabled: enabled,
      keyboardType: keyboardType,
      validator: validator,
      style: TextStyle(
        fontSize: r.fs(15),
        color: p.cs.onSurface,
        fontWeight: FontWeight.w500,
      ),
      decoration: _inputDecoration(
        label: label,
        hint: hint,
        icon: icon,
        r: r,
        p: p,
      ),
    );
  }

  Widget _buildPhoneField(
    _R r,
    _Palette p,
    BxUpdateProfileScreenControllerBloc bloc,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: r.sp(4), bottom: r.vp(8)),
          child: Text(
            'Phone Number',
            style: TextStyle(
              fontSize: r.fs(12),
              color: p.labelColor,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.3,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: p.fieldFill,
            borderRadius: BorderRadius.circular(r.r(14)),
            border: Border.all(color: p.fieldBorder, width: 1),
          ),
          padding: EdgeInsets.symmetric(horizontal: r.sp(4), vertical: r.vp(2)),
          child: AdvancedPhoneInput(
            controller: bloc.phoneController,
            showFlag: true,
            showCountryCode: true,
            showValidationIcon: true,
            enableSearch: true,
            hintText: '50 123 4567',
            labelText: '',
            onCountryChanged: (country) {
              bloc.add(BxChangePhoneCountryCodeEvent(country.dialCode));
            },
          ),
        ),
      ],
    );
  }

  Widget _buildNationalityField(
    _R r,
    _Palette p,
    BxUpdateProfileScreenControllerBloc bloc,
    BxUpdateProfileScreenControllerState state,
    bool isLoading,
  ) {
    const options = ['Emirati', 'Egyptian', 'Saudi', 'British', 'American'];

    return DropdownButtonFormField<String>(
      decoration: _inputDecoration(
        label: 'Nationality',
        icon: Icons.flag_outlined,
        r: r,
        p: p,
      ),
      dropdownColor: p.cardBg,
      borderRadius: BorderRadius.circular(r.r(14)),
      icon: Icon(
        Icons.keyboard_arrow_down_rounded,
        color: p.labelColor,
        size: r.r(22),
      ),
      style: TextStyle(
        fontSize: r.fs(15),
        color: p.cs.onSurface,
        fontWeight: FontWeight.w500,
      ),
      items: options
          .map(
            (o) => DropdownMenuItem(
              value: o,
              child: Text(o, style: TextStyle(fontSize: r.fs(15))),
            ),
          )
          .toList(),
      onChanged: isLoading
          ? null
          : (v) {
              if (v != null) bloc.add(BxChangeNationalityEvent(v));
            },
    );
  }

  Widget _buildDateOfBirthField(
    BuildContext context,
    _R r,
    _Palette p,
    BxUpdateProfileScreenControllerBloc bloc,
    BxUpdateProfileScreenControllerState state,
    bool isLoading,
  ) {
    final text = state.dateOfBirth == null
        ? 'Not set'
        : DateFormat('MMM d, yyyy').format(state.dateOfBirth!);
    final isPlaceholder = state.dateOfBirth == null;

    return InkWell(
      onTap: isLoading ? null : () => _pickDateOfBirth(context, bloc, state),
      borderRadius: BorderRadius.circular(r.r(14)),
      splashColor: p.cs.primary.withValues(alpha: 0.08),
      highlightColor: p.cs.primary.withValues(alpha: 0.04),
      child: InputDecorator(
        decoration:
            _inputDecoration(
              label: 'Date of Birth',
              icon: Icons.cake_outlined,
              r: r,
              p: p,
            ).copyWith(
              suffixIcon: Icon(
                Icons.calendar_today_outlined,
                size: r.r(18),
                color: p.labelColor,
              ),
            ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: r.fs(15),
            fontWeight: FontWeight.w500,
            color: isPlaceholder ? p.hintColor : p.cs.onSurface,
          ),
        ),
      ),
    );
  }

  Future<void> _pickDateOfBirth(
    BuildContext context,
    BxUpdateProfileScreenControllerBloc bloc,
    BxUpdateProfileScreenControllerState state,
  ) async {
    final now = DateTime.now();
    final theme = Theme.of(context);
    final picked = await showDatePicker(
      context: context,
      initialDate: state.dateOfBirth ?? DateTime(now.year - 20),
      firstDate: DateTime(1900),
      lastDate: now,
      builder: (ctx, child) => Theme(
        data: theme.copyWith(
          colorScheme: theme.colorScheme.copyWith(
            surface: theme.brightness == Brightness.dark
                ? theme.colorScheme.surfaceContainerHigh
                : theme.colorScheme.surface,
          ),
        ),
        child: child!,
      ),
    );
    if (picked != null) {
      bloc.add(BxChangeDateOfBirthEvent(picked));
    }
  }

  InputDecoration _inputDecoration({
    required String label,
    String? hint,
    IconData? icon,
    required _R r,
    required _Palette p,
  }) {
    final radius = BorderRadius.circular(r.r(14));
    return InputDecoration(
      labelText: label,
      hintText: hint,
      labelStyle: TextStyle(
        fontSize: r.fs(14),
        color: p.labelColor,
        fontWeight: FontWeight.w500,
      ),
      floatingLabelStyle: TextStyle(
        fontSize: r.fs(13),
        color: p.cs.primary,
        fontWeight: FontWeight.w600,
      ),
      hintStyle: TextStyle(fontSize: r.fs(14), color: p.hintColor),
      prefixIcon: icon != null
          ? Padding(
              padding: EdgeInsets.only(left: r.sp(14), right: r.sp(10)),
              child: Icon(icon, size: r.r(20), color: p.labelColor),
            )
          : null,
      prefixIconConstraints: BoxConstraints(
        minWidth: r.sp(44),
        minHeight: r.r(20),
      ),
      filled: true,
      fillColor: p.fieldFill,
      contentPadding: EdgeInsets.symmetric(
        horizontal: r.sp(16),
        vertical: r.vp(18),
      ),
      border: OutlineInputBorder(
        borderRadius: radius,
        borderSide: BorderSide(color: p.fieldBorder),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: radius,
        borderSide: BorderSide(color: p.fieldBorder, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: radius,
        borderSide: BorderSide(color: p.fieldFocused, width: 1.8),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: radius,
        borderSide: BorderSide(color: p.cs.error, width: 1.2),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: radius,
        borderSide: BorderSide(color: p.cs.error, width: 1.8),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: radius,
        borderSide: BorderSide(color: p.fieldBorder.withValues(alpha: 0.4)),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Save Button
// ─────────────────────────────────────────────────────────────────────────────
class _SaveButton extends StatelessWidget {
  final bool isLoading;
  final BxUpdateProfileScreenControllerBloc bloc;
  final _R r;
  final _Palette p;

  const _SaveButton({
    required this.isLoading,
    required this.bloc,
    required this.r,
    required this.p,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      height: r.vp(56),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(r.r(16)),
        boxShadow: isLoading
            ? []
            : [
                BoxShadow(
                  color: p.cs.primary.withValues(alpha: r.isDark ? 0.30 : 0.25),
                  blurRadius: r.r(16),
                  offset: Offset(0, r.vp(6)),
                ),
              ],
      ),
      child: ElevatedButton(
        onPressed: isLoading
            ? null
            : () {
                if (bloc.formKey.currentState?.validate() ?? false) {
                  bloc.add(const BxSubmitUpdateProfileEvent());
                }
              },
        style: ElevatedButton.styleFrom(
          backgroundColor: p.cs.primary,
          foregroundColor: p.cs.onPrimary,
          disabledBackgroundColor: p.buttonDisabledBg,
          disabledForegroundColor: p.buttonDisabledFg,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(r.r(16)),
          ),
          padding: EdgeInsets.symmetric(horizontal: r.sp(24)),
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: isLoading
              ? SizedBox(
                  key: const ValueKey('loader'),
                  height: r.r(24),
                  width: r.r(24),
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    strokeCap: StrokeCap.round,
                    color: p.cs.onPrimary,
                  ),
                )
              : Row(
                  key: const ValueKey('label'),
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.check_circle_outline_rounded, size: r.r(20)),
                    SizedBox(width: r.sp(10)),
                    Text(
                      'Save Changes',
                      style: TextStyle(
                        fontSize: r.fs(16),
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Section Card
// ─────────────────────────────────────────────────────────────────────────────
class _SectionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Widget> children;
  final _R r;
  final _Palette p;

  const _SectionCard({
    required this.title,
    required this.icon,
    required this.children,
    required this.r,
    required this.p,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(r.sp(18)),
      decoration: BoxDecoration(
        color: p.cardBg,
        borderRadius: BorderRadius.circular(r.r(20)),
        border: Border.all(color: p.cardBorder, width: 1),
        boxShadow: [
          BoxShadow(
            color: p.shadowColor,
            blurRadius: r.r(12),
            offset: Offset(0, r.vp(4)),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section header
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(r.r(8)),
                decoration: BoxDecoration(
                  color: p.sectionIconBg,
                  borderRadius: BorderRadius.circular(r.r(10)),
                ),
                child: Icon(icon, size: r.r(18), color: p.cs.primary),
              ),
              SizedBox(width: r.sp(12)),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: r.fs(14),
                    fontWeight: FontWeight.w700,
                    color: p.cs.onSurface,
                    letterSpacing: 0.25,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: r.vp(6)),
          Divider(color: p.dividerColor, height: r.vp(20), thickness: 1),
          ...children,
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Avatar Editor
// ─────────────────────────────────────────────────────────────────────────────
class _AvatarEditor extends StatelessWidget {
  final BxUpdateProfileScreenControllerBloc bloc;
  final BxUpdateProfileScreenControllerState state;
  final _R r;
  final _Palette p;

  const _AvatarEditor({
    required this.bloc,
    required this.state,
    required this.r,
    required this.p,
  });

  @override
  Widget build(BuildContext context) {
    final image = _currentImage();
    final avatarSize = r.r(136);
    final innerSize = avatarSize - r.r(8);

    return Center(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Outer glow ring
          Container(
            width: avatarSize,
            height: avatarSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  p.cs.primary.withValues(alpha: r.isDark ? 0.40 : 0.25),
                  p.cs.tertiary.withValues(alpha: r.isDark ? 0.25 : 0.12),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: p.cs.primary.withValues(alpha: r.isDark ? 0.20 : 0.12),
                  blurRadius: r.r(24),
                  spreadRadius: r.r(2),
                ),
              ],
            ),
            padding: EdgeInsets.all(r.r(4)),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: p.cardBg,
              ),
              padding: EdgeInsets.all(r.r(3)),
              child: CircleAvatar(
                radius: innerSize / 2,
                backgroundColor: p.avatarBg,
                backgroundImage: image,
                child: image == null
                    ? Icon(
                        Icons.person_rounded,
                        size: r.r(56),
                        color: p.cs.onSurfaceVariant.withValues(alpha: 0.6),
                      )
                    : null,
              ),
            ),
          ),

          // Camera button
          Positioned(
            bottom: r.r(2),
            right: r.r(2),
            child: _CircleActionButton(
              icon: Icons.camera_alt_rounded,
              bgColor: p.cs.primary,
              fgColor: p.cs.onPrimary,
              size: r.r(40),
              iconSize: r.r(18),
              onTap: () => _showPickerSheet(context),
              shadowColor: p.cs.primary.withValues(alpha: 0.35),
            ),
          ),

          // Remove badge
          if (state.hasPendingImage)
            Positioned(
              top: r.r(2),
              right: r.r(2),
              child: _CircleActionButton(
                icon: Icons.close_rounded,
                bgColor: p.cs.error,
                fgColor: p.cs.onError,
                size: r.r(30),
                iconSize: r.r(14),
                onTap: () => bloc.add(const BxRemovePickedHeaderImageEvent()),
                shadowColor: p.cs.error.withValues(alpha: 0.35),
              ),
            ),
        ],
      ),
    );
  }

  ImageProvider? _currentImage() {
    if (state.pickedHeaderImage != null) {
      return FileImage(File(state.pickedHeaderImage!.path));
    }
    final url = state.existingHeaderImgUrl;
    if (url != null && url.isNotEmpty) return NetworkImage(url);
    return null;
  }

  Future<void> _showPickerSheet(BuildContext context) async {
    await showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      backgroundColor: p.cardBg,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(r.r(24))),
      ),
      builder: (sheetContext) => SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(r.sp(8), 0, r.sp(8), r.vp(12)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: r.vp(8)),
                child: Text(
                  'Change Profile Photo',
                  style: TextStyle(
                    fontSize: r.fs(16),
                    fontWeight: FontWeight.w700,
                    color: p.cs.onSurface,
                  ),
                ),
              ),
              Divider(color: p.dividerColor, height: 1),
              SizedBox(height: r.vp(8)),
              _SheetTile(
                icon: Icons.photo_library_outlined,
                title: 'Choose from Gallery',
                subtitle: 'Pick an existing photo',
                iconBg: p.cs.primary.withValues(alpha: 0.12),
                iconColor: p.cs.primary,
                r: r,
                p: p,
                onTap: () {
                  Navigator.pop(sheetContext);
                  bloc.add(
                    const BxPickHeaderImageEvent(source: ImageSource.gallery),
                  );
                },
              ),
              SizedBox(height: r.vp(4)),
              _SheetTile(
                icon: Icons.photo_camera_outlined,
                title: 'Take a Photo',
                subtitle: 'Use your camera',
                iconBg: p.cs.tertiary.withValues(alpha: 0.12),
                iconColor: p.cs.tertiary,
                r: r,
                p: p,
                onTap: () {
                  Navigator.pop(sheetContext);
                  bloc.add(
                    const BxPickHeaderImageEvent(source: ImageSource.camera),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Small reusable pieces
// ─────────────────────────────────────────────────────────────────────────────

class _CircleActionButton extends StatelessWidget {
  final IconData icon;
  final Color bgColor;
  final Color fgColor;
  final double size;
  final double iconSize;
  final VoidCallback onTap;
  final Color shadowColor;

  const _CircleActionButton({
    required this.icon,
    required this.bgColor,
    required this.fgColor,
    required this.size,
    required this.iconSize,
    required this.onTap,
    required this.shadowColor,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: bgColor,
      shape: const CircleBorder(),
      elevation: 0,
      shadowColor: shadowColor,
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        splashColor: fgColor.withValues(alpha: 0.15),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: shadowColor,
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Icon(icon, color: fgColor, size: iconSize),
        ),
      ),
    );
  }
}

class _SheetTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color iconBg;
  final Color iconColor;
  final _R r;
  final _Palette p;
  final VoidCallback onTap;

  const _SheetTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.iconBg,
    required this.iconColor,
    required this.r,
    required this.p,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(r.r(14)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(r.r(14)),
        splashColor: p.cs.primary.withValues(alpha: 0.06),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: r.sp(12),
            vertical: r.vp(12),
          ),
          child: Row(
            children: [
              Container(
                width: r.r(44),
                height: r.r(44),
                decoration: BoxDecoration(
                  color: iconBg,
                  borderRadius: BorderRadius.circular(r.r(12)),
                ),
                child: Icon(icon, color: iconColor, size: r.r(22)),
              ),
              SizedBox(width: r.sp(14)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: r.fs(15),
                        fontWeight: FontWeight.w600,
                        color: p.cs.onSurface,
                      ),
                    ),
                    SizedBox(height: r.vp(2)),
                    Text(
                      subtitle,
                      style: TextStyle(fontSize: r.fs(12), color: p.hintColor),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: p.labelColor.withValues(alpha: 0.5),
                size: r.r(22),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
