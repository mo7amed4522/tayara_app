// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/domain/repositories/bx_get_explore_topic_repositories.dart
// Architecture: Domain Layer - Bx Get explore topic Repository
// Purpose: Define the get explore topic repository for the application

import 'package:tayara/domain/model/request/bx_get_explore_topic_request.dart';
import 'package:tayara/domain/model/response/bx_get_explore_topic_response.dart';

///
/// Implementations call the remote get explore topic endpoint using the
/// user's credentials and return the outcome.
abstract class BxGetExploreTopicRepositories {
  /// Fetches the explore topic with the provided request.
  ///
  /// Returns a [BxGetExploreTopicResponse] indicating success or failure.
  Future<BxGetExploreTopicResponse> fetchExploreTopic(
    BxGetExploreTopicRequest request,
  );
}
