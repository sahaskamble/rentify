# Phase 2 Plan: App Shell, Discover & Listings

Current Phase: Phase 1 complete (Auth & Verification scaffold established). Phase 2 focuses on delivering the app shell, navigation backbone, and initial Discover/Home UX wired to PocketBase, laying the groundwork for Listings and Details.

## Goal
- Implement a reusable app shell with a persistent bottom navigation bar, GoRouter-based routing, and the first-pass Discover/Home UI. Wire basic data fetching from PocketBase for listings and prepare a skeleton for listing details.

## Scope
- UI Shell: persistent bottom navigation with 5 tabs (Home, Search, My Rentals, Chat, Profile)
- Routing: GoRouter with structured redirects based on auth state
- Discover/Home: hero, category chips, featured listings, nearby listings
- Listing Detail: image carousel, title, price, rating, and basic seller info
- Data wiring: fetch listings from PocketBase collections
- Confirm theme and typography reuse from Phase 1 (AppColors, AppTextStyles)
- Prep for Verification Drawer and Seller workspace without embedding heavy features yet
- Asset readiness: placeholder for onboarding visuals; Lottie assets to be added later
- Environment: PB URL handling for emulator/real device with simple constants switch

---

## Task Breakdown (Granular Implementation Tasks)
- [ ] **Infrastructure & Setup**
  - [ ] `pubspec.yaml`: Add `go_router`, `flutter_riverpod`, `cached_network_image`, `shimmer`, `flutter_svg`, `lottie`
  - [ ] `pubspec.yaml`: Declare `assets/images/`, `assets/icons/`, `assets/animations/`
  - [ ] `lib/services/pocketbase_service.dart`: Update `pocketbaseUrl` to handle different environments (Android emulator vs iOS/Web)
- [ ] **Routing & Auth State**
  - [ ] `lib/core/providers/auth_provider.dart`: Create `authProvider` using Riverpod to track `RecordAuth?`
- [x] `lib/core/router/app_router.dart`: Implement `GoRouter` with `ShellRoute` and auth redirects
  - [ ] `lib/main.dart`: Switch to `MaterialApp.router` and use `appRouter`
- [ ] **App Shell & Navigation**
  - [ ] `lib/features/shell/shell_screen.dart`: Create `AppShell` with `Scaffold` and `NavigationBar` (Material 3)
  - [ ] `lib/features/shell/shell_screen.dart`: Wire `navigationShell` to the 5 tabs (Home, Search, Rentals, Chat, Profile)
- [ ] **Home / Discover UI**
  - [ ] `lib/widgets/listing_card.dart`: Create reusable `ListingCard` widget with image, title, price, rating, and location
  - [ ] `lib/features/home/home_screen.dart`: Implement Discover UI with categories, featured, and nearby sections
- [ ] **Data Integration**
  - [ ] `lib/services/pocketbase_service.dart`: Add `getListings()` and `getCategories()` methods
  - [ ] `lib/features/home/providers/home_providers.dart`: Create `listingsProvider` and `categoriesProvider`
- [ ] **Search & Details (Skeletons)**
  - [ ] `lib/features/search/screen/search_screen.dart`: Create basic search layout skeleton
  - [ ] `lib/features/listing_detail/listing_detail_screen.dart`: Create basic listing detail structure
- [ ] **Auth Screens (Placeholders)**
  - [ ] `lib/features/auth/screens/splash_screen.dart`: Implement auth-aware splash screen
  - [ ] `lib/features/auth/screens/onboarding_screen.dart`: Create onboarding placeholder
- [ ] **Verification**
  - [ ] Run `flutter analyze` and `flutter pub get`
  - [ ] Verify routes compile and basic UI renders

---

## Acceptance Criteria
- App shell renders with persistent bottom navigation
- Router redirects respect authentication state
- Home/Discover loads with sample listings from PocketBase
- Listing detail screen structure is present
- No breaking changes to existing models/themes
- Code is organized to accommodate future Listings, Chat, and Payments additions

---

## Execution Log
- Plan authored for Phase 2; next steps are to decompose each item into concrete tasks in the repository and create a new work session
