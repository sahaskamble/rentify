import 'package:pocketbase/pocketbase.dart';

class CategoryModel {
  final String id;
  final String name;
  final String slug;
  final String? parent;
  final String? icon;
  final String? iconColor;
  final int sortOrder;
  final bool isActive;
  final DateTime created;
  final DateTime updated;

  CategoryModel({
    required this.id,
    required this.name,
    required this.slug,
    this.parent,
    this.icon,
    this.iconColor,
    this.sortOrder = 0,
    this.isActive = true,
    required this.created,
    required this.updated,
  });

  factory CategoryModel.fromPocketBase(RecordModel record) {
    return CategoryModel(
      id: record.id,
      name: record.getStringValue('name') as String? ?? '',
      slug: record.getStringValue('slug') as String? ?? '',
      parent: record.getStringValue('parent'),
      icon: record.getStringValue('icon'),
      iconColor: record.getStringValue('icon_color'),
      sortOrder: record.getIntValue('sort_order') as int? ?? 0,
      isActive: record.getBoolValue('is_active') as bool? ?? true,
      created: _parseDateTime(record.data['created']),
      updated: _parseDateTime(record.data['updated']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'slug': slug,
      'parent': parent,
      'icon': icon,
      'icon_color': iconColor,
      'sort_order': sortOrder,
      'is_active': isActive,
    };
  }

  static DateTime _parseDateTime(dynamic value) {
    if (value is String) {
      return DateTime.parse(value);
    }
    return DateTime.now();
  }
}
