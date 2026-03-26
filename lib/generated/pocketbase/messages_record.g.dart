// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'messages_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessagesRecord _$MessagesRecordFromJson(Map<String, dynamic> json) =>
    MessagesRecord(
      id: json['id'] as String,
      collectionId: json['collectionId'] as String,
      collectionName: json['collectionName'] as String,
      conversation: json['conversation'] as String,
      sender: json['sender'] as String,
      content: json['content'] as String,
      attachments: (json['attachments'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      isRead: json['is_read'] as bool,
      readAt: pocketBaseNullableDateTimeFromJson(json['read_at'] as String),
      created: json['created'] == null
          ? null
          : DateTime.parse(json['created'] as String),
      updated: json['updated'] == null
          ? null
          : DateTime.parse(json['updated'] as String),
    );

Map<String, dynamic> _$MessagesRecordToJson(MessagesRecord instance) =>
    <String, dynamic>{
      'id': instance.id,
      'collectionId': instance.collectionId,
      'collectionName': instance.collectionName,
      'conversation': instance.conversation,
      'sender': instance.sender,
      'content': instance.content,
      'attachments': instance.attachments,
      'is_read': instance.isRead,
      'read_at': pocketBaseNullableDateTimeToJson(instance.readAt),
      'created': instance.created?.toIso8601String(),
      'updated': instance.updated?.toIso8601String(),
    };
