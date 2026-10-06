// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/domain/usecase/bx_get_top_agent_usecase.dart
// Architecture: Domain Layer - Bx Get Top Agents UseCase
// Purpose: Defines the get top agents use case

import 'package:tayara/domain/model/request/bx_get_top_agent_request.dart';
import 'package:tayara/domain/model/response/bx_get_top_agent_response.dart';
import 'package:tayara/domain/repositories/bx_get_top_agent_repositories.dart';

/// Use case that fetches the top agents with the provided request.
///
/// It invokes the repository with the fetch request and returns a
/// [BxGetTopAgentResponse] indicating success or failure.
class BxGetTopAgentsUsecase {
  final BxGetTopAgentRepositories repositories;

  /// Creates a [BxGetTopAgentsUsecase] with the necessary [repositories].
  BxGetTopAgentsUsecase(this.repositories);

  /// Fetches the top agents with the provided request.
  ///
  /// Returns the server's fetch response.
  Future<BxGetTopAgentResponse> execute(BxGetTopAgentRequest request) {
    return repositories.fetchTopAgents(request);
  }
}
