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

part 'listings_record.g.dart';

enum ListingsRecordFieldsEnum {
  id('id'),
  collectionId('collectionId'),
  collectionName('collectionName'),
  seller('seller'),
  category('category'),
  title('title'),
  description('description'),
  condition('condition'),
  pricePerDay('price_per_day'),
  securityDeposit('security_deposit'),
  quantity('quantity'),
  images('images'),
  status('status'),
  pricePerWeek('price_per_week'),
  pricePerMonth('price_per_month'),
  minRentalDays('min_rental_days'),
  maxRentalDays('max_rental_days'),
  isFeatured('is_featured'),
  avgRating('avg_rating'),
  totalRentals('total_rentals'),
  tags('tags'),
  created('created'),
  updated('updated');

  const ListingsRecordFieldsEnum(this.nameInSchema);

  final String nameInSchema;
}

enum ListingsRecordConditionEnum {
  @_i1.JsonValue('like_new')
  likeNew('like_new'),
  @_i1.JsonValue('good')
  good('good'),
  @_i1.JsonValue('fair')
  fair('fair'),
  @_i1.JsonValue('brand_new')
  brandNew('brand_new');

  const ListingsRecordConditionEnum(this.nameInSchema);

  final String nameInSchema;
}

enum ListingsRecordStatusEnum {
  @_i1.JsonValue('draft')
  draft('draft'),
  @_i1.JsonValue('pending_review')
  pendingReview('pending_review'),
  @_i1.JsonValue('active')
  active('active'),
  @_i1.JsonValue('paused')
  paused('paused'),
  @_i1.JsonValue('removed')
  removed('removed');

  const ListingsRecordStatusEnum(this.nameInSchema);

  final String nameInSchema;
}

@_i1.JsonSerializable()
final class ListingsRecord extends _i2.BaseRecord {
  ListingsRecord({
    required super.id,
    required super.collectionId,
    required super.collectionName,
    required this.seller,
    required this.category,
    required this.title,
    required this.description,
    required this.condition,
    required this.pricePerDay,
    required this.securityDeposit,
    required this.quantity,
    required this.images,
    required this.status,
    this.pricePerWeek,
    this.pricePerMonth,
    this.minRentalDays,
    this.maxRentalDays,
    required this.isFeatured,
    this.avgRating,
    this.totalRentals,
    this.tags,
    this.created,
    this.updated,
  }) : super();

  factory ListingsRecord.fromJson(Map<String, dynamic> json) =>
      _$ListingsRecordFromJson(json);

  factory ListingsRecord.fromRecordModel(_i3.RecordModel recordModel) {
    final extendedJsonMap = {
      ...recordModel.data,
      ListingsRecordFieldsEnum.id.nameInSchema: recordModel.id,
      ListingsRecordFieldsEnum.collectionId.nameInSchema:
          recordModel.collectionId,
      ListingsRecordFieldsEnum.collectionName.nameInSchema:
          recordModel.collectionName,
    };
    return ListingsRecord.fromJson(extendedJsonMap);
  }

  final String seller;

  final String category;

  final String title;

  static const titleMinValue = 5;

  static const titleMaxValue = 200;

  final String description;

  final ListingsRecordConditionEnum condition;

  @_i1.JsonKey(name: 'price_per_day')
  final double pricePerDay;

  static const price_per_dayMinValue = 1;

  @_i1.JsonKey(name: 'security_deposit')
  final double securityDeposit;

  static const security_depositMinValue = 0;

  final double quantity;

  static const quantityMinValue = 1;

  final List<String> images;

  final ListingsRecordStatusEnum status;

  @_i1.JsonKey(name: 'price_per_week')
  final double? pricePerWeek;

  static const price_per_weekMinValue = 1;

  @_i1.JsonKey(name: 'price_per_month')
  final double? pricePerMonth;

  static const price_per_monthMinValue = 1;

  @_i1.JsonKey(name: 'min_rental_days')
  final double? minRentalDays;

  static const min_rental_daysMinValue = 1;

  @_i1.JsonKey(name: 'max_rental_days')
  final double? maxRentalDays;

  static const max_rental_daysMinValue = 1;

  @_i1.JsonKey(name: 'is_featured')
  final bool isFeatured;

  @_i1.JsonKey(name: 'avg_rating')
  final double? avgRating;

  static const avg_ratingMinValue = 0;

  static const avg_ratingMaxValue = 5;

  @_i1.JsonKey(name: 'total_rentals')
  final double? totalRentals;

  static const total_rentalsMinValue = 0;

  final dynamic tags;

  final DateTime? created;

  final DateTime? updated;

  static const $collectionId = 'listing000001ab';

  static const $collectionName = 'listings';

  Map<String, dynamic> toJson() => _$ListingsRecordToJson(this);

  ListingsRecord copyWith({
    String? seller,
    String? category,
    String? title,
    String? description,
    ListingsRecordConditionEnum? condition,
    double? pricePerDay,
    double? securityDeposit,
    double? quantity,
    List<String>? images,
    ListingsRecordStatusEnum? status,
    double? pricePerWeek,
    double? pricePerMonth,
    double? minRentalDays,
    double? maxRentalDays,
    bool? isFeatured,
    double? avgRating,
    double? totalRentals,
    dynamic tags,
    DateTime? created,
    DateTime? updated,
  }) {
    return ListingsRecord(
      id: id,
      collectionId: collectionId,
      collectionName: collectionName,
      seller: seller ?? this.seller,
      category: category ?? this.category,
      title: title ?? this.title,
      description: description ?? this.description,
      condition: condition ?? this.condition,
      pricePerDay: pricePerDay ?? this.pricePerDay,
      securityDeposit: securityDeposit ?? this.securityDeposit,
      quantity: quantity ?? this.quantity,
      images: images ?? this.images,
      status: status ?? this.status,
      pricePerWeek: pricePerWeek ?? this.pricePerWeek,
      pricePerMonth: pricePerMonth ?? this.pricePerMonth,
      minRentalDays: minRentalDays ?? this.minRentalDays,
      maxRentalDays: maxRentalDays ?? this.maxRentalDays,
      isFeatured: isFeatured ?? this.isFeatured,
      avgRating: avgRating ?? this.avgRating,
      totalRentals: totalRentals ?? this.totalRentals,
      tags: tags ?? this.tags,
      created: created ?? this.created,
      updated: updated ?? this.updated,
    );
  }

  Map<String, dynamic> takeDiff(ListingsRecord other) {
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
        seller,
        category,
        title,
        description,
        condition,
        pricePerDay,
        securityDeposit,
        quantity,
        images,
        status,
        pricePerWeek,
        pricePerMonth,
        minRentalDays,
        maxRentalDays,
        isFeatured,
        avgRating,
        totalRentals,
        tags,
        created,
        updated,
      ];

  static Map<String, dynamic> forCreateRequest({
    required String seller,
    required String category,
    required String title,
    required String description,
    required ListingsRecordConditionEnum condition,
    required double pricePerDay,
    required double securityDeposit,
    required double quantity,
    required List<String> images,
    required ListingsRecordStatusEnum status,
    double? pricePerWeek,
    double? pricePerMonth,
    double? minRentalDays,
    double? maxRentalDays,
    required bool isFeatured,
    double? avgRating,
    double? totalRentals,
    dynamic tags,
    DateTime? created,
    DateTime? updated,
  }) {
    final jsonMap = ListingsRecord(
      id: '',
      collectionId: $collectionId,
      collectionName: $collectionName,
      seller: seller,
      category: category,
      title: title,
      description: description,
      condition: condition,
      pricePerDay: pricePerDay,
      securityDeposit: securityDeposit,
      quantity: quantity,
      images: images,
      status: status,
      pricePerWeek: pricePerWeek,
      pricePerMonth: pricePerMonth,
      minRentalDays: minRentalDays,
      maxRentalDays: maxRentalDays,
      isFeatured: isFeatured,
      avgRating: avgRating,
      totalRentals: totalRentals,
      tags: tags,
      created: created,
      updated: updated,
    ).toJson();
    final Map<String, dynamic> result = {};
    result.addAll({
      ListingsRecordFieldsEnum.seller.nameInSchema:
          jsonMap[ListingsRecordFieldsEnum.seller.nameInSchema]
    });
    result.addAll({
      ListingsRecordFieldsEnum.category.nameInSchema:
          jsonMap[ListingsRecordFieldsEnum.category.nameInSchema]
    });
    result.addAll({
      ListingsRecordFieldsEnum.title.nameInSchema:
          jsonMap[ListingsRecordFieldsEnum.title.nameInSchema]
    });
    result.addAll({
      ListingsRecordFieldsEnum.description.nameInSchema:
          jsonMap[ListingsRecordFieldsEnum.description.nameInSchema]
    });
    result.addAll({
      ListingsRecordFieldsEnum.condition.nameInSchema:
          jsonMap[ListingsRecordFieldsEnum.condition.nameInSchema]
    });
    result.addAll({
      ListingsRecordFieldsEnum.pricePerDay.nameInSchema:
          jsonMap[ListingsRecordFieldsEnum.pricePerDay.nameInSchema]
    });
    result.addAll({
      ListingsRecordFieldsEnum.securityDeposit.nameInSchema:
          jsonMap[ListingsRecordFieldsEnum.securityDeposit.nameInSchema]
    });
    result.addAll({
      ListingsRecordFieldsEnum.quantity.nameInSchema:
          jsonMap[ListingsRecordFieldsEnum.quantity.nameInSchema]
    });
    result.addAll({
      ListingsRecordFieldsEnum.images.nameInSchema:
          jsonMap[ListingsRecordFieldsEnum.images.nameInSchema]
    });
    result.addAll({
      ListingsRecordFieldsEnum.status.nameInSchema:
          jsonMap[ListingsRecordFieldsEnum.status.nameInSchema]
    });
    if (pricePerWeek != null) {
      result.addAll({
        ListingsRecordFieldsEnum.pricePerWeek.nameInSchema:
            jsonMap[ListingsRecordFieldsEnum.pricePerWeek.nameInSchema]
      });
    }
    if (pricePerMonth != null) {
      result.addAll({
        ListingsRecordFieldsEnum.pricePerMonth.nameInSchema:
            jsonMap[ListingsRecordFieldsEnum.pricePerMonth.nameInSchema]
      });
    }
    if (minRentalDays != null) {
      result.addAll({
        ListingsRecordFieldsEnum.minRentalDays.nameInSchema:
            jsonMap[ListingsRecordFieldsEnum.minRentalDays.nameInSchema]
      });
    }
    if (maxRentalDays != null) {
      result.addAll({
        ListingsRecordFieldsEnum.maxRentalDays.nameInSchema:
            jsonMap[ListingsRecordFieldsEnum.maxRentalDays.nameInSchema]
      });
    }
    result.addAll({
      ListingsRecordFieldsEnum.isFeatured.nameInSchema:
          jsonMap[ListingsRecordFieldsEnum.isFeatured.nameInSchema]
    });
    if (avgRating != null) {
      result.addAll({
        ListingsRecordFieldsEnum.avgRating.nameInSchema:
            jsonMap[ListingsRecordFieldsEnum.avgRating.nameInSchema]
      });
    }
    if (totalRentals != null) {
      result.addAll({
        ListingsRecordFieldsEnum.totalRentals.nameInSchema:
            jsonMap[ListingsRecordFieldsEnum.totalRentals.nameInSchema]
      });
    }
    if (tags != null) {
      result.addAll({
        ListingsRecordFieldsEnum.tags.nameInSchema:
            jsonMap[ListingsRecordFieldsEnum.tags.nameInSchema]
      });
    }
    if (created != null) {
      result.addAll({
        ListingsRecordFieldsEnum.created.nameInSchema:
            jsonMap[ListingsRecordFieldsEnum.created.nameInSchema]
      });
    }
    if (updated != null) {
      result.addAll({
        ListingsRecordFieldsEnum.updated.nameInSchema:
            jsonMap[ListingsRecordFieldsEnum.updated.nameInSchema]
      });
    }
    return result;
  }
}
