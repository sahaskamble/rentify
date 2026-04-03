import 'package:rentify/generated/pocketbase/seller_profiles_record.dart';
import 'package:rentify/generated/pocketbase/users_record.dart';
import 'package:rentify/generated/pocketbase/reviews_record.dart';
import 'package:rentify/services/pocketbase_service.dart';

class ProfileService {
  final pb = PocketBaseService().pb;

  /// Get seller profile for current user
  Future<SellerProfilesRecord?> getSellerProfile(String userId) async {
    try {
      final result = await pb
          .collection('seller_profiles')
          .getList(filter: "user = '$userId'", perPage: 1);

      if (result.items.isEmpty) return null;
      return SellerProfilesRecord.fromRecordModel(result.items.first);
    } catch (e) {
      return null;
    }
  }

  /// Get total active listings for user
  Future<int> getTotalListings(String userId) async {
    try {
      final result = await pb
          .collection('listings')
          .getList(
            filter: "seller = '$userId' && status = 'active'",
            perPage: 1,
          );
      return result.totalItems;
    } catch (e) {
      return 0;
    }
  }

  /// Get total rentals for user (as renter)
  Future<int> getTotalRentals(String userId) async {
    try {
      final result = await pb
          .collection('rentals')
          .getList(filter: "renter = '$userId'", perPage: 1);
      return result.totalItems;
    } catch (e) {
      return 0;
    }
  }

  /// Get reviews for user (as seller)
  Future<List<ReviewsRecord>> getSellerReviews(String userId) async {
    try {
      final result = await pb
          .collection('reviews')
          .getList(
            filter: "seller = '$userId'",
            sort: '-created',
            perPage: 100,
          );
      return result.items.map((e) => ReviewsRecord.fromRecordModel(e)).toList();
    } catch (e) {
      return [];
    }
  }

  /// Calculate average rating from reviews
  Future<double> getAverageRating(String userId) async {
    try {
      final reviews = await getSellerReviews(userId);

      if (reviews.isEmpty) return 0.0;

      final sum = reviews.fold<double>(
        0.0,
        (acc, review) => acc + (review.rating ?? 0.0),
      );
      return sum / reviews.length;
    } catch (e) {
      return 0.0;
    }
  }

  /// Update user profile
  Future<UsersRecord> updateUserProfile({
    required String userId,
    String? name,
    String? phone,
    String? email,
  }) async {
    try {
      final body = <String, dynamic>{};
      if (name != null) body['name'] = name;
      if (phone != null) body['phone'] = phone;
      if (email != null) body['email'] = email;

      final result = await pb.collection('users').update(userId, body: body);
      return UsersRecord.fromRecordModel(result);
    } catch (e) {
      rethrow;
    }
  }

  /// Update seller profile
  Future<SellerProfilesRecord> updateSellerProfile({
    required String sellerProfileId,
    String? city,
    String? state,
    String? country,
    String? businessName,
  }) async {
    try {
      final body = <String, dynamic>{};
      if (city != null) body['city'] = city;
      if (state != null) body['state'] = state;
      if (country != null) body['country'] = country;
      if (businessName != null) body['business_name'] = businessName;

      final result = await pb
          .collection('seller_profiles')
          .update(sellerProfileId, body: body);
      return SellerProfilesRecord.fromRecordModel(result);
    } catch (e) {
      rethrow;
    }
  }
}
