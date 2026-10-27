// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/bloc/bx_agencies_detail_screen_controller/bx_agencies_detail_screen_controller_bloc.dart
// Architecture: Presentation Layer - Agencies Detail Screen Controller
// Purpose: BLoC for managing the agency profile/detail screen state
// ignore_for_file: prefer_initializing_formals, empty_constructor_bodies

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tayara/domain/model/request/bx_agent_profile_details_request.dart';
import 'package:tayara/domain/model/response/bx_agent_profile_details_response.dart';
import 'package:tayara/domain/usecase/bx_agent_profile_details_usecase.dart';

part 'bx_agencies_detail_screen_controller_event.dart';
part 'bx_agencies_detail_screen_controller_state.dart';

class BxAgenciesDetailScreenControllerBloc
    extends
        Bloc<
          BxAgenciesDetailScreenControllerEvent,
          BxAgenciesDetailScreenControllerState
        > {
  final BxAgentProfileDetailsUsecase _agentProfileDetailsUsecase;

  BxAgenciesDetailScreenControllerBloc({
    required BxAgentProfileDetailsUsecase agentProfileDetailsUsecase,
  }) : _agentProfileDetailsUsecase = agentProfileDetailsUsecase,
       super(const BxAgenciesDetailScreenControllerState()) {
    on<BxLoadAgentProfileDetails>(_onLoadAgentProfileDetails);
    on<BxLoadMoreAgentPackages>(_onLoadMoreAgentPackages);
    on<BxChangePackageFilter>(_onChangePackageFilter);
  }

  Future<void> _onLoadAgentProfileDetails(
    BxLoadAgentProfileDetails event,
    Emitter<BxAgenciesDetailScreenControllerState> emit,
  ) async {
    emit(
      state.copyWith(
        status: BxAgenciesDetailScreenControllerStatus.loading,
        agentId: event.agentId,
        errorMessage: null,
      ),
    );

    final request = BxAgentProfileDetailsRequest(
      agentId: event.agentId,
      page: 1,
      pageSize: event.pageSize,
    );

    final response = await _agentProfileDetailsUsecase.execute(request);

    if (response.code == 0 && response.data != null) {
      emit(
        state.copyWith(
          status: BxAgenciesDetailScreenControllerStatus.success,
          response: response,
          page: 1,
          hasMore:
              response.data!.packages.length < response.data!.packagesTotal,
          errorMessage: null,
        ),
      );
    } else {
      emit(
        state.copyWith(
          status: BxAgenciesDetailScreenControllerStatus.failure,
          errorMessage: response.msg,
          response: null,
        ),
      );
    }
  }

  Future<void> _onLoadMoreAgentPackages(
    BxLoadMoreAgentPackages event,
    Emitter<BxAgenciesDetailScreenControllerState> emit,
  ) async {
    // Guard: nothing to load, already loading, or no more pages
    if (state.status == BxAgenciesDetailScreenControllerStatus.loading) return;
    if (state.response?.data == null) return;
    if (!state.hasMore) return;
    if (state.isLoadingMore) return;

    emit(state.copyWith(isLoadingMore: true, errorMessage: null));

    final nextPage = state.page + 1;
    final request = BxAgentProfileDetailsRequest(
      agentId: state.agentId,
      page: nextPage,
      pageSize: event.pageSize,
    );

    final response = await _agentProfileDetailsUsecase.execute(request);

    if (response.code == 0 && response.data != null) {
      final existingPackages = state.response!.data!.packages;
      final mergedPackages = [...existingPackages, ...response.data!.packages];

      // Preserve the first page's agent & reviews; only append packages.
      final mergedData = BxAgentProfileDetailsData(
        agent: state.response!.data!.agent,
        packages: mergedPackages,
        packagesTotal: response.data!.packagesTotal,
        reviews: state.response!.data!.reviews,
        reviewAvgRating: state.response!.data!.reviewAvgRating,
        reviewTotal: state.response!.data!.reviewTotal,
        topDestination: state.response!.data!.topDestination,
      );

      final mergedResponse = BxAgentProfileDetailsResponse(
        code: response.code,
        data: mergedData,
        msg: response.msg,
      );

      emit(
        state.copyWith(
          status: BxAgenciesDetailScreenControllerStatus.success,
          response: mergedResponse,
          page: nextPage,
          hasMore: mergedPackages.length < response.data!.packagesTotal,
          isLoadingMore: false,
          errorMessage: null,
        ),
      );
    } else {
      emit(state.copyWith(isLoadingMore: false, errorMessage: response.msg));
    }
  }

  void _onChangePackageFilter(
    BxChangePackageFilter event,
    Emitter<BxAgenciesDetailScreenControllerState> emit,
  ) {
    emit(state.copyWith(selectedCategory: event.category));
  }
}
