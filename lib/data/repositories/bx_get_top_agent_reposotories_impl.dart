/// Concrete implementation of [BxGetTopAgentRepositories] that fetches
/// top agents through the remote data source.
///
/// Unlike some other repositories, this implementation handles
/// [BxNetworkException] explicitly by converting it into a
/// [BxGetTopAgentResponse] with an error status, rather than letting
/// the exception propagate. This ensures that callers always receive a
/// response object, even when the network call fails.
///
library;

import 'package:tayara/core/network/interceptors/bx_network_exception.dart';
import 'package:tayara/data/data_source/remote/bx_system_remote_data_source.dart';
import 'package:tayara/domain/model/request/bx_get_top_agent_request.dart';
import 'package:tayara/domain/model/response/bx_get_top_agent_response.dart';
import 'package:tayara/domain/repositories/bx_get_top_agent_repositories.dart';

// File: lib/data/repositories/bx_get_top_agent_reposotories_impl.dart
// Architecture: Data Layer - Bx Get Top Agents Repository Implementation
// Purpose: Provides concrete implementation of the get top agents interface using remote data source

// ignore_for_file: prefer_initializing_formals

class BxGetTopAgentRepositoriesImpl implements BxGetTopAgentRepositories {
  final BxSystemRemoteDataSource _bxsystemRemoteDataSource;

  BxGetTopAgentRepositoriesImpl({
    required BxSystemRemoteDataSource bxsystemRemoteDataSource,
  }) : _bxsystemRemoteDataSource = bxsystemRemoteDataSource;

  /// Fetches top agents by calling the remote endpoint.
  ///
  /// On success a [BxGetTopAgentResponse] is returned. If a
  /// [BxNetworkException] is caught, an error response with the
  /// corresponding status code and message is returned. Any other
  /// exception results in a generic 7 error response.
  @override
  Future<BxGetTopAgentResponse> fetchTopAgents(
    BxGetTopAgentRequest request,
  ) async {
    try {
      final result = await _bxsystemRemoteDataSource.fetchTopAgents(request);
      return result;
    } on BxNetworkException catch (e) {
      return BxGetTopAgentResponse(
        code: e.statusCode,
        msg: e.message,
        data: null,
      );
    } catch (e) {
      return BxGetTopAgentResponse(
        code: 500,
        msg: 'Failed to fetch top agents. Please try again.',
        data: null,
      );
    }
  }
}
