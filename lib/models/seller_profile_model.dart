import 'package:pocketbase/pocketbase.dart';

class SellerProfileModel {
  final String id;
  final String userId;
  final String? businessName;
  final String? gstin;
  final String subscriptionPlan;
  final DateTime? planExpiresAt;
  final double totalEarnings;
  final double avgRating;
  final int totalReviews;
  final bool isActive;
  final String? bio;
  final DateTime created;
  final DateTime updated;

  SellerProfileModel({
    required this.id,
    required this.userId,
    this.businessName,
    this.gstin,
    required this.subscriptionPlan,
    this.planExpiresAt,
    this.totalEarnings = 0.0,
    this.avgRating = 0.0,
    this.totalReviews = 0,
    this.isActive = true,
    this.bio,
    required this.created,
    required this.updated,
  });

  factory SellerProfileModel.fromPocketBase(RecordModel record) {
    return SellerProfileModel(
      id: record.id,
      userId: record.getStringValue('user') as String? ?? '',
      businessName: record.getStringValue('business_name'),
      gstin: record.getStringValue('gstin'),
      subscriptionPlan:
          record.getStringValue('subscription_plan') as String? ?? 'free',
      planExpiresAt: _parseDateTimeNullable(record.data['plan_expires_at']),
      totalEarnings: record.getDoubleValue('total_earnings') as double? ?? 0.0,
      avgRating: record.getDoubleValue('avg_rating') as double? ?? 0.0,
      totalReviews: record.getIntValue('total_reviews') as int? ?? 0,
      isActive: record.getBoolValue('is_active') as bool? ?? true,
      bio: record.getStringValue('bio'),
      created: _parseDateTime(record.data['created']),
      updated: _parseDateTime(record.data['updated']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': userId,
      'business_name': businessName,
      'gstin': gstin,
      'subscription_plan': subscriptionPlan,
      'plan_expires_at': planExpiresAt?.toIso8601String(),
      'total_earnings': totalEarnings,
      'avg_rating': avgRating,
      'total_reviews': totalReviews,
      'is_active': isActive,
      'bio': bio,
    };
  }

  static DateTime _parseDateTime(dynamic value) {
    if (value is String) {
      return DateTime.parse(value);
    }
    return DateTime.now();
  }

  static DateTime? _parseDateTimeNullable(dynamic value) {
    if (value is String) {
      return DateTime.parse(value);
    }
    return null;
  }
}
