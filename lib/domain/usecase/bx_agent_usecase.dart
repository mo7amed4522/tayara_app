// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/domain/usecase/bx_agent_usecase.dart
// Architecture: Domain Layer - Agent UseCase
// Purpose: Defines the agent use cases

import 'package:tayara/domain/model/request/bx_home_request.dart';
import 'package:tayara/domain/model/response/bx_agent_response.dart';
import 'package:tayara/domain/repositories/bx_agent_repositories.dart';

class BxAgentUsecase {
  final BxAgentRepositories _repositories;

  BxAgentUsecase(this._repositories);

  Future<BxCustomerAgentDetailResponse> loadAgentDetail(
    BxCustomerAgentDetailRequest request,
  ) => _repositories.loadAgentDetail(request);
}
