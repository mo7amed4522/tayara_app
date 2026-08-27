// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/data/repositories/bx_profile_repositories_impl.dart
// Architecture: Data Layer - Profile Repository Implementation
// Purpose: Provides concrete implementation of the profile repository interface

// ignore_for_file: prefer_initializing_formals

import 'package:tayara/data/data_source/remote/bx_system_remote_data_source.dart';
import 'package:tayara/domain/model/response/bx_profile_response.dart';
import 'package:tayara/domain/repositories/bx_profile_repositories.dart';

class BxProfileRepositoriesImpl implements BxProfileRepositories {
  final BxSystemRemoteDataSource _remoteDataSource;

  BxProfileRepositoriesImpl({
    required BxSystemRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Future<BxProfileResponse> loadProfile() => _remoteDataSource.loadProfile();
}
