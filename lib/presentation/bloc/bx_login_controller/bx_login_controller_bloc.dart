// File: lib/presentation/bloc/bx_login_controller/bx_login_controller_bloc.dart
// Architecture: Presentation Layer - Login Controller
// Purpose: BLoC for managing login state and actions

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bx_login_controller_event.dart';
part 'bx_login_controller_state.dart';

class BxLoginControllerBloc extends Bloc<BxLoginControllerEvent, BxLoginControllerState> {
  BxLoginControllerBloc() : super(const BxLoginControllerState()) {
    on<BxLoginWithGoogle>((event, emit) {
      emit(state.copyWith(status: BxLoginControllerStatus.loading));
      // Simulate success
      emit(state.copyWith(status: BxLoginControllerStatus.success));
    });

    on<BxLoginWithApple>((event, emit) {
      emit(state.copyWith(status: BxLoginControllerStatus.loading));
      emit(state.copyWith(status: BxLoginControllerStatus.success));
    });

    on<BxLoginWithFacebook>((event, emit) {
      emit(state.copyWith(status: BxLoginControllerStatus.loading));
      emit(state.copyWith(status: BxLoginControllerStatus.success));
    });

    on<BxLoginWithPhone>((event, emit) {
      emit(state.copyWith(status: BxLoginControllerStatus.loading));
      emit(state.copyWith(status: BxLoginControllerStatus.success));
    });

    on<BxLoginTermsPressed>((event, emit) {});

    on<BxLoginPrivacyPressed>((event, emit) {});
  }
}
