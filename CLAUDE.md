# Tayara Flutter App — Development Rules & Conventions

**Project**: Tayara — Flutter travel booking app  
**Architecture**: Clean Architecture (Domain / Data / Presentation layers)  
**State Management**: flutter_bloc + equatable  
**Dependency Injection**: get_it (`BxDependencyInjector`)  
**Networking**: dio (`BxDioClient`)  
**Responsive**: `BxResponsiveBuilder` (mobile/tablet/desktop) + `flutter_screenutil`  
**Localisation**: flutter_localizations (`AppLocalizations`)  
**Copyright**: `// Copyright (c) 2026 Tayara. All rights reserved.`

---

## 1. File Naming Conventions

All files use **lowercase with underscores**. Every class, file, and folder name is prefixed with **`bx_`** (lowercase).

| Layer | Prefix / Suffix | Example |
|---|---|---|
| BLoC directory | `bx_<feature>_controller/` | `bx_login_controller/` |
| BLoC file | `bx_<feature>_controller_bloc.dart` | `bx_login_controller_bloc.dart` |
| Event file | `bx_<feature>_controller_event.dart` | `bx_login_controller_event.dart` |
| State file | `bx_<feature>_controller_state.dart` | `bx_login_controller_state.dart` |
| Screen (View) | `bx_<feature>_screen.dart` | `bx_login_screen.dart` |
| Screen Mobile | `bx_<feature>_screen_mobile.dart` | `bx_home_bottom_screen_mobile.dart` |
| Screen Tablet | `bx_<feature>_screen_tablet.dart` | `bx_home_bottom_screen_tablet.dart` |
| Widget Mobile | `bx_<feature>_widget_mobile.dart` | `bx_login_widget_mobile.dart` |
| Widget Tablet | `bx_<feature>_widget_tablet.dart` | `bx_login_widget_tablet.dart` |
| Repository (domain) | `bx_<feature>_repositories.dart` | `bx_firebase_login_repositories.dart` |
| Repository (impl) | `bx_<feature>_repositories_impl.dart` | `bx_firebase_login_repositories_impl.dart` |
| UseCase | `bx_<feature>_usecase.dart` | `bx_firebase_login_usecase.dart` |
| Data Source (remote) | `bx_<feature>_remote_data_source.dart` | `bx_system_remote_data_source.dart` |
| Data Source (local) | `bx_<feature>_datasource.dart` | `bx_shared_preferences_datasource.dart` |
| Service | `bx_<feature>_services.dart` | `bx_google_auth_firebase_services.dart` |
| Model (request) | `bx_<feature>_request.dart` (+ `.g.dart`) | `bx_firebase_login_request.dart` |
| Model (response) | `bx_<feature>_response.dart` (+ `.g.dart`) | `bx_firebase_login_response.dart` |
| Constant | `bx_app_constant.dart`, `bx_shared_preferences_keys.dart` | — |
| Theme | `bx_app_theme.dart`, `bx_app_colors.dart` | — |
| Route | `bx_route_names.dart`, `bx_app_routes.dart`, `bx_route_generator.dart` | — |
| Network | `bx_dio_client.dart`, `bx_api_endpoints.dart` | — |
| Responsive | `bx_responsive_builder.dart`, `bx_breakpoints.dart`, `bx_screen_utils.dart` | — |
| Utils | `bx_<utility_name>.dart` | `bx_custom_snack_bar.dart` |
| DI | `bx_dependency_injector.dart` | — |

**Class naming**: PascalCase with `Bx` prefix.  
**Variable naming**: camelCase, no `bx_` prefix on variables.  
**Private helpers**: underscore prefix, e.g. `_callLoginUseCase`, `_onStartSplashTimer`.

---

## 2. File Header / Copyright

Every Dart file MUST start with this header:

```dart
// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/<path>/<file_name>.dart
// Architecture: <Layer Name> - <Description>
// Purpose: <one-line purpose>
```

For library files (e.g. `bx_app_constant.dart`, `bx_dio_client.dart`) use:
```dart
// Copyright (c) 2026 Tayara. All rights reserved.
//
/// <docstring>
library;
```

---

## 3. Architecture — Layer Structure

```
lib/
├── main.dart                      # Entry point
├── bx_app_widget.dart             # Root widget (BlocProviders + MaterialApp)
├── injection/
│   └── bx_dependency_injector.dart
├── core/
│   ├── constant/                  # App constants, fonts, SP keys
│   ├── theme/                     # BxAppTheme, BxAppColors
│   ├── routes/                    # BxRouteNames, BxRouteGenerator, BxAppRouter
│   ├── network/                   # BxDioClient, BxApiEndpoints, interceptors
│   ├── responsive/                # BxResponsiveBuilder, BxBreakpoints, BxScreenUtils
│   ├── services/                  # Auth services (Firebase)
│   ├── utils/                     # Utility widgets/classes
│   └── widgets/                   # Shared core widgets
├── data/
│   ├── data_source/
│   │   ├── local/                 # BxSharedPreferencesDataSource
│   │   └── remote/                # BxSystemRemoteDataSource (abstract + impl)
│   └── repositories/              # Repository implementations
├── domain/
│   ├── repositories/              # Abstract repository interfaces
│   ├── usecase/                   # UseCase classes
│   └── model/
│       ├── request/               # Request models (@JsonSerializable)
│       └── response/              # Response models (@JsonSerializable)
└── presentation/
    ├── bloc/
    │   └── bx_<feature>_controller/
    │       ├── bx_<feature>_controller_bloc.dart
    │       ├── bx_<feature>_controller_event.dart
    │       └── bx_<feature>_controller_state.dart
    ├── views/
    │   └── bx_<feature>_screen/
    │       ├── bx_<feature>_screen.dart          # Delegates to mobile/tablet
    │       ├── bx_<feature>_screen_mobile.dart
    │       └── bx_<feature>_screen_tablet.dart
    └── widgets/
        └── bx_<feature>_widget/
            ├── bx_<feature>_widget_mobile.dart
            └── bx_<feature>_widget_tablet.dart
```

---

## 4. BLoC Rules

### Directory Structure
Each BLoC lives in its own folder: `lib/presentation/bloc/bx_<feature>_controller/`

### Bloc File (`bx_<feature>_controller_bloc.dart`)
```dart
// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/presentation/bloc/bx_<feature>_controller/bx_<feature>_controller_bloc.dart
// Architecture: Presentation Layer - <Feature> Controller
// Purpose: BLoC for managing <feature> state
// ignore_for_file: prefer_initializing_formals, empty_constructor_bodies

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bx_<feature>_controller_event.dart';
part 'bx_<feature>_controller_state.dart';

class Bx<Feature>ControllerBloc
    extends Bloc<Bx<Feature>ControllerEvent, Bx<Feature>ControllerState> {
  // Injected dependencies as final fields
  final SomeDependency _someDependency;

  Bx<Feature>ControllerBloc({required SomeDependency someDependency})
      : _someDependency = someDependency,
        super(const Bx<Feature>ControllerState()) {
    on<BxSomeEvent>(_onSomeEvent);
    on<BxAnotherEvent>(_onAnotherEvent);
  }

  Future<void> _onSomeEvent(
    BxSomeEvent event,
    Emitter<Bx<Feature>ControllerState> emit,
  ) async {
    emit(state.copyWith(status: Bx<Feature>Status.loading));
    try {
      // ... business logic via use case or direct call
      emit(state.copyWith(status: Bx<Feature>Status.success));
    } catch (e) {
      emit(state.copyWith(status: Bx<Feature>Status.error, errorMessage: e.toString()));
    }
  }
}
```

### Event File (`bx_<feature>_controller_event.dart`)
```dart
part of 'bx_<feature>_controller_bloc.dart';

abstract class Bx<Feature>ControllerEvent extends Equatable {
  const Bx<Feature>ControllerEvent();
  @override
  List<Object?> get props => [];
}

class BxSomeEvent extends Bx<Feature>ControllerEvent {
  final String someValue;
  const BxSomeEvent({required this.someValue});
  @override
  List<Object?> get props => [someValue];
}
```

### State File (`bx_<feature>_controller_state.dart`)
```dart
part of 'bx_<feature>_controller_bloc.dart';

enum Bx<Feature>Status { initial, loading, success, error }

class Bx<Feature>ControllerState extends Equatable {
  final Bx<Feature>Status status;
  final String? errorMessage;
  final SomeData? someData;

  const Bx<Feature>ControllerState({
    this.status = Bx<Feature>Status.initial,
    this.errorMessage,
    this.someData,
  });

  @override
  List<Object?> get props => [status, errorMessage, someData];

  Bx<Feature>ControllerState copyWith({
    Bx<Feature>Status? status,
    String? errorMessage,
    SomeData? someData,
  }) {
    return Bx<Feature>ControllerState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      someData: someData ?? this.someData,
    );
  }
}
```

### BLoC Naming Conventions
- **Bloc class**: `Bx<Feature>ControllerBloc`
- **Event base**: `Bx<Feature>ControllerEvent`
- **State base**: `Bx<Feature>ControllerState`
- **Status enum**: `Bx<Feature>Status` (or feature-specific like `BxLoginControllerStatus`)
- **Events**: `Bx<Verb><Noun>` — e.g. `BxLoginWithGoogle`, `BxLoadThemeEvent`, `BxChangeHomeTab`
- **State fields**: named after what they represent, not prefixed with `bx_`

### Status Enum Values
Always use: `initial`, `loading`, `success`, `error`  
(For onboarding only: `initial`, `loading`, `completed`)

---

## 5. Screen / View Rules

### Screen File (`bx_<feature>_screen.dart`)
Always a `StatelessWidget` that provides the BLoC via `BlocProvider` and delegates to mobile/tablet widgets.

```dart
class Bx<Feature>Screen extends StatelessWidget {
  const Bx<Feature>Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => Bx<Feature>ControllerBloc(
        someDependency: BxDependencyInjector.instance
            .get<ISomeDependency>(),
      ),
      child: BxResponsiveBuilder(
        mobileBuilder: (context) => const Bx<Feature>WidgetMobile(),
        tabletBuilder: (context) => const Bx<Feature>WidgetTablet(),
      ),
    );
  }
}
```

For screens using `LayoutBuilder` instead of `BxResponsiveBuilder`:
```dart
child: LayoutBuilder(
  builder: (context, constraints) {
    if (constraints.maxWidth < 600) {
      return const Bx<Feature>WidgetMobile();
    } else {
      return const Bx<Feature>WidgetTablet();
    }
  },
),
```

### Mobile / Tablet Widget Files
- Named `bx_<feature>_widget_mobile.dart` and `bx_<feature>_widget_tablet.dart`
- Inside `lib/presentation/widgets/bx_<feature>_widget/`
- Both are `StatelessWidget`s (or `StatefulWidget` only if they have local state)
- Use `Theme.of(context)` for all colors/text styles — never hard-code colors
- Use `BxAppColors` from `lib/core/theme/bx_app_colors.dart` for brand colors
- Use `textTheme` from `Theme.of(context)` for text styling
- Use `colorScheme` from `Theme.of(context)` for semantic colors

---

## 6. Repository Rules

### Domain Repository (Interface)
Located in `lib/domain/repositories/`. Always an abstract class.

```dart
// Copyright (c) 2026 Tayara. All rights reserved.
//
// File: lib/domain/repositories/bx_<feature>_repositories.dart
// Architecture: Domain Layer - <Feature> Repository
// Purpose: Define the <feature> repository for the application

abstract class Bx<Feature>Repositories {
  Future<SomeResponse> doSomething(SomeRequest request);
}
```

### Data Repository (Implementation)
Located in `lib/data/repositories/`. Implements the domain interface.

```dart
// File: lib/data/repositories/bx_<feature>_repositories_impl.dart
// Architecture: Data Layer - <Feature> Repository Implementation
// Purpose: Provides concrete implementation using remote data source

class Bx<Feature>RepositoriesImpl implements Bx<Feature>Repositories {
  final BxSystemRemoteDataSource _remoteDataSource;

  Bx<Feature>RepositoriesImpl({required BxSystemRemoteDataSource remoteDataSource})
      : _remoteDataSource = remoteDataSource;

  @override
  Future<SomeResponse> doSomething(SomeRequest request) async {
    try {
      final result = await _remoteDataSource.doSomething(request);
      return result;
    } on BxNetworkException catch (e) {
      return SomeResponse(code: e.statusCode, message: e.message, data: null);
    } catch (e) {
      return SomeResponse(code: 500, message: 'Some message', data: null);
    }
  }
}
```

**Key rule**: Never let exceptions escape the repository. Always catch and return an error response object.

---

## 7. Data Source Rules

### Remote Data Source
Located in `lib/data/data_source/remote/`. Has both abstract interface and implementation.

```dart
abstract class BxSystemRemoteDataSource {
  Future<SomeResponse> doSomething(SomeRequest request);
}

class BxSystemRemoteDataSourceImpl implements BxSystemRemoteDataSource {
  final BxDioClient _dioClient;

  BxSystemRemoteDataSourceImpl({required BxDioClient dioClient})
      : _dioClient = dioClient;

  @override
  Future<SomeResponse> doSomething(SomeRequest request) async {
    try {
      final options = Options(headers: {'Content-Type': 'application/json'});
      final response = await _dioClient.post(
        BxApiEndpoints.someEndpoint,
        options: options,
        data: request.toJson(),
      );
      if (response is Map<String, dynamic> && response['code'] == 0) {
        return SomeResponse.fromJson(response);
      }
      // ... handle non-success responses
      return SomeResponse(code: 7, message: response['msg'], data: null);
    } on BxNetworkException catch (e) {
      return SomeResponse(code: e.statusCode, message: e.message, data: null);
    } catch (e) {
      return SomeResponse(code: 7, message: 'some message', data: null);
    }
  }
}
```

### Local Data Source
Located in `lib/data/data_source/local/`. Same pattern: abstract + impl.

```dart
abstract class BxSharedPreferencesDataSource {
  Future<bool> saveString(String key, String value);
  Future<String?> getString(String key);
  Future<bool> saveBool(String key, bool value);
  Future<bool?> getBool(String key);
  Future<bool> saveLanguageCode(String languageCode);
  Future<String?> getLanguageCode();
  Future<bool> saveThemeMode(String themeMode);
  Future<String?> getThemeMode();
}

class BxSharedPreferencesDataSourceImpl implements BxSharedPreferencesDataSource {
  final SharedPreferences _sharedPreferences;
  BxSharedPreferencesDataSourceImpl(this._sharedPreferences);
  // ... implementation delegates to _sharedPreferences
}
```

---

## 8. UseCase Rules

Located in `lib/domain/usecase/`. Thin wrapper around repository.

```dart
// File: lib/domain/usecase/bx_<feature>_usecase.dart
// Architecture: Domain Layer - <Feature> UseCase
// Purpose: Defines the <feature> use case

class Bx<Feature>Usecase {
  final Bx<Feature>Repositories _repositories;

  Bx<Feature>Usecase(this._repositories);

  Future<SomeResponse> execute(SomeRequest request) {
    return _repositories.doSomething(request);
  }
}
```

---

## 9. Service Rules

Auth services are in `lib/core/services/`. They use singleton pattern.

```dart
// File: lib/core/services/bx_<provider>_firebase_services.dart
// Architecture: Core Services – Authentication
// Purpose: Handle <Provider> Sign-In via Firebase Authentication

class Bx<Provider>AuthFirebaseServices {
  static final Bx<Provider>AuthFirebaseServices _instance =
      Bx<Provider>AuthFirebaseServices._internal();
  static Bx<Provider>AuthFirebaseServices get instance => _instance;
  Bx<Provider>AuthFirebaseServices._internal();

  // Result model
  class Bx<Provider>AuthResult {
    final bool success;
    final UserCredential? user;
    final String? error;
    Bx<Provider>AuthResult.success(this.user) : success = true, error = null;
    Bx<Provider>AuthResult.failure(this.error) : success = false, user = null;
  }

  Future<Bx<Provider>AuthResult> signIn() async {
    // ... implementation
  }
}
```

**Key rules for services:**
- Use singleton pattern (`static instance`)
- Return a result model (success/failure), never throw
- Handle all errors internally and return user-friendly messages
- Include platform checks (e.g. iOS simulator check)

---

## 10. Domain Model Rules

### Request Models
Located in `lib/domain/model/request/`. Use `@JsonSerializable()`.

```dart
// File: lib/domain/model/request/bx_<feature>_request.dart
// Architecture: Domain Layer - Request Model
// Purpose: Model for <feature> request

import 'package:json_annotation/json_annotation.dart';

part 'bx_<feature>_request.g.dart';

@JsonSerializable()
class Bx<Feature>Request {
  @JsonKey(name: 'fieldName')
  final String fieldName;

  Bx<Feature>Request({required this.fieldName});

  factory Bx<Feature>Request.fromJson(Map<String, dynamic> json) =>
      _$Bx<Feature>RequestFromJson(json);

  Map<String, dynamic> toJson() => _$Bx<Feature>RequestToJson(this);
}
```

### Response Models
Located in `lib/domain/model/response/`. Use `@JsonSerializable()`.

```dart
// File: lib/domain/model/response/bx_<feature>_response.dart
// Architecture: Domain Layer - Response Model
// Purpose: Model for <feature> response

import 'package:json_annotation/json_annotation.dart';

part 'bx_<feature>_response.g.dart';

@JsonSerializable()
class Bx<Feature>Response {
  @JsonKey(name: 'code')
  final int? code;

  @JsonKey(name: 'msg')
  final String? message;

  @JsonKey(name: 'data')
  final SomeData? data;

  Bx<Feature>Response({this.code, this.message, this.data});

  factory Bx<Feature>Response.fromJson(Map<String, dynamic> json) =>
      _$Bx<Feature>ResponseFromJson(json);

  Map<String, dynamic> toJson() => _$Bx<Feature>ResponseToJson(this);
}
```

**Key rule**: All models use `@JsonSerializable()` with `part` directive pointing to `.g.dart`. Run `flutter pub run build_runner build` after changes.

---

## 11. Dependency Injection Rules

All dependencies are registered in `BxDependencyInjector` (`lib/injection/bx_dependency_injector.dart`).

```dart
// Core
_getIt.registerLazySingleton<BxDioClient>(() => BxDioClient.instance);

// Local Data Source
final sharedPreferences = await SharedPreferences.getInstance();
_getIt.registerSingleton<SharedPreferences>(sharedPreferences);
_getIt.registerLazySingleton<BxSharedPreferencesDataSource>(
  () => BxSharedPreferencesDataSourceImpl(_getIt()),
);

// Remote Data Source
_getIt.registerLazySingleton<BxSystemRemoteDataSource>(
  () => BxSystemRemoteDataSourceImpl(dioClient: _getIt()),
);

// Repository
_getIt.registerLazySingleton<Bx<Feature>Repositories>(
  () => Bx<Feature>RepositoriesImpl(remoteDataSource: _getIt()),
);

// UseCase
_getIt.registerLazySingleton<Bx<Feature>Usecase>(
  () => Bx<Feature>Usecase(_getIt()),
);
```

### Accessing Dependencies
```dart
// In BLoC / Screen / Service:
final dependency = BxDependencyInjector.instance.get<SomeType>();
```

**Key rule**: BLoCs receive dependencies through their constructor (injected at `BlocProvider.create`). Never call `BxDependencyInjector.instance.get()` inside a BLoC's event handler — inject at construction time.

---

## 12. Route Rules

### Route Names
All route names are in `BxRouteNames` (`lib/core/routes/bx_route_names.dart`):
```dart
static const String bxSplashScreen = '/';
static const String bxOnBoardingScreen = '/on-boarding-screen';
static const String bxLoginScreen = '/login-screen';
static const String bxHomeScreen = '/home-screen';
```

### Route Generator
All routes go through `BxRouteGenerator.generateRoute(RouteSettings settings)` in `lib/core/routes/bx_route_generator.dart`. It uses a `switch` on `settings.name` and wraps each route in `_buildRoute()` (slide-up transition).

### Navigation
Use `BxAppRouter` for navigation helpers:
```dart
BxAppRouter.push(context, BxRouteNames.bxLoginScreen);
BxAppRouter.pushReplacement(context, BxRouteNames.bxHomeScreen);
BxAppRouter.pop(context);
```

### Adding a New Route
1. Add constant to `BxRouteNames`
2. Add case to `BxRouteGenerator.generateRoute()` switch
3. Add to `publicRoutes` or `protectedRoutes` list as appropriate

---

## 13. Responsive Design Rules

### Breakpoints
- **Mobile**: `< 600px`
- **Tablet**: `600px – 1200px`
- **Desktop**: `>= 1200px`

### Two Patterns

**Pattern A: `BxResponsiveBuilder`** (preferred for most screens)
```dart
BxResponsiveBuilder(
  mobileBuilder: (context) => const BxFeatureWidgetMobile(),
  tabletBuilder: (context) => const BxFeatureWidgetTablet(),
)
```

**Pattern B: `LayoutBuilder`** (used when conditional logic is needed inside build)
```dart
LayoutBuilder(
  builder: (context, constraints) {
    if (constraints.maxWidth < 600) {
      return const BxFeatureWidgetMobile();
    } else {
      return const BxFeatureWidgetTablet();
    }
  },
)
```

### Responsive Widgets
- Mobile and tablet widgets are separate files
- Tablet widgets may wrap content in `ConstrainedBox(maxWidth: 480)` for centered layouts
- Use `flutter_screenutil` (`.sp`, `.h`, `.w`) for scalable sizing where needed
- Design base size: `375 x 812` (set in `ScreenUtilInit` in `main.dart`)

---

## 14. Widget / UI Rules

### Constructor Pattern
- Public widgets: `const Bx<Feature>Screen({super.key});`
- Private sub-widgets: `const _SubWidget();` (no key needed)

### Theme Usage
```dart
// ALWAYS use Theme.of(context)
final theme = Theme.of(context);
final colorScheme = theme.colorScheme;
final textTheme = theme.textTheme;

// For brand colors, import BxAppColors
import 'package:tayara/core/theme/bx_app_colors.dart';
// Usage: BxAppColors.primary, BxAppColors.error, etc.
```

### Text Styling
- Use `textTheme` from theme, e.g. `textTheme.titleLarge`, `textTheme.bodyMedium`
- Add `fontFamily: 'lao-mn'` where specified in existing code
- Use `?.copyWith()` to override specific properties

### BLoC in Widget
```dart
// Read state
final state = context.read<BxFeatureControllerBloc>().state;

// Listen to state changes
BlocBuilder<BxFeatureControllerBloc, BxFeatureControllerState>(
  builder: (context, state) { ... },
)

// Dispatch event
context.read<BxFeatureControllerBloc>().add(BxSomeEvent());
```

---

## 15. Network / Dio Rules

### API Endpoints
All endpoints go in `BxApiEndpoints` (`lib/core/network/bx_api_endpoints.dart`):
```dart
class BxApiEndpoints {
  BxApiEndpoints._();
  static String get baseUrl => BxAppConfig.baseUrl;
  static String get loginUrl => '/api/${BxAppData.appVersion}/user/firebase-login';
}
```

### Dio Client
- Singleton: `BxDioClient.instance`
- Base URL from `BxAppConfig.baseUrl`
- 30s connect/receive timeout
- `validateStatus: (status) => status <= 500` (manual error handling)
- Three interceptors: `BxAuthInterceptor`, `BxErrorInterceptor`, `BxLoggingInterceptor`

### Error Handling Pattern
```dart
try {
  final response = await _dioClient.post(BxApiEndpoints.someEndpoint, data: request.toJson());
  // process response
} on BxNetworkException catch (e) {
  return SomeResponse(code: e.statusCode, message: e.message, data: null);
} catch (e) {
  return SomeResponse(code: 7, message: 'some message', data: null);
}
```

---

## 16. Constants Rules

### App Constants
Image assets in `BxAppConstant` (`lib/core/constant/bx_app_constant.dart`):
```dart
class BxAppConstant {
  BxAppConstant._();
  static const String baseImageUrl = 'assets/images/';
  static const String appLogo = '${baseImageUrl}app_logo.png';
  // ...
}
```

### SharedPreferences Keys
All keys in `BxSharedPreferencesKeys` (`lib/core/constant/bx_shared_preferences_keys.dart`):
```dart
class BxSharedPreferencesKeys {
  static const String languageCode = 'language_code';
  static const String userData = 'user_data_saved';
  static const String themeMode = 'theme_mode';
  static const String onboardingCompleted = 'onboarding_completed';
}
```

### App Data (Global Mutable State)
In `BxAppData` (`lib/core/constant/bx_app_constant.dart`):
```dart
class BxAppData {
  BxAppData._();
  static String? langCode;
  static String appVersion = 'v1';
}
```

---

## 17. Theme / Colors Rules

### Using Colors
```dart
// Brand colors (import BxAppColors)
BxAppColors.primary       // 0xFF2563EB
BxAppColors.secondary     // 0xFFC49A6C
BxAppColors.error         // 0xFFD32F2F
BxAppColors.success       // 0xFF2E7D32
BxAppColors.warning       // 0xFFED6C02

// Semantic colors from theme
colorScheme.primary
colorScheme.onPrimary
colorScheme.error
colorScheme.surface
colorScheme.background
colorScheme.onSurface
```

### Font Families
```dart
// From BxAppFonts
BxAppFonts.bxAppFonts   // 'Poppins'
BxAppFonts.bxAppFontInter // 'Inter'

// Custom font used in the app
'lao-mn'  // defined in pubspec.yaml
```

---

## 18. Adding a New Feature — Checklist

1. **Domain layer**: Create request/response models, repository interface, use case
2. **Data layer**: Create remote/local data source (abstract + impl), repository implementation
3. **DI**: Register in `BxDependencyInjector.setup()`
4. **Presentation — BLoC**: Create `bx_<feature>_controller/` with bloc, event, state files
5. **Presentation — Screen**: Create `bx_<feature>_screen.dart` + mobile/tablet widgets
6. **Routes**: Add route name to `BxRouteNames`, add case to `BxRouteGenerator`
7. **BlocProvider**: Add to `BxAppWidget` if it's a global BLoC, or inline in screen if feature-scoped
8. **Models**: Run `flutter pub run build_runner build` to generate `.g.dart` files

---

## 19. Key Dependencies

| Package | Version | Purpose |
|---|---|---|
| `flutter_bloc` | ^9.1.1 | State management |
| `equatable` | ^2.0.8 | Value comparison for BLoC |
| `get_it` | ^9.2.0 | Dependency injection |
| `dio` | ^5.9.2 | HTTP client |
| `json_annotation` + `json_serializable` | ^4.9.0 / ^6.7.1 | Model serialization |
| `shared_preferences` | ^2.5.4 | Local storage |
| `flutter_screenutil` | ^5.9.3 | Responsive sizing |
| `flutter_localizations` | SDK | i18n |
| `firebase_auth` | ^6.1.1 | Auth |
| `google_sign_in` | ^7.2.0 | Google auth |
| `sign_in_with_apple` | ^8.1.0 | Apple auth |
| `flutter_facebook_auth` | ^7.2.0 | Facebook auth |
| `lottie` | ^3.3.3 | Animations |
| `shimmer` | ^3.0.0 | Loading placeholders |
| `animate_do` | ^4.2.0 | Animations |

---

## 20. Do NOT Do These Things

- ❌ Do **not** hard-code color values in widgets — use `Theme.of(context)` or `BxAppColors`
- ❌ Do **not** call `BxDependencyInjector.instance.get()` inside BLoC event handlers — inject via constructor
- ❌ Do **not** throw exceptions from repositories or data sources — catch and return error responses
- ❌ Do **not** put business logic in widgets — use BLoC
- ❌ Do **not** create widgets without mobile/tablet variants (use `BxResponsiveBuilder` or `LayoutBuilder`)
- ❌ Do **not** skip the `bx_` prefix on public class names
- ❌ Do **not** use `Navigator.pushNamed` directly — use `BxAppRouter`
- ❌ Do **not** put route logic in screens — keep it in `BxRouteGenerator`
- ❌ Do **not** use `setState` for BLoC-managed state
- ❌ Do **not** forget `super.key` in widget constructors
