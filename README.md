<div align="center">

# ✈️ Tayara

### Travel Marketplace Mobile Application

**Discover · Explore · Book · Travel**

[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.12.2-0175C2?logo=dart&logoColor=white)](https://dart.dev)
[![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS-lightgrey)]()
[![State](https://img.shields.io/badge/State-flutter__bloc-7B61FF?logo=flutter&logoColor=white)](https://bloc.dev)
[![Architecture](https://img.shields.io/badge/Architecture-Clean%20Architecture-FF8A65)]()
[![Backend](https://img.shields.io/badge/Backend-Go%20%2B%20Gin-00ADD8?logo=go&logoColor=white)](https://go.dev)
[![License](https://img.shields.io/badge/License-Proprietary-red)]()
[![Version](https://img.shields.io/badge/Version-1.0.1-blue)]()

---

**Tayara** is a production-oriented Flutter mobile application that connects travelers with travel agencies and service providers across the United Arab Emirates and worldwide. It delivers an end-to-end marketplace experience — from discovering destinations and comparing packages, to booking trips, processing payments, and tracking the full booking lifecycle in real time.

</div>

---

## 📑 Table of Contents

- [Executive Summary](#-executive-summary)
- [Product Overview](#-product-overview)
  - [The Problem](#the-problem)
  - [The Solution](#the-solution)
  - [Target Audience](#target-audience)
  - [Market Scope](#market-scope)
- [Feature Catalog](#-feature-catalog)
  - [Authentication & Onboarding](#1-authentication--onboarding)
  - [Discovery & Exploration](#2-discovery--exploration)
  - [Search & Filtering](#3-search--filtering)
  - [Trip Details & Packages](#4-trip-details--packages)
  - [Booking & Payments](#5-booking--payments)
  - [Traveler Reviews & Agencies](#6-traveler-reviews--agencies)
  - [Profile & Account Management](#7-profile--account-management)
  - [Notifications & Messaging](#8-notifications--messaging)
  - [Localization & Theming](#9-localization--theming)
- [User Journeys](#-user-journeys)
  - [New Traveler Journey](#new-traveler-journey)
  - [Returning Traveler Journey](#returning-traveler-journey)
  - [Custom Trip Journey](#custom-trip-journey)
- [Screen Inventory](#-screen-inventory)
- [Route Architecture](#-route-architecture)
- [Technical Architecture](#-technical-architecture)
  - [Architecture Principles](#architecture-principles)
  - [Layer Overview](#layer-overview)
  - [Dependency Flow](#dependency-flow)
  - [Project Structure](#project-structure)
- [Layer Deep Dives](#-layer-deep-dives)
  - [Core Layer](#core-layer)
  - [Data Layer](#data-layer)
  - [Domain Layer](#domain-layer)
  - [Presentation Layer](#presentation-layer)
  - [Injection Layer](#injection-layer)
- [State Management](#-state-management)
- [Authentication System](#-authentication-system)
- [Networking & API](#-networking--api)
- [Design System](#-design-system)
- [Localization](#-localization)
- [Responsive Design](#-responsive-design)
- [Dependency Reference](#-dependency-reference)
- [Firebase Integration](#-firebase-integration)
- [Platform Configuration](#-platform-configuration)
  - [Android](#android)
  - [iOS](#ios)
- [Setup & Installation](#-setup--installation)
- [Environment Configuration](#-environment-configuration)
- [Build & Release](#-build--release)
- [Testing Strategy](#-testing-strategy)
- [Troubleshooting](#-troubleshooting)
- [Security Considerations](#-security-considerations)
- [Performance Considerations](#-performance-considerations)
- [Code Conventions](#-code-conventions)
- [Extending the Application](#-extending-the-application)
- [Roadmap](#-roadmap)
- [Related Repositories](#-related-repositories)
- [FAQ](#-faq)
- [Contributing](#-contributing)
- [License](#-license)
- [Contact](#-contact)
- [Appendix](#-appendix)

---

## 📊 Executive Summary

| Attribute | Detail |
|---|---|
| **Application name** | Tayara |
| **Type** | Cross-platform mobile marketplace |
| **Domain** | Travel & tourism |
| **Framework** | Flutter 3.x |
| **Language** | Dart 3.12.2 |
| **Current version** | 1.0.1 |
| **Platforms** | Android, iOS |
| **State management** | `flutter_bloc` (BLoC / Cubit pattern) |
| **Dependency injection** | `get_it` service locator |
| **Networking** | `dio` with custom interceptors |
| **Backend** | Go + Gin REST API |
| **Databases (backend)** | MySQL, MongoDB, Redis |
| **Payments** | Stripe, Tabby, Tamara (BNPL), Apple Pay, Google Pay |
| **Authentication** | Firebase Auth — Google, Apple, Facebook, Phone |
| **Notifications** | Firebase Cloud Messaging + local notifications |
| **Localization** | English (en), Arabic (ar) — ARB-based generated delegates |
| **Architecture** | Clean Architecture with clear layer separation |
| **Dart source files** | 263 |
| **Named routes** | 18 |
| **BLoC controllers** | 20 |
| **Use cases** | 17 |
| **Repository interfaces** | 17 |
| **Deployment target** | UAE + international travel market |

Tayara is designed around a **clean, testable, and scalable architecture**. The codebase separates concerns into `core`, `data`, `domain`, `injection`, `l10n`, and `presentation` layers. UI components are further split into feature-oriented `views`, reusable `widgets`, and `bloc` controllers, each with its own events and states. This organization allows product teams to iterate quickly on individual features without destabilizing unrelated parts of the application.

---

## 🎯 Product Overview

### The Problem

Travel booking in the UAE and the wider Gulf region is fragmented. Travelers typically need to:

1. Browse multiple agency websites or social-media pages to find trips.
2. Manually compare prices, inclusions, dates, and cancellation policies.
3. Contact agencies over phone or chat to confirm availability.
4. Handle payment through bank transfers or links sent by message.
5. Track booking status through informal follow-up.
6. Deal with inconsistent information in Arabic and English.

This process is slow, opaque, and error-prone for both travelers and agencies. Agencies also lack a unified digital storefront and a standardized booking pipeline.

### The Solution

Tayara consolidates the entire journey into a single mobile experience:

- **One marketplace** for inbound UAE experiences and outbound international trips.
- **Structured listings** with images, pricing, destinations, and package details.
- **Powerful discovery** via curated home sections, explore topics, and top deals.
- **Search and filtering** to narrow results by destination, price, and preferences.
- **Detailed trip and package views** that communicate inclusions and terms clearly.
- **Integrated booking and payment** with card, wallet, and BNPL support.
- **Real-time booking state** so travelers always know where their reservation stands.
- **Agency profiles and traveler reviews** that build trust in the marketplace.
- **Bilingual interface** (Arabic and English) with full RTL support.
- **Social and phone authentication** for fast, low-friction onboarding.
- **Push notifications** to keep travelers informed of booking changes.

### Target Audience

| Segment | Needs addressed by Tayara |
|---|---|
| **Leisure travelers** | Discover curated trips, compare deals, book in minutes |
| **Business travelers** | Quick search, structured packages, transparent pricing |
| **UAE residents** | Inbound staycations and weekend getaways |
| **Visitors to the UAE** | Local experiences, desert tours, city packages |
| **Travel agencies** | Digital storefront, profile page, standardized bookings |
| **Budget-conscious travelers** | Top deals, filters, BNPL payment options |
| **Arabic-speaking users** | Native Arabic UI with RTL layout support |

### Market Scope

- **Inbound travel:** UAE destinations, desert experiences, city tours, staycations.
- **Outbound travel:** International packages and curated trips.
- **Regional focus:** UAE and GCC, with a design that can scale globally.
- **Currency and pricing:** Transparent display of fees and commission handling.

---

## ✨ Feature Catalog

### 1. Authentication & Onboarding

Tayara supports multiple low-friction sign-in methods and a guided first-run experience.

| Feature | Description | Implementation |
|---|---|---|
| Splash screen | Branded launch screen with timed navigation | `BxSplashScreenControllerBloc` |
| Onboarding | Multi-slide introduction with 5 illustration assets | `BxOnBoardingScreen` |
| Email/password sign up | New account creation flow | `BxSignUpControllerBloc` |
| Login | Returning-user sign-in | `BxLoginControllerBloc` |
| Google Sign-In | OAuth sign-in via Firebase Auth | `BxGoogleAuthFirebaseServices` |
| Apple Sign-In | Sign in with Apple via Firebase Auth | `BxAppleAuthFirebaseServices` |
| Facebook Login | Facebook OAuth via Firebase Auth | `BxFacebookAuthFirebaseServices` |
| Phone authentication | Firebase phone number verification | `BxPhoneAuthFirebaseServices` |
| Phone entry screen | Country-code aware phone number input | `BxEnterPhoneScreen` |
| Secure session | Token storage and authenticated API calls | `BxAuthInterceptor`, SharedPreferences |
| Logout | Clears local session and signs out of providers | Profile controller |

**Authentication flow:**

```
User taps sign-in provider
        │
        ▼
Provider SDK returns credential / ID token
        │
        ▼
FirebaseAuth.signInWithCredential(...)
        │
        ▼
Firebase ID token retrieved
        │
        ▼
POST /api/v1/user/firebase-login  →  backend session
        │
        ▼
User data cached locally  →  navigate to Home
```

### 2. Discovery & Exploration

| Feature | Description |
|---|---|
| Home dashboard | Curated landing surface with multiple content sections |
| Active banner ads | Rotating promotional carousel |
| Destinations | Featured travel destinations (Bali, Paris, Tokyo, Switzerland, etc.) |
| Explore trips | Discoverable trip listings |
| Explore topics | Thematic collections for browsing |
| Top deals | Time-sensitive discounted offers |
| Top agents | Featured travel agencies and service providers |
| Recommended for customer | Personalized recommendations |
| Image-rich cards | High-quality visual presentation of trips and offers |

The home dashboard aggregates several independent data sources. Each section is loaded through its own use case and BLoC, which allows partial failures — one failed section does not break the whole page.

### 3. Search & Filtering

| Feature | Description |
|---|---|
| Global search screen | Search trips and packages from a dedicated screen |
| Home search | Search directly from the home surface |
| Custom search | Advanced search with additional criteria |
| Filter trips screen | Refine results by travel preferences |
| Request models | Strongly typed search/filter request objects |
| Paginated results | Supports large result sets via pagination utilities |

### 4. Trip Details & Packages

| Feature | Description |
|---|---|
| Trip detail screen | Full itinerary, images, price, and inclusions |
| Package detail screen | Detailed package view with agency information |
| Similar trips screen | Related recommendations after viewing a trip |
| Custom trip builder | Build a personalized trip from scratch |
| Image gallery | Multiple destination and package images |
| Agent linkage | Navigate from a package to the agency profile |

### 5. Booking & Payments

| Feature | Description |
|---|---|
| Booking creation | Reserve a trip or package |
| My bookings tab | View all bookings in the bottom navigation |
| Booking detail screen | Full reservation information and current status |
| Real-time status | Live booking lifecycle and tracking |
| Payment screen | Secure checkout flow |
| Apple Pay | Native wallet payment on iOS |
| Google Pay | Native wallet payment on Android |
| Card payments | Visa and Mastercard support |
| BNPL | Tabby and Tamara installment options |
| Transparent fees | Clear display of pricing, fees, and commission |

### 6. Traveler Reviews & Agencies

| Feature | Description |
|---|---|
| Agencies screen | Browse and view agency profiles |
| Agent detail | Agency-specific profile and offerings |
| Review travelers screen | Rating and review interface |
| Trust signals | Reviews and agency identity support informed decisions |

### 7. Profile & Account Management

| Feature | Description |
|---|---|
| Profile tab | User account overview |
| Update profile screen | Edit personal information |
| Profile image upload | Image picker + upload support |
| Delete account | Account deletion flow |
| Preferences | Theme and language settings |
| Local storage | SharedPreferences-based settings and session data |

### 8. Notifications & Messaging

| Feature | Description |
|---|---|
| Firebase Cloud Messaging | Remote push notifications |
| Local notifications | Locally scheduled/triggered notifications |
| Booking updates | Notifications tied to booking lifecycle events |
| Custom notification widget | In-app notification presentation |

### 9. Localization & Theming

| Feature | Description |
|---|---|
| English (en) | Default locale, ARB source: `app_en.arb` |
| Arabic (ar) | Full Arabic translations, ARB source: `app_ar.arb` |
| RTL support | Arabic layout direction handled by Flutter |
| Generated delegates | `AppLocalizations` generated at build time |
| Language controller | Persisted locale selection via BLoC |
| Light theme | Full Material light theme |
| Dark theme | Full Material dark theme |
| System theme | Follow device theme setting |
| Theme controller | Persisted theme selection via BLoC |

---

## 🧭 User Journeys

### New Traveler Journey

```
┌──────────────┐    ┌──────────────┐    ┌──────────────┐
│    Splash    │───▶│  Onboarding  │───▶│    Login     │
└──────────────┘    └──────────────┘    └──────┬───────┘
                                               │
                       ┌───────────────────────┼───────────────────────┐
                       ▼                       ▼                       ▼
              ┌────────────────┐      ┌────────────────┐      ┌────────────────┐
              │ Social Sign-In │      │ Phone Sign-In  │      │  Sign Up       │
              └───────┬────────┘      └───────┬────────┘      └───────┬────────┘
                      └───────────────────────┼───────────────────────┘
                                              ▼
                                    ┌──────────────────┐
                                    │ Firebase + API   │
                                    │   Auth Handshake │
                                    └────────┬─────────┘
                                             ▼
                                    ┌──────────────────┐
                                    │   Home Screen    │
                                    └──────────────────┘
```

### Returning Traveler Journey

```
Home
 ├── Ads / Destinations / Deals / Agents
 ├── Search or Filter
 ├── Trip Detail or Package Detail
 ├── Similar Trips
 ├── Select & Book
 ├── Payment (Card / Wallet / BNPL)
 └── My Bookings → Booking Detail → Status Updates
```

### Custom Trip Journey

```
Home → Explore → Build Custom Trip → Customize Preferences
                                            │
                                            ▼
                                   Custom Search Results
                                            │
                                            ▼
                                   Trip Detail → Booking
```

---

## 🖼️ Screen Inventory

| # | Screen | Route | Purpose |
|---|---|---|---|
| 1 | Splash | `/` | Launch, token check, timed navigation |
| 2 | Onboarding | `/bx-on-boarding-screen` | First-run introduction |
| 3 | Login | `/bx-login-screen` | Social and phone sign-in |
| 4 | Sign Up | `/bx-sign-up-screen` | New account registration |
| 5 | Enter Phone | `/bx-enter-phone-screen` | Phone number verification |
| 6 | Home | `/bx-home-screen` | Main dashboard with bottom navigation |
| 7 | Update Profile | `/bx-update-profile-screen` | Edit account information |
| 8 | Trip Detail | `/bx-trip-detail-screen` | Trip information and booking entry |
| 9 | Booking Detail | `/bx-booking-detail-screen` | Reservation details and status |
| 10 | Payment | `/bx-payment-screen` | Checkout and payment methods |
| 11 | Filter Trips | `/bx-filter-trips-screen` | Refine trip results |
| 12 | Agencies | `/bx-agencies-screen` | Agency profiles |
| 13 | Similar Trips | `/bx-similar-trips-screen` | Related trip suggestions |
| 14 | Custom Trip | `/bx-custom-trip-screen` | Personalized trip builder |
| 15 | Review Travelers | `/bx-review-travelers-screen` | Ratings and reviews |
| 16 | Search | `/bx-search-screen` | Search trips and packages |
| 17 | Package Detail | `/bx-package-detail-screen` | Package information |
| 18 | Error | `/bx-error-screen` | Unknown route / fallback screen |

### Bottom Navigation

The main experience uses a four-tab bottom navigation structure, with responsive mobile and tablet layouts:

| Tab | Screen component | Purpose |
|---|---|---|
| Home | `BxHomeBottomScreenMobile` / `BxHomeBottomScreenTablet` | Discovery dashboard |
| Explore | `BxExploreBottomScreenMobile` / `BxExploreBottomScreenTablet` | Browse and topics |
| Bookings | `BxBookingBottomScreenMobile` / `BxBookingBottomScreenTablet` | Reservation management |
| Profile | `BxProfileBottomScreenMobile` / `BxProfileBottomScreenTablet` | Account and settings |

---

## 🧭 Route Architecture

Tayara uses centralized named routing with custom transitions and navigation helpers.

### Route Definition

All route paths are declared as constants in `lib/core/routes/bx_route_names.dart`:

```dart
static const String bxSplashScreen = '/';
static const String bxLoginScreen = '/bx-login-screen';
static const String bxHomeScreen = '/bx-home-screen';
static const String bxPaymentScreen = '/bx-payment-screen';
```

Naming convention: **lowercase, hyphen-separated**, prefixed with `/bx-`.

### Route Generation

`BxRouteGenerator.generateRoute()` maps a `RouteSettings.name` to the corresponding screen and wraps it in a `PageRouteBuilder` with a **300 ms slide-up transition**:

```dart
static Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case BxRouteNames.bxSplashScreen:
      return _buildRoute(settings, const BxSplashScreen());
    case BxRouteNames.bxLoginScreen:
      return _buildRoute(settings, const BxLoginScreen());
    // ...
    default:
      return _buildRoute(settings, const BxErrorScreen());
  }
}
```

Some routes accept typed arguments:

```dart
// Agencies screen: optional agentId
final id = (args is Map && args['agentId'] is int) ? args['agentId'] : null;

// Package detail: required packageId
final id = (args is Map && args['packageId'] is int) ? args['packageId'] : null;
```

### Transition Builders

| Builder | Animation | Duration |
|---|---|---|
| `_buildRoute` (default) | Slide up from bottom | 300 ms |
| `fadeTransitionRoute` | Fade in | 300 ms |
| `slideTransitionRoute` | Slide from right | 300 ms |
| `scaleTransitionRoute` | Scale 0 → 1 | 400 ms |

### Navigation Helpers

`BxRouteGenerator` provides:

- `pushNamed`
- `pushReplacementNamed`
- `popUntilNamed`
- `popAndPushNamed`
- `pushNamedAndRemoveUntil`

`BxAppRouter` provides a higher-level singleton API:

- `push`, `pushReplacement`, `pushAndPopUntil`, `pop`, `maybePop`
- `getCurrentPath`, `getCurrentName`
- `handleDeepLink`, `isDeepLink`, `parseDeepLinkParameters`, `generateDeepLink`
- `showModal`, `showDialogModal`
- `onWillPop` (Android back-button confirmation)
- `createRouterConfig()` for `MaterialApp.router`

### Route Analytics

Every navigation event is logged:

```
I/flutter: Route viewed: /bx-login-screen
I/flutter: Route parameters: {arguments: null}
```

`trackRouteView()` is intentionally stubbed for replacement with a real analytics service in production.

---

## 🏗️ Technical Architecture

### Architecture Principles

1. **Clean Architecture** — domain logic is independent of UI and framework details.
2. **Separation of concerns** — each layer has one clear responsibility.
3. **Dependency inversion** — high-level modules depend on abstractions (repository interfaces).
4. **Single source of truth** — constants, endpoints, colors, and assets are centralized.
5. **Testability** — use cases and BLoCs can be tested in isolation.
6. **Scalability** — feature folders group related UI, state, and widgets.
7. **Consistency** — a `Bx` naming prefix identifies project-owned classes.
8. **Responsiveness** — mobile/tablet variants for major tab screens.
9. **Localization-first** — user-facing strings go through `AppLocalizations`.
10. **Configuration safety** — secrets and platform config stay local and untracked.

### Layer Overview

```
┌──────────────────────────────────────────────────────────────────────┐
│                        PRESENTATION LAYER                           │
│  Screens · Widgets · BLoCs (Events / States) · Route Generator      │
│  lib/presentation/                                                  │
└───────────────────────────────┬──────────────────────────────────────┘
                                │ depends on
┌───────────────────────────────▼──────────────────────────────────────┐
│                          DOMAIN LAYER                               │
│  Use Cases · Repository Interfaces · Request/Response Models        │
│  lib/domain/                                                        │
└───────────────────────────────▲──────────────────────────────────────┘
                                │ implements
┌───────────────────────────────┴──────────────────────────────────────┐
│                            DATA LAYER                               │
│  Repository Implementations · Remote/Local Data Sources · DTOs      │
│  lib/data/                                                          │
└───────────────────────────────┬──────────────────────────────────────┘
                                │ depends on
┌───────────────────────────────▼──────────────────────────────────────┐
│                            CORE LAYER                               │
│  Network · Auth Services · Theme · Routes · Constants · Utils       │
│  lib/core/                                                          │
└──────────────────────────────────────────────────────────────────────┘

Cross-cutting:
┌──────────────────────────────────────────────────────────────────────┐
│  INJECTION (get_it)  ·  L10N (generated ARB delegates)               │
└──────────────────────────────────────────────────────────────────────┘
```

### Dependency Flow

```
UI (Screen)
   │ dispatches event
   ▼
BLoC
   │ calls
   ▼
Use Case
   │ depends on interface
   ▼
Repository Interface ─────implemented by────▶ Repository Implementation
                                                     │
                                                     ▼
                                              Data Source
                                                     │
                                                     ▼
                                          Dio / SharedPreferences
```

### Project Structure

```
tayara/
│
├── android/                          # Android platform project
│   ├── app/
│   │   ├── build.gradle.kts          # App-level Gradle config
│   │   ├── google-services.json      # Firebase config (local, untracked)
│   │   └── src/main/
│   │       ├── AndroidManifest.xml   # Permissions, intents, metadata
│   │       ├── kotlin/com/app/taiyara/MainActivity.kt
│   │       └── res/                  # Styles, drawables, values
│   ├── build.gradle.kts              # Project-level Gradle config
│   ├── key.properties                # Release signing (local, untracked)
│   └── settings.gradle.kts
│
├── ios/                              # iOS platform project
│   ├── Flutter/
│   │   └── Local.xcconfig            # Generated URL scheme config (local)
│   └── Runner/
│       ├── GoogleService-Info.plist  # Firebase config (local, untracked)
│       └── Info.plist                # URL schemes, permissions
│
├── assets/
│   ├── fonts/                        # Poppins, Lao MN
│   └── images/                       # Logos, illustrations, destinations
│
├── lib/
│   ├── main.dart                     # Application entry point
│   ├── bx_app_widget.dart            # Root widget, providers, MaterialApp
│   ├── firebase_options.dart         # Platform-specific Firebase options
│   │
│   ├── core/                         # Shared infrastructure
│   │   ├── constant/                 # App constants, asset paths, keys
│   │   │   ├── bx_app_constant.dart
│   │   │   └── bx_shared_preferences_keys.dart
│   │   ├── network/                  # HTTP client and endpoints
│   │   │   ├── bx_api_endpoints.dart
│   │   │   ├── bx_dio_client.dart
│   │   │   └── interceptors/
│   │   ├── responsive/               # Breakpoints and responsive helpers
│   │   ├── routes/                   # Named routes and navigation helpers
│   │   ├── services/                 # Firebase auth service wrappers
│   │   ├── theme/                    # Colors and light/dark themes
│   │   ├── utils/                    # Formatters, image conversion, pagination
│   │   └── widgets/                  # Shared UI utilities
│   │
│   ├── data/                         # Data layer
│   │   ├── data_source/
│   │   │   ├── local/                # SharedPreferences data source
│   │   │   └── remote/               # REST API data source
│   │   └── repositories/             # Repository implementations (19)
│   │
│   ├── domain/                       # Domain layer
│   │   ├── model/
│   │   │   ├── request/              # Typed request models + .g.dart
│   │   │   └── response/             # Typed response models + .g.dart
│   │   ├── repositories/             # Abstract repository contracts (17)
│   │   └── usecase/                  # Business-use cases (17)
│   │
│   ├── injection/
│   │   └── bx_dependency_injector.dart  # get_it service locator setup
│   │
│   ├── l10n/
│   │   ├── arb/                      # app_en.arb, app_ar.arb
│   │   └── generated/                # Generated localization classes
│   │
│   └── presentation/                 # UI layer
│       ├── bloc/                     # 20 feature BLoCs (event/state/bloc)
│       ├── views/                    # 27 screen files
│       └── widgets/                  # Feature-scoped reusable widgets
│
├── scripts/
│   └── configure_local_config.py     # Generates iOS Local.xcconfig from .env
│
├── test/
│   └── widget_test.dart
│
├── .env.example                      # Environment variable template
├── analysis_options.yaml
├── pubspec.yaml
├── pubspec.lock
└── README.md                         # This document
```

---

## 🔬 Layer Deep Dives

### Core Layer

The `core` layer contains framework-adjacent, cross-cutting infrastructure that is shared by all features.

#### Core Components

| Component | Files | Responsibility |
|---|---|---|
| Constants | `constant/bx_app_constant.dart` | Asset paths, app metadata, font families, global runtime data |
| Preference keys | `constant/bx_shared_preferences_keys.dart` | Centralized SharedPreferences key names |
| Network | `network/bx_dio_client.dart`, `network/bx_api_endpoints.dart`, `interceptors/` | HTTP client, endpoint catalog, auth/error/logging interceptors |
| Routes | `routes/bx_route_names.dart`, `bx_route_generator.dart`, `bx_app_routes.dart` | Route constants, route generation, navigation helpers |
| Services | `services/bx_*_auth_firebase_services.dart` | Google, Apple, Facebook, and Phone Firebase auth wrappers |
| Theme | `theme/bx_app_colors.dart`, `bx_app_theme.dart` | Color palette and Material themes |
| Responsive | `responsive/bx_breakpoints.dart`, `bx_responsive_builder.dart`, etc. | Device-class detection and responsive layout helpers |
| Utils | `utils/bx_phone_formatter.dart`, `bx_convert_image.dart`, etc. | Formatting, conversion, pagination, notification widgets |
| Shared widgets | `widgets/bx_custom_snack_bar.dart`, `bx_loading_app.dart`, etc. | App-wide UI helpers |

#### Global Runtime Data

`BxAppData` in `constant/bx_app_constant.dart` holds lightweight global state:

```dart
class BxAppData {
  static String? langCode;                  // active language code
  static String appVersion = 'v1';          // API version prefix
  static BxLoginUserResponse? currentUser;  // logged-in user
}
```

> **Note:** `BxAppData` is intentionally minimal. Most state should live in BLoCs or persistent storage.

### Data Layer

The data layer implements the repository contracts defined in the domain layer.

#### Data Sources

| Data source | File | Technology |
|---|---|---|
| Remote | `data/data_source/remote/bx_system_remote_data_source.dart` | Dio REST calls |
| Local | `data/data_source/local/bx_shared_preferences_datasource.dart` | SharedPreferences |

#### Repository Implementations (19)

| Repository implementation | Purpose |
|---|---|
| `BxActiveTopBannerAdsRepositoriesImpl` | Home banner ads |
| `BxAgentProfileDetailsRepositoriesImpl` | Agency profile details |
| `BxCustomSearchRepositoriesImpl` | Advanced/custom search |
| `BxDeleteUserDataRepositoriesImpl` | Account deletion |
| `BxFirebaseLoginRepositoriesImpl` | Firebase token → backend login |
| `BxGetDestinationsRepositoriesImpl` | Featured destinations |
| `BxGetExploreTopicRepositoriesImpl` | Explore topics |
| `BxGetExploreTripsRepositoriesImpl` | Explore trips |
| `BxGetMyBookingListRepositoriesImpl` | User booking list |
| `BxGetPackageDetailRepositoriesImpl` | Package detail |
| `BxGetRecommendedForCustomerRepositoriesImpl` | Recommendations |
| `BxGetSearchRepositoriesImpl` | General search |
| `BxGetTopAgentRepositoriesImpl` | Top agents |
| `BxGetTopDealsRepositoriesImpl` | Top deals |
| `BxGetUserDataRepositoriesImpl` | User profile |
| `BxLoginUserRepositoriesImpl` | Customer login |
| `BxUpdateUserDataRepositoriesImpl` | Profile update |

### Domain Layer

The domain layer is the heart of the application and has **no dependency on Flutter UI**.

#### Use Cases (17)

| Use case | Purpose |
|---|---|
| `BxActiveTopBannerAdsUsecase` | Load home ads |
| `BxAgentProfileDetailsUsecase` | Load agency profile |
| `BxCustomSearchUsecase` | Execute custom search |
| `BxDeleteUserDataUsecase` | Delete user account |
| `BxFirebaseLoginUsecase` | Authenticate with backend using Firebase token |
| `BxGetDestinationsUsecase` | Load destinations |
| `BxGetExploreTopicUsecase` | Load explore topics |
| `BxGetExploreTripsUsecase` | Load explore trips |
| `BxGetTopDealsUsecase` | Load top deals |
| `BxGetTopAgentsUsecase` | Load top agents |
| `BxGetSearchUsecase` | Execute search |
| `BxGetRecommendedForCustomerUsecase` | Load recommendations |
| `BxAgentProfileDetailsUsecase` | Load agent details |
| `BxCustomSearchUsecase` | Custom search |
| `BxGetPackageDetailUsecase` | Load package detail |
| `BxGetUserDataUsecase` | Load current user |
| `BxLoginUserUsecase` | Customer login |
| `BxUpdateUserDataUsecase` | Update profile |
| `BxDeleteUserDataUsecase` | Delete account |
| `BxGetMyBookingListUsecase` | Load bookings |

#### Models

Request and response models live under `domain/model/request` and `domain/model/response`. They use `json_serializable`:

```dart
@JsonSerializable()
class BxGetDestinationsRequest {
  final String? lang;
  final int? page;
  final int? limit;

  const BxGetDestinationsRequest({this.lang, this.page, this.limit});

  factory BxGetDestinationsRequest.fromJson(Map<String, dynamic> json) =>
      _$BxGetDestinationsRequestFromJson(json);

  Map<String, dynamic> toJson() => _$BxGetDestinationsRequestToJson(this);
}
```

Generated `.g.dart` files are checked in and regenerated with:

```bash
dart run build_runner build --delete-conflicting-outputs
```

### Presentation Layer

The presentation layer contains everything the user sees and interacts with.

#### Structure

```
presentation/
├── bloc/       # 20 controllers × 3 files (bloc/event/state)
├── views/      # 27 screen files, grouped by feature folder
└── widgets/    # Feature-scoped reusable widgets
```

#### Naming Convention

| Suffix | Purpose | Example |
|---|---|---|
| `_screen.dart` | Full page/screen | `bx_login_screen.dart` |
| `_mobile.dart` | Mobile layout variant | `bx_home_bottom_screen_mobile.dart` |
| `_tablet.dart` | Tablet layout variant | `bx_home_bottom_screen_tablet.dart` |
| `_bloc.dart` | BLoC controller | `bx_login_controller_bloc.dart` |
| `_event.dart` | BLoC events | `bx_login_controller_event.dart` |
| `_state.dart` | BLoC states | `bx_login_controller_state.dart` |
| `_widget.dart` | Reusable component | `bx_custom_trip_widget.dart` |

### Injection Layer

`BxDependencyInjector` is a singleton wrapper around `get_it`.

```dart
class BxDependencyInjector {
  static final BxDependencyInjector _singleton = BxDependencyInjector._internal();
  static final GetIt _getIt = GetIt.instance;

  factory BxDependencyInjector() => _singleton;
  static BxDependencyInjector get instance => _singleton;

  Future<void> setup() async {
    // Register all dependencies here
  }

  T get<T extends Object>() => _getIt.get<T>();
}
```

Registration strategy:

| Registration type | Used for |
|---|---|
| `registerLazySingleton` | Most services, repositories, use cases, tab BLoCs |
| `registerSingleton` | Already-created `SharedPreferences` instance |

Access patterns:

```dart
// Via static getter
BxDependencyInjector.instance.get<BxLoginUserUsecase>()

// Via callable alias
BxDependencyInjector.instance<BxLoginUserUsecase>()

// Check registration
BxDependencyInjector.instance.isRegistered<BxLoginUserUsecase>()
```

---

## 🧠 State Management

Tayara uses the **BLoC pattern** from `flutter_bloc`.

### BLoC Inventory (20 controllers)

| # | Controller | Responsibility |
|---|---|---|
| 1 | `BxSplashScreenControllerBloc` | Splash timer, navigation decision |
| 2 | `BxOnBoardingControllerBloc` | Onboarding progression |
| 3 | `BxLoginControllerBloc` | Login form + social auth |
| 4 | `BxSignUpControllerBloc` | Registration form + social auth |
| 5 | `BxEnterPhoneControllerBloc` | Phone verification + social auth |
| 6 | `BxHomeScreenControllerBloc` | Home screen state |
| 7 | `BxHomeBottomScreenControllerBloc` | Home tab data aggregation |
| 8 | `BxExploreBottomScreenControllerBloc` | Explore tab data |
| 9 | `BxBookingBottomScreenControllerBloc` | Bookings tab data |
| 10 | `BxProfileBottomScreenControllerBloc` | Profile tab data, logout |
| 11 | `BxSearchScreenControllerBloc` | Search behavior |
| 12 | `BxCustomTripControllerBloc` | Custom trip builder |
| 13 | `BxTripDetailControllerBloc` | Trip detail state |
| 14 | `BxPackageDetailScreenControllerBloc` | Package detail state |
| 15 | `BxAgenciesDetailScreenControllerBloc` | Agency detail state |
| 16 | `BxUpdateProfileScreenControllerBloc` | Profile editing |
| 17 | `BxThemeControllerBloc` | Light/dark/system theme |
| 18 | `BxLocalizationControllerBloc` | Locale selection |
| 19 | `BxReviewTravelersControllerBloc`* | Reviews |
| 20 | `BxFilterTripsControllerBloc`* | Trip filtering |

\* Screen-level controllers exist in the feature folders and may be named according to their screen group.

### BLoC Pattern Example

```dart
on<BxLoginWithGoogle>((event, emit) async {
  emit(state.copyWith(status: BxLoginControllerStatus.loading));
  try {
    final result = await BxGoogleAuthFirebaseServices.instance.signIn();
    if (!result.success || result.user == null) {
      emit(state.copyWith(
        status: BxLoginControllerStatus.error,
        errorMessage: result.error ?? 'Google sign-in failed',
      ));
      return;
    }
    final idToken = await result.user!.user!.getIdToken();
    await _callLoginUseCase(idToken!, emit);
  } catch (e) {
    emit(state.copyWith(
      status: BxLoginControllerStatus.error,
      errorMessage: e.toString(),
    ));
  }
});
```

### Root Providers

`BxAppWidget` provides app-level BLoCs:

```dart
MultiBlocProvider(
  providers: [
    BlocProvider<BxSplashScreenControllerBloc>(...),
    BlocProvider<BxThemeControllerBloc>(...),
    BlocProvider<BxLocalizationControllerBloc>(...),
  ],
  child: ...
)
```

`MaterialApp` reacts to theme and locale changes via nested `BlocBuilder`s.

---

## 🔐 Authentication System

### Supported Providers

| Provider | Service class | Package |
|---|---|---|
| Google | `BxGoogleAuthFirebaseServices` | `google_sign_in` |
| Apple | `BxAppleAuthFirebaseServices` | `sign_in_with_apple` |
| Facebook | `BxFacebookAuthFirebaseServices` | `flutter_facebook_auth` |
| Phone | `BxPhoneAuthFirebaseServices` | `firebase_auth` |

### Common Result Pattern

Each auth service returns a result object:

```dart
class BxGoogleAuthResult {
  final bool success;
  final UserCredential? user;
  final String? error;
}
```

This avoids throwing across UI boundaries and lets BLoCs emit consistent error states.

### Google Sign-In Notes (v7)

`google_sign_in` v7 requires explicit initialization before `authenticate()`:

```dart
await GoogleSignIn.instance.initialize(
  serverClientId: '<WEB_CLIENT_ID>',
);
final account = await GoogleSignIn.instance.authenticate();
```

In Tayara this is handled inside `BxGoogleAuthFirebaseServices._ensureInitialized()`.

> **Important:** Android's Credential Manager can report configuration errors (wrong SHA-1, wrong OAuth client) as "cancelled". If sign-in fails immediately after the account picker, verify the Firebase SHA-1 fingerprints and the web client ID.

### Error Handling

Auth services map platform errors to user-friendly messages:

| Error code | User-facing message |
|---|---|
| `canceled` | Cancellation or masked configuration error |
| `clientConfigurationError` | Misconfigured sign-in |
| `providerConfigurationError` | Google services unavailable |
| `invalid-credential` | Credential invalid or expired |
| `account-exists-with-different-credential` | Use the original sign-in method |
| `operation-not-allowed` | Provider not enabled in Firebase |

---

## 🌐 Networking & API

### Base URL

Defined in `lib/core/network/bx_api_endpoints.dart`:

```dart
class BxAppConfig {
  static const String baseUrl = 'https://imprecise-daintily-goes.ngrok-free.dev';
}
```

> ⚠️ This is currently a **tunneling/staging URL**. Replace it with a stable staging or production endpoint before release.

### Endpoint Catalog

All endpoints are versioned via `BxAppData.appVersion` (`v1`).

| Endpoint | Method | Path |
|---|---|---|
| Firebase login | POST | `/api/v1/user/firebase-login` |
| Customer login | POST | `/api/v1/user/login` |
| Get profile | GET | `/api/v1/user/profile` |
| Update profile | PUT | `/api/v1/user/profile` |
| Delete account | DELETE | `/api/v1/user/profile` |
| Home ads | GET | `/api/v1/customer/home/ads` |
| Destinations | GET | `/api/v1/customer/home/destinations` |
| Explore trips | GET | `/api/v1/customer/explore/trips` |
| Top deals | GET | `/api/v1/customer/home/deals` |
| Top agents | GET | `/api/v1/customer/home/agents` |
| Search | GET | `/api/v1/customer/search` |
| Recommendations | GET | `/api/v1/customer/home/recommended` |
| Custom search | GET | `/api/v1/customer/search` |
| Agent detail | GET | `/api/v1/customer/agent/detail` |
| Explore topics | GET | `/api/v1/customer/explore/topics` |
| Package detail | GET | `/api/v1/catalog/public/packages/detail` |
| My bookings | GET | `/api/v1/booking` |

### Dio Client

`BxDioClient` is a singleton with:

```dart
BaseOptions(
  baseUrl: BxApiEndpoints.baseUrl,
  connectTimeout: Duration(seconds: 30),
  receiveTimeout: Duration(seconds: 30),
  validateStatus: (status) => status != null && status <= 500,
)
```

### Interceptors

| Interceptor | Purpose |
|---|---|
| `BxAuthInterceptor` | Attaches authentication token to requests |
| `BxErrorInterceptor` | Centralized error inspection |
| `BxLoggingInterceptor` | Debug-mode request/response logging |

### Error Handling

`BxDioClient` converts `DioException` to `BxNetworkException`:

| Error type | Message |
|---|---|
| `connectionTimeout` | Connection timed out. Please try again. |
| `sendTimeout` | Request timed out. Please try again. |
| `receiveTimeout` | Server took too long to respond. Please try again. |
| `connectionError` | No internet connection. Please check your network. |
| `badResponse` | Parsed from JSON `message`/`error` or HTML error page |
| `cancel` | Request was cancelled. |

HTML error pages (e.g., from an ngrok/proxy misconfiguration) are parsed for `<title>`, `<h1>`, or `<p>` content to surface a readable message.

---

## 🎨 Design System

### Typography

| Font | Family name | Usage |
|---|---|---|
| Poppins | `Poppins` | Primary UI font |
| Lao MN | `lao-mn` | Secondary/supporting font |

Declared in `pubspec.yaml`:

```yaml
fonts:
  - family: lao-mn
    fonts:
      - asset: assets/fonts/lao-mn.ttf
  - family: Poppins
    fonts:
      - asset: assets/fonts/Poppins-Regular.ttf
```

### Color Palette

Defined in `lib/core/theme/bx_app_colors.dart`:

| Role | Name | Hex |
|---|---|---|
| Primary | `primary` | `#2563EB` |
| Primary light | `primaryLight` | `#6B9BFF` |
| Primary dark | `primaryDark` | `#1E4FBB` |
| Secondary | `secondary` | `#C49A6C` |
| Secondary light | `secondaryLight` | `#E0BC97` |
| Secondary dark | `secondaryDark` | `#9E7648` |
| Success | `success` | `#16A24A` |
| Warning | `warning` | `#D97705` |
| Error | `error` | `#EF4444` |
| Info | `info` | `#0288D1` |
| Teal | `teal` | `#10B981` |
| Purple | `purple` | `#9333EA` |
| Pink | `pink` | `#DA2677` |
| Amber | `amber` | `#F59E0B` |
| Background | `background` | `#F5F7FA` |
| Surface | `surface` | `#FFFFFF` |
| Text | `onBackground` / `onSurface` | `#111827` |

Dark theme variants include `darkBackground` (`#121212`), `darkSurface` (`#1E1E1E`), and `darkBorder` (`#374151`).

### Asset Categories

`BxAppConstant` centralizes all asset paths:

| Category | Examples |
|---|---|
| Branding | `app_logo.png`, `app_background.png`, `tayara_object.png` |
| Onboarding | `on_boarding_1.png` … `on_boarding_5.png` |
| Navigation | `home_icon.png`, `explore_icon.png`, `booking_icon.png`, `profile_icon.png` |
| Social login | `google_logo.png`, `apple_logo.png`, `facebook_logo.png` |
| Destinations | `bali_image.png`, `pairs_image.png`, `tokyo_image.png`, `swazireland_image.png` |
| Deals & ads | `top_deals_image1.png`, `top_deals_image2.png`, `ads_background.png` |
| States | `active.png`, `no_active.png`, `expire_logo.png` |
| Animations | `lf30_editor_pdbikagl.json` (Lottie loading indicator) |

### Shared UI Utilities

| Widget | Purpose |
|---|---|
| `BxCustomSnackBar` | Consistent feedback messages |
| `BxLoadingApp` | Global loading indicator |
| `BxSafeNetworkImage` | Resilient remote image loading |
| `BxCreateAsLeadWidget` | Reusable content component |
| `BxCustomNotificationWidget` | In-app notification display |

---

## 🌍 Localization

### Supported Locales

| Locale | ARB file | Generated class |
|---|---|---|
| English (`en`) | `lib/l10n/arb/app_en.arb` | `AppLocalizationsEn` |
| Arabic (`ar`) | `lib/l10n/arb/app_ar.arb` | `AppLocalizationsAr` |

Generated delegates live in `lib/l10n/generated/`.

### Configuration

`pubspec.yaml` enables code generation:

```yaml
flutter:
  generate: true
```

`BxAppWidget` wires localization into `MaterialApp`:

```dart
localizationsDelegates: const [
  AppLocalizations.delegate,
  GlobalMaterialLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate,
],
supportedLocales: AppLocalizations.supportedLocales,
locale: locale,
```

The active locale comes from `BxLocalizationControllerBloc`, which persists the user's choice via `SharedPreferences`.

### Usage

```dart
Text(AppLocalizations.of(context)?.app_name ?? 'Tayara')
```

or through the helper:

```dart
Text(BxAppConfiguration.bxAppName(context))
```

### Adding a Translation

1. Add the key to `app_en.arb` and `app_ar.arb`.
2. Run:
   ```bash
   flutter gen-l10n
   ```
3. Use the generated getter in the UI.

> **Best practice:** Never hard-code user-facing strings in widgets; always add them to both ARB files.

---

## 📱 Responsive Design

Tayara adapts to different screen sizes using `flutter_screenutil` plus custom responsive helpers.

### ScreenUtil Configuration

```dart
ScreenUtilInit(
  designSize: const Size(375, 812),
  minTextAdapt: true,
  splitScreenMode: true,
  builder: (context, child) => BxAppWidget(),
)
```

- **Design baseline:** 375 × 812 (iPhone X-class viewport).
- **Text scaling:** enabled via `minTextAdapt`.
- **Split-screen:** supported via `splitScreenMode`.

### Responsive Helpers

| File | Purpose |
|---|---|
| `bx_breakpoints.dart` | Phone/tablet/desktop breakpoint constants |
| `bx_responsive_builder.dart` | Widget builder based on screen class |
| `bx_responsive_grid.dart` | Adaptive grid layouts |
| `bx_screen_utils.dart` | Additional sizing helpers |

### Responsive Screens

The four main tabs provide explicit mobile and tablet variants:

```
bx_home_bottom_screen_mobile.dart   |  bx_home_bottom_screen_tablet.dart
bx_explore_bottom_screen_mobile.dart|  bx_explore_bottom_screen_tablet.dart
bx_booking_bottom_screen_mobile.dart|  bx_booking_bottom_screen_tablet.dart
bx_profile_bottom_screen_mobile.dart|  bx_profile_bottom_screen_tablet.dart
```

---

## 📦 Dependency Reference

### Runtime Dependencies

| Package | Version | Purpose |
|---|---|---|
| `flutter` | SDK | Flutter framework |
| `cupertino_icons` | ^1.0.8 | iOS-style icons |
| `dio` | ^5.9.2 | HTTP client |
| `flutter_localizations` | SDK | Material/Cupertino localization delegates |
| `intl` | ^0.20.2 | Internationalization utilities |
| `json_annotation` | ^4.9.0 | JSON serialization annotations |
| `flutter_bloc` | ^9.1.1 | BLoC state management |
| `equatable` | ^2.0.8 | Value equality for events/states/models |
| `get_it` | ^9.2.0 | Dependency injection |
| `animate_do` | ^4.2.0 | Entrance animations |
| `shimmer` | ^3.0.0 | Loading placeholders |
| `shared_preferences` | ^2.5.4 | Local key-value storage |
| `flutter_screenutil` | ^5.9.3 | Responsive sizing |
| `intl_phone_selector` | ^1.0.0 | Phone input with country selector |
| `lottie` | ^3.3.3 | JSON animations |
| `firebase_core` | ^4.9.0 | Firebase initialization |
| `flutter_dotenv` | ^5.2.1 | `.env` loading |
| `firebase_auth` | ^6.1.1 | Authentication |
| `firebase_messaging` | ^16.2.2 | Push notifications |
| `google_sign_in` | ^7.2.0 | Google OAuth |
| `sign_in_with_apple` | ^8.1.0 | Apple OAuth |
| `flutter_facebook_auth` | ^7.2.0 | Facebook OAuth |
| `device_info_plus` | ^13.2.0 | Device information |
| `path` | any | Filesystem paths |
| `image_picker` | ^1.2.4 | Image selection |

### Development Dependencies

| Package | Version | Purpose |
|---|---|---|
| `flutter_test` | SDK | Widget/unit testing |
| `build_runner` | ^2.4.6 | Code generation |
| `json_serializable` | ^6.7.1 | JSON code generator |
| `flutter_lints` | ^6.0.0 | Recommended lint rules |

### SDK Constraints

```yaml
environment:
  sdk: ^3.12.2
```

---

## 🔥 Firebase Integration

### Firebase Project

| Setting | Value |
|---|---|
| Project ID | `taiyara-676dc` |
| Project number | `271442722424` |
| Android package | `com.app.taiyara` |
| iOS bundle ID | `com.app.taiyara` |
| Storage bucket | `taiyara-676dc.firebasestorage.app` |

### Services Used

| Service | Purpose |
|---|---|
| Firebase Core | SDK initialization |
| Firebase Auth | Email/social/phone authentication |
| Firebase Cloud Messaging | Push notifications |
| Firebase Storage (bucket configured) | Asset/file storage capability |

### Initialization

`lib/main.dart` performs startup initialization:

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await BxDependencyInjector.instance.setup();
  runApp(...);
}
```

### Firebase Options

`lib/firebase_options.dart` contains platform-specific options for Android, iOS, and Web. These are application identifiers (not secrets), but the associated API keys should still be restricted in the provider console.

### OAuth Client IDs

| Client type | Value (suffix) | Purpose |
|---|---|---|
| AndroidOAuth (`client_type 1`) | `...rie3k.apps.googleusercontent.com` | Android app sign-in |
| Web OAuth (`client_type 3`) | `...lstfjh9.apps.googleusercontent.com` | `serverClientId` for Google Sign-In |
| iOS OAuth (`client_type 2`) | `...po1i2.apps.googleusercontent.com` | iOS sign-in / reversed scheme |

---

## ⚙️ Platform Configuration

### Android

#### Gradle

| Setting | Value |
|---|---|
| Namespace | `com.app.taiyara` |
| Application ID | `com.app.taiyara` |
| Compile SDK / min SDK / target SDK | Flutter-managed |
| Java/Kotlin target | JVM 17 |
| Firebase BoM | `33.14.0` |
| Google Services Gradle plugin | Intentionally omitted (runtime Firebase options used) |
| Release signing | From `android/key.properties` when present |

#### Manifest Highlights

- `INTERNET` permission (debug/profile manifests).
- `MainActivity` exported, `singleTop` launch mode.
- Launch theme + normal theme metadata.
- `configChanges` for orientation, keyboard, screen size, locale, font scale, etc.
- `adjustResize` soft-input mode.
- Intent filters for:
  - `MAIN` / `LAUNCHER`
  - OAuth redirect (`VIEW`, `BROWSABLE`, scheme/host `com.app.taiyara`)
- Facebook SDK metadata:
  - `com.facebook.sdk.ApplicationId`
  - `com.facebook.sdk.AutoInitEnabled`
  - `com.facebook.sdk.AutoLogAppEventsEnabled`
- Queries for text processing and Facebook provider.

> **Important:** `res/values/strings.xml` currently contains the placeholder `{YOUR_FACEBOOK_APP_ID}`. Replace it with the real Facebook App ID before shipping Facebook Login.

#### Signing & SHA-1

Register both debug and release SHA-1/SHA-256 fingerprints in Firebase Console:

```bash
cd android && ./gradlew signingReport
```

Google Sign-In will fail if the fingerprint of the signing certificate does not match a registered OAuth client.

### iOS

#### Bundle & Firebase

| Setting | Value |
|---|---|
| Bundle identifier | `com.app.taiyara` |
| Firebase plist | `ios/Runner/GoogleService-Info.plist` |
| URL scheme | `$(GOOGLE_REVERSED_CLIENT_ID)` from `Local.xcconfig` |

#### Info.plist Highlights

- `CFBundleURLTypes` with `$(GOOGLE_REVERSED_CLIENT_ID)` for Google OAuth callback.
- `LSApplicationQueriesSchemes` for Facebook (`fbapi`, `fb-messenger-share-api`, `fbauth`, `fbshareextension`).
- `NSPhotoLibraryUsageDescription` for profile image changes.

#### Local Config Generation

`scripts/configure_local_config.py` reads `GOOGLE_REVERSED_CLIENT_ID` from `.env` and writes:

```
ios/Flutter/Local.xcconfig
```

This file is local-only and referenced by the Xcode build configuration.

---

## 🚀 Setup & Installation

### Prerequisites

| Requirement | Version / Notes |
|---|---|
| Flutter SDK | `>= 3.12.2` |
| Dart SDK | `^ 3.12.2` |
| Android Studio | For Android builds / emulator |
| Xcode | For iOS builds (macOS only) |
| Firebase account | Project `taiyara-676dc` or your own |
| Backend API | Access to the Go/Gin API |
| Python 3 | For local iOS config generation |

### 1. Clone the repository

```bash
git clone <this-repo-url>
cd tayara
```

### 2. Install dependencies

```bash
flutter pub get
```

### 3. Configure environment

```bash
cp .env.example .env
```

Fill in the Firebase and OAuth values in `.env`. See [Environment Configuration](#-environment-configuration).

### 4. Configure iOS local settings

```bash
python3 scripts/configure_local_config.py
```

> This generates `ios/Flutter/Local.xcconfig` from `GOOGLE_REVERSED_CLIENT_ID` in `.env`.

### 5. Add platform Firebase files

Place the following local files in the correct paths:

```
android/app/google-services.json
ios/Runner/GoogleService-Info.plist
```

These files are intentionally untracked by Git.

### 6. Register signing fingerprints

```bash
cd android && ./gradlew signingReport
```

Add the SHA-1 and SHA-256 values to Firebase Console → Project Settings → Your apps → Android app.

### 7. Run the app

```bash
flutter run
```

Or select a device:

```bash
flutter devices
flutter run -d <device-id>
```

---

## 🔧 Environment Configuration

### `.env` Variables

Copy `.env.example` to `.env` and fill in:

| Variable | Purpose |
|---|---|
| `FIREBASE_ANDROID_API_KEY` | Android Firebase API key |
| `FIREBASE_ANDROID_APP_ID` | Android Firebase app ID |
| `FIREBASE_IOS_API_KEY` | iOS Firebase API key |
| `FIREBASE_IOS_APP_ID` | iOS Firebase app ID |
| `FIREBASE_IOS_BUNDLE_ID` | iOS bundle identifier |
| `FIREBASE_MESSAGING_SENDER_ID` | FCM sender ID |
| `FIREBASE_PROJECT_ID` | Firebase project ID |
| `FIREBASE_STORAGE_BUCKET` | Firebase Storage bucket |
| `FIREBASE_WEB_API_KEY` | Web Firebase API key |
| `FIREBASE_WEB_APP_ID` | Web Firebase app ID |
| `FIREBASE_WEB_AUTH_DOMAIN` | Web auth domain |
| `FIREBASE_WEB_MEASUREMENT_ID` | Analytics measurement ID |
| `GOOGLE_WEB_CLIENT_ID` | Web OAuth client ID (Sign-In server client) |
| `GOOGLE_IOS_CLIENT_ID` | iOS OAuth client ID |
| `GOOGLE_REVERSED_CLIENT_ID` | Reversed iOS client ID for URL scheme |

### Security Notes

- `.env` is ignored by Git.
- Firebase/OAuth client IDs are **public application identifiers**, not server secrets.
- API keys should still be restricted by package/bundle ID and API in the provider console.
- Never commit keystores, signing passwords, or service-account credentials.

---

## 🏗️ Build & Release

### Analysis

```bash
flutter analyze
```

### Code generation

```bash
dart run build_runner build --delete-conflicting-outputs
flutter gen-l10n
```

### Debug build

```bash
flutter build apk --debug
```

### Release APK

```bash
flutter build apk --release --dart-define-from-file=.env
```

### App Bundle (recommended for Play Store)

```bash
flutter build appbundle --release --dart-define-from-file=.env
```

### iOS

```bash
flutter build ios --release
# or
flutter build ipa --release
```

### Versioning

Version is defined in `pubspec.yaml`:

```yaml
version: 1.0.1
```

Override per build:

```bash
flutter build apk --build-name=1.0.2 --build-number=3
```

### Release Checklist

- [ ] Replace staging `baseUrl` with production URL.
- [ ] Fill in real Facebook App ID in `strings.xml` / plist config.
- [ ] Verify all Firebase files are present and correct.
- [ ] Register release SHA-1/SHA-256 in Firebase.
- [ ] Confirm Google Sign-In web client ID matches Firebase Console.
- [ ] Enable required OAuth APIs in Google Cloud Console.
- [ ] Verify push notification certificates/keys.
- [ ] Run `flutter analyze` with zero issues.
- [ ] Run `flutter test`.
- [ ] Test on real devices (Android + iOS).
- [ ] Test RTL (Arabic) layout.
- [ ] Test dark mode.
- [ ] Test offline/error states.
- [ ] Test all payment methods in sandbox mode.
- [ ] Review API keys and restrictions.

---

## 🧪 Testing Strategy

### Current State

A basic widget test exists:

```
test/widget_test.dart
```

### Recommended Test Pyramid

```
              ╱╲
             ╱  ╲           Integration tests
            ╱    ╲          (full flows on device)
           ╱──────╲
          ╱        ╲        Widget tests
         ╱──────────╲       (screens, widgets, BLoCs)
        ╱            ╲
       ╱──────────────╲     Unit tests
      ╱                ╲    (use cases, repositories, models)
```

### Unit Tests

Target:

- Use cases with mocked repositories.
- Repository implementations with mocked data sources.
- Model serialization/deserialization.
- `BxNetworkException` mapping in `BxDioClient`.
- Auth service error-message helpers.

Example:

```dart
test('get top deals returns mapped response', () async {
  final mockRepo = MockTopDealsRepository();
  final usecase = BxGetTopDealsUsecase(mockRepo);
  when(() => mockRepo.getTopDeals(any())).thenAnswer((_) async => Right(fakeDeals));

  final result = await usecase(fakeRequest);

  expect(result, Right(fakeDeals));
});
```

### Widget Tests

Target:

- Each screen renders key UI elements.
- Loading/error/success states render correctly.
- BLoC events trigger expected states.
- Localized strings appear in both locales.
- RTL layout does not overflow.

### Integration Tests

Target:

- Complete login → home → trip detail → booking flow.
- Social auth flows on real devices.
- Push notification receipt and tap handling.
- Payment sandbox transactions.
- Responsive layout on phone and tablet.

### Commands

```bash
flutter test
flutter test test/unit
flutter test integration_test
```

---

## 🛠️ Troubleshooting

### 1. App crashes immediately: `ClassNotFoundException: MainActivity`

**Symptom:**

```
java.lang.ClassNotFoundException: Didn't find class "com.app.taiyara.MainActivity"
```

**Cause:** Kotlin package does not match the Gradle namespace.

**Fix:** Ensure the activity file is at:

```
android/app/src/main/kotlin/com/app/taiyara/MainActivity.kt
```

with:

```kotlin
package com.app.taiyara

import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity()
```

### 2. "Google Sign-In is misconfigured"

**Cause:** `GoogleSignIn.instance.initialize()` was not called, or `serverClientId` is wrong/missing.

**Fix:**

- Confirm `_ensureInitialized()` calls `initialize(serverClientId: ...)`.
- Use the `client_type: 3` web client ID from Firebase.
- Verify it matches Firebase Console → Authentication → Google → Web SDK client ID.

### 3. "Sign-in was cancelled" / `[16] account reauth failed`

**Cause:** Android Credential Manager reports some configuration errors as cancellation.

**Fix:**

- Register debug and release SHA-1 fingerprints in Firebase.
- Remove and re-add the Google account on the device.
- Use a physical device instead of an emulator.
- Clear Google Play services cache.
- Ensure the account is a personal account, not a work profile.

### 4. Network requests fail with HTML error page

**Cause:** Staging ngrok URL expired or is unreachable.

**Fix:**

- Check `BxAppConfig.baseUrl`.
- Confirm the backend API is running.
- Update to a stable staging/production URL.

### 5. Facebook Login fails with placeholder App ID

**Cause:** `strings.xml` still contains `{YOUR_FACEBOOK_APP_ID}`.

**Fix:** Replace with the real App ID from Facebook Developer Console.

### 6. iOS build fails with URL scheme error

**Cause:** `Local.xcconfig` missing or `GOOGLE_REVERSED_CLIENT_ID` not set.

**Fix:**

```bash
cp .env.example .env
# fill GOOGLE_REVERSED_CLIENT_ID
python3 scripts/configure_local_config.py
```

### 7. Localization keys missing after adding ARB entries

**Fix:**

```bash
flutter gen-l10n
```

### 8. JSON model `fromJson` undefined

**Fix:**

```bash
dart run build_runner build --delete-conflicting-outputs
```

---

## 🔒 Security Considerations

### Local-Only Files

The following must remain untracked:

```
.env
android/key.properties
android/*.jks
android/app/google-services.json
ios/Runner/GoogleService-Info.plist
ios/Flutter/Local.xcconfig
```

### API Key Restrictions

Restrict Firebase/OAuth keys by:

- Android package name: `com.app.taiyara`
- iOS bundle ID: `com.app.taiyara`
- API type (Maps, Storage, etc.)

### Authentication

- Store only necessary tokens.
- Use `SharedPreferences` for non-sensitive settings.
- Consider `flutter_secure_storage` for sensitive tokens in a future iteration.
- Always validate tokens on the backend.

### Network

- Use HTTPS only.
- Validate server certificates in production.
- Avoid logging sensitive headers in production builds.

### Code

- Never commit real credentials.
- Rotate keys if they were ever committed.
- Use `--dart-define-from-file=.env` for build-time configuration.

---

## ⚡ Performance Considerations

### Current Optimizations

| Technique | Where |
|---|---|
| Lazy singletons | `get_it` registrations in DI container |
| Cached tab BLoCs | Bottom nav tab controllers registered as lazy singletons |
| `shimmer` loading states | Perceived performance during data loads |
| `SafeNetworkImage` | Resilient image loading |
| Pagination utilities | `BxPaginationResponse` for large lists |
| 30-second timeouts | Prevents hanging network requests |
| ScreenUtil | Consistent sizing across devices |

### Recommended Improvements

1. **Image caching:** Use `cached_network_image` for remote assets.
2. **List virtualization:** Use `ListView.builder`/`GridView.builder` for long lists.
3. **Pagination:** Wire `BxPaginationResponse` into all list endpoints.
4. **Debouncing:** Add debounce to search input to reduce API calls.
5. **Compute isolation:** Move heavy JSON parsing to `compute()`/`Isolate.run`.
6. **Analytics:** Replace debug-only route logging with a real analytics service.
7. **Crash reporting:** Add Crashlytics/Sentry.
8. **Deep linking:** Implement full Android App Links / iOS Universal Links.
9. **Offline mode:** Cache critical data with a local database.
10. **Performance profiling:** Use DevTools for raster/UI frame analysis.

---

## 📏 Code Conventions

### Naming

| Element | Convention | Example |
|---|---|---|
| Files | `bx_` prefix + snake_case | `bx_login_screen.dart` |
| Classes | `Bx` prefix + PascalCase | `BxLoginControllerBloc` |
| Constants | lowerCamelCase | `baseImageUrl` |
| Route constants | `bx` prefix + PascalCase | `bxPaymentScreen` |
| Private fields | underscore prefix | `_googleSignIn` |
| Workers | kebab-case folder names | `bx-home-bottom-screen/` |

### File Header

Most files include a documentation header:

```dart
// Copyright (c) 2026 Tayara. All rights reserved.
//
/// Brief description.
/// Architecture: Layer - Component
/// Purpose: What this file does.
library;
```

### Documentation

- Public classes and methods use `///` doc comments.
- Complex flows include ASCII diagrams.
- Constants include inline `///` descriptions.

### Error Handling

- Auth services return result objects (`BxGoogleAuthResult`, etc.).
- Network errors are wrapped in `BxNetworkException`.
- BLoCs catch exceptions and emit error states.
- User-facing messages are mapped to friendly text.

### State

- Events are immutable and extend `Equatable`.
- States use `copyWith()` for partial updates.
- Status enums drive UI rendering (initial/loading/success/error).

---

## 🧩 Extending the Application

### Adding a New Screen

1. Create the view:
   ```
   lib/presentation/views/bx_my_feature_screen/bx_my_feature_screen.dart
   ```
2. Create its BLoC (if needed):
   ```
   lib/presentation/bloc/bx_my_feature_controller/
   ```
3. Add the route constant in `bx_route_names.dart`.
4. Register it in `BxRouteGenerator.generateRoute()`.
5. Add localized strings to both ARB files.
6. Add assets to `BxAppConstant` and `pubspec.yaml` if needed.

### Adding a New API Feature

1. Add endpoint to `BxApiEndpoints`.
2. Create request/response models in `domain/model/`.
3. Run build_runner.
4. Add repository interface in `domain/repositories/`.
5. Add use case in `domain/usecase/`.
6. Implement repository in `data/repositories/`.
7. Add data-source method in `BxSystemRemoteDataSource`.
8. Register in `BxDependencyInjector`.
9. Consume from a BLoC.

### Adding a New Authentication Provider

1. Create `lib/core/services/bx_<provider>_auth_firebase_services.dart`.
2. Return a result object with success/user/error.
3. Map platform errors to friendly messages.
4. Invoke from login/sign-up/phone BLoCs.
5. Configure provider credentials in Firebase Console.
6. Update platform config (URL schemes, intent filters, plist values).

### Adding a New Locale

1. Add `app_<locale>.arb`.
2. Translate all existing keys.
3. Run `flutter gen-l10n`.
4. Add a locale option to the localization BLoC UI.
5. Test RTL if applicable.

---

## 🗺️ Roadmap

### Near Term

- [ ] Replace staging ngrok base URL with stable environment-based API URL.
- [ ] Move hardcoded Firebase/OAuth IDs to `.env`-driven configuration.
- [ ] Replace Facebook App ID placeholder.
- [ ] Add real analytics service for route tracking.
- [ ] Add Crashlytics/Sentry crash reporting.
- [ ] Expand unit and widget test coverage.

### Medium Term

- [ ] Full deep linking (Android App Links / iOS Universal Links).
- [ ] Offline caching and retry queue.
- [ ] Advanced search filters with saved preferences.
- [ ] In-app chat with agencies.
- [ ] Wishlist / favorites.
- [ ] Multi-currency support.

### Long Term

- [ ] Web admin portal for agencies.
- [ ] Dynamic pricing engine integration.
- [ ] Loyalty and rewards program.
- [ ] AI-powered trip recommendations.
- [ ] Social features and travel communities.

---

## 🔗 Related Repositories

| Repository | Purpose |
|---|---|
| [tayara_api_repo](https://github.com/mo7amed4522/tayara_api_repo) | Go/Gin backend API, GORM, MySQL, MongoDB, Redis |

---

## ❓ FAQ

### Is Tayara free to use?

The app is a marketplace client; usage terms depend on the backend/service policies.

### Which platforms are supported?

Android and iOS.

### Which languages are supported?

English and Arabic, with RTL support for Arabic.

### How are payments handled?

Through the backend payment integrations: Stripe-style card payments, Apple Pay, Google Pay, and BNPL providers (Tabby/Tamara).

### Why does Google Sign-In require SHA-1 registration?

Android OAuth clients are bound to the app's signing certificate. Without matching fingerprints, Google refuses the sign-in request.

### Can I switch the API environment?

Yes. Update `BxAppConfig.baseUrl` in `lib/core/network/bx_api_endpoints.dart` or make it environment-driven.

### How do I regenerate JSON models?

```bash
dart run build_runner build --delete-conflicting-outputs
```

### How do I regenerate localization files?

```bash
flutter gen-l10n
```

### Where are assets defined?

Paths are centralized in `BxAppConstant` and declared in `pubspec.yaml`.

### Is this app production-ready?

The architecture is production-oriented, but release requires configuration cleanup (base URL, Facebook App ID, fingerprints, analytics, crash reporting, tests).

---

## 🤝 Contributing

### Workflow

1. Create a feature branch:
   ```bash
   git checkout -b feature/my-feature
   ```
2. Make changes following the code conventions.
3. Run:
   ```bash
   flutter analyze
   flutter test
   ```
4. Commit with a clear message.
5. Push and open a Pull Request.

### Pull Request Checklist

- [ ] Code follows `Bx` naming conventions.
- [ ] `flutter analyze` passes.
- [ ] `flutter test` passes.
- [ ] New strings added to both ARB files.
- [ ] Generated files updated where needed.
- [ ] No secrets or local config files included.
- [ ] Screenshots attached for UI changes.
- [ ] Documentation updated.

---

## 📄 License

**Proprietary — © 2026 Tayara. All rights reserved.**

Unauthorized copying, distribution, modification, or public display of this software is strictly prohibited.

---

## 📬 Contact

| Topic | Contact |
|---|---|
| Backend / API | [github.com/mo7amed4522/tayara_api_repo](https://github.com/mo7amed4522/tayara_api_repo) |
| Product / Mobile | Tayara mobile team |
| General | Maintainer of this repository |

---

## 📎 Appendix

### A. Quick Command Reference

| Command | Purpose |
|---|---|
| `flutter pub get` | Install packages |
| `flutter run` | Run the app |
| `flutter analyze` | Static analysis |
| `flutter test` | Run tests |
| `flutter gen-l10n` | Generate localization classes |
| `dart run build_runner build --delete-conflicting-outputs` | Generate JSON adapters |
| `flutter build apk --debug` | Debug APK |
| `flutter build apk --release --dart-define-from-file=.env` | Release APK |
| `flutter build appbundle --release` | Play Store bundle |
| `python3 scripts/configure_local_config.py` | Generate iOS local config |
| `cd android && ./gradlew signingReport` | Show signing fingerprints |

### B. Key Files at a Glance

| File | Purpose |
|---|---|
| `lib/main.dart` | Entry point, Firebase + DI initialization |
| `lib/bx_app_widget.dart` | Root widget, providers, MaterialApp |
| `lib/firebase_options.dart` | Firebase platform options |
| `lib/core/routes/bx_route_names.dart` | Route constants |
| `lib/core/routes/bx_route_generator.dart` | Route generation and transitions |
| `lib/core/network/bx_api_endpoints.dart` | Base URL and endpoint catalog |
| `lib/core/network/bx_dio_client.dart` | HTTP client and error handling |
| `lib/core/theme/bx_app_theme.dart` | Material light/dark themes |
| `lib/core/theme/bx_app_colors.dart` | Color palette |
| `lib/core/services/bx_*_auth_firebase_services.dart` | Auth providers |
| `lib/injection/bx_dependency_injector.dart` | DI container |
| `lib/l10n/arb/app_en.arb` | English strings |
| `lib/l10n/arb/app_ar.arb` | Arabic strings |
| `scripts/configure_local_config.py` | iOS local config generator |

### C. Architecture Decision Records (Summary)

| Decision | Rationale |
|---|---|
| Clean Architecture | Keeps business logic framework-independent and testable |
| BLoC | Predictable state transitions for complex UI flows |
| get_it | Lightweight DI without code generation |
| Dio | Rich interceptor model for auth/logging/error handling |
| JSON Serializable | Type-safe API models |
| ARB localization | First-party Flutter localization workflow |
| ScreenUtil | Fast responsive scaling around a fixed design size |
| Runtime Firebase options | Avoids Gradle Google Services plugin version conflicts |
| Local-only config files | Prevents credential leakage in source control |

### D. Glossary

| Term | Meaning |
|---|---|
| **BLoC** | Business Logic Component — separates events from UI states |
| **Use case** | A single application action in the domain layer |
| **Repository** | Abstraction over a data source |
| **Data source** | Concrete access to remote API or local storage |
| **DTO / Model** | Typed representation of API request/response data |
| **DI** | Dependency Injection — supplying dependencies externally |
| **ARB** | Application Resource Bundle used by Flutter localization |
| **BNPL** | Buy Now, Pay Later |
| **KYC** | Know Your Customer identity verification |
| **FCM** | Firebase Cloud Messaging |
| **RTL** | Right-to-left layout (Arabic) |
| **OAuth client** | Application identity registered with Google/Facebook/Apple |

---

<div align="center">

**Tayara — Built with Flutter & Dart**

*Connecting travelers with the world, one trip at a time.* ✈️

<sub>Maintained by the Tayara mobile team · Proprietary © 2026</sub>

</div>
