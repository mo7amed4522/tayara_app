// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/bloc/bx_update_profile_screen_controller/bx_update_profile_screen_controller_bloc.dart
// Architecture: Presentation Layer - Update Profile Screen Controller
// Purpose: BLoC owns the form (controllers + non-text state) and the submit.
// ignore_for_file: prefer_initializing_formals

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_selector/intl_phone_selector.dart';
import 'package:tayara/core/constant/bx_app_constant.dart';
import 'package:tayara/domain/usecase/bx_update_user_data_usecase.dart';

part 'bx_update_profile_screen_controller_event.dart';
part 'bx_update_profile_screen_controller_state.dart';

class BxUpdateProfileScreenControllerBloc
    extends
        Bloc<
          BxUpdateProfileScreenControllerEvent,
          BxUpdateProfileScreenControllerState
        > {
  final BxUpdateUserDataUsecase _updateUserDataUsecase;
  final ImagePicker _imagePicker;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late final TextEditingController fullNameController;
  late final TextEditingController nickNameController;
  late final TextEditingController emailController;
  late final PhoneNumberController phoneController;

  BxUpdateProfileScreenControllerBloc({
    required BxUpdateUserDataUsecase updateUserDataUsecase,
    ImagePicker? imagePicker,
  }) : _updateUserDataUsecase = updateUserDataUsecase,
       _imagePicker = imagePicker ?? ImagePicker(),
       super(_seedState()) {
    final user = BxAppData.currentUser?.data?.user;

    fullNameController = TextEditingController(text: user?.fullName ?? '');
    nickNameController = TextEditingController(text: user?.nickName ?? '');
    emailController = TextEditingController(text: user?.email ?? '');

    phoneController = PhoneNumberController();
    final seedCode = _safePhoneCode(user?.phoneCountryCode);
    final seedCountry = CountriesData.getCountryByDialCode(seedCode);
    phoneController.setCountry(seedCountry);

    final seedPhone = user?.phone ?? '';
    if (seedPhone.isNotEmpty) {
      phoneController.setPhoneNumber(seedPhone);
    } else {
      phoneController.clearNumber();
    }

    on<BxSubmitUpdateProfileEvent>(_onSubmit);
    on<BxChangePhoneCountryCodeEvent>(_onChangePhoneCountryCode);
    on<BxChangeNationalityEvent>(_onChangeNationality);
    on<BxChangeDateOfBirthEvent>(_onChangeDateOfBirth);
    on<BxResetUpdateProfileEvent>(_onReset);
    on<BxPickHeaderImageEvent>(_onPickHeaderImage);
    on<BxRemovePickedHeaderImageEvent>(_onRemovePickedHeaderImage);
  }

  static const _knownCodes = <String>{'+971', '+20', '+966', '+1', '+44'};

  static String _safePhoneCode(String? raw) {
    final c = raw ?? '';
    return _knownCodes.contains(c) ? c : '+971';
  }

  static BxUpdateProfileScreenControllerState _seedState() {
    final user = BxAppData.currentUser?.data?.user;
    return BxUpdateProfileScreenControllerState(
      phoneCountryCode: _safePhoneCode(user?.phoneCountryCode),
      nationality: user?.nationality ?? '',
      dateOfBirth: user?.dateOfBirth != null
          ? DateTime.tryParse(user!.dateOfBirth!)
          : null,
      existingHeaderImgUrl: user?.headerImg,
    );
  }

  @override
  Future<void> close() {
    fullNameController.dispose();
    nickNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    return super.close();
  }

  // ---------------------------------------------------------------------------
  // Submit
  // ---------------------------------------------------------------------------

  Future<void> _onSubmit(
    BxSubmitUpdateProfileEvent event,
    Emitter<BxUpdateProfileScreenControllerState> emit,
  ) async {
    final valid = formKey.currentState?.validate() ?? false;
    if (!valid) return;

    final token = BxAppData.currentUser?.data?.token;
    if (token == null || token.isEmpty) {
      emit(
        state.copyWith(
          status: BxUpdateProfileScreenControllerStatus.failure,
          errorMessage: 'You are not logged in.',
        ),
      );
      return;
    }

    // Use the phone controller's complete number and extract the phone part
    // based on the country code stored in state.
    final dialCode = state.phoneCountryCode;
    final fullNumber = phoneController.completeNumber;
    final phone = fullNumber.replaceFirst(dialCode, '').trim();

    final fullName = fullNameController.text.trim();
    final nickName = nickNameController.text.trim();
    final email = emailController.text.trim();

    final body = <String, dynamic>{};
    if (fullName.isNotEmpty) body['fullName'] = fullName;
    if (nickName.isNotEmpty) body['nickName'] = nickName;
    if (email.isNotEmpty) body['email'] = email;
    if (dialCode.isNotEmpty) body['phoneCountryCode'] = dialCode;
    if (phone.isNotEmpty) body['phone'] = phone;
    if (state.nationality.isNotEmpty) body['nationality'] = state.nationality;
    if (state.dateOfBirth != null) {
      body['dateOfBirth'] = state.dateOfBirth!.toUtc().toIso8601String();
    }

    final imageFile = state.pickedHeaderImage;
    if (body.isEmpty && imageFile == null) {
      emit(
        state.copyWith(
          status: BxUpdateProfileScreenControllerStatus.failure,
          errorMessage: 'Nothing to update.',
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        status: BxUpdateProfileScreenControllerStatus.loading,
        clearErrorMessage: true,
      ),
    );

    final response = await _updateUserDataUsecase.execute(
      token: token,
      body: body,
      headerImage: imageFile,
    );

    if (response.code == 0) {
      emit(
        state.copyWith(
          status: BxUpdateProfileScreenControllerStatus.success,
          clearErrorMessage: true,
          existingHeaderImgUrl:
              response.data?.user?.headerImg ?? state.existingHeaderImgUrl,
          clearPickedHeaderImage: response.data?.user?.headerImg != null,
        ),
      );
    } else {
      emit(
        state.copyWith(
          status: BxUpdateProfileScreenControllerStatus.failure,
          errorMessage: response.msg,
        ),
      );
    }
  }

  // ---------------------------------------------------------------------------
  // Image picking
  // ---------------------------------------------------------------------------

  Future<void> _onPickHeaderImage(
    BxPickHeaderImageEvent event,
    Emitter<BxUpdateProfileScreenControllerState> emit,
  ) async {
    try {
      final picked = await _imagePicker.pickImage(
        source: event.source,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
        preferredCameraDevice: CameraDevice.front,
      );
      if (picked == null) return; // user cancelled

      emit(state.copyWith(pickedHeaderImage: picked, clearErrorMessage: true));
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage:
              'Could not open image picker. Please check permissions and try again.',
        ),
      );
    }
  }

  void _onRemovePickedHeaderImage(
    BxRemovePickedHeaderImageEvent event,
    Emitter<BxUpdateProfileScreenControllerState> emit,
  ) {
    emit(state.copyWith(clearPickedHeaderImage: true));
  }

  // ---------------------------------------------------------------------------
  // Field change handlers
  // ---------------------------------------------------------------------------

  void _onChangePhoneCountryCode(
    BxChangePhoneCountryCodeEvent event,
    Emitter<BxUpdateProfileScreenControllerState> emit,
  ) {
    emit(state.copyWith(phoneCountryCode: event.dialCode));
  }

  void _onChangeNationality(
    BxChangeNationalityEvent event,
    Emitter<BxUpdateProfileScreenControllerState> emit,
  ) {
    emit(state.copyWith(nationality: event.value));
  }

  void _onChangeDateOfBirth(
    BxChangeDateOfBirthEvent event,
    Emitter<BxUpdateProfileScreenControllerState> emit,
  ) {
    emit(
      state.copyWith(
        dateOfBirth: event.value,
        clearDateOfBirth: event.value == null,
      ),
    );
  }

  void _onReset(
    BxResetUpdateProfileEvent event,
    Emitter<BxUpdateProfileScreenControllerState> emit,
  ) {
    final user = BxAppData.currentUser?.data?.user;
    fullNameController.text = user?.fullName ?? '';
    nickNameController.text = user?.nickName ?? '';
    emailController.text = user?.email ?? '';

    final seedCode = _safePhoneCode(user?.phoneCountryCode);
    final seedCountry = CountriesData.getCountryByDialCode(seedCode);
    phoneController.setCountry(seedCountry);

    final seedPhone = user?.phone ?? '';
    if (seedPhone.isNotEmpty) {
      phoneController.setPhoneNumber(seedPhone);
    } else {
      phoneController.clearNumber();
    }

    emit(_seedState());
  }
}
