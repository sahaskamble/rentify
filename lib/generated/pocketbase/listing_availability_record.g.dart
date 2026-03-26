// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'listing_availability_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListingAvailabilityRecord _$ListingAvailabilityRecordFromJson(
  Map<String, dynamic> json,
) => ListingAvailabilityRecord(
  id: json['id'] as String,
  collectionId: json['collectionId'] as String,
  collectionName: json['collectionName'] as String,
  listing: json['listing'] as String,
  unavailableFrom: pocketBaseDateTimeFromJson(
    json['unavailable_from'] as String,
  ),
  unavailableTo: pocketBaseDateTimeFromJson(json['unavailable_to'] as String),
  reason: $enumDecodeNullable(
    _$ListingAvailabilityRecordReasonEnumEnumMap,
    json['reason'],
    unknownValue: JsonKey.nullForUndefinedEnumValue,
  ),
  created: json['created'] == null
      ? null
      : DateTime.parse(json['created'] as String),
  updated: json['updated'] == null
      ? null
      : DateTime.parse(json['updated'] as String),
);

Map<String, dynamic> _$ListingAvailabilityRecordToJson(
  ListingAvailabilityRecord instance,
) => <String, dynamic>{
  'id': instance.id,
  'collectionId': instance.collectionId,
  'collectionName': instance.collectionName,
  'listing': instance.listing,
  'unavailable_from': pocketBaseDateTimeToJson(instance.unavailableFrom),
  'unavailable_to': pocketBaseDateTimeToJson(instance.unavailableTo),
  'reason': _$ListingAvailabilityRecordReasonEnumEnumMap[instance.reason],
  'created': instance.created?.toIso8601String(),
  'updated': instance.updated?.toIso8601String(),
};

const _$ListingAvailabilityRecordReasonEnumEnumMap = {
  ListingAvailabilityRecordReasonEnum.booked: 'booked',
  ListingAvailabilityRecordReasonEnum.maintenance: 'maintenance',
  ListingAvailabilityRecordReasonEnum.personal: 'personal',
  ListingAvailabilityRecordReasonEnum.holiday: 'holiday',
};
