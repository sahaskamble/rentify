# Rentify - Phase 1: Project Infrastructure & Auth Plan

This plan focuses on setting up the Flutter project infrastructure, routing, dependency injection, and building the authentication & onboarding flows according to the `implementation_plan.md`.

## Goal
Set up a production-ready Flutter architecture using GoRouter and Riverpod, and implement the Auth & Verification screens integrating with the existing PocketBase models.

## Scope
**IN:**
- Dependencies: `go_router`, `riverpod_annotation`, `image_picker`, `shared_preferences`, `dio`, `lottie`, `pinput`, `file_picker`, `build_runner`
- Core architecture: Routing, constants, and utils.
- Screens: Splash, Onboarding (with Lottie placeholders), Login, Register, OTP, Forgot Password.
- Verification Screens: Verification Hub, Govt ID Upload, Selfie Capture, Seller Bank Details.
- PocketBase Auth integration with persistent state.

**OUT:**
- Main App Shell (Bottom Navigation), Home Screen, Search, Listings, Chat, Payments.
- OCR or Face Matching (Verification is strictly manual file upload).
- Social Auth (Google/Apple).

## Technical Approach & Guardrails
- **Routing**: `GoRouter` with strict redirection based on the Riverpod `authProvider` state. Prevent back-button hijacking (e.g., returning to Login after successful auth).
- **State Management**: `flutter_riverpod` + `riverpod_generator`.
- **Backend URL**: Update `PocketbaseService` to support Android emulator (`10.0.2.2:8090`) or physical device IPs dynamically.
- **Persistence**: Create a custom `AuthStore` using `shared_preferences` and integrate it into `PocketbaseService` to maintain sessions. The `AuthProvider` must listen to `pb.authStore.onChange` to trigger router redirects automatically.
- **Global Error Handling**: Implement a global utility (e.g., via `ScaffoldMessenger`) to handle Dio/PocketBase exceptions consistently across auth screens.
- **OTP Implementation**: For v1, mock the SMS sending but implement the UI/UX flow with a hardcoded OTP (e.g., "123456") or a PocketBase custom endpoint hook if available.
- **Assets**: Create an `assets/animations/` folder, add it to `pubspec.yaml`, and instruct the implementer to download free Lottie JSONs for the onboarding carousel.

---

## Execution Plan

### Step 1: Project Infrastructure & Dependencies
1. **Update `pubspec.yaml`**: Add all missing dependencies (`go_router`, `flutter_riverpod`, `riverpod_annotation`, `image_picker`, `shared_preferences`, `intl`, `shimmer`, `dio`, `flutter_animate`, `lottie`, `pinput`, `photo_view`, `file_picker`). Add `build_runner` to dev_dependencies.
2. **Add Assets Declaration**: Add `assets/animations/` to `pubspec.yaml`. Create the directory `assets/animations/`.
3. **Run Pub Get**: Execute `flutter pub get`.
4. **Create Core Directories**: Create `lib/core/constants.dart`, `lib/core/extensions.dart`, and `lib/core/utils/validators.dart`.
5. **Backend URL Fix**: In `lib/core/constants.dart`, define the PB URL. Update `lib/services/pocketbase_service.dart` to use `10.0.2.2:8090` for Android emulators (or detect the platform).

### Step 2: Routing & State Management Foundation
1. **Create Auth Provider Skeleton**: Create `lib/features/auth/providers/auth_provider.dart`. Implement an `AsyncNotifier` that checks `PocketbaseService().pb.authStore.isValid` and persists state.
2. **Setup GoRouter**: Create `lib/core/router/app_router.dart`. Define the routes: `/` (Splash), `/onboarding`, `/login`, `/register`, `/otp`, `/verification_hub`, and a placeholder `/home`. Implement the redirect logic based on `authProvider`.
3. **Update Main**: Modify `lib/main.dart` to wrap the app in a `ProviderScope` and return `MaterialApp.router` using the GoRouter instance. Use the existing theme from `AppColors` and `AppTextStyles`.

### Step 3: Auth & Onboarding UI
1. **Download Assets**: Find and download 3 free Lottie JSON files for the onboarding screens. Place them in `assets/animations/`.
2. **Build Splash Screen**: Create `lib/features/auth/screens/splash_screen.dart` with a simple animated logo or text that transitions based on auth state.
3. **Build Onboarding Screen**: Create `lib/features/auth/screens/onboarding_screen.dart`. Implement a 3-page carousel using `PageView` and `Lottie.asset`. Include a "Skip" and "Get Started" button.
4. **Build Login Screen**: Create `lib/features/auth/screens/login_screen.dart` with Email/Password fields. Integrate with `PocketbaseService.pb.collection('users').authWithPassword()`.
5. **Build Register Screen**: Create `lib/features/auth/screens/register_screen.dart` with Name, Email, Phone, Password. Use `validators.dart` for input sanitization (Mumbai phone format).

### Step 4: OTP & Verification Flow
1. **Build OTP Screen**: Create `lib/features/auth/screens/otp_screen.dart` using the `pinput` package. Mock the actual SMS send for v1.
2. **Build Verification Hub**: Create `lib/features/verification/screens/verification_hub_screen.dart` showing steps: Phone (Done), Govt ID (Pending), Selfie (Pending).
3. **Build Govt ID Upload Screen**: Create `lib/features/verification/screens/govt_id_upload_screen.dart`. Use `file_picker` to select images and submit to the `user_verifications` PocketBase collection. Handle upload states and errors.
4. **Build Selfie Screen**: Create `lib/features/verification/screens/selfie_screen.dart` using `image_picker` (camera source). Submit to PB.
5. **Build Seller Bank Screen**: Create `lib/features/verification/screens/seller_bank_screen.dart` to capture Bank Account, IFSC, and UPI, saving to the `seller_profiles` collection.

### Step 5: Code Generation & Final Wiring
1. **Run Build Runner**: Execute `dart run build_runner build -d` to generate Riverpod providers.
2. **QA Scenarios**:
   - Verify unauthenticated users are redirected to `/login` or `/onboarding`.
   - Verify successful login updates the `authProvider` state and redirects to the placeholder `/home` or `/verification_hub`.
   - Verify `AuthStore` persists across hot restarts.
   - Test validation logic on the Register screen.

## Final Verification Wave
- The implementer must run `flutter analyze` and fix any warnings related to the newly created files.
- The implementer must confirm that the app builds successfully on an Android emulator and can connect to a local PocketBase instance.