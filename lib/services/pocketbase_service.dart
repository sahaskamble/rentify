import 'package:pocketbase/pocketbase.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/constants/app_constants.dart';

class PocketbaseService {
  static final PocketbaseService _instance = PocketbaseService._internal();

  late PocketBase _pb;
  late AsyncAuthStore _authStore;

  factory PocketbaseService() => _instance;

  PocketbaseService._internal();

  /// Must be called once in main() before using any PB features.
  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    _authStore = AsyncAuthStore(
      save: (String data) async =>
          prefs.setString(AppConstants.prefAuthToken, data),
      initial: prefs.getString(AppConstants.prefAuthToken),
    );
    _pb = PocketBase(AppConstants.pbUrl, authStore: _authStore);
  }

  PocketBase get pb => _pb;

  bool get isAuthenticated => _pb.authStore.isValid;

  String? get currentUserId => _pb.authStore.record?.id;

  Future<bool> isConnected() async {
    try {
      await _pb.health.check();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> clearAuth() async {
    _pb.authStore.clear();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(AppConstants.prefAuthToken);
  }
}
