import 'package:pocketbase/pocketbase.dart';

class UserVerificationModel {
  final String id;
  final String userId;
  final String type;
  final String status;
  final List<String> documents;
  final String? rejectionReason;
  final String? reviewedBy;
  final DateTime? verifiedAt;
  final DateTime created;
  final DateTime updated;

  UserVerificationModel({
    required this.id,
    required this.userId,
    required this.type,
    required this.status,
    this.documents = const [],
    this.rejectionReason,
    this.reviewedBy,
    this.verifiedAt,
    required this.created,
    required this.updated,
  });

  factory UserVerificationModel.fromPocketBase(RecordModel record) {
    final documents = record.getListValue('document');

    return UserVerificationModel(
      id: record.id,
      userId: record.getStringValue('user') as String? ?? '',
      type: record.getStringValue('type') as String? ?? 'otp',
      status: record.getStringValue('status') as String? ?? 'pending',
      documents: documents.cast<String>(),
      rejectionReason: record.getStringValue('rejection_reason'),
      reviewedBy: record.getStringValue('reviewed_by'),
      verifiedAt: _parseDateTimeNullable(record.data['verified_at']),
      created: _parseDateTime(record.data['created']),
      updated: _parseDateTime(record.data['updated']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': userId,
      'type': type,
      'status': status,
      'document': documents,
      'rejection_reason': rejectionReason,
      'reviewed_by': reviewedBy,
      'verified_at': verifiedAt?.toIso8601String(),
    };
  }

  static DateTime _parseDateTime(dynamic value) {
    if (value is String) {
      return DateTime.parse(value);
    }
    return DateTime.now();
  }

  static DateTime? _parseDateTimeNullable(dynamic value) {
    if (value is String) {
      return DateTime.parse(value);
    }
    return null;
  }
}
