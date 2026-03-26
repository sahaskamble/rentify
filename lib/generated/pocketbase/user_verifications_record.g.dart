// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_verifications_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserVerificationsRecord _$UserVerificationsRecordFromJson(
  Map<String, dynamic> json,
) => UserVerificationsRecord(
  id: json['id'] as String,
  collectionId: json['collectionId'] as String,
  collectionName: json['collectionName'] as String,
  user: json['user'] as String,
  type: $enumDecode(_$UserVerificationsRecordTypeEnumEnumMap, json['type']),
  status: $enumDecode(
    _$UserVerificationsRecordStatusEnumEnumMap,
    json['status'],
  ),
  document: (json['document'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  rejectionReason: json['rejection_reason'] as String?,
  reviewedBy: json['reviewed_by'] as String?,
  verifiedAt: pocketBaseNullableDateTimeFromJson(json['verified_at'] as String),
  created: json['created'] == null
      ? null
      : DateTime.parse(json['created'] as String),
  updated: json['updated'] == null
      ? null
      : DateTime.parse(json['updated'] as String),
);

Map<String, dynamic> _$UserVerificationsRecordToJson(
  UserVerificationsRecord instance,
) => <String, dynamic>{
  'id': instance.id,
  'collectionId': instance.collectionId,
  'collectionName': instance.collectionName,
  'user': instance.user,
  'type': _$UserVerificationsRecordTypeEnumEnumMap[instance.type]!,
  'status': _$UserVerificationsRecordStatusEnumEnumMap[instance.status]!,
  'document': instance.document,
  'rejection_reason': instance.rejectionReason,
  'reviewed_by': instance.reviewedBy,
  'verified_at': pocketBaseNullableDateTimeToJson(instance.verifiedAt),
  'created': instance.created?.toIso8601String(),
  'updated': instance.updated?.toIso8601String(),
};

const _$UserVerificationsRecordTypeEnumEnumMap = {
  UserVerificationsRecordTypeEnum.otp: 'otp',
  UserVerificationsRecordTypeEnum.govtId: 'govt_id',
  UserVerificationsRecordTypeEnum.selfie: 'selfie',
  UserVerificationsRecordTypeEnum.bankAccount: 'bank_account',
};

const _$UserVerificationsRecordStatusEnumEnumMap = {
  UserVerificationsRecordStatusEnum.pending: 'pending',
  UserVerificationsRecordStatusEnum.approved: 'approved',
  UserVerificationsRecordStatusEnum.rejected: 'rejected',
};
