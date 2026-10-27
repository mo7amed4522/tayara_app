// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/domain/usecase/bx_get_explore_topic_usecase.dart
// Architecture: Domain Layer - Bx Get explore topic UseCase
// Purpose: Defines the get destinations use case

import 'package:tayara/domain/model/request/bx_get_explore_topic_request.dart';
import 'package:tayara/domain/model/response/bx_get_explore_topic_response.dart';
import 'package:tayara/domain/repositories/bx_get_explore_topic_repositories.dart';

/// Use case that fetches the explore topic with the provided request.
///
/// It invokes the repository with the fetch request and returns a
/// [BxGetExploreTopicResponse] indicating success or failure.
class BxGetExploreTopicUsecase {
  final BxGetExploreTopicRepositories repositories;

  /// Creates a [BxGetExploreTopicUsecase] with the necessary [repositories].
  BxGetExploreTopicUsecase(this.repositories);

  /// Fetches the explore topic with the provided request.
  ///
  /// Returns the server's fetch response.
  Future<BxGetExploreTopicResponse> execute(BxGetExploreTopicRequest request) {
    return repositories.fetchExploreTopic(request);
  }
}
