// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reviews_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewsRecord _$ReviewsRecordFromJson(Map<String, dynamic> json) =>
    ReviewsRecord(
      id: json['id'] as String,
      collectionId: json['collectionId'] as String,
      collectionName: json['collectionName'] as String,
      rental: json['rental'] as String,
      reviewer: json['reviewer'] as String,
      reviewee: json['reviewee'] as String,
      listing: json['listing'] as String,
      type: $enumDecode(_$ReviewsRecordTypeEnumEnumMap, json['type']),
      rating: (json['rating'] as num).toDouble(),
      comment: json['comment'] as String?,
      isVisible: json['is_visible'] as bool,
      created: json['created'] == null
          ? null
          : DateTime.parse(json['created'] as String),
      updated: json['updated'] == null
          ? null
          : DateTime.parse(json['updated'] as String),
    );

Map<String, dynamic> _$ReviewsRecordToJson(ReviewsRecord instance) =>
    <String, dynamic>{
      'id': instance.id,
      'collectionId': instance.collectionId,
      'collectionName': instance.collectionName,
      'rental': instance.rental,
      'reviewer': instance.reviewer,
      'reviewee': instance.reviewee,
      'listing': instance.listing,
      'type': _$ReviewsRecordTypeEnumEnumMap[instance.type]!,
      'rating': instance.rating,
      'comment': instance.comment,
      'is_visible': instance.isVisible,
      'created': instance.created?.toIso8601String(),
      'updated': instance.updated?.toIso8601String(),
    };

const _$ReviewsRecordTypeEnumEnumMap = {
  ReviewsRecordTypeEnum.renterToSeller: 'renter_to_seller',
  ReviewsRecordTypeEnum.sellerToRenter: 'seller_to_renter',
};
