// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UsersRecord _$UsersRecordFromJson(Map<String, dynamic> json) => UsersRecord(
  id: json['id'] as String,
  collectionId: json['collectionId'] as String,
  collectionName: json['collectionName'] as String,
  email: json['email'] as String?,
  emailVisibility: json['emailVisibility'] as bool,
  verified: json['verified'] as bool,
  name: json['name'] as String?,
  avatar: json['avatar'] as String?,
  phone: json['phone'] as String?,
  role: $enumDecodeNullable(
    _$UsersRecordRoleEnumEnumMap,
    json['role'],
    unknownValue: JsonKey.nullForUndefinedEnumValue,
  ),
  isPhoneVerified: json['is_phone_verified'] as bool,
  isIdVerified: json['is_id_verified'] as bool,
  city: json['city'] as String?,
  area: json['area'] as String?,
  created: json['created'] == null
      ? null
      : DateTime.parse(json['created'] as String),
  updated: json['updated'] == null
      ? null
      : DateTime.parse(json['updated'] as String),
);

Map<String, dynamic> _$UsersRecordToJson(UsersRecord instance) =>
    <String, dynamic>{
      'id': instance.id,
      'collectionId': instance.collectionId,
      'collectionName': instance.collectionName,
      'email': instance.email,
      'emailVisibility': instance.emailVisibility,
      'verified': instance.verified,
      'name': instance.name,
      'avatar': instance.avatar,
      'phone': instance.phone,
      'role': _$UsersRecordRoleEnumEnumMap[instance.role],
      'is_phone_verified': instance.isPhoneVerified,
      'is_id_verified': instance.isIdVerified,
      'city': instance.city,
      'area': instance.area,
      'created': instance.created?.toIso8601String(),
      'updated': instance.updated?.toIso8601String(),
    };

const _$UsersRecordRoleEnumEnumMap = {
  UsersRecordRoleEnum.renter: 'renter',
  UsersRecordRoleEnum.seller: 'seller',
  UsersRecordRoleEnum.both: 'both',
};
