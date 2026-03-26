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

part 'payouts_record.g.dart';

enum PayoutsRecordFieldsEnum {
  id('id'),
  collectionId('collectionId'),
  collectionName('collectionName'),
  seller('seller'),
  rental('rental'),
  grossAmount('gross_amount'),
  commissionDeducted('commission_deducted'),
  netAmount('net_amount'),
  status('status'),
  payoutMethod('payout_method'),
  transactionRef('transaction_ref'),
  processedAt('processed_at'),
  created('created'),
  updated('updated');

  const PayoutsRecordFieldsEnum(this.nameInSchema);

  final String nameInSchema;
}

enum PayoutsRecordStatusEnum {
  @_i1.JsonValue('pending')
  pending('pending'),
  @_i1.JsonValue('processing')
  processing('processing'),
  @_i1.JsonValue('completed')
  completed('completed'),
  @_i1.JsonValue('failed')
  failed('failed');

  const PayoutsRecordStatusEnum(this.nameInSchema);

  final String nameInSchema;
}

enum PayoutsRecordPayout_methodEnum {
  @_i1.JsonValue('bank_transfer')
  bankTransfer('bank_transfer'),
  @_i1.JsonValue('upi')
  upi('upi'),
  @_i1.JsonValue('wallet')
  wallet('wallet');

  const PayoutsRecordPayout_methodEnum(this.nameInSchema);

  final String nameInSchema;
}

@_i1.JsonSerializable()
final class PayoutsRecord extends _i2.BaseRecord {
  PayoutsRecord({
    required super.id,
    required super.collectionId,
    required super.collectionName,
    required this.seller,
    required this.rental,
    required this.grossAmount,
    required this.commissionDeducted,
    required this.netAmount,
    required this.status,
    this.payoutMethod,
    this.transactionRef,
    this.processedAt,
    this.created,
    this.updated,
  }) : super();

  factory PayoutsRecord.fromJson(Map<String, dynamic> json) =>
      _$PayoutsRecordFromJson(json);

  factory PayoutsRecord.fromRecordModel(_i3.RecordModel recordModel) {
    final extendedJsonMap = {
      ...recordModel.data,
      PayoutsRecordFieldsEnum.id.nameInSchema: recordModel.id,
      PayoutsRecordFieldsEnum.collectionId.nameInSchema:
          recordModel.collectionId,
      PayoutsRecordFieldsEnum.collectionName.nameInSchema:
          recordModel.collectionName,
    };
    return PayoutsRecord.fromJson(extendedJsonMap);
  }

  final String seller;

  final String rental;

  @_i1.JsonKey(name: 'gross_amount')
  final double grossAmount;

  static const gross_amountMinValue = 0;

  @_i1.JsonKey(name: 'commission_deducted')
  final double commissionDeducted;

  static const commission_deductedMinValue = 0;

  @_i1.JsonKey(name: 'net_amount')
  final double netAmount;

  static const net_amountMinValue = 0;

  final PayoutsRecordStatusEnum status;

  @_i1.JsonKey(
    name: 'payout_method',
    unknownEnumValue: _i1.JsonKey.nullForUndefinedEnumValue,
  )
  final PayoutsRecordPayout_methodEnum? payoutMethod;

  @_i1.JsonKey(name: 'transaction_ref')
  final String? transactionRef;

  static const transaction_refMinValue = 0;

  static const transaction_refMaxValue = 100;

  @_i1.JsonKey(
    toJson: pocketBaseNullableDateTimeToJson,
    fromJson: pocketBaseNullableDateTimeFromJson,
    name: 'processed_at',
  )
  final DateTime? processedAt;

  final DateTime? created;

  final DateTime? updated;

  static const $collectionId = 'payout0000001ab';

  static const $collectionName = 'payouts';

  Map<String, dynamic> toJson() => _$PayoutsRecordToJson(this);

  PayoutsRecord copyWith({
    String? seller,
    String? rental,
    double? grossAmount,
    double? commissionDeducted,
    double? netAmount,
    PayoutsRecordStatusEnum? status,
    PayoutsRecordPayout_methodEnum? payoutMethod,
    String? transactionRef,
    DateTime? processedAt,
    DateTime? created,
    DateTime? updated,
  }) {
    return PayoutsRecord(
      id: id,
      collectionId: collectionId,
      collectionName: collectionName,
      seller: seller ?? this.seller,
      rental: rental ?? this.rental,
      grossAmount: grossAmount ?? this.grossAmount,
      commissionDeducted: commissionDeducted ?? this.commissionDeducted,
      netAmount: netAmount ?? this.netAmount,
      status: status ?? this.status,
      payoutMethod: payoutMethod ?? this.payoutMethod,
      transactionRef: transactionRef ?? this.transactionRef,
      processedAt: processedAt ?? this.processedAt,
      created: created ?? this.created,
      updated: updated ?? this.updated,
    );
  }

  Map<String, dynamic> takeDiff(PayoutsRecord other) {
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
        seller,
        rental,
        grossAmount,
        commissionDeducted,
        netAmount,
        status,
        payoutMethod,
        transactionRef,
        processedAt,
        created,
        updated,
      ];

  static Map<String, dynamic> forCreateRequest({
    required String seller,
    required String rental,
    required double grossAmount,
    required double commissionDeducted,
    required double netAmount,
    required PayoutsRecordStatusEnum status,
    PayoutsRecordPayout_methodEnum? payoutMethod,
    String? transactionRef,
    DateTime? processedAt,
    DateTime? created,
    DateTime? updated,
  }) {
    final jsonMap = PayoutsRecord(
      id: '',
      collectionId: $collectionId,
      collectionName: $collectionName,
      seller: seller,
      rental: rental,
      grossAmount: grossAmount,
      commissionDeducted: commissionDeducted,
      netAmount: netAmount,
      status: status,
      payoutMethod: payoutMethod,
      transactionRef: transactionRef,
      processedAt: processedAt,
      created: created,
      updated: updated,
    ).toJson();
    final Map<String, dynamic> result = {};
    result.addAll({
      PayoutsRecordFieldsEnum.seller.nameInSchema:
          jsonMap[PayoutsRecordFieldsEnum.seller.nameInSchema]
    });
    result.addAll({
      PayoutsRecordFieldsEnum.rental.nameInSchema:
          jsonMap[PayoutsRecordFieldsEnum.rental.nameInSchema]
    });
    result.addAll({
      PayoutsRecordFieldsEnum.grossAmount.nameInSchema:
          jsonMap[PayoutsRecordFieldsEnum.grossAmount.nameInSchema]
    });
    result.addAll({
      PayoutsRecordFieldsEnum.commissionDeducted.nameInSchema:
          jsonMap[PayoutsRecordFieldsEnum.commissionDeducted.nameInSchema]
    });
    result.addAll({
      PayoutsRecordFieldsEnum.netAmount.nameInSchema:
          jsonMap[PayoutsRecordFieldsEnum.netAmount.nameInSchema]
    });
    result.addAll({
      PayoutsRecordFieldsEnum.status.nameInSchema:
          jsonMap[PayoutsRecordFieldsEnum.status.nameInSchema]
    });
    if (payoutMethod != null) {
      result.addAll({
        PayoutsRecordFieldsEnum.payoutMethod.nameInSchema:
            jsonMap[PayoutsRecordFieldsEnum.payoutMethod.nameInSchema]
      });
    }
    if (transactionRef != null) {
      result.addAll({
        PayoutsRecordFieldsEnum.transactionRef.nameInSchema:
            jsonMap[PayoutsRecordFieldsEnum.transactionRef.nameInSchema]
      });
    }
    if (processedAt != null) {
      result.addAll({
        PayoutsRecordFieldsEnum.processedAt.nameInSchema:
            jsonMap[PayoutsRecordFieldsEnum.processedAt.nameInSchema]
      });
    }
    if (created != null) {
      result.addAll({
        PayoutsRecordFieldsEnum.created.nameInSchema:
            jsonMap[PayoutsRecordFieldsEnum.created.nameInSchema]
      });
    }
    if (updated != null) {
      result.addAll({
        PayoutsRecordFieldsEnum.updated.nameInSchema:
            jsonMap[PayoutsRecordFieldsEnum.updated.nameInSchema]
      });
    }
    return result;
  }
}
