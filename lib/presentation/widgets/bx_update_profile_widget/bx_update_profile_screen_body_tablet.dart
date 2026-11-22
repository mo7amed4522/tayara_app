// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/widgets/bx_update_profile_widget/bx_update_profile_screen_body_tablet.dart
// Architecture: Presentation Layer - Update Profile (Tablet)
// Purpose: Tablet layout for the "Edit Profile" screen.
//
// Design decisions:
//   * Two-column layout:
//       - Left  : a fixed-width "identity" panel (avatar + hint text) that
//                 reads like a profile card rather than a form field.
//       - Right : the actual editable form, grouped in section cards.
//   * Wider inner padding, larger avatar, and bigger cards so the layout does
//     not feel like a stretched phone screen.
//   * Everything scrolls as one unit (single `SingleChildScrollView`) so there
//     is no "sticky header vs. sticky form" trap if the form gets long.
//   * Same BLoC, events and validation as mobile — only the layout differs.

// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_selector/intl_phone_selector.dart';
import 'package:tayara/presentation/bloc/bx_update_profile_screen_controller/bx_update_profile_screen_controller_bloc.dart';

class BxUpdateProfileScreenBodyTablet extends StatelessWidget {
  const BxUpdateProfileScreenBodyTablet({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bloc = context.read<BxUpdateProfileScreenControllerBloc>();

    return BlocBuilder<
      BxUpdateProfileScreenControllerBloc,
      BxUpdateProfileScreenControllerState
    >(
      builder: (context, state) {
        final isLoading = state.isSubmitting;

        return Form(
          key: bloc.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(32),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1200),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Left: identity panel (avatar + helper copy).
                    SizedBox(
                      width: 320,
                      child: _TabletAvatarPanel(bloc: bloc, state: state),
                    ),
                    const SizedBox(width: 32),

                    // Right: the actual form.
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Personal info
                          _SectionCard(
                            title: 'Personal Information',
                            icon: Icons.badge_outlined,
                            children: [
                              _buildTextField(
                                controller: bloc.fullNameController,
                                label: 'Full Name',
                                hint: 'Enter your full name',
                                icon: Icons.person_outline,
                                enabled: !isLoading,
                                validator: (v) =>
                                    (v == null || v.trim().isEmpty)
                                    ? 'Full name is required'
                                    : null,
                              ),
                              const SizedBox(height: 20),
                              _buildTextField(
                                controller: bloc.nickNameController,
                                label: 'Nick Name',
                                hint: 'Display name (optional)',
                                icon: Icons.alternate_email,
                                enabled: !isLoading,
                              ),
                              const SizedBox(height: 20),
                              _buildTextField(
                                controller: bloc.emailController,
                                label: 'Email',
                                hint: 'you@example.com',
                                icon: Icons.mail_outline,
                                keyboardType: TextInputType.emailAddress,
                                enabled: !isLoading,
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
                          const SizedBox(height: 20),

                          // Contact info
                          _SectionCard(
                            title: 'Contact Information',
                            icon: Icons.contact_phone_outlined,
                            children: [
                              _buildPhoneField(theme, bloc),
                              const SizedBox(height: 20),
                              _buildNationalityField(
                                theme,
                                bloc,
                                state,
                                isLoading,
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),

                          // Additional info
                          _SectionCard(
                            title: 'Additional Information',
                            icon: Icons.info_outline,
                            children: [
                              _buildDateOfBirthField(
                                context,
                                theme,
                                bloc,
                                state,
                                isLoading,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // ---------------------------------------------------------------------------
  // Form fields
  // ---------------------------------------------------------------------------

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    required bool enabled,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      enabled: enabled,
      keyboardType: keyboardType,
      validator: validator,
      style: const TextStyle(fontSize: 15),
      decoration: _inputDecoration(label: label, hint: hint, icon: icon),
    );
  }

  Widget _buildPhoneField(
    ThemeData theme,
    BxUpdateProfileScreenControllerBloc bloc,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            'Phone Number',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        AdvancedPhoneInput(
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
      ],
    );
  }

  Widget _buildNationalityField(
    ThemeData theme,
    BxUpdateProfileScreenControllerBloc bloc,
    BxUpdateProfileScreenControllerState state,
    bool enabled,
  ) {
    const options = ['Emirati', 'Egyptian', 'Saudi', 'British', 'American'];
    final hasValidSelection = options.contains(state.nationality);

    return DropdownButtonFormField<String>(
      value: hasValidSelection ? state.nationality : null,
      decoration: _inputDecoration(
        label: 'Nationality',
        icon: Icons.flag_outlined,
      ),
      items: options
          .map((o) => DropdownMenuItem(value: o, child: Text(o)))
          .toList(),
      onChanged: enabled
          ? (v) {
              if (v != null) bloc.add(BxChangeNationalityEvent(v));
            }
          : null,
    );
  }

  Widget _buildDateOfBirthField(
    BuildContext context,
    ThemeData theme,
    BxUpdateProfileScreenControllerBloc bloc,
    BxUpdateProfileScreenControllerState state,
    bool enabled,
  ) {
    final text = state.dateOfBirth == null
        ? 'Not set'
        : DateFormat('MMM d, yyyy').format(state.dateOfBirth!);

    return InkWell(
      onTap: enabled ? () => _pickDateOfBirth(context, bloc, state) : null,
      borderRadius: BorderRadius.circular(12),
      child: InputDecorator(
        decoration:
            _inputDecoration(
              label: 'Date of Birth',
              icon: Icons.cake_outlined,
            ).copyWith(
              suffixIcon: const Icon(Icons.calendar_today_outlined, size: 20),
            ),
        child: Text(text, style: theme.textTheme.bodyMedium),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Misc helpers
  // ---------------------------------------------------------------------------

  Future<void> _pickDateOfBirth(
    BuildContext context,
    BxUpdateProfileScreenControllerBloc bloc,
    BxUpdateProfileScreenControllerState state,
  ) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: state.dateOfBirth ?? DateTime(now.year - 20),
      firstDate: DateTime(1900),
      lastDate: now,
    );
    if (picked != null) {
      bloc.add(BxChangeDateOfBirthEvent(picked));
    }
  }

  InputDecoration _inputDecoration({
    required String label,
    String? hint,
    IconData? icon,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: icon != null ? Icon(icon, size: 20) : null,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(width: 1.5, color: Colors.blue),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// Private widgets
// -----------------------------------------------------------------------------

/// Rounded card used to group form fields under a titled section.
class _SectionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Widget> children;

  const _SectionCard({
    required this.title,
    required this.icon,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: theme.colorScheme.outline.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, size: 18, color: theme.colorScheme.primary),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ...children,
        ],
      ),
    );
  }
}

/// Left-hand identity panel: large avatar + hint copy.
/// Reads like a "profile card", not a form field, which makes the tablet
/// layout feel more like a dashboard than a stretched phone screen.
class _TabletAvatarPanel extends StatelessWidget {
  final BxUpdateProfileScreenControllerBloc bloc;
  final BxUpdateProfileScreenControllerState state;

  const _TabletAvatarPanel({required this.bloc, required this.state});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final image = _currentImage();

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: theme.colorScheme.outline.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Avatar with camera badge.
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: theme.colorScheme.primary.withOpacity(0.2),
                    width: 4,
                  ),
                ),
                child: CircleAvatar(
                  radius: 86,
                  backgroundColor: theme.colorScheme.primary.withOpacity(0.08),
                  backgroundImage: image,
                  child: image == null
                      ? Icon(
                          Icons.person,
                          size: 88,
                          color: theme.colorScheme.onSurfaceVariant,
                        )
                      : null,
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Material(
                  color: theme.colorScheme.primary,
                  shape: const CircleBorder(),
                  elevation: 4,
                  child: InkWell(
                    onTap: () => _showPickerSheet(context),
                    customBorder: const CircleBorder(),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Icon(
                        Icons.camera_alt_rounded,
                        color: theme.colorScheme.onPrimary,
                        size: 22,
                      ),
                    ),
                  ),
                ),
              ),
              if (state.hasPendingImage)
                Positioned(
                  top: 0,
                  right: 0,
                  child: Material(
                    color: theme.colorScheme.error,
                    shape: const CircleBorder(),
                    elevation: 4,
                    child: InkWell(
                      onTap: () =>
                          bloc.add(const BxRemovePickedHeaderImageEvent()),
                      customBorder: const CircleBorder(),
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: Icon(
                          Icons.close_rounded,
                          color: theme.colorScheme.onError,
                          size: 16,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            'Profile Photo',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'A friendly, up-to-date photo helps agencies recognize you and '
            'builds trust before your trip.',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            height: 1,
            color: theme.colorScheme.outline.withOpacity(0.2),
          ),
          const SizedBox(height: 20),
          // Small privacy note — reuses the same "shield" tone as the login
          // screen so the two screens feel like they belong to one product.
          Row(
            children: [
              Icon(
                Icons.shield_outlined,
                size: 16,
                color: theme.colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Only you and trusted agencies can see your profile.',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ],
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
    if (url != null && url.isNotEmpty) {
      return NetworkImage(url);
    }
    return null;
  }

  Future<void> _showPickerSheet(BuildContext context) async {
    await showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (sheetContext) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library_outlined),
              title: const Text('Choose from Gallery'),
              onTap: () {
                Navigator.pop(sheetContext);
                bloc.add(
                  const BxPickHeaderImageEvent(source: ImageSource.gallery),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_camera_outlined),
              title: const Text('Take a Photo'),
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
    );
  }
}
