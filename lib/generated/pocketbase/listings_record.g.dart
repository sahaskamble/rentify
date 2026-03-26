// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'listings_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListingsRecord _$ListingsRecordFromJson(Map<String, dynamic> json) =>
    ListingsRecord(
      id: json['id'] as String,
      collectionId: json['collectionId'] as String,
      collectionName: json['collectionName'] as String,
      seller: json['seller'] as String,
      category: json['category'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      condition: $enumDecode(
        _$ListingsRecordConditionEnumEnumMap,
        json['condition'],
      ),
      pricePerDay: (json['price_per_day'] as num).toDouble(),
      securityDeposit: (json['security_deposit'] as num).toDouble(),
      quantity: (json['quantity'] as num).toDouble(),
      images: (json['images'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      status: $enumDecode(_$ListingsRecordStatusEnumEnumMap, json['status']),
      pricePerWeek: (json['price_per_week'] as num?)?.toDouble(),
      pricePerMonth: (json['price_per_month'] as num?)?.toDouble(),
      minRentalDays: (json['min_rental_days'] as num?)?.toDouble(),
      maxRentalDays: (json['max_rental_days'] as num?)?.toDouble(),
      isFeatured: json['is_featured'] as bool,
      avgRating: (json['avg_rating'] as num?)?.toDouble(),
      totalRentals: (json['total_rentals'] as num?)?.toDouble(),
      tags: json['tags'],
      created: json['created'] == null
          ? null
          : DateTime.parse(json['created'] as String),
      updated: json['updated'] == null
          ? null
          : DateTime.parse(json['updated'] as String),
    );

Map<String, dynamic> _$ListingsRecordToJson(ListingsRecord instance) =>
    <String, dynamic>{
      'id': instance.id,
      'collectionId': instance.collectionId,
      'collectionName': instance.collectionName,
      'seller': instance.seller,
      'category': instance.category,
      'title': instance.title,
      'description': instance.description,
      'condition': _$ListingsRecordConditionEnumEnumMap[instance.condition]!,
      'price_per_day': instance.pricePerDay,
      'security_deposit': instance.securityDeposit,
      'quantity': instance.quantity,
      'images': instance.images,
      'status': _$ListingsRecordStatusEnumEnumMap[instance.status]!,
      'price_per_week': instance.pricePerWeek,
      'price_per_month': instance.pricePerMonth,
      'min_rental_days': instance.minRentalDays,
      'max_rental_days': instance.maxRentalDays,
      'is_featured': instance.isFeatured,
      'avg_rating': instance.avgRating,
      'total_rentals': instance.totalRentals,
      'tags': instance.tags,
      'created': instance.created?.toIso8601String(),
      'updated': instance.updated?.toIso8601String(),
    };

const _$ListingsRecordConditionEnumEnumMap = {
  ListingsRecordConditionEnum.likeNew: 'like_new',
  ListingsRecordConditionEnum.good: 'good',
  ListingsRecordConditionEnum.fair: 'fair',
  ListingsRecordConditionEnum.brandNew: 'brand_new',
};

const _$ListingsRecordStatusEnumEnumMap = {
  ListingsRecordStatusEnum.draft: 'draft',
  ListingsRecordStatusEnum.pendingReview: 'pending_review',
  ListingsRecordStatusEnum.active: 'active',
  ListingsRecordStatusEnum.paused: 'paused',
  ListingsRecordStatusEnum.removed: 'removed',
};
