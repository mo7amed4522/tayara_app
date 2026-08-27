// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/data/repositories/bx_agent_repositories_impl.dart
// Architecture: Data Layer - Agent Repository Implementation
// Purpose: Provides concrete implementation of the agent repository interface

// ignore_for_file: prefer_initializing_formals

import 'package:tayara/data/data_source/remote/bx_system_remote_data_source.dart';
import 'package:tayara/domain/model/request/bx_home_request.dart';
import 'package:tayara/domain/model/response/bx_agent_response.dart';
import 'package:tayara/domain/repositories/bx_agent_repositories.dart';

class BxAgentRepositoriesImpl implements BxAgentRepositories {
  final BxSystemRemoteDataSource _remoteDataSource;

  BxAgentRepositoriesImpl({required BxSystemRemoteDataSource remoteDataSource})
    : _remoteDataSource = remoteDataSource;

  @override
  Future<BxCustomerAgentDetailResponse> loadAgentDetail(
    BxCustomerAgentDetailRequest request,
  ) => _remoteDataSource.loadAgentDetail(request);
}
