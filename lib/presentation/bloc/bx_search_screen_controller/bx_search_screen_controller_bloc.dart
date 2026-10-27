// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/bloc/bx_search_screen_controller/bx_search_screen_controller_bloc.dart
// Architecture: Presentation Layer - Search Controller
// Purpose: BLoC for managing search screen state
// ignore_for_file: prefer_initializing_formals, empty_constructor_bodies

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tayara/domain/model/request/bx_custom_search_request.dart';
import 'package:tayara/domain/model/response/bx_custom_search_response.dart';
import 'package:tayara/domain/usecase/bx_custom_search_usecase.dart';

part 'bx_search_screen_controller_event.dart';
part 'bx_search_screen_controller_state.dart';

class BxSearchScreenControllerBloc
    extends Bloc<BxSearchScreenControllerEvent, BxSearchScreenControllerState> {
  final BxCustomSearchUsecase _customSearchUsecase;

  BxSearchScreenControllerBloc({
    required BxCustomSearchUsecase customSearchUsecase,
  }) : _customSearchUsecase = customSearchUsecase,
       super(const BxSearchScreenControllerState()) {
    on<BxLoadSearch>(_onLoadSearch);
    on<BxUpdateSearchQuery>(_onUpdateSearchQuery);
    on<BxSearchCustom>(_onSearchCustom);
  }

  void _onLoadSearch(
    BxLoadSearch event,
    Emitter<BxSearchScreenControllerState> emit,
  ) {
    emit(state.copyWith(status: BxSearchScreenControllerStatus.success));
  }

  void _onUpdateSearchQuery(
    BxUpdateSearchQuery event,
    Emitter<BxSearchScreenControllerState> emit,
  ) {
    emit(state.copyWith(query: event.query));
  }

  Future<void> _onSearchCustom(
    BxSearchCustom event,
    Emitter<BxSearchScreenControllerState> emit,
  ) async {
    if (event.keyword.trim().isEmpty) {
      emit(
        state.copyWith(
          status: BxSearchScreenControllerStatus.success,
          customSearchResponse: null,
          errorMessage: null,
        ),
      );
      return;
    }

    emit(state.copyWith(status: BxSearchScreenControllerStatus.loading));

    final request = BxCustomSearchRequest(
      keyword: event.keyword.trim(),
      page: event.page,
      pageSize: event.pageSize,
    );

    final response = await _customSearchUsecase.execute(request);

    if (response.code == 0) {
      emit(
        state.copyWith(
          status: BxSearchScreenControllerStatus.success,
          customSearchResponse: response,
          errorMessage: null,
        ),
      );
    } else {
      emit(
        state.copyWith(
          status: BxSearchScreenControllerStatus.failure,
          errorMessage: response.msg,
          customSearchResponse: null,
        ),
      );
    }
  }
}
