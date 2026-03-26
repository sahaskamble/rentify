// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payments_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentsRecord _$PaymentsRecordFromJson(Map<String, dynamic> json) =>
    PaymentsRecord(
      id: json['id'] as String,
      collectionId: json['collectionId'] as String,
      collectionName: json['collectionName'] as String,
      rental: json['rental'] as String,
      user: json['user'] as String,
      type: $enumDecode(_$PaymentsRecordTypeEnumEnumMap, json['type']),
      amount: (json['amount'] as num).toDouble(),
      gateway: $enumDecode(_$PaymentsRecordGatewayEnumEnumMap, json['gateway']),
      status: $enumDecode(_$PaymentsRecordStatusEnumEnumMap, json['status']),
      gatewayOrderId: json['gateway_order_id'] as String?,
      gatewayPaymentId: json['gateway_payment_id'] as String?,
      failureReason: json['failure_reason'] as String?,
      paidAt: pocketBaseNullableDateTimeFromJson(json['paid_at'] as String),
      created: json['created'] == null
          ? null
          : DateTime.parse(json['created'] as String),
      updated: json['updated'] == null
          ? null
          : DateTime.parse(json['updated'] as String),
    );

Map<String, dynamic> _$PaymentsRecordToJson(PaymentsRecord instance) =>
    <String, dynamic>{
      'id': instance.id,
      'collectionId': instance.collectionId,
      'collectionName': instance.collectionName,
      'rental': instance.rental,
      'user': instance.user,
      'type': _$PaymentsRecordTypeEnumEnumMap[instance.type]!,
      'amount': instance.amount,
      'gateway': _$PaymentsRecordGatewayEnumEnumMap[instance.gateway]!,
      'status': _$PaymentsRecordStatusEnumEnumMap[instance.status]!,
      'gateway_order_id': instance.gatewayOrderId,
      'gateway_payment_id': instance.gatewayPaymentId,
      'failure_reason': instance.failureReason,
      'paid_at': pocketBaseNullableDateTimeToJson(instance.paidAt),
      'created': instance.created?.toIso8601String(),
      'updated': instance.updated?.toIso8601String(),
    };

const _$PaymentsRecordTypeEnumEnumMap = {
  PaymentsRecordTypeEnum.rentalPayment: 'rental_payment',
  PaymentsRecordTypeEnum.securityDeposit: 'security_deposit',
  PaymentsRecordTypeEnum.refund: 'refund',
  PaymentsRecordTypeEnum.payout: 'payout',
  PaymentsRecordTypeEnum.promotionFee: 'promotion_fee',
};

const _$PaymentsRecordGatewayEnumEnumMap = {
  PaymentsRecordGatewayEnum.razorpay: 'razorpay',
  PaymentsRecordGatewayEnum.upi: 'upi',
  PaymentsRecordGatewayEnum.wallet: 'wallet',
  PaymentsRecordGatewayEnum.bankTransfer: 'bank_transfer',
};

const _$PaymentsRecordStatusEnumEnumMap = {
  PaymentsRecordStatusEnum.pending: 'pending',
  PaymentsRecordStatusEnum.success: 'success',
  PaymentsRecordStatusEnum.failed: 'failed',
  PaymentsRecordStatusEnum.refunded: 'refunded',
};
