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

part 'payments_record.g.dart';

enum PaymentsRecordFieldsEnum {
  id('id'),
  collectionId('collectionId'),
  collectionName('collectionName'),
  rental('rental'),
  user('user'),
  type('type'),
  amount('amount'),
  gateway('gateway'),
  status('status'),
  gatewayOrderId('gateway_order_id'),
  gatewayPaymentId('gateway_payment_id'),
  failureReason('failure_reason'),
  paidAt('paid_at'),
  created('created'),
  updated('updated');

  const PaymentsRecordFieldsEnum(this.nameInSchema);

  final String nameInSchema;
}

enum PaymentsRecordTypeEnum {
  @_i1.JsonValue('rental_payment')
  rentalPayment('rental_payment'),
  @_i1.JsonValue('security_deposit')
  securityDeposit('security_deposit'),
  @_i1.JsonValue('refund')
  refund('refund'),
  @_i1.JsonValue('payout')
  payout('payout'),
  @_i1.JsonValue('promotion_fee')
  promotionFee('promotion_fee');

  const PaymentsRecordTypeEnum(this.nameInSchema);

  final String nameInSchema;
}

enum PaymentsRecordGatewayEnum {
  @_i1.JsonValue('razorpay')
  razorpay('razorpay'),
  @_i1.JsonValue('upi')
  upi('upi'),
  @_i1.JsonValue('wallet')
  wallet('wallet'),
  @_i1.JsonValue('bank_transfer')
  bankTransfer('bank_transfer');

  const PaymentsRecordGatewayEnum(this.nameInSchema);

  final String nameInSchema;
}

enum PaymentsRecordStatusEnum {
  @_i1.JsonValue('pending')
  pending('pending'),
  @_i1.JsonValue('success')
  success('success'),
  @_i1.JsonValue('failed')
  failed('failed'),
  @_i1.JsonValue('refunded')
  refunded('refunded');

  const PaymentsRecordStatusEnum(this.nameInSchema);

  final String nameInSchema;
}

@_i1.JsonSerializable()
final class PaymentsRecord extends _i2.BaseRecord {
  PaymentsRecord({
    required super.id,
    required super.collectionId,
    required super.collectionName,
    required this.rental,
    required this.user,
    required this.type,
    required this.amount,
    required this.gateway,
    required this.status,
    this.gatewayOrderId,
    this.gatewayPaymentId,
    this.failureReason,
    this.paidAt,
    this.created,
    this.updated,
  }) : super();

  factory PaymentsRecord.fromJson(Map<String, dynamic> json) =>
      _$PaymentsRecordFromJson(json);

  factory PaymentsRecord.fromRecordModel(_i3.RecordModel recordModel) {
    final extendedJsonMap = {
      ...recordModel.data,
      PaymentsRecordFieldsEnum.id.nameInSchema: recordModel.id,
      PaymentsRecordFieldsEnum.collectionId.nameInSchema:
          recordModel.collectionId,
      PaymentsRecordFieldsEnum.collectionName.nameInSchema:
          recordModel.collectionName,
    };
    return PaymentsRecord.fromJson(extendedJsonMap);
  }

  final String rental;

  final String user;

  final PaymentsRecordTypeEnum type;

  final double amount;

  static const amountMinValue = 0;

  final PaymentsRecordGatewayEnum gateway;

  final PaymentsRecordStatusEnum status;

  @_i1.JsonKey(name: 'gateway_order_id')
  final String? gatewayOrderId;

  static const gateway_order_idMinValue = 0;

  static const gateway_order_idMaxValue = 100;

  @_i1.JsonKey(name: 'gateway_payment_id')
  final String? gatewayPaymentId;

  static const gateway_payment_idMinValue = 0;

  static const gateway_payment_idMaxValue = 100;

  @_i1.JsonKey(name: 'failure_reason')
  final String? failureReason;

  static const failure_reasonMinValue = 0;

  static const failure_reasonMaxValue = 300;

  @_i1.JsonKey(
    toJson: pocketBaseNullableDateTimeToJson,
    fromJson: pocketBaseNullableDateTimeFromJson,
    name: 'paid_at',
  )
  final DateTime? paidAt;

  final DateTime? created;

  final DateTime? updated;

  static const $collectionId = 'payment000001ab';

  static const $collectionName = 'payments';

  Map<String, dynamic> toJson() => _$PaymentsRecordToJson(this);

  PaymentsRecord copyWith({
    String? rental,
    String? user,
    PaymentsRecordTypeEnum? type,
    double? amount,
    PaymentsRecordGatewayEnum? gateway,
    PaymentsRecordStatusEnum? status,
    String? gatewayOrderId,
    String? gatewayPaymentId,
    String? failureReason,
    DateTime? paidAt,
    DateTime? created,
    DateTime? updated,
  }) {
    return PaymentsRecord(
      id: id,
      collectionId: collectionId,
      collectionName: collectionName,
      rental: rental ?? this.rental,
      user: user ?? this.user,
      type: type ?? this.type,
      amount: amount ?? this.amount,
      gateway: gateway ?? this.gateway,
      status: status ?? this.status,
      gatewayOrderId: gatewayOrderId ?? this.gatewayOrderId,
      gatewayPaymentId: gatewayPaymentId ?? this.gatewayPaymentId,
      failureReason: failureReason ?? this.failureReason,
      paidAt: paidAt ?? this.paidAt,
      created: created ?? this.created,
      updated: updated ?? this.updated,
    );
  }

  Map<String, dynamic> takeDiff(PaymentsRecord other) {
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
        rental,
        user,
        type,
        amount,
        gateway,
        status,
        gatewayOrderId,
        gatewayPaymentId,
        failureReason,
        paidAt,
        created,
        updated,
      ];

  static Map<String, dynamic> forCreateRequest({
    required String rental,
    required String user,
    required PaymentsRecordTypeEnum type,
    required double amount,
    required PaymentsRecordGatewayEnum gateway,
    required PaymentsRecordStatusEnum status,
    String? gatewayOrderId,
    String? gatewayPaymentId,
    String? failureReason,
    DateTime? paidAt,
    DateTime? created,
    DateTime? updated,
  }) {
    final jsonMap = PaymentsRecord(
      id: '',
      collectionId: $collectionId,
      collectionName: $collectionName,
      rental: rental,
      user: user,
      type: type,
      amount: amount,
      gateway: gateway,
      status: status,
      gatewayOrderId: gatewayOrderId,
      gatewayPaymentId: gatewayPaymentId,
      failureReason: failureReason,
      paidAt: paidAt,
      created: created,
      updated: updated,
    ).toJson();
    final Map<String, dynamic> result = {};
    result.addAll({
      PaymentsRecordFieldsEnum.rental.nameInSchema:
          jsonMap[PaymentsRecordFieldsEnum.rental.nameInSchema]
    });
    result.addAll({
      PaymentsRecordFieldsEnum.user.nameInSchema:
          jsonMap[PaymentsRecordFieldsEnum.user.nameInSchema]
    });
    result.addAll({
      PaymentsRecordFieldsEnum.type.nameInSchema:
          jsonMap[PaymentsRecordFieldsEnum.type.nameInSchema]
    });
    result.addAll({
      PaymentsRecordFieldsEnum.amount.nameInSchema:
          jsonMap[PaymentsRecordFieldsEnum.amount.nameInSchema]
    });
    result.addAll({
      PaymentsRecordFieldsEnum.gateway.nameInSchema:
          jsonMap[PaymentsRecordFieldsEnum.gateway.nameInSchema]
    });
    result.addAll({
      PaymentsRecordFieldsEnum.status.nameInSchema:
          jsonMap[PaymentsRecordFieldsEnum.status.nameInSchema]
    });
    if (gatewayOrderId != null) {
      result.addAll({
        PaymentsRecordFieldsEnum.gatewayOrderId.nameInSchema:
            jsonMap[PaymentsRecordFieldsEnum.gatewayOrderId.nameInSchema]
      });
    }
    if (gatewayPaymentId != null) {
      result.addAll({
        PaymentsRecordFieldsEnum.gatewayPaymentId.nameInSchema:
            jsonMap[PaymentsRecordFieldsEnum.gatewayPaymentId.nameInSchema]
      });
    }
    if (failureReason != null) {
      result.addAll({
        PaymentsRecordFieldsEnum.failureReason.nameInSchema:
            jsonMap[PaymentsRecordFieldsEnum.failureReason.nameInSchema]
      });
    }
    if (paidAt != null) {
      result.addAll({
        PaymentsRecordFieldsEnum.paidAt.nameInSchema:
            jsonMap[PaymentsRecordFieldsEnum.paidAt.nameInSchema]
      });
    }
    if (created != null) {
      result.addAll({
        PaymentsRecordFieldsEnum.created.nameInSchema:
            jsonMap[PaymentsRecordFieldsEnum.created.nameInSchema]
      });
    }
    if (updated != null) {
      result.addAll({
        PaymentsRecordFieldsEnum.updated.nameInSchema:
            jsonMap[PaymentsRecordFieldsEnum.updated.nameInSchema]
      });
    }
    return result;
  }
}
