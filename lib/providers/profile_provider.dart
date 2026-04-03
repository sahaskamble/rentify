import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rentify/generated/pocketbase/seller_profiles_record.dart';
import 'package:rentify/generated/pocketbase/reviews_record.dart';
import 'package:rentify/services/profile_service.dart';
import 'package:rentify/providers/auth_provider.dart';

final profileServiceProvider = Provider((ref) => ProfileService());

/// Get seller profile for authenticated user
final sellerProfileProvider = FutureProvider<SellerProfilesRecord?>((
  ref,
) async {
  final authState = ref.watch(authStateProvider);
  final user = authState.user;

  if (user == null) return null;

  final service = ref.watch(profileServiceProvider);
  return service.getSellerProfile(user.id);
});

/// Get total listings count for authenticated user
final totalListingsProvider = FutureProvider<int>((ref) async {
  final authState = ref.watch(authStateProvider);
  final user = authState.user;

  if (user == null) return 0;

  final service = ref.watch(profileServiceProvider);
  return service.getTotalListings(user.id);
});

/// Get total rentals count for authenticated user
final totalRentalsProvider = FutureProvider<int>((ref) async {
  final authState = ref.watch(authStateProvider);
  final user = authState.user;

  if (user == null) return 0;

  final service = ref.watch(profileServiceProvider);
  return service.getTotalRentals(user.id);
});

/// Get seller reviews for authenticated user
final sellerReviewsProvider = FutureProvider<List<ReviewsRecord>>((ref) async {
  final authState = ref.watch(authStateProvider);
  final user = authState.user;

  if (user == null) return [];

  final service = ref.watch(profileServiceProvider);
  return service.getSellerReviews(user.id);
});

/// Calculate average rating from reviews
final averageRatingProvider = FutureProvider<double>((ref) async {
  final reviews = await ref.watch(sellerReviewsProvider.future);

  if (reviews.isEmpty) return 0.0;

  final sum = reviews.fold<double>(
    0.0,
    (acc, review) => acc + (review.rating ?? 0.0),
  );
  return sum / reviews.length;
});

/// Get total reviews count
final totalReviewsProvider = FutureProvider<int>((ref) async {
  final reviews = await ref.watch(sellerReviewsProvider.future);
  return reviews.length;
});
