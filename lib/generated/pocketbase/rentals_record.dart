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

part 'rentals_record.g.dart';

enum RentalsRecordFieldsEnum {
  id('id'),
  collectionId('collectionId'),
  collectionName('collectionName'),
  listing('listing'),
  renter('renter'),
  seller('seller'),
  startDate('start_date'),
  endDate('end_date'),
  totalDays('total_days'),
  baseAmount('base_amount'),
  platformFee('platform_fee'),
  securityDeposit('security_deposit'),
  totalAmount('total_amount'),
  status('status'),
  pickupType('pickup_type'),
  deliveryCharge('delivery_charge'),
  pickupAddress('pickup_address'),
  renterNotes('renter_notes'),
  cancellationReason('cancellation_reason'),
  created('created'),
  updated('updated');

  const RentalsRecordFieldsEnum(this.nameInSchema);

  final String nameInSchema;
}

enum RentalsRecordStatusEnum {
  @_i1.JsonValue('pending')
  pending('pending'),
  @_i1.JsonValue('confirmed')
  confirmed('confirmed'),
  @_i1.JsonValue('active')
  active('active'),
  @_i1.JsonValue('completed')
  completed('completed'),
  @_i1.JsonValue('cancelled')
  cancelled('cancelled'),
  @_i1.JsonValue('disputed')
  disputed('disputed');

  const RentalsRecordStatusEnum(this.nameInSchema);

  final String nameInSchema;
}

enum RentalsRecordPickup_typeEnum {
  @_i1.JsonValue('self_pickup')
  selfPickup('self_pickup'),
  @_i1.JsonValue('delivery')
  delivery('delivery');

  const RentalsRecordPickup_typeEnum(this.nameInSchema);

  final String nameInSchema;
}

@_i1.JsonSerializable()
final class RentalsRecord extends _i2.BaseRecord {
  RentalsRecord({
    required super.id,
    required super.collectionId,
    required super.collectionName,
    required this.listing,
    required this.renter,
    required this.seller,
    required this.startDate,
    required this.endDate,
    required this.totalDays,
    required this.baseAmount,
    required this.platformFee,
    required this.securityDeposit,
    required this.totalAmount,
    required this.status,
    required this.pickupType,
    this.deliveryCharge,
    this.pickupAddress,
    this.renterNotes,
    this.cancellationReason,
    this.created,
    this.updated,
  }) : super();

  factory RentalsRecord.fromJson(Map<String, dynamic> json) =>
      _$RentalsRecordFromJson(json);

  factory RentalsRecord.fromRecordModel(_i3.RecordModel recordModel) {
    final extendedJsonMap = {
      ...recordModel.data,
      RentalsRecordFieldsEnum.id.nameInSchema: recordModel.id,
      RentalsRecordFieldsEnum.collectionId.nameInSchema:
          recordModel.collectionId,
      RentalsRecordFieldsEnum.collectionName.nameInSchema:
          recordModel.collectionName,
    };
    return RentalsRecord.fromJson(extendedJsonMap);
  }

  final String listing;

  final String renter;

  final String seller;

  @_i1.JsonKey(
    toJson: pocketBaseDateTimeToJson,
    fromJson: pocketBaseDateTimeFromJson,
    name: 'start_date',
  )
  final DateTime startDate;

  @_i1.JsonKey(
    toJson: pocketBaseDateTimeToJson,
    fromJson: pocketBaseDateTimeFromJson,
    name: 'end_date',
  )
  final DateTime endDate;

  @_i1.JsonKey(name: 'total_days')
  final double totalDays;

  static const total_daysMinValue = 1;

  @_i1.JsonKey(name: 'base_amount')
  final double baseAmount;

  static const base_amountMinValue = 0;

  @_i1.JsonKey(name: 'platform_fee')
  final double platformFee;

  static const platform_feeMinValue = 0;

  @_i1.JsonKey(name: 'security_deposit')
  final double securityDeposit;

  static const security_depositMinValue = 0;

  @_i1.JsonKey(name: 'total_amount')
  final double totalAmount;

  static const total_amountMinValue = 0;

  final RentalsRecordStatusEnum status;

  @_i1.JsonKey(name: 'pickup_type')
  final RentalsRecordPickup_typeEnum pickupType;

  @_i1.JsonKey(name: 'delivery_charge')
  final double? deliveryCharge;

  static const delivery_chargeMinValue = 0;

  @_i1.JsonKey(name: 'pickup_address')
  final String? pickupAddress;

  static const pickup_addressMinValue = 0;

  static const pickup_addressMaxValue = 400;

  @_i1.JsonKey(name: 'renter_notes')
  final String? renterNotes;

  static const renter_notesMinValue = 0;

  static const renter_notesMaxValue = 500;

  @_i1.JsonKey(name: 'cancellation_reason')
  final String? cancellationReason;

  static const cancellation_reasonMinValue = 0;

  static const cancellation_reasonMaxValue = 500;

  final DateTime? created;

  final DateTime? updated;

  static const $collectionId = 'rental00001ab12';

  static const $collectionName = 'rentals';

  Map<String, dynamic> toJson() => _$RentalsRecordToJson(this);

  RentalsRecord copyWith({
    String? listing,
    String? renter,
    String? seller,
    DateTime? startDate,
    DateTime? endDate,
    double? totalDays,
    double? baseAmount,
    double? platformFee,
    double? securityDeposit,
    double? totalAmount,
    RentalsRecordStatusEnum? status,
    RentalsRecordPickup_typeEnum? pickupType,
    double? deliveryCharge,
    String? pickupAddress,
    String? renterNotes,
    String? cancellationReason,
    DateTime? created,
    DateTime? updated,
  }) {
    return RentalsRecord(
      id: id,
      collectionId: collectionId,
      collectionName: collectionName,
      listing: listing ?? this.listing,
      renter: renter ?? this.renter,
      seller: seller ?? this.seller,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      totalDays: totalDays ?? this.totalDays,
      baseAmount: baseAmount ?? this.baseAmount,
      platformFee: platformFee ?? this.platformFee,
      securityDeposit: securityDeposit ?? this.securityDeposit,
      totalAmount: totalAmount ?? this.totalAmount,
      status: status ?? this.status,
      pickupType: pickupType ?? this.pickupType,
      deliveryCharge: deliveryCharge ?? this.deliveryCharge,
      pickupAddress: pickupAddress ?? this.pickupAddress,
      renterNotes: renterNotes ?? this.renterNotes,
      cancellationReason: cancellationReason ?? this.cancellationReason,
      created: created ?? this.created,
      updated: updated ?? this.updated,
    );
  }

  Map<String, dynamic> takeDiff(RentalsRecord other) {
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
        renter,
        seller,
        startDate,
        endDate,
        totalDays,
        baseAmount,
        platformFee,
        securityDeposit,
        totalAmount,
        status,
        pickupType,
        deliveryCharge,
        pickupAddress,
        renterNotes,
        cancellationReason,
        created,
        updated,
      ];

  static Map<String, dynamic> forCreateRequest({
    required String listing,
    required String renter,
    required String seller,
    required DateTime startDate,
    required DateTime endDate,
    required double totalDays,
    required double baseAmount,
    required double platformFee,
    required double securityDeposit,
    required double totalAmount,
    required RentalsRecordStatusEnum status,
    required RentalsRecordPickup_typeEnum pickupType,
    double? deliveryCharge,
    String? pickupAddress,
    String? renterNotes,
    String? cancellationReason,
    DateTime? created,
    DateTime? updated,
  }) {
    final jsonMap = RentalsRecord(
      id: '',
      collectionId: $collectionId,
      collectionName: $collectionName,
      listing: listing,
      renter: renter,
      seller: seller,
      startDate: startDate,
      endDate: endDate,
      totalDays: totalDays,
      baseAmount: baseAmount,
      platformFee: platformFee,
      securityDeposit: securityDeposit,
      totalAmount: totalAmount,
      status: status,
      pickupType: pickupType,
      deliveryCharge: deliveryCharge,
      pickupAddress: pickupAddress,
      renterNotes: renterNotes,
      cancellationReason: cancellationReason,
      created: created,
      updated: updated,
    ).toJson();
    final Map<String, dynamic> result = {};
    result.addAll({
      RentalsRecordFieldsEnum.listing.nameInSchema:
          jsonMap[RentalsRecordFieldsEnum.listing.nameInSchema]
    });
    result.addAll({
      RentalsRecordFieldsEnum.renter.nameInSchema:
          jsonMap[RentalsRecordFieldsEnum.renter.nameInSchema]
    });
    result.addAll({
      RentalsRecordFieldsEnum.seller.nameInSchema:
          jsonMap[RentalsRecordFieldsEnum.seller.nameInSchema]
    });
    result.addAll({
      RentalsRecordFieldsEnum.startDate.nameInSchema:
          jsonMap[RentalsRecordFieldsEnum.startDate.nameInSchema]
    });
    result.addAll({
      RentalsRecordFieldsEnum.endDate.nameInSchema:
          jsonMap[RentalsRecordFieldsEnum.endDate.nameInSchema]
    });
    result.addAll({
      RentalsRecordFieldsEnum.totalDays.nameInSchema:
          jsonMap[RentalsRecordFieldsEnum.totalDays.nameInSchema]
    });
    result.addAll({
      RentalsRecordFieldsEnum.baseAmount.nameInSchema:
          jsonMap[RentalsRecordFieldsEnum.baseAmount.nameInSchema]
    });
    result.addAll({
      RentalsRecordFieldsEnum.platformFee.nameInSchema:
          jsonMap[RentalsRecordFieldsEnum.platformFee.nameInSchema]
    });
    result.addAll({
      RentalsRecordFieldsEnum.securityDeposit.nameInSchema:
          jsonMap[RentalsRecordFieldsEnum.securityDeposit.nameInSchema]
    });
    result.addAll({
      RentalsRecordFieldsEnum.totalAmount.nameInSchema:
          jsonMap[RentalsRecordFieldsEnum.totalAmount.nameInSchema]
    });
    result.addAll({
      RentalsRecordFieldsEnum.status.nameInSchema:
          jsonMap[RentalsRecordFieldsEnum.status.nameInSchema]
    });
    result.addAll({
      RentalsRecordFieldsEnum.pickupType.nameInSchema:
          jsonMap[RentalsRecordFieldsEnum.pickupType.nameInSchema]
    });
    if (deliveryCharge != null) {
      result.addAll({
        RentalsRecordFieldsEnum.deliveryCharge.nameInSchema:
            jsonMap[RentalsRecordFieldsEnum.deliveryCharge.nameInSchema]
      });
    }
    if (pickupAddress != null) {
      result.addAll({
        RentalsRecordFieldsEnum.pickupAddress.nameInSchema:
            jsonMap[RentalsRecordFieldsEnum.pickupAddress.nameInSchema]
      });
    }
    if (renterNotes != null) {
      result.addAll({
        RentalsRecordFieldsEnum.renterNotes.nameInSchema:
            jsonMap[RentalsRecordFieldsEnum.renterNotes.nameInSchema]
      });
    }
    if (cancellationReason != null) {
      result.addAll({
        RentalsRecordFieldsEnum.cancellationReason.nameInSchema:
            jsonMap[RentalsRecordFieldsEnum.cancellationReason.nameInSchema]
      });
    }
    if (created != null) {
      result.addAll({
        RentalsRecordFieldsEnum.created.nameInSchema:
            jsonMap[RentalsRecordFieldsEnum.created.nameInSchema]
      });
    }
    if (updated != null) {
      result.addAll({
        RentalsRecordFieldsEnum.updated.nameInSchema:
            jsonMap[RentalsRecordFieldsEnum.updated.nameInSchema]
      });
    }
    return result;
  }
}
