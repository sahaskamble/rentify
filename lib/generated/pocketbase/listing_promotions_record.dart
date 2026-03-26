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

part 'listing_promotions_record.g.dart';

enum ListingPromotionsRecordFieldsEnum {
  id('id'),
  collectionId('collectionId'),
  collectionName('collectionName'),
  listing('listing'),
  seller('seller'),
  plan('plan'),
  amountPaid('amount_paid'),
  startsAt('starts_at'),
  endsAt('ends_at'),
  status('status'),
  payment('payment'),
  created('created'),
  updated('updated');

  const ListingPromotionsRecordFieldsEnum(this.nameInSchema);

  final String nameInSchema;
}

enum ListingPromotionsRecordPlanEnum {
  @_i1.JsonValue('featured_24h')
  featured24h('featured_24h'),
  @_i1.JsonValue('featured_7d')
  featured7d('featured_7d'),
  @_i1.JsonValue('top_category_7d')
  topCategory7d('top_category_7d'),
  @_i1.JsonValue('top_category_30d')
  topCategory30d('top_category_30d');

  const ListingPromotionsRecordPlanEnum(this.nameInSchema);

  final String nameInSchema;
}

enum ListingPromotionsRecordStatusEnum {
  @_i1.JsonValue('active')
  active('active'),
  @_i1.JsonValue('expired')
  expired('expired'),
  @_i1.JsonValue('cancelled')
  cancelled('cancelled');

  const ListingPromotionsRecordStatusEnum(this.nameInSchema);

  final String nameInSchema;
}

@_i1.JsonSerializable()
final class ListingPromotionsRecord extends _i2.BaseRecord {
  ListingPromotionsRecord({
    required super.id,
    required super.collectionId,
    required super.collectionName,
    required this.listing,
    required this.seller,
    required this.plan,
    required this.amountPaid,
    required this.startsAt,
    required this.endsAt,
    required this.status,
    this.payment,
    this.created,
    this.updated,
  }) : super();

  factory ListingPromotionsRecord.fromJson(Map<String, dynamic> json) =>
      _$ListingPromotionsRecordFromJson(json);

  factory ListingPromotionsRecord.fromRecordModel(_i3.RecordModel recordModel) {
    final extendedJsonMap = {
      ...recordModel.data,
      ListingPromotionsRecordFieldsEnum.id.nameInSchema: recordModel.id,
      ListingPromotionsRecordFieldsEnum.collectionId.nameInSchema:
          recordModel.collectionId,
      ListingPromotionsRecordFieldsEnum.collectionName.nameInSchema:
          recordModel.collectionName,
    };
    return ListingPromotionsRecord.fromJson(extendedJsonMap);
  }

  final String listing;

  final String seller;

  final ListingPromotionsRecordPlanEnum plan;

  @_i1.JsonKey(name: 'amount_paid')
  final double amountPaid;

  static const amount_paidMinValue = 0;

  @_i1.JsonKey(
    toJson: pocketBaseDateTimeToJson,
    fromJson: pocketBaseDateTimeFromJson,
    name: 'starts_at',
  )
  final DateTime startsAt;

  @_i1.JsonKey(
    toJson: pocketBaseDateTimeToJson,
    fromJson: pocketBaseDateTimeFromJson,
    name: 'ends_at',
  )
  final DateTime endsAt;

  final ListingPromotionsRecordStatusEnum status;

  final String? payment;

  final DateTime? created;

  final DateTime? updated;

  static const $collectionId = 'promotion0001ab';

  static const $collectionName = 'listing_promotions';

  Map<String, dynamic> toJson() => _$ListingPromotionsRecordToJson(this);

  ListingPromotionsRecord copyWith({
    String? listing,
    String? seller,
    ListingPromotionsRecordPlanEnum? plan,
    double? amountPaid,
    DateTime? startsAt,
    DateTime? endsAt,
    ListingPromotionsRecordStatusEnum? status,
    String? payment,
    DateTime? created,
    DateTime? updated,
  }) {
    return ListingPromotionsRecord(
      id: id,
      collectionId: collectionId,
      collectionName: collectionName,
      listing: listing ?? this.listing,
      seller: seller ?? this.seller,
      plan: plan ?? this.plan,
      amountPaid: amountPaid ?? this.amountPaid,
      startsAt: startsAt ?? this.startsAt,
      endsAt: endsAt ?? this.endsAt,
      status: status ?? this.status,
      payment: payment ?? this.payment,
      created: created ?? this.created,
      updated: updated ?? this.updated,
    );
  }

  Map<String, dynamic> takeDiff(ListingPromotionsRecord other) {
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
        seller,
        plan,
        amountPaid,
        startsAt,
        endsAt,
        status,
        payment,
        created,
        updated,
      ];

  static Map<String, dynamic> forCreateRequest({
    required String listing,
    required String seller,
    required ListingPromotionsRecordPlanEnum plan,
    required double amountPaid,
    required DateTime startsAt,
    required DateTime endsAt,
    required ListingPromotionsRecordStatusEnum status,
    String? payment,
    DateTime? created,
    DateTime? updated,
  }) {
    final jsonMap = ListingPromotionsRecord(
      id: '',
      collectionId: $collectionId,
      collectionName: $collectionName,
      listing: listing,
      seller: seller,
      plan: plan,
      amountPaid: amountPaid,
      startsAt: startsAt,
      endsAt: endsAt,
      status: status,
      payment: payment,
      created: created,
      updated: updated,
    ).toJson();
    final Map<String, dynamic> result = {};
    result.addAll({
      ListingPromotionsRecordFieldsEnum.listing.nameInSchema:
          jsonMap[ListingPromotionsRecordFieldsEnum.listing.nameInSchema]
    });
    result.addAll({
      ListingPromotionsRecordFieldsEnum.seller.nameInSchema:
          jsonMap[ListingPromotionsRecordFieldsEnum.seller.nameInSchema]
    });
    result.addAll({
      ListingPromotionsRecordFieldsEnum.plan.nameInSchema:
          jsonMap[ListingPromotionsRecordFieldsEnum.plan.nameInSchema]
    });
    result.addAll({
      ListingPromotionsRecordFieldsEnum.amountPaid.nameInSchema:
          jsonMap[ListingPromotionsRecordFieldsEnum.amountPaid.nameInSchema]
    });
    result.addAll({
      ListingPromotionsRecordFieldsEnum.startsAt.nameInSchema:
          jsonMap[ListingPromotionsRecordFieldsEnum.startsAt.nameInSchema]
    });
    result.addAll({
      ListingPromotionsRecordFieldsEnum.endsAt.nameInSchema:
          jsonMap[ListingPromotionsRecordFieldsEnum.endsAt.nameInSchema]
    });
    result.addAll({
      ListingPromotionsRecordFieldsEnum.status.nameInSchema:
          jsonMap[ListingPromotionsRecordFieldsEnum.status.nameInSchema]
    });
    if (payment != null) {
      result.addAll({
        ListingPromotionsRecordFieldsEnum.payment.nameInSchema:
            jsonMap[ListingPromotionsRecordFieldsEnum.payment.nameInSchema]
      });
    }
    if (created != null) {
      result.addAll({
        ListingPromotionsRecordFieldsEnum.created.nameInSchema:
            jsonMap[ListingPromotionsRecordFieldsEnum.created.nameInSchema]
      });
    }
    if (updated != null) {
      result.addAll({
        ListingPromotionsRecordFieldsEnum.updated.nameInSchema:
            jsonMap[ListingPromotionsRecordFieldsEnum.updated.nameInSchema]
      });
    }
    return result;
  }
}
