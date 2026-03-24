import 'package:pocketbase/pocketbase.dart';

class UserModel {
  final String id;
  final String email;
  final String? name;
  final String? avatar;
  final String? phone;
  final String? role;
  final bool isPhoneVerified;
  final bool isIdVerified;
  final String? city;
  final String? area;
  final DateTime created;
  final DateTime updated;

  UserModel({
    required this.id,
    required this.email,
    this.name,
    this.avatar,
    this.phone,
    this.role,
    this.isPhoneVerified = false,
    this.isIdVerified = false,
    this.city,
    this.area,
    required this.created,
    required this.updated,
  });

  factory UserModel.fromPocketBase(RecordModel record) {
    return UserModel(
      id: record.id,
      email: record.getStringValue('email') as String? ?? '',
      name: record.getStringValue('name'),
      avatar: record.getStringValue('avatar'),
      phone: record.getStringValue('phone'),
      role: record.getStringValue('role'),
      isPhoneVerified:
          record.getBoolValue('is_phone_verified') as bool? ?? false,
      isIdVerified: record.getBoolValue('is_id_verified') as bool? ?? false,
      city: record.getStringValue('city'),
      area: record.getStringValue('area'),
      created: _parseDateTime(record.data['created']),
      updated: _parseDateTime(record.data['updated']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'name': name,
      'phone': phone,
      'role': role,
      'city': city,
      'area': area,
    };
  }

  static DateTime _parseDateTime(dynamic value) {
    if (value is String) {
      return DateTime.parse(value);
    }
    return DateTime.now();
  }
}
