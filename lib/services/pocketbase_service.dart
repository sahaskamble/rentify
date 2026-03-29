import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pocketbase/pocketbase.dart';

class PocketBaseService {
  static final PocketBaseService _instance = PocketBaseService._internal();

  factory PocketBaseService() => _instance;

  PocketBaseService._internal();

  late final PocketBase pb;

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  static const _authKey = 'pb_auth';

  bool _isInitialized = false;

  bool get isInitialized => _isInitialized;

  Future<void> initialize() async {
    if (_isInitialized) return;

    _isInitialized = true;

    pb = PocketBase('https://backend.rentifystore.com');

    final stored = await _storage.read(key: _authKey);

    if (stored != null) {
      final data = jsonDecode(stored);

      pb.authStore.save(
        data['token'],
        data['record'] != null ? RecordModel.fromJson(data['record']) : null,
      );
    }

    pb.authStore.onChange.listen((_) async {
      if (pb.authStore.isValid) {
        final data = jsonEncode({
          'token': pb.authStore.token,
          'record': pb.authStore.record?.toJson(),
        });

        await _storage.write(key: _authKey, value: data);
      } else {
        await _storage.delete(key: _authKey);
      }
    });
  }
}
