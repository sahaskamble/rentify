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

part 'messages_record.g.dart';

enum MessagesRecordFieldsEnum {
  id('id'),
  collectionId('collectionId'),
  collectionName('collectionName'),
  conversation('conversation'),
  sender('sender'),
  content('content'),
  attachments('attachments'),
  isRead('is_read'),
  readAt('read_at'),
  created('created'),
  updated('updated');

  const MessagesRecordFieldsEnum(this.nameInSchema);

  final String nameInSchema;
}

@_i1.JsonSerializable()
final class MessagesRecord extends _i2.BaseRecord {
  MessagesRecord({
    required super.id,
    required super.collectionId,
    required super.collectionName,
    required this.conversation,
    required this.sender,
    required this.content,
    this.attachments,
    required this.isRead,
    this.readAt,
    this.created,
    this.updated,
  }) : super();

  factory MessagesRecord.fromJson(Map<String, dynamic> json) =>
      _$MessagesRecordFromJson(json);

  factory MessagesRecord.fromRecordModel(_i3.RecordModel recordModel) {
    final extendedJsonMap = {
      ...recordModel.data,
      MessagesRecordFieldsEnum.id.nameInSchema: recordModel.id,
      MessagesRecordFieldsEnum.collectionId.nameInSchema:
          recordModel.collectionId,
      MessagesRecordFieldsEnum.collectionName.nameInSchema:
          recordModel.collectionName,
    };
    return MessagesRecord.fromJson(extendedJsonMap);
  }

  final String conversation;

  final String sender;

  final String content;

  static const contentMinValue = 1;

  static const contentMaxValue = 2000;

  final List<String>? attachments;

  @_i1.JsonKey(name: 'is_read')
  final bool isRead;

  @_i1.JsonKey(
    toJson: pocketBaseNullableDateTimeToJson,
    fromJson: pocketBaseNullableDateTimeFromJson,
    name: 'read_at',
  )
  final DateTime? readAt;

  final DateTime? created;

  final DateTime? updated;

  static const $collectionId = 'message000001ab';

  static const $collectionName = 'messages';

  Map<String, dynamic> toJson() => _$MessagesRecordToJson(this);

  MessagesRecord copyWith({
    String? conversation,
    String? sender,
    String? content,
    List<String>? attachments,
    bool? isRead,
    DateTime? readAt,
    DateTime? created,
    DateTime? updated,
  }) {
    return MessagesRecord(
      id: id,
      collectionId: collectionId,
      collectionName: collectionName,
      conversation: conversation ?? this.conversation,
      sender: sender ?? this.sender,
      content: content ?? this.content,
      attachments: attachments ?? this.attachments,
      isRead: isRead ?? this.isRead,
      readAt: readAt ?? this.readAt,
      created: created ?? this.created,
      updated: updated ?? this.updated,
    );
  }

  Map<String, dynamic> takeDiff(MessagesRecord other) {
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
        conversation,
        sender,
        content,
        attachments,
        isRead,
        readAt,
        created,
        updated,
      ];

  static Map<String, dynamic> forCreateRequest({
    required String conversation,
    required String sender,
    required String content,
    List<String>? attachments,
    required bool isRead,
    DateTime? readAt,
    DateTime? created,
    DateTime? updated,
  }) {
    final jsonMap = MessagesRecord(
      id: '',
      collectionId: $collectionId,
      collectionName: $collectionName,
      conversation: conversation,
      sender: sender,
      content: content,
      attachments: attachments,
      isRead: isRead,
      readAt: readAt,
      created: created,
      updated: updated,
    ).toJson();
    final Map<String, dynamic> result = {};
    result.addAll({
      MessagesRecordFieldsEnum.conversation.nameInSchema:
          jsonMap[MessagesRecordFieldsEnum.conversation.nameInSchema]
    });
    result.addAll({
      MessagesRecordFieldsEnum.sender.nameInSchema:
          jsonMap[MessagesRecordFieldsEnum.sender.nameInSchema]
    });
    result.addAll({
      MessagesRecordFieldsEnum.content.nameInSchema:
          jsonMap[MessagesRecordFieldsEnum.content.nameInSchema]
    });
    if (attachments != null) {
      result.addAll({
        MessagesRecordFieldsEnum.attachments.nameInSchema:
            jsonMap[MessagesRecordFieldsEnum.attachments.nameInSchema]
      });
    }
    result.addAll({
      MessagesRecordFieldsEnum.isRead.nameInSchema:
          jsonMap[MessagesRecordFieldsEnum.isRead.nameInSchema]
    });
    if (readAt != null) {
      result.addAll({
        MessagesRecordFieldsEnum.readAt.nameInSchema:
            jsonMap[MessagesRecordFieldsEnum.readAt.nameInSchema]
      });
    }
    if (created != null) {
      result.addAll({
        MessagesRecordFieldsEnum.created.nameInSchema:
            jsonMap[MessagesRecordFieldsEnum.created.nameInSchema]
      });
    }
    if (updated != null) {
      result.addAll({
        MessagesRecordFieldsEnum.updated.nameInSchema:
            jsonMap[MessagesRecordFieldsEnum.updated.nameInSchema]
      });
    }
    return result;
  }
}
