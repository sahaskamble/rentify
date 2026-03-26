// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversations_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConversationsRecord _$ConversationsRecordFromJson(Map<String, dynamic> json) =>
    ConversationsRecord(
      id: json['id'] as String,
      collectionId: json['collectionId'] as String,
      collectionName: json['collectionName'] as String,
      listing: json['listing'] as String,
      renter: json['renter'] as String,
      seller: json['seller'] as String,
      rental: json['rental'] as String?,
      lastMessageAt: pocketBaseNullableDateTimeFromJson(
        json['last_message_at'] as String,
      ),
      renterUnreadCount: (json['renter_unread_count'] as num?)?.toDouble(),
      sellerUnreadCount: (json['seller_unread_count'] as num?)?.toDouble(),
      created: json['created'] == null
          ? null
          : DateTime.parse(json['created'] as String),
      updated: json['updated'] == null
          ? null
          : DateTime.parse(json['updated'] as String),
    );

Map<String, dynamic> _$ConversationsRecordToJson(
  ConversationsRecord instance,
) => <String, dynamic>{
  'id': instance.id,
  'collectionId': instance.collectionId,
  'collectionName': instance.collectionName,
  'listing': instance.listing,
  'renter': instance.renter,
  'seller': instance.seller,
  'rental': instance.rental,
  'last_message_at': pocketBaseNullableDateTimeToJson(instance.lastMessageAt),
  'renter_unread_count': instance.renterUnreadCount,
  'seller_unread_count': instance.sellerUnreadCount,
  'created': instance.created?.toIso8601String(),
  'updated': instance.updated?.toIso8601String(),
};
