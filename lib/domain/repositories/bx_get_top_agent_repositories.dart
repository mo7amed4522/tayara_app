// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/domain/repositories/bx_get_top_agent_repositories.dart
// Architecture: Domain Layer - Bx Get Top Agents Repository
// Purpose: Define the get top agents repository for the application

import 'package:tayara/domain/model/request/bx_get_top_agent_request.dart';
import 'package:tayara/domain/model/response/bx_get_top_agent_response.dart';

///
/// Implementations call the remote get top agents endpoint using the
/// user's credentials and return the outcome.
abstract class BxGetTopAgentRepositories {
  /// Fetches the top agents with the provided request.
  ///
  /// Returns a [BxGetTopAgentResponse] indicating success or failure.
  Future<BxGetTopAgentResponse> fetchTopAgents(BxGetTopAgentRequest request);
}
