import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pocketbase/pocketbase.dart';

class PocketBaseService {
  static final PocketBaseService _instance = PocketBaseService._internal();
  static const _authStorageKey = 'pb_auth';

  factory PocketBaseService() => _instance;

  late final PocketBase pb;
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  bool _didLoadStoredAuth = false;

  PocketBaseService._internal() {
    pb = PocketBase('https://backend.rentifystore.com');

    pb.authStore.onChange.listen((event) async {
      if (event.token.isEmpty) {
        await storage.delete(key: _authStorageKey);
        return;
      }

      final payload = jsonEncode({
        'token': event.token,
        'record': event.record?.toJson(),
      });

      await storage.write(key: _authStorageKey, value: payload);
    });
  }

  Future<void> initialize() async {
    if (_didLoadStoredAuth) {
      return;
    }

    _didLoadStoredAuth = true;

    final storedAuth = await storage.read(key: _authStorageKey);
    if (storedAuth == null || storedAuth.isEmpty) {
      return;
    }

    try {
      final decoded = jsonDecode(storedAuth);
      if (decoded is! Map<String, dynamic>) {
        throw const FormatException('Invalid stored auth payload');
      }

      final token = decoded['token'] as String? ?? '';
      final rawRecord = decoded['record'];

      if (token.isEmpty || rawRecord is! Map<String, dynamic>) {
        await storage.delete(key: _authStorageKey);
        return;
      }

      pb.authStore.save(token, RecordModel.fromJson(rawRecord));
    } catch (_) {
      pb.authStore.clear();
      await storage.delete(key: _authStorageKey);
    }
  }
}
