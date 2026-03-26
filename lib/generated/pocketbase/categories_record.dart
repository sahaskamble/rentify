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

part 'categories_record.g.dart';

enum CategoriesRecordFieldsEnum {
  id('id'),
  collectionId('collectionId'),
  collectionName('collectionName'),
  name('name'),
  slug('slug'),
  parent('parent'),
  icon('icon'),
  iconColor('icon_color'),
  sortOrder('sort_order'),
  isActive('is_active'),
  created('created'),
  updated('updated');

  const CategoriesRecordFieldsEnum(this.nameInSchema);

  final String nameInSchema;
}

@_i1.JsonSerializable()
final class CategoriesRecord extends _i2.BaseRecord {
  CategoriesRecord({
    required super.id,
    required super.collectionId,
    required super.collectionName,
    required this.name,
    required this.slug,
    this.parent,
    this.icon,
    this.iconColor,
    this.sortOrder,
    required this.isActive,
    this.created,
    this.updated,
  }) : super();

  factory CategoriesRecord.fromJson(Map<String, dynamic> json) =>
      _$CategoriesRecordFromJson(json);

  factory CategoriesRecord.fromRecordModel(_i3.RecordModel recordModel) {
    final extendedJsonMap = {
      ...recordModel.data,
      CategoriesRecordFieldsEnum.id.nameInSchema: recordModel.id,
      CategoriesRecordFieldsEnum.collectionId.nameInSchema:
          recordModel.collectionId,
      CategoriesRecordFieldsEnum.collectionName.nameInSchema:
          recordModel.collectionName,
    };
    return CategoriesRecord.fromJson(extendedJsonMap);
  }

  final String name;

  static const nameMinValue = 2;

  static const nameMaxValue = 100;

  final String slug;

  static const slugMinValue = 2;

  static const slugMaxValue = 100;

  final String? parent;

  final String? icon;

  @_i1.JsonKey(name: 'icon_color')
  final String? iconColor;

  static const icon_colorMinValue = 0;

  static const icon_colorMaxValue = 10;

  @_i1.JsonKey(name: 'sort_order')
  final double? sortOrder;

  static const sort_orderMinValue = 0;

  @_i1.JsonKey(name: 'is_active')
  final bool isActive;

  final DateTime? created;

  final DateTime? updated;

  static const $collectionId = 'category000001a';

  static const $collectionName = 'categories';

  Map<String, dynamic> toJson() => _$CategoriesRecordToJson(this);

  CategoriesRecord copyWith({
    String? name,
    String? slug,
    String? parent,
    String? icon,
    String? iconColor,
    double? sortOrder,
    bool? isActive,
    DateTime? created,
    DateTime? updated,
  }) {
    return CategoriesRecord(
      id: id,
      collectionId: collectionId,
      collectionName: collectionName,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      parent: parent ?? this.parent,
      icon: icon ?? this.icon,
      iconColor: iconColor ?? this.iconColor,
      sortOrder: sortOrder ?? this.sortOrder,
      isActive: isActive ?? this.isActive,
      created: created ?? this.created,
      updated: updated ?? this.updated,
    );
  }

  Map<String, dynamic> takeDiff(CategoriesRecord other) {
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
        slug,
        parent,
        icon,
        iconColor,
        sortOrder,
        isActive,
        created,
        updated,
      ];

  static Map<String, dynamic> forCreateRequest({
    required String name,
    required String slug,
    String? parent,
    String? icon,
    String? iconColor,
    double? sortOrder,
    required bool isActive,
    DateTime? created,
    DateTime? updated,
  }) {
    final jsonMap = CategoriesRecord(
      id: '',
      collectionId: $collectionId,
      collectionName: $collectionName,
      name: name,
      slug: slug,
      parent: parent,
      icon: icon,
      iconColor: iconColor,
      sortOrder: sortOrder,
      isActive: isActive,
      created: created,
      updated: updated,
    ).toJson();
    final Map<String, dynamic> result = {};
    result.addAll({
      CategoriesRecordFieldsEnum.name.nameInSchema:
          jsonMap[CategoriesRecordFieldsEnum.name.nameInSchema]
    });
    result.addAll({
      CategoriesRecordFieldsEnum.slug.nameInSchema:
          jsonMap[CategoriesRecordFieldsEnum.slug.nameInSchema]
    });
    if (parent != null) {
      result.addAll({
        CategoriesRecordFieldsEnum.parent.nameInSchema:
            jsonMap[CategoriesRecordFieldsEnum.parent.nameInSchema]
      });
    }
    if (icon != null) {
      result.addAll({
        CategoriesRecordFieldsEnum.icon.nameInSchema:
            jsonMap[CategoriesRecordFieldsEnum.icon.nameInSchema]
      });
    }
    if (iconColor != null) {
      result.addAll({
        CategoriesRecordFieldsEnum.iconColor.nameInSchema:
            jsonMap[CategoriesRecordFieldsEnum.iconColor.nameInSchema]
      });
    }
    if (sortOrder != null) {
      result.addAll({
        CategoriesRecordFieldsEnum.sortOrder.nameInSchema:
            jsonMap[CategoriesRecordFieldsEnum.sortOrder.nameInSchema]
      });
    }
    result.addAll({
      CategoriesRecordFieldsEnum.isActive.nameInSchema:
          jsonMap[CategoriesRecordFieldsEnum.isActive.nameInSchema]
    });
    if (created != null) {
      result.addAll({
        CategoriesRecordFieldsEnum.created.nameInSchema:
            jsonMap[CategoriesRecordFieldsEnum.created.nameInSchema]
      });
    }
    if (updated != null) {
      result.addAll({
        CategoriesRecordFieldsEnum.updated.nameInSchema:
            jsonMap[CategoriesRecordFieldsEnum.updated.nameInSchema]
      });
    }
    return result;
  }
}
