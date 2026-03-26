// GENERATED CODE - DO NOT MODIFY BY HAND
// *****************************************************
// POCKETBASE_UTILS
// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint

// ignore_for_file: unused_import

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:collection/collection.dart' as _i4;
import 'package:json_annotation/json_annotation.dart' as _i1;
import 'package:json_annotation/json_annotation.dart';
import 'package:pocketbase/pocketbase.dart' as _i3;

import 'base_record.dart' as _i2;
import 'date_time_json_methods.dart';
import 'geo_point_class.dart';

part 'seller_profiles_record.g.dart';

enum SellerProfilesRecordFieldsEnum {
  id('id'),
  collectionId('collectionId'),
  collectionName('collectionName'),
  user('user'),
  subscriptionPlan('subscription_plan'),
  businessName('business_name'),
  gstin('gstin'),
  planExpiresAt('plan_expires_at'),
  totalEarnings('total_earnings'),
  avgRating('avg_rating'),
  totalReviews('total_reviews'),
  isActive('is_active'),
  bio('bio'),
  created('created'),
  updated('updated'),
  hidden$bankAccountNumber('bank_account_number'),
  hidden$ifscCode('ifsc_code'),
  hidden$upiId('upi_id');

  const SellerProfilesRecordFieldsEnum(this.nameInSchema);

  final String nameInSchema;
}

enum SellerProfilesRecordSubscription_planEnum {
  @_i1.JsonValue('free')
  free('free'),
  @_i1.JsonValue('basic')
  basic('basic'),
  @_i1.JsonValue('pro')
  pro('pro');

  const SellerProfilesRecordSubscription_planEnum(this.nameInSchema);

  final String nameInSchema;
}

@_i1.JsonSerializable()
final class SellerProfilesRecord extends _i2.BaseRecord {
  SellerProfilesRecord({
    required super.id,
    required super.collectionId,
    required super.collectionName,
    required this.user,
    required this.subscriptionPlan,
    this.businessName,
    this.gstin,
    this.planExpiresAt,
    this.totalEarnings,
    this.avgRating,
    this.totalReviews,
    required this.isActive,
    this.bio,
    this.created,
    this.updated,
  }) : super();

  factory SellerProfilesRecord.fromJson(Map<String, dynamic> json) =>
      _$SellerProfilesRecordFromJson(json);

  factory SellerProfilesRecord.fromRecordModel(_i3.RecordModel recordModel) {
    final extendedJsonMap = {
      ...recordModel.data,
      SellerProfilesRecordFieldsEnum.id.nameInSchema: recordModel.id,
      SellerProfilesRecordFieldsEnum.collectionId.nameInSchema:
          recordModel.collectionId,
      SellerProfilesRecordFieldsEnum.collectionName.nameInSchema:
          recordModel.collectionName,
    };
    return SellerProfilesRecord.fromJson(extendedJsonMap);
  }

  final String user;

  @_i1.JsonKey(name: 'subscription_plan')
  final SellerProfilesRecordSubscription_planEnum subscriptionPlan;

  @_i1.JsonKey(name: 'business_name')
  final String? businessName;

  static const business_nameMinValue = 0;

  static const business_nameMaxValue = 150;

  final String? gstin;

  static const gstinMinValue = 0;

  static const gstinMaxValue = 20;

  @_i1.JsonKey(
    toJson: pocketBaseNullableDateTimeToJson,
    fromJson: pocketBaseNullableDateTimeFromJson,
    name: 'plan_expires_at',
  )
  final DateTime? planExpiresAt;

  @_i1.JsonKey(name: 'total_earnings')
  final double? totalEarnings;

  static const total_earningsMinValue = 0;

  @_i1.JsonKey(name: 'avg_rating')
  final double? avgRating;

  static const avg_ratingMinValue = 0;

  static const avg_ratingMaxValue = 5;

  @_i1.JsonKey(name: 'total_reviews')
  final double? totalReviews;

  static const total_reviewsMinValue = 0;

  @_i1.JsonKey(name: 'is_active')
  final bool isActive;

  final String? bio;

  static const bioMinValue = 0;

  static const bioMaxValue = 500;

  final DateTime? created;

  final DateTime? updated;

  static const $collectionId = 'sellerprofile01';

  static const $collectionName = 'seller_profiles';

  Map<String, dynamic> toJson() => _$SellerProfilesRecordToJson(this);

  SellerProfilesRecord copyWith({
    String? user,
    SellerProfilesRecordSubscription_planEnum? subscriptionPlan,
    String? businessName,
    String? gstin,
    DateTime? planExpiresAt,
    double? totalEarnings,
    double? avgRating,
    double? totalReviews,
    bool? isActive,
    String? bio,
    DateTime? created,
    DateTime? updated,
  }) {
    return SellerProfilesRecord(
      id: id,
      collectionId: collectionId,
      collectionName: collectionName,
      user: user ?? this.user,
      subscriptionPlan: subscriptionPlan ?? this.subscriptionPlan,
      businessName: businessName ?? this.businessName,
      gstin: gstin ?? this.gstin,
      planExpiresAt: planExpiresAt ?? this.planExpiresAt,
      totalEarnings: totalEarnings ?? this.totalEarnings,
      avgRating: avgRating ?? this.avgRating,
      totalReviews: totalReviews ?? this.totalReviews,
      isActive: isActive ?? this.isActive,
      bio: bio ?? this.bio,
      created: created ?? this.created,
      updated: updated ?? this.updated,
    );
  }

  Map<String, dynamic> takeDiff(SellerProfilesRecord other) {
    final thisInJsonMap = toJson();
    final otherInJsonMap = other.toJson();
    final Map<String, dynamic> result = {};
    final _i4.DeepCollectionEquality deepCollectionEquality =
        _i4.DeepCollectionEquality();
    for (final mapEntry in thisInJsonMap.entries) {
      final thisValue = mapEntry.value;
      final otherValue = otherInJsonMap[mapEntry.key];
      if (!deepCollectionEquality.equals(
        thisValue,
        otherValue,
      )) {
        result.addAll({mapEntry.key: otherValue});
      }
    }
    return result;
  }

  @override
  List<Object?> get props => [
        ...super.props,
        user,
        subscriptionPlan,
        businessName,
        gstin,
        planExpiresAt,
        totalEarnings,
        avgRating,
        totalReviews,
        isActive,
        bio,
        created,
        updated,
      ];

  static Map<String, dynamic> forCreateRequest({
    required String user,
    required SellerProfilesRecordSubscription_planEnum subscriptionPlan,
    String? businessName,
    String? gstin,
    DateTime? planExpiresAt,
    double? totalEarnings,
    double? avgRating,
    double? totalReviews,
    required bool isActive,
    String? bio,
    DateTime? created,
    DateTime? updated,
  }) {
    final jsonMap = SellerProfilesRecord(
      id: '',
      collectionId: $collectionId,
      collectionName: $collectionName,
      user: user,
      subscriptionPlan: subscriptionPlan,
      businessName: businessName,
      gstin: gstin,
      planExpiresAt: planExpiresAt,
      totalEarnings: totalEarnings,
      avgRating: avgRating,
      totalReviews: totalReviews,
      isActive: isActive,
      bio: bio,
      created: created,
      updated: updated,
    ).toJson();
    final Map<String, dynamic> result = {};
    result.addAll({
      SellerProfilesRecordFieldsEnum.user.nameInSchema:
          jsonMap[SellerProfilesRecordFieldsEnum.user.nameInSchema]
    });
    result.addAll({
      SellerProfilesRecordFieldsEnum.subscriptionPlan.nameInSchema:
          jsonMap[SellerProfilesRecordFieldsEnum.subscriptionPlan.nameInSchema]
    });
    if (businessName != null) {
      result.addAll({
        SellerProfilesRecordFieldsEnum.businessName.nameInSchema:
            jsonMap[SellerProfilesRecordFieldsEnum.businessName.nameInSchema]
      });
    }
    if (gstin != null) {
      result.addAll({
        SellerProfilesRecordFieldsEnum.gstin.nameInSchema:
            jsonMap[SellerProfilesRecordFieldsEnum.gstin.nameInSchema]
      });
    }
    if (planExpiresAt != null) {
      result.addAll({
        SellerProfilesRecordFieldsEnum.planExpiresAt.nameInSchema:
            jsonMap[SellerProfilesRecordFieldsEnum.planExpiresAt.nameInSchema]
      });
    }
    if (totalEarnings != null) {
      result.addAll({
        SellerProfilesRecordFieldsEnum.totalEarnings.nameInSchema:
            jsonMap[SellerProfilesRecordFieldsEnum.totalEarnings.nameInSchema]
      });
    }
    if (avgRating != null) {
      result.addAll({
        SellerProfilesRecordFieldsEnum.avgRating.nameInSchema:
            jsonMap[SellerProfilesRecordFieldsEnum.avgRating.nameInSchema]
      });
    }
    if (totalReviews != null) {
      result.addAll({
        SellerProfilesRecordFieldsEnum.totalReviews.nameInSchema:
            jsonMap[SellerProfilesRecordFieldsEnum.totalReviews.nameInSchema]
      });
    }
    result.addAll({
      SellerProfilesRecordFieldsEnum.isActive.nameInSchema:
          jsonMap[SellerProfilesRecordFieldsEnum.isActive.nameInSchema]
    });
    if (bio != null) {
      result.addAll({
        SellerProfilesRecordFieldsEnum.bio.nameInSchema:
            jsonMap[SellerProfilesRecordFieldsEnum.bio.nameInSchema]
      });
    }
    if (created != null) {
      result.addAll({
        SellerProfilesRecordFieldsEnum.created.nameInSchema:
            jsonMap[SellerProfilesRecordFieldsEnum.created.nameInSchema]
      });
    }
    if (updated != null) {
      result.addAll({
        SellerProfilesRecordFieldsEnum.updated.nameInSchema:
            jsonMap[SellerProfilesRecordFieldsEnum.updated.nameInSchema]
      });
    }
    return result;
  }
}
