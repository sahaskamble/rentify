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

part 'listing_locations_record.g.dart';

enum ListingLocationsRecordFieldsEnum {
  id('id'),
  collectionId('collectionId'),
  collectionName('collectionName'),
  listing('listing'),
  addressLine('address_line'),
  area('area'),
  city('city'),
  pincode('pincode'),
  lat('lat'),
  lng('lng'),
  deliveryAvailable('delivery_available'),
  deliveryRadiusKm('delivery_radius_km'),
  deliveryChargePerKm('delivery_charge_per_km'),
  created('created'),
  updated('updated');

  const ListingLocationsRecordFieldsEnum(this.nameInSchema);

  final String nameInSchema;
}

@_i1.JsonSerializable()
final class ListingLocationsRecord extends _i2.BaseRecord {
  ListingLocationsRecord({
    required super.id,
    required super.collectionId,
    required super.collectionName,
    required this.listing,
    required this.addressLine,
    required this.area,
    required this.city,
    required this.pincode,
    required this.lat,
    required this.lng,
    required this.deliveryAvailable,
    this.deliveryRadiusKm,
    this.deliveryChargePerKm,
    this.created,
    this.updated,
  }) : super();

  factory ListingLocationsRecord.fromJson(Map<String, dynamic> json) =>
      _$ListingLocationsRecordFromJson(json);

  factory ListingLocationsRecord.fromRecordModel(_i3.RecordModel recordModel) {
    final extendedJsonMap = {
      ...recordModel.data,
      ListingLocationsRecordFieldsEnum.id.nameInSchema: recordModel.id,
      ListingLocationsRecordFieldsEnum.collectionId.nameInSchema:
          recordModel.collectionId,
      ListingLocationsRecordFieldsEnum.collectionName.nameInSchema:
          recordModel.collectionName,
    };
    return ListingLocationsRecord.fromJson(extendedJsonMap);
  }

  final String listing;

  @_i1.JsonKey(name: 'address_line')
  final String addressLine;

  static const address_lineMinValue = 0;

  static const address_lineMaxValue = 300;

  final String area;

  static const areaMinValue = 0;

  static const areaMaxValue = 100;

  final String city;

  static const cityMinValue = 0;

  static const cityMaxValue = 100;

  final String pincode;

  static const pincodeMinValue = 6;

  static const pincodeMaxValue = 6;

  final double lat;

  static const latMinValue = -90;

  static const latMaxValue = 90;

  final double lng;

  static const lngMinValue = -180;

  static const lngMaxValue = 180;

  @_i1.JsonKey(name: 'delivery_available')
  final bool deliveryAvailable;

  @_i1.JsonKey(name: 'delivery_radius_km')
  final double? deliveryRadiusKm;

  static const delivery_radius_kmMinValue = 1;

  static const delivery_radius_kmMaxValue = 100;

  @_i1.JsonKey(name: 'delivery_charge_per_km')
  final double? deliveryChargePerKm;

  static const delivery_charge_per_kmMinValue = 0;

  final DateTime? created;

  final DateTime? updated;

  static const $collectionId = 'listingloc0001a';

  static const $collectionName = 'listing_locations';

  Map<String, dynamic> toJson() => _$ListingLocationsRecordToJson(this);

  ListingLocationsRecord copyWith({
    String? listing,
    String? addressLine,
    String? area,
    String? city,
    String? pincode,
    double? lat,
    double? lng,
    bool? deliveryAvailable,
    double? deliveryRadiusKm,
    double? deliveryChargePerKm,
    DateTime? created,
    DateTime? updated,
  }) {
    return ListingLocationsRecord(
      id: id,
      collectionId: collectionId,
      collectionName: collectionName,
      listing: listing ?? this.listing,
      addressLine: addressLine ?? this.addressLine,
      area: area ?? this.area,
      city: city ?? this.city,
      pincode: pincode ?? this.pincode,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      deliveryAvailable: deliveryAvailable ?? this.deliveryAvailable,
      deliveryRadiusKm: deliveryRadiusKm ?? this.deliveryRadiusKm,
      deliveryChargePerKm: deliveryChargePerKm ?? this.deliveryChargePerKm,
      created: created ?? this.created,
      updated: updated ?? this.updated,
    );
  }

  Map<String, dynamic> takeDiff(ListingLocationsRecord other) {
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
        listing,
        addressLine,
        area,
        city,
        pincode,
        lat,
        lng,
        deliveryAvailable,
        deliveryRadiusKm,
        deliveryChargePerKm,
        created,
        updated,
      ];

  static Map<String, dynamic> forCreateRequest({
    required String listing,
    required String addressLine,
    required String area,
    required String city,
    required String pincode,
    required double lat,
    required double lng,
    required bool deliveryAvailable,
    double? deliveryRadiusKm,
    double? deliveryChargePerKm,
    DateTime? created,
    DateTime? updated,
  }) {
    final jsonMap = ListingLocationsRecord(
      id: '',
      collectionId: $collectionId,
      collectionName: $collectionName,
      listing: listing,
      addressLine: addressLine,
      area: area,
      city: city,
      pincode: pincode,
      lat: lat,
      lng: lng,
      deliveryAvailable: deliveryAvailable,
      deliveryRadiusKm: deliveryRadiusKm,
      deliveryChargePerKm: deliveryChargePerKm,
      created: created,
      updated: updated,
    ).toJson();
    final Map<String, dynamic> result = {};
    result.addAll({
      ListingLocationsRecordFieldsEnum.listing.nameInSchema:
          jsonMap[ListingLocationsRecordFieldsEnum.listing.nameInSchema]
    });
    result.addAll({
      ListingLocationsRecordFieldsEnum.addressLine.nameInSchema:
          jsonMap[ListingLocationsRecordFieldsEnum.addressLine.nameInSchema]
    });
    result.addAll({
      ListingLocationsRecordFieldsEnum.area.nameInSchema:
          jsonMap[ListingLocationsRecordFieldsEnum.area.nameInSchema]
    });
    result.addAll({
      ListingLocationsRecordFieldsEnum.city.nameInSchema:
          jsonMap[ListingLocationsRecordFieldsEnum.city.nameInSchema]
    });
    result.addAll({
      ListingLocationsRecordFieldsEnum.pincode.nameInSchema:
          jsonMap[ListingLocationsRecordFieldsEnum.pincode.nameInSchema]
    });
    result.addAll({
      ListingLocationsRecordFieldsEnum.lat.nameInSchema:
          jsonMap[ListingLocationsRecordFieldsEnum.lat.nameInSchema]
    });
    result.addAll({
      ListingLocationsRecordFieldsEnum.lng.nameInSchema:
          jsonMap[ListingLocationsRecordFieldsEnum.lng.nameInSchema]
    });
    result.addAll({
      ListingLocationsRecordFieldsEnum.deliveryAvailable.nameInSchema: jsonMap[
          ListingLocationsRecordFieldsEnum.deliveryAvailable.nameInSchema]
    });
    if (deliveryRadiusKm != null) {
      result.addAll({
        ListingLocationsRecordFieldsEnum.deliveryRadiusKm.nameInSchema: jsonMap[
            ListingLocationsRecordFieldsEnum.deliveryRadiusKm.nameInSchema]
      });
    }
    if (deliveryChargePerKm != null) {
      result.addAll({
        ListingLocationsRecordFieldsEnum.deliveryChargePerKm.nameInSchema:
            jsonMap[ListingLocationsRecordFieldsEnum
                .deliveryChargePerKm.nameInSchema]
      });
    }
    if (created != null) {
      result.addAll({
        ListingLocationsRecordFieldsEnum.created.nameInSchema:
            jsonMap[ListingLocationsRecordFieldsEnum.created.nameInSchema]
      });
    }
    if (updated != null) {
      result.addAll({
        ListingLocationsRecordFieldsEnum.updated.nameInSchema:
            jsonMap[ListingLocationsRecordFieldsEnum.updated.nameInSchema]
      });
    }
    return result;
  }
}
