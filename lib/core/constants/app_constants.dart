class AppConstants {
  AppConstants._();

  // PocketBase
  static const String pbUrl = 'http://10.0.2.2:8090'; // Android emulator → localhost
  static const String pbUrlLocal = 'http://localhost:8090';

  // Collections
  static const String colUsers = 'users';
  static const String colUserVerifications = 'user_verifications';
  static const String colSellerProfiles = 'seller_profiles';
  static const String colCategories = 'categories';
  static const String colListings = 'listings';
  static const String colListingLocations = 'listing_locations';
  static const String colListingAvailability = 'listing_availability';
  static const String colRentals = 'rentals';
  static const String colPayments = 'payments';
  static const String colPayouts = 'payouts';
  static const String colReviews = 'reviews';
  static const String colConversations = 'conversations';
  static const String colMessages = 'messages';
  static const String colDisputes = 'disputes';
  static const String colListingPromotions = 'listing_promotions';

  // Platform fee (%)
  static const double platformFeePercent = 12.0;

  // Rentify branding
  static const String appName = 'Rentify';
  static const String appTagline = 'Use karo, kharidna zaroori nahi';

  // Shared prefs keys
  static const String prefAuthToken = 'auth_token';
  static const String prefUserId = 'user_id';
}
