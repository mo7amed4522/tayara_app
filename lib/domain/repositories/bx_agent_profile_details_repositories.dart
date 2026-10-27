// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/domain/repositories/bx_agent_profile_details_repositories.dart
// Architecture: Domain Layer - Bx Agent profile details Repository
// Purpose: Define the Agent profile details repository for the application

import 'package:tayara/domain/model/request/bx_agent_profile_details_request.dart';
import 'package:tayara/domain/model/response/bx_agent_profile_details_response.dart';

///
/// Implementations call the remote Agent profile details endpoint using the
/// user's credentials and return the outcome.
abstract class BxAgentProfileDetailsRepositories {
  /// Fetches the Agent profile details with the provided request.
  ///
  /// Returns a [BxAgentProfileDetailsResponse] indicating success or failure.
  Future<BxAgentProfileDetailsResponse> fetchAgentDetailsData(
    BxAgentProfileDetailsRequest request,
  );
}
