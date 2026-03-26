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

part 'conversations_record.g.dart';

enum ConversationsRecordFieldsEnum {
  id('id'),
  collectionId('collectionId'),
  collectionName('collectionName'),
  listing('listing'),
  renter('renter'),
  seller('seller'),
  rental('rental'),
  lastMessageAt('last_message_at'),
  renterUnreadCount('renter_unread_count'),
  sellerUnreadCount('seller_unread_count'),
  created('created'),
  updated('updated');

  const ConversationsRecordFieldsEnum(this.nameInSchema);

  final String nameInSchema;
}

@_i1.JsonSerializable()
final class ConversationsRecord extends _i2.BaseRecord {
  ConversationsRecord({
    required super.id,
    required super.collectionId,
    required super.collectionName,
    required this.listing,
    required this.renter,
    required this.seller,
    this.rental,
    this.lastMessageAt,
    this.renterUnreadCount,
    this.sellerUnreadCount,
    this.created,
    this.updated,
  }) : super();

  factory ConversationsRecord.fromJson(Map<String, dynamic> json) =>
      _$ConversationsRecordFromJson(json);

  factory ConversationsRecord.fromRecordModel(_i3.RecordModel recordModel) {
    final extendedJsonMap = {
      ...recordModel.data,
      ConversationsRecordFieldsEnum.id.nameInSchema: recordModel.id,
      ConversationsRecordFieldsEnum.collectionId.nameInSchema:
          recordModel.collectionId,
      ConversationsRecordFieldsEnum.collectionName.nameInSchema:
          recordModel.collectionName,
    };
    return ConversationsRecord.fromJson(extendedJsonMap);
  }

  final String listing;

  final String renter;

  final String seller;

  final String? rental;

  @_i1.JsonKey(
    toJson: pocketBaseNullableDateTimeToJson,
    fromJson: pocketBaseNullableDateTimeFromJson,
    name: 'last_message_at',
  )
  final DateTime? lastMessageAt;

  @_i1.JsonKey(name: 'renter_unread_count')
  final double? renterUnreadCount;

  static const renter_unread_countMinValue = 0;

  @_i1.JsonKey(name: 'seller_unread_count')
  final double? sellerUnreadCount;

  static const seller_unread_countMinValue = 0;

  final DateTime? created;

  final DateTime? updated;

  static const $collectionId = 'conversation001';

  static const $collectionName = 'conversations';

  Map<String, dynamic> toJson() => _$ConversationsRecordToJson(this);

  ConversationsRecord copyWith({
    String? listing,
    String? renter,
    String? seller,
    String? rental,
    DateTime? lastMessageAt,
    double? renterUnreadCount,
    double? sellerUnreadCount,
    DateTime? created,
    DateTime? updated,
  }) {
    return ConversationsRecord(
      id: id,
      collectionId: collectionId,
      collectionName: collectionName,
      listing: listing ?? this.listing,
      renter: renter ?? this.renter,
      seller: seller ?? this.seller,
      rental: rental ?? this.rental,
      lastMessageAt: lastMessageAt ?? this.lastMessageAt,
      renterUnreadCount: renterUnreadCount ?? this.renterUnreadCount,
      sellerUnreadCount: sellerUnreadCount ?? this.sellerUnreadCount,
      created: created ?? this.created,
      updated: updated ?? this.updated,
    );
  }

  Map<String, dynamic> takeDiff(ConversationsRecord other) {
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
        listing,
        renter,
        seller,
        rental,
        lastMessageAt,
        renterUnreadCount,
        sellerUnreadCount,
        created,
        updated,
      ];

  static Map<String, dynamic> forCreateRequest({
    required String listing,
    required String renter,
    required String seller,
    String? rental,
    DateTime? lastMessageAt,
    double? renterUnreadCount,
    double? sellerUnreadCount,
    DateTime? created,
    DateTime? updated,
  }) {
    final jsonMap = ConversationsRecord(
      id: '',
      collectionId: $collectionId,
      collectionName: $collectionName,
      listing: listing,
      renter: renter,
      seller: seller,
      rental: rental,
      lastMessageAt: lastMessageAt,
      renterUnreadCount: renterUnreadCount,
      sellerUnreadCount: sellerUnreadCount,
      created: created,
      updated: updated,
    ).toJson();
    final Map<String, dynamic> result = {};
    result.addAll({
      ConversationsRecordFieldsEnum.listing.nameInSchema:
          jsonMap[ConversationsRecordFieldsEnum.listing.nameInSchema]
    });
    result.addAll({
      ConversationsRecordFieldsEnum.renter.nameInSchema:
          jsonMap[ConversationsRecordFieldsEnum.renter.nameInSchema]
    });
    result.addAll({
      ConversationsRecordFieldsEnum.seller.nameInSchema:
          jsonMap[ConversationsRecordFieldsEnum.seller.nameInSchema]
    });
    if (rental != null) {
      result.addAll({
        ConversationsRecordFieldsEnum.rental.nameInSchema:
            jsonMap[ConversationsRecordFieldsEnum.rental.nameInSchema]
      });
    }
    if (lastMessageAt != null) {
      result.addAll({
        ConversationsRecordFieldsEnum.lastMessageAt.nameInSchema:
            jsonMap[ConversationsRecordFieldsEnum.lastMessageAt.nameInSchema]
      });
    }
    if (renterUnreadCount != null) {
      result.addAll({
        ConversationsRecordFieldsEnum.renterUnreadCount.nameInSchema: jsonMap[
            ConversationsRecordFieldsEnum.renterUnreadCount.nameInSchema]
      });
    }
    if (sellerUnreadCount != null) {
      result.addAll({
        ConversationsRecordFieldsEnum.sellerUnreadCount.nameInSchema: jsonMap[
            ConversationsRecordFieldsEnum.sellerUnreadCount.nameInSchema]
      });
    }
    if (created != null) {
      result.addAll({
        ConversationsRecordFieldsEnum.created.nameInSchema:
            jsonMap[ConversationsRecordFieldsEnum.created.nameInSchema]
      });
    }
    if (updated != null) {
      result.addAll({
        ConversationsRecordFieldsEnum.updated.nameInSchema:
            jsonMap[ConversationsRecordFieldsEnum.updated.nameInSchema]
      });
    }
    return result;
  }
}
