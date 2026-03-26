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

import 'auth_record.dart' as _i2;
import 'date_time_json_methods.dart';
import 'geo_point_class.dart';

part 'users_record.g.dart';

enum UsersRecordFieldsEnum {
  id('id'),
  collectionId('collectionId'),
  collectionName('collectionName'),
  email('email'),
  emailVisibility('emailVisibility'),
  verified('verified'),
  name('name'),
  avatar('avatar'),
  phone('phone'),
  role('role'),
  isPhoneVerified('is_phone_verified'),
  isIdVerified('is_id_verified'),
  city('city'),
  area('area'),
  created('created'),
  updated('updated'),
  hidden$tokenKey('tokenKey'),
  hidden$password('password'),
  hidden$passwordConfirm('passwordConfirm');

  const UsersRecordFieldsEnum(this.nameInSchema);

  final String nameInSchema;
}

enum UsersRecordRoleEnum {
  @_i1.JsonValue('renter')
  renter('renter'),
  @_i1.JsonValue('seller')
  seller('seller'),
  @_i1.JsonValue('both')
  both('both');

  const UsersRecordRoleEnum(this.nameInSchema);

  final String nameInSchema;
}

@_i1.JsonSerializable()
final class UsersRecord extends _i2.AuthRecord {
  UsersRecord({
    required super.id,
    required super.collectionId,
    required super.collectionName,
    super.email,
    required super.emailVisibility,
    required super.verified,
    this.name,
    this.avatar,
    this.phone,
    this.role,
    required this.isPhoneVerified,
    required this.isIdVerified,
    this.city,
    this.area,
    this.created,
    this.updated,
  }) : super();

  factory UsersRecord.fromJson(Map<String, dynamic> json) =>
      _$UsersRecordFromJson(json);

  factory UsersRecord.fromRecordModel(_i3.RecordModel recordModel) {
    final extendedJsonMap = {
      ...recordModel.data,
      UsersRecordFieldsEnum.id.nameInSchema: recordModel.id,
      UsersRecordFieldsEnum.collectionId.nameInSchema: recordModel.collectionId,
      UsersRecordFieldsEnum.collectionName.nameInSchema:
          recordModel.collectionName,
    };
    return UsersRecord.fromJson(extendedJsonMap);
  }

  final String? name;

  static const nameMinValue = 0;

  static const nameMaxValue = 255;

  final String? avatar;

  final String? phone;

  static const phoneMinValue = 10;

  static const phoneMaxValue = 15;

  @_i1.JsonKey(unknownEnumValue: _i1.JsonKey.nullForUndefinedEnumValue)
  final UsersRecordRoleEnum? role;

  @_i1.JsonKey(name: 'is_phone_verified')
  final bool isPhoneVerified;

  @_i1.JsonKey(name: 'is_id_verified')
  final bool isIdVerified;

  final String? city;

  static const cityMinValue = 0;

  static const cityMaxValue = 100;

  final String? area;

  static const areaMinValue = 0;

  static const areaMaxValue = 100;

  final DateTime? created;

  final DateTime? updated;

  static const $collectionId = '_pb_users_auth_';

  static const $collectionName = 'users';

  Map<String, dynamic> toJson() => _$UsersRecordToJson(this);

  UsersRecord copyWith({
    String? email,
    bool? emailVisibility,
    bool? verified,
    String? name,
    String? avatar,
    String? phone,
    UsersRecordRoleEnum? role,
    bool? isPhoneVerified,
    bool? isIdVerified,
    String? city,
    String? area,
    DateTime? created,
    DateTime? updated,
  }) {
    return UsersRecord(
      id: id,
      collectionId: collectionId,
      collectionName: collectionName,
      email: email ?? this.email,
      emailVisibility: emailVisibility ?? this.emailVisibility,
      verified: verified ?? this.verified,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
      phone: phone ?? this.phone,
      role: role ?? this.role,
      isPhoneVerified: isPhoneVerified ?? this.isPhoneVerified,
      isIdVerified: isIdVerified ?? this.isIdVerified,
      city: city ?? this.city,
      area: area ?? this.area,
      created: created ?? this.created,
      updated: updated ?? this.updated,
    );
  }

  Map<String, dynamic> takeDiff(UsersRecord other) {
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
        name,
        avatar,
        phone,
        role,
        isPhoneVerified,
        isIdVerified,
        city,
        area,
        created,
        updated,
      ];

  static Map<String, dynamic> forCreateRequest({
    String? email,
    required bool emailVisibility,
    required bool verified,
    String? name,
    String? avatar,
    String? phone,
    UsersRecordRoleEnum? role,
    required bool isPhoneVerified,
    required bool isIdVerified,
    String? city,
    String? area,
    DateTime? created,
    DateTime? updated,
  }) {
    final jsonMap = UsersRecord(
      id: '',
      collectionId: $collectionId,
      collectionName: $collectionName,
      email: email,
      emailVisibility: emailVisibility,
      verified: verified,
      name: name,
      avatar: avatar,
      phone: phone,
      role: role,
      isPhoneVerified: isPhoneVerified,
      isIdVerified: isIdVerified,
      city: city,
      area: area,
      created: created,
      updated: updated,
    ).toJson();
    final Map<String, dynamic> result = {};
    if (email != null) {
      result.addAll({
        UsersRecordFieldsEnum.email.nameInSchema:
            jsonMap[UsersRecordFieldsEnum.email.nameInSchema]
      });
    }
    result.addAll({
      UsersRecordFieldsEnum.emailVisibility.nameInSchema:
          jsonMap[UsersRecordFieldsEnum.emailVisibility.nameInSchema]
    });
    result.addAll({
      UsersRecordFieldsEnum.verified.nameInSchema:
          jsonMap[UsersRecordFieldsEnum.verified.nameInSchema]
    });
    if (name != null) {
      result.addAll({
        UsersRecordFieldsEnum.name.nameInSchema:
            jsonMap[UsersRecordFieldsEnum.name.nameInSchema]
      });
    }
    if (avatar != null) {
      result.addAll({
        UsersRecordFieldsEnum.avatar.nameInSchema:
            jsonMap[UsersRecordFieldsEnum.avatar.nameInSchema]
      });
    }
    if (phone != null) {
      result.addAll({
        UsersRecordFieldsEnum.phone.nameInSchema:
            jsonMap[UsersRecordFieldsEnum.phone.nameInSchema]
      });
    }
    if (role != null) {
      result.addAll({
        UsersRecordFieldsEnum.role.nameInSchema:
            jsonMap[UsersRecordFieldsEnum.role.nameInSchema]
      });
    }
    result.addAll({
      UsersRecordFieldsEnum.isPhoneVerified.nameInSchema:
          jsonMap[UsersRecordFieldsEnum.isPhoneVerified.nameInSchema]
    });
    result.addAll({
      UsersRecordFieldsEnum.isIdVerified.nameInSchema:
          jsonMap[UsersRecordFieldsEnum.isIdVerified.nameInSchema]
    });
    if (city != null) {
      result.addAll({
        UsersRecordFieldsEnum.city.nameInSchema:
            jsonMap[UsersRecordFieldsEnum.city.nameInSchema]
      });
    }
    if (area != null) {
      result.addAll({
        UsersRecordFieldsEnum.area.nameInSchema:
            jsonMap[UsersRecordFieldsEnum.area.nameInSchema]
      });
    }
    if (created != null) {
      result.addAll({
        UsersRecordFieldsEnum.created.nameInSchema:
            jsonMap[UsersRecordFieldsEnum.created.nameInSchema]
      });
    }
    if (updated != null) {
      result.addAll({
        UsersRecordFieldsEnum.updated.nameInSchema:
            jsonMap[UsersRecordFieldsEnum.updated.nameInSchema]
      });
    }
    return result;
  }
}
