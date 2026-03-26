// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'disputes_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DisputesRecord _$DisputesRecordFromJson(
  Map<String, dynamic> json,
) => DisputesRecord(
  id: json['id'] as String,
  collectionId: json['collectionId'] as String,
  collectionName: json['collectionName'] as String,
  rental: json['rental'] as String,
  raisedBy: json['raised_by'] as String,
  raisedAgainst: json['raised_against'] as String,
  category: $enumDecode(_$DisputesRecordCategoryEnumEnumMap, json['category']),
  description: json['description'] as String,
  status: $enumDecode(_$DisputesRecordStatusEnumEnumMap, json['status']),
  evidence: (json['evidence'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  decision: $enumDecodeNullable(
    _$DisputesRecordDecisionEnumEnumMap,
    json['decision'],
    unknownValue: JsonKey.nullForUndefinedEnumValue,
  ),
  resolutionNote: json['resolution_note'] as String?,
  refundAmount: (json['refund_amount'] as num?)?.toDouble(),
  resolvedBy: json['resolved_by'] as String?,
  resolvedAt: pocketBaseNullableDateTimeFromJson(json['resolved_at'] as String),
  created: json['created'] == null
      ? null
      : DateTime.parse(json['created'] as String),
  updated: json['updated'] == null
      ? null
      : DateTime.parse(json['updated'] as String),
);

Map<String, dynamic> _$DisputesRecordToJson(DisputesRecord instance) =>
    <String, dynamic>{
      'id': instance.id,
      'collectionId': instance.collectionId,
      'collectionName': instance.collectionName,
      'rental': instance.rental,
      'raised_by': instance.raisedBy,
      'raised_against': instance.raisedAgainst,
      'category': _$DisputesRecordCategoryEnumEnumMap[instance.category]!,
      'description': instance.description,
      'status': _$DisputesRecordStatusEnumEnumMap[instance.status]!,
      'evidence': instance.evidence,
      'decision': _$DisputesRecordDecisionEnumEnumMap[instance.decision],
      'resolution_note': instance.resolutionNote,
      'refund_amount': instance.refundAmount,
      'resolved_by': instance.resolvedBy,
      'resolved_at': pocketBaseNullableDateTimeToJson(instance.resolvedAt),
      'created': instance.created?.toIso8601String(),
      'updated': instance.updated?.toIso8601String(),
    };

const _$DisputesRecordCategoryEnumEnumMap = {
  DisputesRecordCategoryEnum.itemDamaged: 'item_damaged',
  DisputesRecordCategoryEnum.itemNotReturned: 'item_not_returned',
  DisputesRecordCategoryEnum.itemNotAsDescribed: 'item_not_as_described',
  DisputesRecordCategoryEnum.noShow: 'no_show',
  DisputesRecordCategoryEnum.paymentIssue: 'payment_issue',
  DisputesRecordCategoryEnum.other: 'other',
};

const _$DisputesRecordStatusEnumEnumMap = {
  DisputesRecordStatusEnum.open: 'open',
  DisputesRecordStatusEnum.underReview: 'under_review',
  DisputesRecordStatusEnum.awaitingResponse: 'awaiting_response',
  DisputesRecordStatusEnum.resolved: 'resolved',
  DisputesRecordStatusEnum.closed: 'closed',
};

const _$DisputesRecordDecisionEnumEnumMap = {
  DisputesRecordDecisionEnum.favourRenter: 'favour_renter',
  DisputesRecordDecisionEnum.favourSeller: 'favour_seller',
  DisputesRecordDecisionEnum.split: 'split',
  DisputesRecordDecisionEnum.noAction: 'no_action',
};
