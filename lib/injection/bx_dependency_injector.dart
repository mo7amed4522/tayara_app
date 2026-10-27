// File: lib/injection/bx_dependency_injector.dart
// Architecture: Dependency Injection - Main Injector
// Pattern: Dependency injection setup for the entire app

import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tayara/core/network/bx_dio_client.dart';
import 'package:tayara/data/data_source/local/bx_shared_preferences_datasource.dart';
import 'package:tayara/data/data_source/remote/bx_system_remote_data_source.dart';
import 'package:tayara/data/repositories/bx_active_top_banner_ads_repositories_impl.dart';
import 'package:tayara/data/repositories/bx_custom_search_repositories_impl.dart';
import 'package:tayara/data/repositories/bx_firebase_login_repositories_impl.dart';
import 'package:tayara/data/repositories/bx_get_destinations_repositories_impl.dart';
import 'package:tayara/data/repositories/bx_get_explore_trips_repositories_impl.dart';
import 'package:tayara/data/repositories/bx_get_recommended_for_customer_repositories_impl.dart';
import 'package:tayara/data/repositories/bx_get_search_repositories_impl.dart';
import 'package:tayara/data/repositories/bx_get_top_agent_reposotories_impl.dart';
import 'package:tayara/data/repositories/bx_get_top_deals_repositories_impl.dart';
import 'package:tayara/data/repositories/bx_login_user_repositories_impl.dart';
import 'package:tayara/domain/repositories/bx_active_top_banner_ads_repositories.dart';
import 'package:tayara/domain/repositories/bx_custom_search_repositories.dart';
import 'package:tayara/domain/repositories/bx_firebase_login_repositories.dart';
import 'package:tayara/domain/repositories/bx_get_destinations_repositories.dart';
import 'package:tayara/domain/repositories/bx_get_explore_trips_repositories.dart';
import 'package:tayara/domain/repositories/bx_get_recommended_for_customer_repositories.dart';
import 'package:tayara/domain/repositories/bx_get_search_repositories.dart';
import 'package:tayara/domain/repositories/bx_get_top_agent_repositories.dart';
import 'package:tayara/domain/repositories/bx_get_top_deals_repositories.dart';
import 'package:tayara/domain/repositories/bx_login_user_repositories.dart';
import 'package:tayara/domain/usecase/bx_active_top_banner_ads_usecase.dart';
import 'package:tayara/domain/usecase/bx_custom_search_usecase.dart';
import 'package:tayara/domain/usecase/bx_firebase_login_usecase.dart';
import 'package:tayara/domain/usecase/bx_get_destinations_usecase.dart';
import 'package:tayara/domain/usecase/bx_get_explore_trips_usecase.dart';
import 'package:tayara/domain/usecase/bx_get_recommended_for_customer_usecase.dart';
import 'package:tayara/domain/usecase/bx_get_search_usecase.dart';
import 'package:tayara/domain/usecase/bx_get_top_agent_usecase.dart';
import 'package:tayara/domain/usecase/bx_get_top_deals_usecase.dart';
import 'package:tayara/domain/usecase/bx_login_user_usecase.dart';

/// Central dependency injection container based on [GetIt].
///
/// This singleton initialises and wires together all core services,
/// data sources, repositories and use cases. The [setup] method must
/// be called once during app startup (e.g. in `main()` or a splash
/// screen) to register all dependencies before any other part of the
/// application attempts to retrieve them via the [get] method.
///
/// Usage:
/// ```dart
/// final injector = BxDependencyInjector.instance;
/// await injector.setup();
/// // later…
/// final loginUsecase = injector.get<BxLoginUserUsecase>();
/// ```
class BxDependencyInjector {
  static final BxDependencyInjector _singleton =
      BxDependencyInjector._internal();
  static final GetIt _getIt = GetIt.instance;

  /// Returns the singleton instance of the injector.
  factory BxDependencyInjector() {
    return _singleton;
  }

  BxDependencyInjector._internal();

  /// Provides access to the singleton from anywhere.
  static BxDependencyInjector get instance => _singleton;

  /// Registers all application dependencies.
  ///
  /// Must be called once before the first [get] call. It initialises:
  /// - Core: [BxDioClient] (singleton HTTP client)
  /// - SharedPreferences (singleton, obtained asynchronously)
  /// - Remote data source ([BxSystemRemoteDataSource])
  /// - Local data source ([BxSharedPreferencesDataSource])
  /// - All domain repositories (each bound to their implementation)
  /// - All use cases, with their required repositories injected
  ///
  /// After this completes, any registered type can be retrieved via [get].
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

    // Repositories
    _getIt.registerLazySingleton<BxFirebaseLoginRepositories>(
      () => BxFirebaseLoginRepositoriesImpl(bxsystemRemoteDataSource: _getIt()),
    );
    _getIt.registerLazySingleton<BxLoginUserRepositories>(
      () => BxLoginUserRepositoriesImpl(bxsystemRemoteDataSource: _getIt()),
    );
    _getIt.registerLazySingleton<BxActiveTopBannerAdsRepositories>(
      () => BxActiveTopBannerAdsRepositoriesImpl(
        bxsystemRemoteDataSource: _getIt(),
      ),
    );
    _getIt.registerLazySingleton<BxGetDestinationsRepositories>(
      () =>
          BxGetDestinationsRepositoriesImpl(bxsystemRemoteDataSource: _getIt()),
    );
    _getIt.registerLazySingleton<BxGetExploreTripsRepositories>(
      () =>
          BxGetExploreTripsRepositoriesImpl(bxsystemRemoteDataSource: _getIt()),
    );
    _getIt.registerLazySingleton<BxGetTopDealsRepositories>(
      () => BxGetTopDealsRepositoriesImpl(bxsystemRemoteDataSource: _getIt()),
    );
    _getIt.registerLazySingleton<BxGetTopAgentRepositories>(
      () => BxGetTopAgentRepositoriesImpl(bxsystemRemoteDataSource: _getIt()),
    );
    _getIt.registerLazySingleton<BxGetSearchRepositories>(
      () => BxGetSearchRepositoriesImpl(bxsystemRemoteDataSource: _getIt()),
    );
    _getIt.registerLazySingleton<BxGetRecommendedForCustomerRepositories>(
      () => BxGetRecommendedForCustomerRepositoriesImpl(
        bxsystemRemoteDataSource: _getIt(),
      ),
    );
    _getIt.registerLazySingleton<BxCustomSearchRepositories>(
      () => BxCustomSearchRepositoriesImpl(bxsystemRemoteDataSource: _getIt()),
    );
    // UseCases
    _getIt.registerLazySingleton<BxFirebaseLoginUsecase>(
      () => BxFirebaseLoginUsecase(_getIt()),
    );
    _getIt.registerLazySingleton<BxLoginUserUsecase>(
      () => BxLoginUserUsecase(_getIt()),
    );
    _getIt.registerLazySingleton<BxActiveTopBannerAdsUsecase>(
      () => BxActiveTopBannerAdsUsecase(_getIt()),
    );
    _getIt.registerLazySingleton<BxGetDestinationsUsecase>(
      () => BxGetDestinationsUsecase(_getIt()),
    );
    _getIt.registerLazySingleton<BxGetExploreTripsUsecase>(
      () => BxGetExploreTripsUsecase(_getIt()),
    );
    _getIt.registerLazySingleton<BxGetTopDealsUsecase>(
      () => BxGetTopDealsUsecase(_getIt()),
    );
    _getIt.registerLazySingleton<BxGetTopAgentsUsecase>(
      () => BxGetTopAgentsUsecase(_getIt()),
    );
    _getIt.registerLazySingleton<BxGetSearchUsecase>(
      () => BxGetSearchUsecase(_getIt()),
    );
    _getIt.registerLazySingleton<BxGetRecommendedForCustomerUsecase>(
      () => BxGetRecommendedForCustomerUsecase(_getIt()),
    );
    _getIt.registerLazySingleton<BxCustomSearchUsecase>(
      () => BxCustomSearchUsecase(_getIt()),
    );
    // Tab Blocs — singleton so data stays cached and is NOT re-fetched on tab switch/swipe.
    // They live as long as the app lives; RefreshIndicator / retry explicitly reloads them.
  }

  /// Whether [T] is already registered in GetIt.
  bool isRegistered<T extends Object>() => _getIt.isRegistered<T>();

  /// Callable alias for [get] so `injector<T>()` works (used by some screens).
  T call<T extends Object>() => get<T>();

  /// Retrieves a previously registered dependency of type [T].
  ///
  /// Throws a [GetIt] error if the type has not been registered.
  T get<T extends Object>() => _getIt.get<T>();
}
