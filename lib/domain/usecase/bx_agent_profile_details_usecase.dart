// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/domain/usecase/bx_agent_profile_details_usecase.dart
// Architecture: Domain Layer - Bx Agent profile details UseCase
// Purpose: Defines the Agent profile details use case

import 'package:tayara/domain/model/request/bx_agent_profile_details_request.dart';
import 'package:tayara/domain/model/response/bx_agent_profile_details_response.dart';
import 'package:tayara/domain/repositories/bx_agent_profile_details_repositories.dart';

/// Use case that fetches the Agent profile details with the provided request.
///
/// It invokes the repository with the fetch request and returns a
/// [BxAgentProfileDetailsResponse] indicating success or failure.
class BxAgentProfileDetailsUsecase {
  final BxAgentProfileDetailsRepositories repositories;

  /// Creates a [BxAgentProfileDetailsUsecase] with the necessary [repositories].
  BxAgentProfileDetailsUsecase(this.repositories);

  /// Fetches the Agent profile details with the provided request.
  ///
  /// Returns the server's fetch response.
  Future<BxAgentProfileDetailsResponse> execute(
    BxAgentProfileDetailsRequest request,
  ) {
    return repositories.fetchAgentDetailsData(request);
  }
}
