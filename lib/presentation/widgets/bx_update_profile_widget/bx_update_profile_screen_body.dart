// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/views/bx_update_profile_screen/bx_update_profile_screen_body.dart
// Architecture: Presentation Layer - Bx Update Profile Screen Body
// Purpose: Stateless form. All controllers + non-text state live in the BLoC.

// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_selector/intl_phone_selector.dart';
import 'package:tayara/presentation/bloc/bx_update_profile_screen_controller/bx_update_profile_screen_controller_bloc.dart';

class BxUpdateProfileScreenBody extends StatelessWidget {
  final bool isTablet;
  const BxUpdateProfileScreenBody({super.key, this.isTablet = false});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bloc = context.read<BxUpdateProfileScreenControllerBloc>();

    return BlocConsumer<
      BxUpdateProfileScreenControllerBloc,
      BxUpdateProfileScreenControllerState
    >(
      listenWhen: (prev, curr) => prev.status != curr.status,
      listener: (context, state) {
        if (state.status == BxUpdateProfileScreenControllerStatus.success) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Profile updated successfully')),
            );
          Navigator.of(context).maybePop();
        } else if (state.status ==
            BxUpdateProfileScreenControllerStatus.failure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text(state.errorMessage ?? 'Update failed')),
            );
        }
      },
      builder: (context, state) {
        final isLoading =
            state.status == BxUpdateProfileScreenControllerStatus.loading;

        return Scaffold(
          appBar: AppBar(title: const Text('Edit Profile'), centerTitle: true),
          body: SafeArea(
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: isTablet ? 560 : double.infinity,
                ),
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: isTablet ? 32 : 20,
                    vertical: 16,
                  ),
                  child: Form(
                    key: bloc.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Center(
                          child: Stack(
                            children: [
                              CircleAvatar(
                                radius: 64,
                                backgroundColor: Colors.grey.shade200,
                                backgroundImage: _getAvatarImage(state),
                                child: _getAvatarImage(state) == null
                                    ? const Icon(Icons.person, size: 64)
                                    : null,
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Material(
                                  elevation: 2,
                                  shape: const CircleBorder(),
                                  child: InkWell(
                                    onTap: () =>
                                        _showImagePicker(context, bloc),
                                    customBorder: const CircleBorder(),
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: theme.primaryColor,
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.camera_alt,
                                        color: Colors.white,
                                        size: 20,
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
                                    elevation: 2,
                                    shape: const CircleBorder(),
                                    child: InkWell(
                                      onTap: () => bloc.add(
                                        const BxRemovePickedHeaderImageEvent(),
                                      ),
                                      customBorder: const CircleBorder(),
                                      child: Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: const BoxDecoration(
                                          color: Colors.red,
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.close,
                                          color: Colors.white,
                                          size: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),

                        _label(theme, 'Full Name'),
                        TextFormField(
                          controller: bloc.fullNameController,
                          decoration: const InputDecoration(
                            hintText: 'Your full name',
                            border: OutlineInputBorder(),
                          ),
                          validator: (v) => (v == null || v.trim().isEmpty)
                              ? 'Full name is required'
                              : null,
                        ),
                        const SizedBox(height: 16),

                        _label(theme, 'Nick Name'),
                        TextFormField(
                          controller: bloc.nickNameController,
                          decoration: const InputDecoration(
                            hintText: 'Display name',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 16),

                        _label(theme, 'Email'),
                        TextFormField(
                          controller: bloc.emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            hintText: 'you@example.com',
                            border: OutlineInputBorder(),
                          ),
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
                        const SizedBox(height: 16),

                        _label(theme, 'Phone'),
                        AdvancedPhoneInput(
                          controller:
                              bloc.phoneController, // ✅ PhoneNumberController
                          showFlag: true,
                          showCountryCode: true,
                          showValidationIcon: true,
                          enableSearch: true,
                          hintText: '50 123 4567',
                          labelText: '',
                          onCountryChanged: (country) {
                            bloc.add(
                              BxChangePhoneCountryCodeEvent(country.dialCode),
                            );
                          },
                        ),
                        const SizedBox(height: 16),

                        _label(theme, 'Nationality'),
                        DropdownButtonFormField<String>(
                          value:
                              const {
                                'Emirati',
                                'Egyptian',
                                'Saudi',
                                'British',
                                'American',
                              }.contains(state.nationality)
                              ? state.nationality
                              : null,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Select nationality',
                          ),
                          items: const [
                            DropdownMenuItem(
                              value: 'Emirati',
                              child: Text('Emirati'),
                            ),
                            DropdownMenuItem(
                              value: 'Egyptian',
                              child: Text('Egyptian'),
                            ),
                            DropdownMenuItem(
                              value: 'Saudi',
                              child: Text('Saudi'),
                            ),
                            DropdownMenuItem(
                              value: 'British',
                              child: Text('British'),
                            ),
                            DropdownMenuItem(
                              value: 'American',
                              child: Text('American'),
                            ),
                          ],
                          onChanged: (v) {
                            if (v != null) {
                              bloc.add(BxChangeNationalityEvent(v));
                            }
                          },
                        ),
                        const SizedBox(height: 16),

                        _label(theme, 'Date of Birth'),
                        InkWell(
                          onTap: () => _pickDateOfBirth(context, bloc, state),
                          borderRadius: BorderRadius.circular(4),
                          child: InputDecorator(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              suffixIcon: Icon(Icons.calendar_today),
                            ),
                            child: Text(
                              state.dateOfBirth == null
                                  ? 'Not set'
                                  : '${state.dateOfBirth!.year}-'
                                        '${state.dateOfBirth!.month.toString().padLeft(2, '0')}-'
                                        '${state.dateOfBirth!.day.toString().padLeft(2, '0')}',
                              style: theme.textTheme.bodyMedium,
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),

                        SizedBox(
                          height: 48,
                          child: ElevatedButton(
                            onPressed: isLoading
                                ? null
                                : () => bloc.add(
                                    const BxSubmitUpdateProfileEvent(),
                                  ),
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ),
                            child: isLoading
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white,
                                      ),
                                    ),
                                  )
                                : const Text('Save Changes'),
                          ),
                        ),
                        const SizedBox(height: 12),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _label(ThemeData theme, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: theme.textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  ImageProvider? _getAvatarImage(BxUpdateProfileScreenControllerState state) {
    // Priority: 1. Picked local image, 2. Server URL
    if (state.pickedHeaderImage != null) {
      return FileImage(File(state.pickedHeaderImage!.path));
    }
    if (state.existingHeaderImgUrl != null &&
        state.existingHeaderImgUrl!.isNotEmpty) {
      return NetworkImage(state.existingHeaderImgUrl!);
    }
    return null;
  }

  Future<void> _showImagePicker(
    BuildContext context,
    BxUpdateProfileScreenControllerBloc bloc,
  ) async {
    await showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Choose from Gallery'),
              onTap: () {
                Navigator.pop(context);
                bloc.add(
                  const BxPickHeaderImageEvent(source: ImageSource.gallery),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_camera),
              title: const Text('Take a Photo'),
              onTap: () {
                Navigator.pop(context);
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
}
