// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'listing_locations_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListingLocationsRecord _$ListingLocationsRecordFromJson(
  Map<String, dynamic> json,
) => ListingLocationsRecord(
  id: json['id'] as String,
  collectionId: json['collectionId'] as String,
  collectionName: json['collectionName'] as String,
  listing: json['listing'] as String,
  addressLine: json['address_line'] as String,
  area: json['area'] as String,
  city: json['city'] as String,
  pincode: json['pincode'] as String,
  lat: (json['lat'] as num).toDouble(),
  lng: (json['lng'] as num).toDouble(),
  deliveryAvailable: json['delivery_available'] as bool,
  deliveryRadiusKm: (json['delivery_radius_km'] as num?)?.toDouble(),
  deliveryChargePerKm: (json['delivery_charge_per_km'] as num?)?.toDouble(),
  created: json['created'] == null
      ? null
      : DateTime.parse(json['created'] as String),
  updated: json['updated'] == null
      ? null
      : DateTime.parse(json['updated'] as String),
);

Map<String, dynamic> _$ListingLocationsRecordToJson(
  ListingLocationsRecord instance,
) => <String, dynamic>{
  'id': instance.id,
  'collectionId': instance.collectionId,
  'collectionName': instance.collectionName,
  'listing': instance.listing,
  'address_line': instance.addressLine,
  'area': instance.area,
  'city': instance.city,
  'pincode': instance.pincode,
  'lat': instance.lat,
  'lng': instance.lng,
  'delivery_available': instance.deliveryAvailable,
  'delivery_radius_km': instance.deliveryRadiusKm,
  'delivery_charge_per_km': instance.deliveryChargePerKm,
  'created': instance.created?.toIso8601String(),
  'updated': instance.updated?.toIso8601String(),
};
