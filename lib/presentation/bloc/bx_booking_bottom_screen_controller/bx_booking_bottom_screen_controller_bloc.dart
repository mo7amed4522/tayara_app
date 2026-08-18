// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/bloc/bx_booking_bottom_screen_controller/bx_booking_bottom_screen_controller_bloc.dart
// Architecture: Presentation Layer - Booking Bottom Screen Controller
// Purpose: BLoC for managing booking bottom screen state, theme toggle and persistence
// ignore_for_file: empty_constructor_bodies, prefer_initializing_formals, use_build_context_synchronously

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bx_booking_bottom_screen_controller_state.dart';
part 'bx_booking_bottom_screen_controller_event.dart';

class BxBookingBottomScreenControllerBloc
    extends
        Bloc<
          BxBookingBottomScreenControllerEvent,
          BxBookingBottomScreenControllerState
        > {
  BxBookingBottomScreenControllerBloc()
    : super(
        const BxBookingBottomScreenControllerState(
          status: BxBookingBottomScreenControllerStatus.initial,
        ),
      ) {}
}
