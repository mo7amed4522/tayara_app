// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/injection/bx_dependency_injector.dart
// Architecture: Dependency Injection - Main Injector
// Pattern: Dependency injection setup for the entire app

import 'package:tayara/core/network/bx_dio_client.dart';
import 'package:tayara/data/data_source/local/bx_shared_preferences_datasource.dart';
import 'package:tayara/data/data_source/remote/bx_system_remote_data_source.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tayara/data/repositories/bx_firebase_login_repositories_impl.dart';
import 'package:tayara/domain/repositories/bx_firebase_login_repositories.dart';
import 'package:tayara/domain/usecase/bx_firebase_login_usecase.dart';
import 'package:tayara/data/repositories/bx_home_repositories_impl.dart';
import 'package:tayara/domain/repositories/bx_home_repositories.dart';
import 'package:tayara/domain/usecase/bx_home_usecase.dart';
import 'package:tayara/data/repositories/bx_booking_repositories_impl.dart';
import 'package:tayara/domain/repositories/bx_booking_repositories.dart';
import 'package:tayara/domain/usecase/bx_booking_usecase.dart';
import 'package:tayara/data/repositories/bx_package_repositories_impl.dart';
import 'package:tayara/domain/repositories/bx_package_repositories.dart';
import 'package:tayara/domain/usecase/bx_package_usecase.dart';
import 'package:tayara/data/repositories/bx_agent_repositories_impl.dart';
import 'package:tayara/domain/repositories/bx_agent_repositories.dart';
import 'package:tayara/domain/usecase/bx_agent_usecase.dart';
import 'package:tayara/data/repositories/bx_profile_repositories_impl.dart';
import 'package:tayara/domain/repositories/bx_profile_repositories.dart';
import 'package:tayara/domain/usecase/bx_profile_usecase.dart';

/// Central dependency injection container based on [GetIt].
class BxDependencyInjector {
  static final BxDependencyInjector _singleton =
      BxDependencyInjector._internal();
  static final GetIt _getIt = GetIt.instance;

  factory BxDependencyInjector() => _singleton;

  BxDependencyInjector._internal();

  static BxDependencyInjector get instance => _singleton;

  /// Registers all application dependencies.
  Future<void> setup() async {
    // Core
    _getIt.registerLazySingleton<BxDioClient>(() => BxDioClient.instance);

    // Initialize SharedPreferences first
    final sharedPreferences = await SharedPreferences.getInstance();
    _getIt.registerSingleton<SharedPreferences>(sharedPreferences);

    // Data Sources
    _getIt.registerLazySingleton<BxSystemRemoteDataSource>(
      () => BxSystemRemoteDataSourceImpl(dioClient: _getIt()),
    );
    _getIt.registerLazySingleton<BxSharedPreferencesDataSource>(
      () => BxSharedPreferencesDataSourceImpl(_getIt()),
    );

    // ── Auth Repositories & UseCases ─────────────────────────────────────────

    _getIt.registerLazySingleton<BxFirebaseLoginRepositories>(
      () => BxFirebaseLoginRepositoriesImpl(bxsystemRemoteDataSource: _getIt()),
    );
    _getIt.registerLazySingleton<BxFirebaseLoginUsecase>(
      () => BxFirebaseLoginUsecase(_getIt()),
    );

    // ── Home Repositories & UseCases ─────────────────────────────────────────

    _getIt.registerLazySingleton<BxHomeRepositories>(
      () => BxHomeRepositoriesImpl(remoteDataSource: _getIt()),
    );
    _getIt.registerLazySingleton<BxHomeUsecase>(() => BxHomeUsecase(_getIt()));

    // ── Booking Repositories & UseCases ───────────────────────────────────────

    _getIt.registerLazySingleton<BxBookingRepositories>(
      () => BxBookingRepositoriesImpl(remoteDataSource: _getIt()),
    );
    _getIt.registerLazySingleton<BxBookingUsecase>(
      () => BxBookingUsecase(_getIt()),
    );

    // ── Package Repositories & UseCases ───────────────────────────────────────

    _getIt.registerLazySingleton<BxPackageRepositories>(
      () => BxPackageRepositoriesImpl(remoteDataSource: _getIt()),
    );
    _getIt.registerLazySingleton<BxPackageUsecase>(
      () => BxPackageUsecase(_getIt()),
    );

    // ── Agent Repositories & UseCases ─────────────────────────────────────────

    _getIt.registerLazySingleton<BxAgentRepositories>(
      () => BxAgentRepositoriesImpl(remoteDataSource: _getIt()),
    );
    _getIt.registerLazySingleton<BxAgentUsecase>(
      () => BxAgentUsecase(_getIt()),
    );

    // ── Profile Repositories & UseCases ───────────────────────────────────────

    _getIt.registerLazySingleton<BxProfileRepositories>(
      () => BxProfileRepositoriesImpl(remoteDataSource: _getIt()),
    );
    _getIt.registerLazySingleton<BxProfileUsecase>(
      () => BxProfileUsecase(_getIt()),
    );
  }

  /// Retrieves a previously registered dependency of type [T].
  T get<T extends Object>() => _getIt.get<T>();
}
