// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seller_profiles_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SellerProfilesRecord _$SellerProfilesRecordFromJson(
  Map<String, dynamic> json,
) => SellerProfilesRecord(
  id: json['id'] as String,
  collectionId: json['collectionId'] as String,
  collectionName: json['collectionName'] as String,
  user: json['user'] as String,
  subscriptionPlan: $enumDecode(
    _$SellerProfilesRecordSubscription_planEnumEnumMap,
    json['subscription_plan'],
  ),
  businessName: json['business_name'] as String?,
  gstin: json['gstin'] as String?,
  planExpiresAt: pocketBaseNullableDateTimeFromJson(
    json['plan_expires_at'] as String,
  ),
  totalEarnings: (json['total_earnings'] as num?)?.toDouble(),
  avgRating: (json['avg_rating'] as num?)?.toDouble(),
  totalReviews: (json['total_reviews'] as num?)?.toDouble(),
  isActive: json['is_active'] as bool,
  bio: json['bio'] as String?,
  created: json['created'] == null
      ? null
      : DateTime.parse(json['created'] as String),
  updated: json['updated'] == null
      ? null
      : DateTime.parse(json['updated'] as String),
);

Map<String, dynamic> _$SellerProfilesRecordToJson(
  SellerProfilesRecord instance,
) => <String, dynamic>{
  'id': instance.id,
  'collectionId': instance.collectionId,
  'collectionName': instance.collectionName,
  'user': instance.user,
  'subscription_plan':
      _$SellerProfilesRecordSubscription_planEnumEnumMap[instance
          .subscriptionPlan]!,
  'business_name': instance.businessName,
  'gstin': instance.gstin,
  'plan_expires_at': pocketBaseNullableDateTimeToJson(instance.planExpiresAt),
  'total_earnings': instance.totalEarnings,
  'avg_rating': instance.avgRating,
  'total_reviews': instance.totalReviews,
  'is_active': instance.isActive,
  'bio': instance.bio,
  'created': instance.created?.toIso8601String(),
  'updated': instance.updated?.toIso8601String(),
};

const _$SellerProfilesRecordSubscription_planEnumEnumMap = {
  SellerProfilesRecordSubscription_planEnum.free: 'free',
  SellerProfilesRecordSubscription_planEnum.basic: 'basic',
  SellerProfilesRecordSubscription_planEnum.pro: 'pro',
};
