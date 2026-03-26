// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rentals_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RentalsRecord _$RentalsRecordFromJson(Map<String, dynamic> json) =>
    RentalsRecord(
      id: json['id'] as String,
      collectionId: json['collectionId'] as String,
      collectionName: json['collectionName'] as String,
      listing: json['listing'] as String,
      renter: json['renter'] as String,
      seller: json['seller'] as String,
      startDate: pocketBaseDateTimeFromJson(json['start_date'] as String),
      endDate: pocketBaseDateTimeFromJson(json['end_date'] as String),
      totalDays: (json['total_days'] as num).toDouble(),
      baseAmount: (json['base_amount'] as num).toDouble(),
      platformFee: (json['platform_fee'] as num).toDouble(),
      securityDeposit: (json['security_deposit'] as num).toDouble(),
      totalAmount: (json['total_amount'] as num).toDouble(),
      status: $enumDecode(_$RentalsRecordStatusEnumEnumMap, json['status']),
      pickupType: $enumDecode(
        _$RentalsRecordPickup_typeEnumEnumMap,
        json['pickup_type'],
      ),
      deliveryCharge: (json['delivery_charge'] as num?)?.toDouble(),
      pickupAddress: json['pickup_address'] as String?,
      renterNotes: json['renter_notes'] as String?,
      cancellationReason: json['cancellation_reason'] as String?,
      created: json['created'] == null
          ? null
          : DateTime.parse(json['created'] as String),
      updated: json['updated'] == null
          ? null
          : DateTime.parse(json['updated'] as String),
    );

Map<String, dynamic> _$RentalsRecordToJson(
  RentalsRecord instance,
) => <String, dynamic>{
  'id': instance.id,
  'collectionId': instance.collectionId,
  'collectionName': instance.collectionName,
  'listing': instance.listing,
  'renter': instance.renter,
  'seller': instance.seller,
  'start_date': pocketBaseDateTimeToJson(instance.startDate),
  'end_date': pocketBaseDateTimeToJson(instance.endDate),
  'total_days': instance.totalDays,
  'base_amount': instance.baseAmount,
  'platform_fee': instance.platformFee,
  'security_deposit': instance.securityDeposit,
  'total_amount': instance.totalAmount,
  'status': _$RentalsRecordStatusEnumEnumMap[instance.status]!,
  'pickup_type': _$RentalsRecordPickup_typeEnumEnumMap[instance.pickupType]!,
  'delivery_charge': instance.deliveryCharge,
  'pickup_address': instance.pickupAddress,
  'renter_notes': instance.renterNotes,
  'cancellation_reason': instance.cancellationReason,
  'created': instance.created?.toIso8601String(),
  'updated': instance.updated?.toIso8601String(),
};

const _$RentalsRecordStatusEnumEnumMap = {
  RentalsRecordStatusEnum.pending: 'pending',
  RentalsRecordStatusEnum.confirmed: 'confirmed',
  RentalsRecordStatusEnum.active: 'active',
  RentalsRecordStatusEnum.completed: 'completed',
  RentalsRecordStatusEnum.cancelled: 'cancelled',
  RentalsRecordStatusEnum.disputed: 'disputed',
};

const _$RentalsRecordPickup_typeEnumEnumMap = {
  RentalsRecordPickup_typeEnum.selfPickup: 'self_pickup',
  RentalsRecordPickup_typeEnum.delivery: 'delivery',
};
