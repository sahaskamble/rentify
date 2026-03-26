// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categories_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoriesRecord _$CategoriesRecordFromJson(Map<String, dynamic> json) =>
    CategoriesRecord(
      id: json['id'] as String,
      collectionId: json['collectionId'] as String,
      collectionName: json['collectionName'] as String,
      name: json['name'] as String,
      slug: json['slug'] as String,
      parent: json['parent'] as String?,
      icon: json['icon'] as String?,
      iconColor: json['icon_color'] as String?,
      sortOrder: (json['sort_order'] as num?)?.toDouble(),
      isActive: json['is_active'] as bool,
      created: json['created'] == null
          ? null
          : DateTime.parse(json['created'] as String),
      updated: json['updated'] == null
          ? null
          : DateTime.parse(json['updated'] as String),
    );

Map<String, dynamic> _$CategoriesRecordToJson(CategoriesRecord instance) =>
    <String, dynamic>{
      'id': instance.id,
      'collectionId': instance.collectionId,
      'collectionName': instance.collectionName,
      'name': instance.name,
      'slug': instance.slug,
      'parent': instance.parent,
      'icon': instance.icon,
      'icon_color': instance.iconColor,
      'sort_order': instance.sortOrder,
      'is_active': instance.isActive,
      'created': instance.created?.toIso8601String(),
      'updated': instance.updated?.toIso8601String(),
    };
