import 'package:pocketbase/pocketbase.dart';

class ListingModel {
  final String id;
  final String sellerId;
  final String categoryId;
  final String title;
  final String description;
  final String condition;
  final double pricePerDay;
  final double? pricePerWeek;
  final double? pricePerMonth;
  final double securityDeposit;
  final int? minRentalDays;
  final int? maxRentalDays;
  final int quantity;
  final List<String> images;
  final String status;
  final bool isFeatured;
  final double avgRating;
  final int totalRentals;
  final List<String> tags;
  final DateTime created;
  final DateTime updated;

  ListingModel({
    required this.id,
    required this.sellerId,
    required this.categoryId,
    required this.title,
    required this.description,
    required this.condition,
    required this.pricePerDay,
    this.pricePerWeek,
    this.pricePerMonth,
    required this.securityDeposit,
    this.minRentalDays,
    this.maxRentalDays,
    required this.quantity,
    required this.images,
    required this.status,
    this.isFeatured = false,
    this.avgRating = 0.0,
    this.totalRentals = 0,
    this.tags = const [],
    required this.created,
    required this.updated,
  });

  factory ListingModel.fromPocketBase(RecordModel record) {
    final images = record.getListValue('images');
    final tags = record.getListValue('tags');

    return ListingModel(
      id: record.id,
      sellerId: record.getStringValue('seller') as String? ?? '',
      categoryId: record.getStringValue('category') as String? ?? '',
      title: record.getStringValue('title') as String? ?? '',
      description: record.getStringValue('description') as String? ?? '',
      condition: record.getStringValue('condition') as String? ?? 'good',
      pricePerDay: record.getDoubleValue('price_per_day') as double? ?? 0.0,
      pricePerWeek: record.getDoubleValue('price_per_week'),
      pricePerMonth: record.getDoubleValue('price_per_month'),
      securityDeposit:
          record.getDoubleValue('security_deposit') as double? ?? 0.0,
      minRentalDays: record.getIntValue('min_rental_days'),
      maxRentalDays: record.getIntValue('max_rental_days'),
      quantity: record.getIntValue('quantity') as int? ?? 1,
      images: images.cast<String>(),
      status: record.getStringValue('status') as String? ?? 'draft',
      isFeatured: record.getBoolValue('is_featured') as bool? ?? false,
      avgRating: record.getDoubleValue('avg_rating') as double? ?? 0.0,
      totalRentals: record.getIntValue('total_rentals') as int? ?? 0,
      tags: tags.cast<String>(),
      created: _parseDateTime(record.data['created']),
      updated: _parseDateTime(record.data['updated']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'seller': sellerId,
      'category': categoryId,
      'title': title,
      'description': description,
      'condition': condition,
      'price_per_day': pricePerDay,
      'price_per_week': pricePerWeek,
      'price_per_month': pricePerMonth,
      'security_deposit': securityDeposit,
      'min_rental_days': minRentalDays,
      'max_rental_days': maxRentalDays,
      'quantity': quantity,
      'images': images,
      'status': status,
      'is_featured': isFeatured,
      'avg_rating': avgRating,
      'total_rentals': totalRentals,
      'tags': tags,
    };
  }

  static DateTime _parseDateTime(dynamic value) {
    if (value is String) {
      return DateTime.parse(value);
    }
    return DateTime.now();
  }
}
