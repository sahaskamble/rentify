import 'package:pocketbase/pocketbase.dart';

class PocketbaseService {
  static final PocketbaseService _instance = PocketbaseService._internal();

  late PocketBase _pb;

  static const String pocketbaseUrl = 'http://localhost:8090';

  factory PocketbaseService() {
    return _instance;
  }

  PocketbaseService._internal() {
    _pb = PocketBase(pocketbaseUrl);
  }

  PocketBase get pb => _pb;

  // Check connection status
  Future<bool> isConnected() async {
    try {
      // Try to get health status
      await _pb.health.check();
      return true;
    } catch (e) {
      return false;
    }
  }
}
