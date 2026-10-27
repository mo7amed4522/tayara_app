/// Concrete implementation of [BxActiveTopBannerAdsRepositories] that fetches
/// Agent profile detail through the remote data source.
///
/// Unlike some other repositories, this implementation handles
/// [BxNetworkException] explicitly by converting it into a
/// [BxAgentProfileDetailsResponse] with an error status, rather than letting
/// the exception propagate. This ensures that callers always receive a
/// response object, even when the network call fails.
///
library;

import 'package:tayara/core/network/interceptors/bx_network_exception.dart';
import 'package:tayara/data/data_source/remote/bx_system_remote_data_source.dart';
import 'package:tayara/domain/model/request/bx_agent_profile_details_request.dart';
import 'package:tayara/domain/model/response/bx_agent_profile_details_response.dart';
import 'package:tayara/domain/repositories/bx_agent_profile_details_repositories.dart';

// File: lib/data/repositories/bx_agent_profile_details_repositories_impl.dart
// Architecture: Data Layer - Bx Agent profile detail Repository Implementation
// Purpose: Provides concrete implementation of the Agent profile detail interface using remote data source

// ignore_for_file: prefer_initializing_formals

class BxAgentProfileDetailsRepositoriesImpl
    implements BxAgentProfileDetailsRepositories {
  final BxSystemRemoteDataSource _bxsystemRemoteDataSource;

  BxAgentProfileDetailsRepositoriesImpl({
    required BxSystemRemoteDataSource bxsystemRemoteDataSource,
  }) : _bxsystemRemoteDataSource = bxsystemRemoteDataSource;

  /// Fetches Agent profile detail by calling the remote endpoint.
  ///
  /// On success a [BxAgentProfileDetailsResponse] is returned. If a
  /// [BxNetworkException] is caught, an error response with the
  /// corresponding status code and message is returned. Any other
  /// exception results in a generic 7 error response.
  @override
  Future<BxAgentProfileDetailsResponse> fetchAgentDetailsData(
    BxAgentProfileDetailsRequest request,
  ) async {
    try {
      final result = await _bxsystemRemoteDataSource.fetchAgentDetailsData(
        request,
      );
      return result;
    } on BxNetworkException catch (e) {
      return BxAgentProfileDetailsResponse(
        code: e.statusCode,
        msg: e.message,
        data: null,
      );
    } catch (e) {
      return BxAgentProfileDetailsResponse(
        code: 500,
        msg: 'Failed to fetch agent profile details. Please try again.',
        data: null,
      );
    }
  }
}
