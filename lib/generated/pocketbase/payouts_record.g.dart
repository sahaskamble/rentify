// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payouts_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PayoutsRecord _$PayoutsRecordFromJson(Map<String, dynamic> json) =>
    PayoutsRecord(
      id: json['id'] as String,
      collectionId: json['collectionId'] as String,
      collectionName: json['collectionName'] as String,
      seller: json['seller'] as String,
      rental: json['rental'] as String,
      grossAmount: (json['gross_amount'] as num).toDouble(),
      commissionDeducted: (json['commission_deducted'] as num).toDouble(),
      netAmount: (json['net_amount'] as num).toDouble(),
      status: $enumDecode(_$PayoutsRecordStatusEnumEnumMap, json['status']),
      payoutMethod: $enumDecodeNullable(
        _$PayoutsRecordPayout_methodEnumEnumMap,
        json['payout_method'],
        unknownValue: JsonKey.nullForUndefinedEnumValue,
      ),
      transactionRef: json['transaction_ref'] as String?,
      processedAt: pocketBaseNullableDateTimeFromJson(
        json['processed_at'] as String,
      ),
      created: json['created'] == null
          ? null
          : DateTime.parse(json['created'] as String),
      updated: json['updated'] == null
          ? null
          : DateTime.parse(json['updated'] as String),
    );

Map<String, dynamic> _$PayoutsRecordToJson(PayoutsRecord instance) =>
    <String, dynamic>{
      'id': instance.id,
      'collectionId': instance.collectionId,
      'collectionName': instance.collectionName,
      'seller': instance.seller,
      'rental': instance.rental,
      'gross_amount': instance.grossAmount,
      'commission_deducted': instance.commissionDeducted,
      'net_amount': instance.netAmount,
      'status': _$PayoutsRecordStatusEnumEnumMap[instance.status]!,
      'payout_method':
          _$PayoutsRecordPayout_methodEnumEnumMap[instance.payoutMethod],
      'transaction_ref': instance.transactionRef,
      'processed_at': pocketBaseNullableDateTimeToJson(instance.processedAt),
      'created': instance.created?.toIso8601String(),
      'updated': instance.updated?.toIso8601String(),
    };

const _$PayoutsRecordStatusEnumEnumMap = {
  PayoutsRecordStatusEnum.pending: 'pending',
  PayoutsRecordStatusEnum.processing: 'processing',
  PayoutsRecordStatusEnum.completed: 'completed',
  PayoutsRecordStatusEnum.failed: 'failed',
};

const _$PayoutsRecordPayout_methodEnumEnumMap = {
  PayoutsRecordPayout_methodEnum.bankTransfer: 'bank_transfer',
  PayoutsRecordPayout_methodEnum.upi: 'upi',
  PayoutsRecordPayout_methodEnum.wallet: 'wallet',
};
