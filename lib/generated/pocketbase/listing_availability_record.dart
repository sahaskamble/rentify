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

part 'listing_availability_record.g.dart';

enum ListingAvailabilityRecordFieldsEnum {
  id('id'),
  collectionId('collectionId'),
  collectionName('collectionName'),
  listing('listing'),
  unavailableFrom('unavailable_from'),
  unavailableTo('unavailable_to'),
  reason('reason'),
  created('created'),
  updated('updated');

  const ListingAvailabilityRecordFieldsEnum(this.nameInSchema);

  final String nameInSchema;
}

enum ListingAvailabilityRecordReasonEnum {
  @_i1.JsonValue('booked')
  booked('booked'),
  @_i1.JsonValue('maintenance')
  maintenance('maintenance'),
  @_i1.JsonValue('personal')
  personal('personal'),
  @_i1.JsonValue('holiday')
  holiday('holiday');

  const ListingAvailabilityRecordReasonEnum(this.nameInSchema);

  final String nameInSchema;
}

@_i1.JsonSerializable()
final class ListingAvailabilityRecord extends _i2.BaseRecord {
  ListingAvailabilityRecord({
    required super.id,
    required super.collectionId,
    required super.collectionName,
    required this.listing,
    required this.unavailableFrom,
    required this.unavailableTo,
    this.reason,
    this.created,
    this.updated,
  }) : super();

  factory ListingAvailabilityRecord.fromJson(Map<String, dynamic> json) =>
      _$ListingAvailabilityRecordFromJson(json);

  factory ListingAvailabilityRecord.fromRecordModel(
      _i3.RecordModel recordModel) {
    final extendedJsonMap = {
      ...recordModel.data,
      ListingAvailabilityRecordFieldsEnum.id.nameInSchema: recordModel.id,
      ListingAvailabilityRecordFieldsEnum.collectionId.nameInSchema:
          recordModel.collectionId,
      ListingAvailabilityRecordFieldsEnum.collectionName.nameInSchema:
          recordModel.collectionName,
    };
    return ListingAvailabilityRecord.fromJson(extendedJsonMap);
  }

  final String listing;

  @_i1.JsonKey(
    toJson: pocketBaseDateTimeToJson,
    fromJson: pocketBaseDateTimeFromJson,
    name: 'unavailable_from',
  )
  final DateTime unavailableFrom;

  @_i1.JsonKey(
    toJson: pocketBaseDateTimeToJson,
    fromJson: pocketBaseDateTimeFromJson,
    name: 'unavailable_to',
  )
  final DateTime unavailableTo;

  @_i1.JsonKey(unknownEnumValue: _i1.JsonKey.nullForUndefinedEnumValue)
  final ListingAvailabilityRecordReasonEnum? reason;

  final DateTime? created;

  final DateTime? updated;

  static const $collectionId = 'listingavail01a';

  static const $collectionName = 'listing_availability';

  Map<String, dynamic> toJson() => _$ListingAvailabilityRecordToJson(this);

  ListingAvailabilityRecord copyWith({
    String? listing,
    DateTime? unavailableFrom,
    DateTime? unavailableTo,
    ListingAvailabilityRecordReasonEnum? reason,
    DateTime? created,
    DateTime? updated,
  }) {
    return ListingAvailabilityRecord(
      id: id,
      collectionId: collectionId,
      collectionName: collectionName,
      listing: listing ?? this.listing,
      unavailableFrom: unavailableFrom ?? this.unavailableFrom,
      unavailableTo: unavailableTo ?? this.unavailableTo,
      reason: reason ?? this.reason,
      created: created ?? this.created,
      updated: updated ?? this.updated,
    );
  }

  Map<String, dynamic> takeDiff(ListingAvailabilityRecord other) {
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
        unavailableFrom,
        unavailableTo,
        reason,
        created,
        updated,
      ];

  static Map<String, dynamic> forCreateRequest({
    required String listing,
    required DateTime unavailableFrom,
    required DateTime unavailableTo,
    ListingAvailabilityRecordReasonEnum? reason,
    DateTime? created,
    DateTime? updated,
  }) {
    final jsonMap = ListingAvailabilityRecord(
      id: '',
      collectionId: $collectionId,
      collectionName: $collectionName,
      listing: listing,
      unavailableFrom: unavailableFrom,
      unavailableTo: unavailableTo,
      reason: reason,
      created: created,
      updated: updated,
    ).toJson();
    final Map<String, dynamic> result = {};
    result.addAll({
      ListingAvailabilityRecordFieldsEnum.listing.nameInSchema:
          jsonMap[ListingAvailabilityRecordFieldsEnum.listing.nameInSchema]
    });
    result.addAll({
      ListingAvailabilityRecordFieldsEnum.unavailableFrom.nameInSchema: jsonMap[
          ListingAvailabilityRecordFieldsEnum.unavailableFrom.nameInSchema]
    });
    result.addAll({
      ListingAvailabilityRecordFieldsEnum.unavailableTo.nameInSchema: jsonMap[
          ListingAvailabilityRecordFieldsEnum.unavailableTo.nameInSchema]
    });
    if (reason != null) {
      result.addAll({
        ListingAvailabilityRecordFieldsEnum.reason.nameInSchema:
            jsonMap[ListingAvailabilityRecordFieldsEnum.reason.nameInSchema]
      });
    }
    if (created != null) {
      result.addAll({
        ListingAvailabilityRecordFieldsEnum.created.nameInSchema:
            jsonMap[ListingAvailabilityRecordFieldsEnum.created.nameInSchema]
      });
    }
    if (updated != null) {
      result.addAll({
        ListingAvailabilityRecordFieldsEnum.updated.nameInSchema:
            jsonMap[ListingAvailabilityRecordFieldsEnum.updated.nameInSchema]
      });
    }
    return result;
  }
}
