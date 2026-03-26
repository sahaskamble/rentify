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

part 'user_verifications_record.g.dart';

enum UserVerificationsRecordFieldsEnum {
  id('id'),
  collectionId('collectionId'),
  collectionName('collectionName'),
  user('user'),
  type('type'),
  status('status'),
  document('document'),
  rejectionReason('rejection_reason'),
  reviewedBy('reviewed_by'),
  verifiedAt('verified_at'),
  created('created'),
  updated('updated');

  const UserVerificationsRecordFieldsEnum(this.nameInSchema);

  final String nameInSchema;
}

enum UserVerificationsRecordTypeEnum {
  @_i1.JsonValue('otp')
  otp('otp'),
  @_i1.JsonValue('govt_id')
  govtId('govt_id'),
  @_i1.JsonValue('selfie')
  selfie('selfie'),
  @_i1.JsonValue('bank_account')
  bankAccount('bank_account');

  const UserVerificationsRecordTypeEnum(this.nameInSchema);

  final String nameInSchema;
}

enum UserVerificationsRecordStatusEnum {
  @_i1.JsonValue('pending')
  pending('pending'),
  @_i1.JsonValue('approved')
  approved('approved'),
  @_i1.JsonValue('rejected')
  rejected('rejected');

  const UserVerificationsRecordStatusEnum(this.nameInSchema);

  final String nameInSchema;
}

@_i1.JsonSerializable()
final class UserVerificationsRecord extends _i2.BaseRecord {
  UserVerificationsRecord({
    required super.id,
    required super.collectionId,
    required super.collectionName,
    required this.user,
    required this.type,
    required this.status,
    this.document,
    this.rejectionReason,
    this.reviewedBy,
    this.verifiedAt,
    this.created,
    this.updated,
  }) : super();

  factory UserVerificationsRecord.fromJson(Map<String, dynamic> json) =>
      _$UserVerificationsRecordFromJson(json);

  factory UserVerificationsRecord.fromRecordModel(_i3.RecordModel recordModel) {
    final extendedJsonMap = {
      ...recordModel.data,
      UserVerificationsRecordFieldsEnum.id.nameInSchema: recordModel.id,
      UserVerificationsRecordFieldsEnum.collectionId.nameInSchema:
          recordModel.collectionId,
      UserVerificationsRecordFieldsEnum.collectionName.nameInSchema:
          recordModel.collectionName,
    };
    return UserVerificationsRecord.fromJson(extendedJsonMap);
  }

  final String user;

  final UserVerificationsRecordTypeEnum type;

  final UserVerificationsRecordStatusEnum status;

  final List<String>? document;

  @_i1.JsonKey(name: 'rejection_reason')
  final String? rejectionReason;

  static const rejection_reasonMinValue = 0;

  static const rejection_reasonMaxValue = 500;

  @_i1.JsonKey(name: 'reviewed_by')
  final String? reviewedBy;

  @_i1.JsonKey(
    toJson: pocketBaseNullableDateTimeToJson,
    fromJson: pocketBaseNullableDateTimeFromJson,
    name: 'verified_at',
  )
  final DateTime? verifiedAt;

  final DateTime? created;

  final DateTime? updated;

  static const $collectionId = 'uverification01';

  static const $collectionName = 'user_verifications';

  Map<String, dynamic> toJson() => _$UserVerificationsRecordToJson(this);

  UserVerificationsRecord copyWith({
    String? user,
    UserVerificationsRecordTypeEnum? type,
    UserVerificationsRecordStatusEnum? status,
    List<String>? document,
    String? rejectionReason,
    String? reviewedBy,
    DateTime? verifiedAt,
    DateTime? created,
    DateTime? updated,
  }) {
    return UserVerificationsRecord(
      id: id,
      collectionId: collectionId,
      collectionName: collectionName,
      user: user ?? this.user,
      type: type ?? this.type,
      status: status ?? this.status,
      document: document ?? this.document,
      rejectionReason: rejectionReason ?? this.rejectionReason,
      reviewedBy: reviewedBy ?? this.reviewedBy,
      verifiedAt: verifiedAt ?? this.verifiedAt,
      created: created ?? this.created,
      updated: updated ?? this.updated,
    );
  }

  Map<String, dynamic> takeDiff(UserVerificationsRecord other) {
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
        user,
        type,
        status,
        document,
        rejectionReason,
        reviewedBy,
        verifiedAt,
        created,
        updated,
      ];

  static Map<String, dynamic> forCreateRequest({
    required String user,
    required UserVerificationsRecordTypeEnum type,
    required UserVerificationsRecordStatusEnum status,
    List<String>? document,
    String? rejectionReason,
    String? reviewedBy,
    DateTime? verifiedAt,
    DateTime? created,
    DateTime? updated,
  }) {
    final jsonMap = UserVerificationsRecord(
      id: '',
      collectionId: $collectionId,
      collectionName: $collectionName,
      user: user,
      type: type,
      status: status,
      document: document,
      rejectionReason: rejectionReason,
      reviewedBy: reviewedBy,
      verifiedAt: verifiedAt,
      created: created,
      updated: updated,
    ).toJson();
    final Map<String, dynamic> result = {};
    result.addAll({
      UserVerificationsRecordFieldsEnum.user.nameInSchema:
          jsonMap[UserVerificationsRecordFieldsEnum.user.nameInSchema]
    });
    result.addAll({
      UserVerificationsRecordFieldsEnum.type.nameInSchema:
          jsonMap[UserVerificationsRecordFieldsEnum.type.nameInSchema]
    });
    result.addAll({
      UserVerificationsRecordFieldsEnum.status.nameInSchema:
          jsonMap[UserVerificationsRecordFieldsEnum.status.nameInSchema]
    });
    if (document != null) {
      result.addAll({
        UserVerificationsRecordFieldsEnum.document.nameInSchema:
            jsonMap[UserVerificationsRecordFieldsEnum.document.nameInSchema]
      });
    }
    if (rejectionReason != null) {
      result.addAll({
        UserVerificationsRecordFieldsEnum.rejectionReason.nameInSchema: jsonMap[
            UserVerificationsRecordFieldsEnum.rejectionReason.nameInSchema]
      });
    }
    if (reviewedBy != null) {
      result.addAll({
        UserVerificationsRecordFieldsEnum.reviewedBy.nameInSchema:
            jsonMap[UserVerificationsRecordFieldsEnum.reviewedBy.nameInSchema]
      });
    }
    if (verifiedAt != null) {
      result.addAll({
        UserVerificationsRecordFieldsEnum.verifiedAt.nameInSchema:
            jsonMap[UserVerificationsRecordFieldsEnum.verifiedAt.nameInSchema]
      });
    }
    if (created != null) {
      result.addAll({
        UserVerificationsRecordFieldsEnum.created.nameInSchema:
            jsonMap[UserVerificationsRecordFieldsEnum.created.nameInSchema]
      });
    }
    if (updated != null) {
      result.addAll({
        UserVerificationsRecordFieldsEnum.updated.nameInSchema:
            jsonMap[UserVerificationsRecordFieldsEnum.updated.nameInSchema]
      });
    }
    return result;
  }
}
