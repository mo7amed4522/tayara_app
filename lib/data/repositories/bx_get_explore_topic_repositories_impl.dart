/// Concrete implementation of [BxGetExploreTopicRepositories] that fetches
/// explore topic through the remote data source.
///
/// Unlike some other repositories, this implementation handles
/// [BxNetworkException] explicitly by converting it into a
/// [BxGetExploreTopicResponse] with an error status, rather than letting
/// the exception propagate. This ensures that callers always receive a
/// response object, even when the network call fails.
///
library;

import 'package:tayara/core/network/interceptors/bx_network_exception.dart';
import 'package:tayara/data/data_source/remote/bx_system_remote_data_source.dart';
import 'package:tayara/domain/model/request/bx_get_explore_topic_request.dart';
import 'package:tayara/domain/model/response/bx_get_explore_topic_response.dart';
import 'package:tayara/domain/repositories/bx_get_explore_topic_repositories.dart';

// File: lib/data/repositories/bx_get_explore_topic_repositories_impl.dart
// Architecture: Data Layer - Bx Get explore topic Repository Implementation
// Purpose: Provides concrete implementation of the get explore topic interface using remote data source

// ignore_for_file: prefer_initializing_formals

class BxGetExploreTopicRepositoriesImpl
    implements BxGetExploreTopicRepositories {
  final BxSystemRemoteDataSource _bxsystemRemoteDataSource;

  BxGetExploreTopicRepositoriesImpl({
    required BxSystemRemoteDataSource bxsystemRemoteDataSource,
  }) : _bxsystemRemoteDataSource = bxsystemRemoteDataSource;

  /// Fetches explore topic by calling the remote endpoint.
  ///
  /// On success a [BxGetExploreTopicResponse] is returned. If a
  /// [BxNetworkException] is caught, an error response with the
  /// corresponding status code and message is returned. Any other
  /// exception results in a generic 7 error response.
  @override
  Future<BxGetExploreTopicResponse> fetchExploreTopic(
    BxGetExploreTopicRequest request,
  ) async {
    try {
      final result = await _bxsystemRemoteDataSource.fetchExploreTopic(request);
      return result;
    } on BxNetworkException catch (e) {
      return BxGetExploreTopicResponse(
        code: e.statusCode,
        msg: e.message,
        data: null,
      );
    } catch (e) {
      return BxGetExploreTopicResponse(
        code: 500,
        msg: 'Failed to fetch explore topic. Please try again.',
        data: null,
      );
    }
  }
}
