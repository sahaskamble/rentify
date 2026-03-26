// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'listing_promotions_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListingPromotionsRecord _$ListingPromotionsRecordFromJson(
  Map<String, dynamic> json,
) => ListingPromotionsRecord(
  id: json['id'] as String,
  collectionId: json['collectionId'] as String,
  collectionName: json['collectionName'] as String,
  listing: json['listing'] as String,
  seller: json['seller'] as String,
  plan: $enumDecode(_$ListingPromotionsRecordPlanEnumEnumMap, json['plan']),
  amountPaid: (json['amount_paid'] as num).toDouble(),
  startsAt: pocketBaseDateTimeFromJson(json['starts_at'] as String),
  endsAt: pocketBaseDateTimeFromJson(json['ends_at'] as String),
  status: $enumDecode(
    _$ListingPromotionsRecordStatusEnumEnumMap,
    json['status'],
  ),
  payment: json['payment'] as String?,
  created: json['created'] == null
      ? null
      : DateTime.parse(json['created'] as String),
  updated: json['updated'] == null
      ? null
      : DateTime.parse(json['updated'] as String),
);

Map<String, dynamic> _$ListingPromotionsRecordToJson(
  ListingPromotionsRecord instance,
) => <String, dynamic>{
  'id': instance.id,
  'collectionId': instance.collectionId,
  'collectionName': instance.collectionName,
  'listing': instance.listing,
  'seller': instance.seller,
  'plan': _$ListingPromotionsRecordPlanEnumEnumMap[instance.plan]!,
  'amount_paid': instance.amountPaid,
  'starts_at': pocketBaseDateTimeToJson(instance.startsAt),
  'ends_at': pocketBaseDateTimeToJson(instance.endsAt),
  'status': _$ListingPromotionsRecordStatusEnumEnumMap[instance.status]!,
  'payment': instance.payment,
  'created': instance.created?.toIso8601String(),
  'updated': instance.updated?.toIso8601String(),
};

const _$ListingPromotionsRecordPlanEnumEnumMap = {
  ListingPromotionsRecordPlanEnum.featured24h: 'featured_24h',
  ListingPromotionsRecordPlanEnum.featured7d: 'featured_7d',
  ListingPromotionsRecordPlanEnum.topCategory7d: 'top_category_7d',
  ListingPromotionsRecordPlanEnum.topCategory30d: 'top_category_30d',
};

const _$ListingPromotionsRecordStatusEnumEnumMap = {
  ListingPromotionsRecordStatusEnum.active: 'active',
  ListingPromotionsRecordStatusEnum.expired: 'expired',
  ListingPromotionsRecordStatusEnum.cancelled: 'cancelled',
};
