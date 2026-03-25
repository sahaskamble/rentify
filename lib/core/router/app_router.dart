import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/auth/screens/splash_screen.dart';
import '../../features/auth/screens/onboarding_screen.dart';
import '../../features/auth/screens/login_screen.dart';
import '../../features/auth/screens/register_screen.dart';
import '../../features/auth/screens/otp_screen.dart';
import '../../features/shell/screens/shell_screen.dart';
import '../../features/listing_detail/screens/listing_detail_screen.dart';
import '../../features/seller/screens/create_listing/create_listing_screen.dart';
import '../../features/rental/screens/booking_screen.dart';
import '../../features/rental/screens/rental_detail_screen.dart';
import '../../features/auth/providers/auth_provider.dart';

abstract class AppRoutes {
  static const splash = '/';
  static const onboarding = '/onboarding';
  static const login = '/login';
  static const register = '/register';
  static const otp = '/otp';
  static const shell = '/home';
  static const listingDetail = '/listing/:id';
  static const createListing = '/seller/create-listing';
  static const editListing = '/seller/edit-listing/:id';
  static const booking = '/booking/:listingId';
  static const rentalDetail = '/rental/:id';
  static const chat = '/chat/:conversationId';
  static const verification = '/verification';
  static const editProfile = '/profile/edit';
  static const writeReview = '/review/write/:rentalId';
  static const fileDispute = '/dispute/:rentalId';
}

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);
  return GoRouter(
    initialLocation: AppRoutes.splash,
    debugLogDiagnostics: false,
    redirect: (context, state) {
      // Only redirect if auth state is in data (loaded successfully)
      // Skip redirect while loading to let splash screen handle its own logic
      if (authState case AsyncData(:final value)) {
        final isLoggedIn = value.isAuthenticated;
        final isAuthRoute = [
          AppRoutes.login,
          AppRoutes.register,
          AppRoutes.otp,
          AppRoutes.onboarding,
          AppRoutes.splash,
        ].contains(state.fullPath);

        if (isLoggedIn && isAuthRoute && state.fullPath != AppRoutes.splash) {
          return AppRoutes.shell;
        }
      }
      return null;
    },
    routes: [
      GoRoute(path: AppRoutes.splash, builder: (_, __) => const SplashScreen()),
      GoRoute(
        path: AppRoutes.onboarding,
        builder: (_, __) => const OnboardingScreen(),
      ),
      GoRoute(path: AppRoutes.login, builder: (_, __) => const LoginScreen()),
      GoRoute(
        path: AppRoutes.register,
        builder: (_, __) => const RegisterScreen(),
      ),
      GoRoute(
        path: AppRoutes.otp,
        builder: (_, state) =>
            OtpScreen(phone: state.uri.queryParameters['phone'] ?? ''),
      ),
      GoRoute(path: AppRoutes.shell, builder: (_, __) => const ShellScreen()),
      GoRoute(
        path: AppRoutes.listingDetail,
        builder: (_, state) =>
            ListingDetailScreen(listingId: state.pathParameters['id']!),
      ),
      GoRoute(
        path: AppRoutes.createListing,
        builder: (_, __) => const CreateListingScreen(),
      ),
      GoRoute(
        path: AppRoutes.editListing,
        builder: (_, state) =>
            CreateListingScreen(editListingId: state.pathParameters['id']),
      ),
      GoRoute(
        path: AppRoutes.booking,
        builder: (_, state) =>
            BookingScreen(listingId: state.pathParameters['listingId']!),
      ),
      GoRoute(
        path: AppRoutes.rentalDetail,
        builder: (_, state) =>
            RentalDetailScreen(rentalId: state.pathParameters['id']!),
      ),
    ],
    errorBuilder: (context, state) =>
        Scaffold(body: Center(child: Text('Page not found: ${state.error}'))),
  );
});
