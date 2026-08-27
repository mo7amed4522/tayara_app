// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/domain/repositories/bx_agent_repositories.dart
// Architecture: Domain Layer - Agent Repository
// Purpose: Define the agent repository interface for the application

import 'package:tayara/domain/model/request/bx_home_request.dart';
import 'package:tayara/domain/model/response/bx_agent_response.dart';

abstract class BxAgentRepositories {
  Future<BxCustomerAgentDetailResponse> loadAgentDetail(
    BxCustomerAgentDetailRequest request,
  );
}
