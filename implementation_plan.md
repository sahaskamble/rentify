# Rentify Flutter App — Implementation Plan

Rentify is a peer-to-peer rental marketplace for Mumbai. This plan covers the full v1 Flutter mobile app using PocketBase as the backend. The existing project already has: a basic theme (`AppColors`, `AppTextStyles`), 5 data models (`User`, `Listing`, `SellerProfile`, `Category`, `UserVerification`), a bare `HomeScreen`, and a `PocketbaseService` singleton. The PocketBase schema is fully designed with 15 collections.

---

## Proposed Changes

### Component 1: Project Infrastructure

#### [MODIFY] [pubspec.yaml](file:///home/shado/Workspace/rentify/pubspec.yaml)
Add missing dependencies:
- `go_router` — declarative routing
- `flutter_riverpod` + `riverpod_annotation` + `riverpod_generator` — state management (already present, add `build_runner`, `riverpod_annotation`)
- `image_picker` — for listing photos, verification docs, selfie
- `shared_preferences` — persisting auth token
- `intl` — date formatting
- `shimmer` — skeleton loading states
- `dio` — for Razorpay payment API calls
- `flutter_animate` — micro-animations
- `lottie` — onboarding animations
- `pinput` — OTP input field
- `photo_view` — full-screen image viewer
- `file_picker` — for govt ID document upload

#### [NEW] `lib/core/` directory
- `lib/core/constants.dart` — app constants (PB URL, category slugs, etc.)
- `lib/core/extensions.dart` — useful Dart extensions
- `lib/core/utils/` — validators, formatters, helpers
- `lib/core/router/app_router.dart` — GoRouter configuration with all named routes

---

### Component 2: Auth & Onboarding

#### [NEW] `lib/features/auth/`
- `screens/splash_screen.dart` — animated logo → auto-navigate based on auth state
- `screens/onboarding_screen.dart` — 3-step carousel with Lottie animations
- `screens/login_screen.dart` — email + password login
- `screens/register_screen.dart` — name, email, phone, password
- `screens/otp_screen.dart` — phone OTP verification (Pinput widget)
- `screens/forgot_password_screen.dart`
- `providers/auth_provider.dart` — Riverpod AsyncNotifier managing auth state (login, register, logout, persist token)
- `services/auth_service.dart` — wraps PocketbaseService auth methods

#### [NEW] `lib/features/verification/`
- `screens/verification_hub_screen.dart` — shows which verifications are done (phone ✓, govt ID ⏳, selfie ⏳)
- `screens/govt_id_upload_screen.dart` — upload front/back of Aadhaar/PAN via `file_picker`, submit to `user_verifications` collection
- `screens/selfie_screen.dart` — capture selfie via camera, submit
- `screens/seller_bank_screen.dart` — enter bank account + IFSC + UPI, saved to `seller_profiles`

> **Seller Verification Flow:**
> 1. User registers → verifies phone (OTP)  
> 2. To list items: must submit Govt ID + selfie (status = pending, admin approves)  
> 3. Seller profile created with bank details

---

### Component 3: App Shell & Navigation

#### [MODIFY] [main.dart](file:///home/shado/Workspace/rentify/lib/main.dart)
- Wrap with `ProviderScope` (Riverpod)
- Replace `MaterialApp` with `MaterialApp.router` using GoRouter

#### [NEW] `lib/features/shell/`
- `screens/shell_screen.dart` — persistent bottom nav with 5 tabs:
  - **Home** (discover listings)
  - **Search** (filter + browse)
  - **My Rentals** (order history)
  - **Chat** (conversations)
  - **Profile** (settings, seller dashboard toggle)

---

### Component 4: Discover & Search (Renter Side)

#### [NEW] `lib/features/home/`
- `screens/home_screen.dart` — hero banner, category chips row, featured listings grid, nearby listings
- `widgets/category_chip.dart` — scrollable category pills
- `widgets/listing_card.dart` — reusable card (image, title, price/day, rating, location)
- `widgets/featured_banner.dart`
- `providers/home_provider.dart` — fetches featured + recent listings

#### [NEW] `lib/features/search/`
- `screens/search_screen.dart` — search bar, filter bottom sheet (category, pincode/area, price range, condition, delivery available)
- `providers/search_provider.dart` — Riverpod provider with debounced search

#### [NEW] `lib/features/listing_detail/`
- `screens/listing_detail_screen.dart` — photo carousel, title, condition badge, pricing tiers (day/week/month), security deposit, seller info card, availability calendar, "Rent Now" CTA
- `widgets/photo_carousel.dart`
- `widgets/pricing_card.dart`
- `widgets/seller_info_card.dart`

---

### Component 5: Seller — Listing Management

#### [NEW] `lib/features/seller/`

**Seller Dashboard:**
- `screens/seller_dashboard_screen.dart` — active listings count, total earnings, pending rentals, avg rating
- `screens/my_listings_screen.dart` — list of seller's own listings with status badges

**Create/Edit Listing (Multi-Step Form):**
- `screens/create_listing/create_listing_screen.dart` — stepper controller
  - `step1_basics.dart` — title, category picker, description, condition selector
  - `step2_pricing.dart` — price/day (required), price/week, price/month, security deposit, min/max rental days, quantity
  - `step3_photos.dart` — up to 8 photos via `image_picker`
  - `step4_location.dart` — area, city, pincode, GPS coords, delivery toggle + radius + charge/km
  - `step5_condition_docs.dart` — **Pre-condition documentation**: seller takes/uploads photos of any pre-existing damage before listing goes live. Text description of damages. This is saved in the listing's `description` or a new `pre_condition_photos` field.
- `providers/create_listing_provider.dart` — step state management

> **Product Security / Pre-Condition Flow:**
> When creating a listing, Step 5 forces sellers to document existing damage. These photos are uploaded as part of the listing and shown on the detail page as "Item Condition at Time of Listing". When a renter returns the item, any new damage can be compared against these baseline photos to resolve disputes fairly.

**Availability Management:**
- `screens/listing_availability_screen.dart` — calendar view to block unavailable dates

---

### Component 6: Rental Flow & Orders

#### [NEW] `lib/features/rental/`
- `screens/booking_screen.dart` — renter selects start/end date (respecting unavailability), pickup type (self/delivery), calculates total (base + platform fee + delivery + deposit)
- `screens/booking_confirm_screen.dart` — order summary before payment
- `screens/rental_detail_screen.dart` — current status, timeline, chat CTA, cancel button
- `screens/rental_return_screen.dart` — renter marks return; seller can flag damage with photos → triggers dispute if damage found
- `screens/my_rentals_screen.dart` — renter's order history with tabs (Active, Completed, Cancelled)
- `screens/seller_rental_requests_screen.dart` — seller sees pending rental requests, accept/reject
- `providers/rental_provider.dart`

---

### Component 7: Chat

#### [NEW] `lib/features/chat/`
- `screens/conversations_screen.dart` — list of all conversations with unread badge
- `screens/chat_screen.dart` — real-time messages via PocketBase `subscribe()`, image attachments support
- `providers/chat_provider.dart` — real-time subscription management

---

### Component 8: Payments (v1 Basic)

#### [NEW] `lib/features/payment/`
- `screens/payment_screen.dart` — shows total breakdown, Razorpay "Pay Now" button
- `services/payment_service.dart` — Razorpay order creation → PocketBase payment record
- Note: Full Razorpay SDK integration requires Android/iOS setup

---

### Component 9: Reviews & Disputes

#### [NEW] `lib/features/review/`
- `screens/write_review_screen.dart` — star rating + comment, triggered after rental completion
- `screens/listing_reviews_screen.dart` — paginated list of reviews for a listing

#### [NEW] `lib/features/dispute/`
- `screens/file_dispute_screen.dart` — select category, description, upload evidence (photos/video)

---

### Component 10: Profile & Settings

#### [NEW] `lib/features/profile/`
- `screens/profile_screen.dart` — avatar, name, verification badges, stats
- `screens/edit_profile_screen.dart`
- `screens/seller_earnings_screen.dart` — payouts list, total earnings
- `screens/verification_status_screen.dart` — shows status of each verification step
- `screens/settings_screen.dart` — logout, notifications, help

---

### Component 11: Shared Widgets & Models

#### [MODIFY] `lib/models/` — add missing models:
- `rental_model.dart`
- `payment_model.dart`
- `review_model.dart`
- `conversation_model.dart`
- `message_model.dart`
- `dispute_model.dart`

#### [NEW] `lib/shared/widgets/`
- `app_button.dart` — primary/secondary/outline variants
- `app_text_field.dart` — consistent input styling
- `app_bottom_sheet.dart`
- `empty_state_widget.dart`
- `error_widget.dart`
- `loading_shimmer.dart`

---

## Schema Gap: Pre-Condition Photos

The existing `listings` schema does not have a dedicated field for pre-condition damage photos. We need to add either:
- A `pre_condition_photos` file field (up to 5 images) + `pre_condition_notes` text field to the `listings` collection in PocketBase, **OR**
- Use the description field with a structured note

> **Recommendation**: Add `pre_condition_photos` (file, up to 5 images) and `pre_condition_notes` (text, 1000 chars) to the `listings` collection schema.

---

## Development Priority Order

| Phase | Feature | Estimated Effort |
|---|---|---|
| 1 | Auth + Onboarding | ~3 days |
| 2 | App shell + navigation | ~1 day |
| 3 | Home + Browse + Listing Detail | ~3 days |
| 4 | Create Listing (all 5 steps) | ~3 days |
| 5 | Rental booking flow + order management | ~4 days |
| 6 | Chat (real-time) | ~2 days |
| 7 | Payments (Razorpay) | ~2 days |
| 8 | Reviews + Disputes | ~2 days |
| 9 | Profile + Seller Dashboard | ~2 days |

---

## Verification Plan

### Manual Verification (per phase)
Since this is a new Flutter app, verification will be manual using the running app:

**Phase 1 — Auth:**
```
flutter run
```
1. Splash → Onboarding → Register with email/phone
2. OTP flow (phone verification)
3. Login → check auth state persists after hot restart
4. Logout → redirects to login

**Phase 2 — Listings:**
1. Seller creates a listing with all 5 steps including pre-condition photos
2. Listing appears in home/browse as renter
3. Listing detail shows all info + condition photos

**Phase 3 — Rental Flow:**
1. Renter books item → checks availability blocking
2. Seller sees request → accepts
3. Rental moves through statuses: pending → confirmed → active → completed

**Phase 4 — Chat:**
1. Open two devices/emulators with two accounts
2. Renter opens listing → "Chat with Seller"
3. Real-time messages appear on both sides

### Flutter Analyze (run after each phase)
```bash
cd /home/shado/Workspace/rentify && flutter analyze
```
