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

part 'disputes_record.g.dart';

enum DisputesRecordFieldsEnum {
  id('id'),
  collectionId('collectionId'),
  collectionName('collectionName'),
  rental('rental'),
  raisedBy('raised_by'),
  raisedAgainst('raised_against'),
  category('category'),
  description('description'),
  status('status'),
  evidence('evidence'),
  decision('decision'),
  resolutionNote('resolution_note'),
  refundAmount('refund_amount'),
  resolvedBy('resolved_by'),
  resolvedAt('resolved_at'),
  created('created'),
  updated('updated');

  const DisputesRecordFieldsEnum(this.nameInSchema);

  final String nameInSchema;
}

enum DisputesRecordCategoryEnum {
  @_i1.JsonValue('item_damaged')
  itemDamaged('item_damaged'),
  @_i1.JsonValue('item_not_returned')
  itemNotReturned('item_not_returned'),
  @_i1.JsonValue('item_not_as_described')
  itemNotAsDescribed('item_not_as_described'),
  @_i1.JsonValue('no_show')
  noShow('no_show'),
  @_i1.JsonValue('payment_issue')
  paymentIssue('payment_issue'),
  @_i1.JsonValue('other')
  other('other');

  const DisputesRecordCategoryEnum(this.nameInSchema);

  final String nameInSchema;
}

enum DisputesRecordStatusEnum {
  @_i1.JsonValue('open')
  open('open'),
  @_i1.JsonValue('under_review')
  underReview('under_review'),
  @_i1.JsonValue('awaiting_response')
  awaitingResponse('awaiting_response'),
  @_i1.JsonValue('resolved')
  resolved('resolved'),
  @_i1.JsonValue('closed')
  closed('closed');

  const DisputesRecordStatusEnum(this.nameInSchema);

  final String nameInSchema;
}

enum DisputesRecordDecisionEnum {
  @_i1.JsonValue('favour_renter')
  favourRenter('favour_renter'),
  @_i1.JsonValue('favour_seller')
  favourSeller('favour_seller'),
  @_i1.JsonValue('split')
  split('split'),
  @_i1.JsonValue('no_action')
  noAction('no_action');

  const DisputesRecordDecisionEnum(this.nameInSchema);

  final String nameInSchema;
}

@_i1.JsonSerializable()
final class DisputesRecord extends _i2.BaseRecord {
  DisputesRecord({
    required super.id,
    required super.collectionId,
    required super.collectionName,
    required this.rental,
    required this.raisedBy,
    required this.raisedAgainst,
    required this.category,
    required this.description,
    required this.status,
    this.evidence,
    this.decision,
    this.resolutionNote,
    this.refundAmount,
    this.resolvedBy,
    this.resolvedAt,
    this.created,
    this.updated,
  }) : super();

  factory DisputesRecord.fromJson(Map<String, dynamic> json) =>
      _$DisputesRecordFromJson(json);

  factory DisputesRecord.fromRecordModel(_i3.RecordModel recordModel) {
    final extendedJsonMap = {
      ...recordModel.data,
      DisputesRecordFieldsEnum.id.nameInSchema: recordModel.id,
      DisputesRecordFieldsEnum.collectionId.nameInSchema:
          recordModel.collectionId,
      DisputesRecordFieldsEnum.collectionName.nameInSchema:
          recordModel.collectionName,
    };
    return DisputesRecord.fromJson(extendedJsonMap);
  }

  final String rental;

  @_i1.JsonKey(name: 'raised_by')
  final String raisedBy;

  @_i1.JsonKey(name: 'raised_against')
  final String raisedAgainst;

  final DisputesRecordCategoryEnum category;

  final String description;

  static const descriptionMinValue = 20;

  static const descriptionMaxValue = 2000;

  final DisputesRecordStatusEnum status;

  final List<String>? evidence;

  @_i1.JsonKey(unknownEnumValue: _i1.JsonKey.nullForUndefinedEnumValue)
  final DisputesRecordDecisionEnum? decision;

  @_i1.JsonKey(name: 'resolution_note')
  final String? resolutionNote;

  static const resolution_noteMinValue = 0;

  static const resolution_noteMaxValue = 2000;

  @_i1.JsonKey(name: 'refund_amount')
  final double? refundAmount;

  static const refund_amountMinValue = 0;

  @_i1.JsonKey(name: 'resolved_by')
  final String? resolvedBy;

  @_i1.JsonKey(
    toJson: pocketBaseNullableDateTimeToJson,
    fromJson: pocketBaseNullableDateTimeFromJson,
    name: 'resolved_at',
  )
  final DateTime? resolvedAt;

  final DateTime? created;

  final DateTime? updated;

  static const $collectionId = 'dispute000001ab';

  static const $collectionName = 'disputes';

  Map<String, dynamic> toJson() => _$DisputesRecordToJson(this);

  DisputesRecord copyWith({
    String? rental,
    String? raisedBy,
    String? raisedAgainst,
    DisputesRecordCategoryEnum? category,
    String? description,
    DisputesRecordStatusEnum? status,
    List<String>? evidence,
    DisputesRecordDecisionEnum? decision,
    String? resolutionNote,
    double? refundAmount,
    String? resolvedBy,
    DateTime? resolvedAt,
    DateTime? created,
    DateTime? updated,
  }) {
    return DisputesRecord(
      id: id,
      collectionId: collectionId,
      collectionName: collectionName,
      rental: rental ?? this.rental,
      raisedBy: raisedBy ?? this.raisedBy,
      raisedAgainst: raisedAgainst ?? this.raisedAgainst,
      category: category ?? this.category,
      description: description ?? this.description,
      status: status ?? this.status,
      evidence: evidence ?? this.evidence,
      decision: decision ?? this.decision,
      resolutionNote: resolutionNote ?? this.resolutionNote,
      refundAmount: refundAmount ?? this.refundAmount,
      resolvedBy: resolvedBy ?? this.resolvedBy,
      resolvedAt: resolvedAt ?? this.resolvedAt,
      created: created ?? this.created,
      updated: updated ?? this.updated,
    );
  }

  Map<String, dynamic> takeDiff(DisputesRecord other) {
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
        rental,
        raisedBy,
        raisedAgainst,
        category,
        description,
        status,
        evidence,
        decision,
        resolutionNote,
        refundAmount,
        resolvedBy,
        resolvedAt,
        created,
        updated,
      ];

  static Map<String, dynamic> forCreateRequest({
    required String rental,
    required String raisedBy,
    required String raisedAgainst,
    required DisputesRecordCategoryEnum category,
    required String description,
    required DisputesRecordStatusEnum status,
    List<String>? evidence,
    DisputesRecordDecisionEnum? decision,
    String? resolutionNote,
    double? refundAmount,
    String? resolvedBy,
    DateTime? resolvedAt,
    DateTime? created,
    DateTime? updated,
  }) {
    final jsonMap = DisputesRecord(
      id: '',
      collectionId: $collectionId,
      collectionName: $collectionName,
      rental: rental,
      raisedBy: raisedBy,
      raisedAgainst: raisedAgainst,
      category: category,
      description: description,
      status: status,
      evidence: evidence,
      decision: decision,
      resolutionNote: resolutionNote,
      refundAmount: refundAmount,
      resolvedBy: resolvedBy,
      resolvedAt: resolvedAt,
      created: created,
      updated: updated,
    ).toJson();
    final Map<String, dynamic> result = {};
    result.addAll({
      DisputesRecordFieldsEnum.rental.nameInSchema:
          jsonMap[DisputesRecordFieldsEnum.rental.nameInSchema]
    });
    result.addAll({
      DisputesRecordFieldsEnum.raisedBy.nameInSchema:
          jsonMap[DisputesRecordFieldsEnum.raisedBy.nameInSchema]
    });
    result.addAll({
      DisputesRecordFieldsEnum.raisedAgainst.nameInSchema:
          jsonMap[DisputesRecordFieldsEnum.raisedAgainst.nameInSchema]
    });
    result.addAll({
      DisputesRecordFieldsEnum.category.nameInSchema:
          jsonMap[DisputesRecordFieldsEnum.category.nameInSchema]
    });
    result.addAll({
      DisputesRecordFieldsEnum.description.nameInSchema:
          jsonMap[DisputesRecordFieldsEnum.description.nameInSchema]
    });
    result.addAll({
      DisputesRecordFieldsEnum.status.nameInSchema:
          jsonMap[DisputesRecordFieldsEnum.status.nameInSchema]
    });
    if (evidence != null) {
      result.addAll({
        DisputesRecordFieldsEnum.evidence.nameInSchema:
            jsonMap[DisputesRecordFieldsEnum.evidence.nameInSchema]
      });
    }
    if (decision != null) {
      result.addAll({
        DisputesRecordFieldsEnum.decision.nameInSchema:
            jsonMap[DisputesRecordFieldsEnum.decision.nameInSchema]
      });
    }
    if (resolutionNote != null) {
      result.addAll({
        DisputesRecordFieldsEnum.resolutionNote.nameInSchema:
            jsonMap[DisputesRecordFieldsEnum.resolutionNote.nameInSchema]
      });
    }
    if (refundAmount != null) {
      result.addAll({
        DisputesRecordFieldsEnum.refundAmount.nameInSchema:
            jsonMap[DisputesRecordFieldsEnum.refundAmount.nameInSchema]
      });
    }
    if (resolvedBy != null) {
      result.addAll({
        DisputesRecordFieldsEnum.resolvedBy.nameInSchema:
            jsonMap[DisputesRecordFieldsEnum.resolvedBy.nameInSchema]
      });
    }
    if (resolvedAt != null) {
      result.addAll({
        DisputesRecordFieldsEnum.resolvedAt.nameInSchema:
            jsonMap[DisputesRecordFieldsEnum.resolvedAt.nameInSchema]
      });
    }
    if (created != null) {
      result.addAll({
        DisputesRecordFieldsEnum.created.nameInSchema:
            jsonMap[DisputesRecordFieldsEnum.created.nameInSchema]
      });
    }
    if (updated != null) {
      result.addAll({
        DisputesRecordFieldsEnum.updated.nameInSchema:
            jsonMap[DisputesRecordFieldsEnum.updated.nameInSchema]
      });
    }
    return result;
  }
}
