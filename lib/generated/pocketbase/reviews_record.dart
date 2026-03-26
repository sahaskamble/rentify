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

part 'reviews_record.g.dart';

enum ReviewsRecordFieldsEnum {
  id('id'),
  collectionId('collectionId'),
  collectionName('collectionName'),
  rental('rental'),
  reviewer('reviewer'),
  reviewee('reviewee'),
  listing('listing'),
  type('type'),
  rating('rating'),
  comment('comment'),
  isVisible('is_visible'),
  created('created'),
  updated('updated');

  const ReviewsRecordFieldsEnum(this.nameInSchema);

  final String nameInSchema;
}

enum ReviewsRecordTypeEnum {
  @_i1.JsonValue('renter_to_seller')
  renterToSeller('renter_to_seller'),
  @_i1.JsonValue('seller_to_renter')
  sellerToRenter('seller_to_renter');

  const ReviewsRecordTypeEnum(this.nameInSchema);

  final String nameInSchema;
}

@_i1.JsonSerializable()
final class ReviewsRecord extends _i2.BaseRecord {
  ReviewsRecord({
    required super.id,
    required super.collectionId,
    required super.collectionName,
    required this.rental,
    required this.reviewer,
    required this.reviewee,
    required this.listing,
    required this.type,
    required this.rating,
    this.comment,
    required this.isVisible,
    this.created,
    this.updated,
  }) : super();

  factory ReviewsRecord.fromJson(Map<String, dynamic> json) =>
      _$ReviewsRecordFromJson(json);

  factory ReviewsRecord.fromRecordModel(_i3.RecordModel recordModel) {
    final extendedJsonMap = {
      ...recordModel.data,
      ReviewsRecordFieldsEnum.id.nameInSchema: recordModel.id,
      ReviewsRecordFieldsEnum.collectionId.nameInSchema:
          recordModel.collectionId,
      ReviewsRecordFieldsEnum.collectionName.nameInSchema:
          recordModel.collectionName,
    };
    return ReviewsRecord.fromJson(extendedJsonMap);
  }

  final String rental;

  final String reviewer;

  final String reviewee;

  final String listing;

  final ReviewsRecordTypeEnum type;

  final double rating;

  static const ratingMinValue = 1;

  static const ratingMaxValue = 5;

  final String? comment;

  static const commentMinValue = 0;

  static const commentMaxValue = 1000;

  @_i1.JsonKey(name: 'is_visible')
  final bool isVisible;

  final DateTime? created;

  final DateTime? updated;

  static const $collectionId = 'review00000001a';

  static const $collectionName = 'reviews';

  Map<String, dynamic> toJson() => _$ReviewsRecordToJson(this);

  ReviewsRecord copyWith({
    String? rental,
    String? reviewer,
    String? reviewee,
    String? listing,
    ReviewsRecordTypeEnum? type,
    double? rating,
    String? comment,
    bool? isVisible,
    DateTime? created,
    DateTime? updated,
  }) {
    return ReviewsRecord(
      id: id,
      collectionId: collectionId,
      collectionName: collectionName,
      rental: rental ?? this.rental,
      reviewer: reviewer ?? this.reviewer,
      reviewee: reviewee ?? this.reviewee,
      listing: listing ?? this.listing,
      type: type ?? this.type,
      rating: rating ?? this.rating,
      comment: comment ?? this.comment,
      isVisible: isVisible ?? this.isVisible,
      created: created ?? this.created,
      updated: updated ?? this.updated,
    );
  }

  Map<String, dynamic> takeDiff(ReviewsRecord other) {
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
        reviewer,
        reviewee,
        listing,
        type,
        rating,
        comment,
        isVisible,
        created,
        updated,
      ];

  static Map<String, dynamic> forCreateRequest({
    required String rental,
    required String reviewer,
    required String reviewee,
    required String listing,
    required ReviewsRecordTypeEnum type,
    required double rating,
    String? comment,
    required bool isVisible,
    DateTime? created,
    DateTime? updated,
  }) {
    final jsonMap = ReviewsRecord(
      id: '',
      collectionId: $collectionId,
      collectionName: $collectionName,
      rental: rental,
      reviewer: reviewer,
      reviewee: reviewee,
      listing: listing,
      type: type,
      rating: rating,
      comment: comment,
      isVisible: isVisible,
      created: created,
      updated: updated,
    ).toJson();
    final Map<String, dynamic> result = {};
    result.addAll({
      ReviewsRecordFieldsEnum.rental.nameInSchema:
          jsonMap[ReviewsRecordFieldsEnum.rental.nameInSchema]
    });
    result.addAll({
      ReviewsRecordFieldsEnum.reviewer.nameInSchema:
          jsonMap[ReviewsRecordFieldsEnum.reviewer.nameInSchema]
    });
    result.addAll({
      ReviewsRecordFieldsEnum.reviewee.nameInSchema:
          jsonMap[ReviewsRecordFieldsEnum.reviewee.nameInSchema]
    });
    result.addAll({
      ReviewsRecordFieldsEnum.listing.nameInSchema:
          jsonMap[ReviewsRecordFieldsEnum.listing.nameInSchema]
    });
    result.addAll({
      ReviewsRecordFieldsEnum.type.nameInSchema:
          jsonMap[ReviewsRecordFieldsEnum.type.nameInSchema]
    });
    result.addAll({
      ReviewsRecordFieldsEnum.rating.nameInSchema:
          jsonMap[ReviewsRecordFieldsEnum.rating.nameInSchema]
    });
    if (comment != null) {
      result.addAll({
        ReviewsRecordFieldsEnum.comment.nameInSchema:
            jsonMap[ReviewsRecordFieldsEnum.comment.nameInSchema]
      });
    }
    result.addAll({
      ReviewsRecordFieldsEnum.isVisible.nameInSchema:
          jsonMap[ReviewsRecordFieldsEnum.isVisible.nameInSchema]
    });
    if (created != null) {
      result.addAll({
        ReviewsRecordFieldsEnum.created.nameInSchema:
            jsonMap[ReviewsRecordFieldsEnum.created.nameInSchema]
      });
    }
    if (updated != null) {
      result.addAll({
        ReviewsRecordFieldsEnum.updated.nameInSchema:
            jsonMap[ReviewsRecordFieldsEnum.updated.nameInSchema]
      });
    }
    return result;
  }
}
