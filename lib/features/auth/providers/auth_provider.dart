import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocketbase/pocketbase.dart';
import '../../../services/pocketbase_service.dart';
import '../../../core/constants/app_constants.dart';

class AuthState {
  final bool isAuthenticated;
  final RecordModel? user;

  const AuthState({required this.isAuthenticated, this.user});

  AuthState copyWith({bool? isAuthenticated, RecordModel? user}) {
    return AuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      user: user ?? this.user,
    );
  }
}

class AuthNotifier extends AsyncNotifier<AuthState> {
  PocketbaseService get _pb => PocketbaseService();

  @override
  Future<AuthState> build() async {
    final pb = _pb.pb;
    // Check if we have a valid auth store with token
    if (pb.authStore.isValid && pb.authStore.token.isNotEmpty) {
      try {
        await pb.collection(AppConstants.colUsers).authRefresh();
        return AuthState(isAuthenticated: true, user: pb.authStore.record);
      } catch (e) {
        // Token expired or invalid - clear and return unauthenticated
        await _pb.clearAuth();
        return const AuthState(isAuthenticated: false);
      }
    }
    return const AuthState(isAuthenticated: false);
  }

  Future<void> login(String email, String password) async {
    state = const AsyncLoading();
    try {
      final result = await _pb.pb
          .collection(AppConstants.colUsers)
          .authWithPassword(email, password);
      state = AsyncData(AuthState(isAuthenticated: true, user: result.record));
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) async {
    state = const AsyncLoading();
    try {
      await _pb.pb
          .collection(AppConstants.colUsers)
          .create(
            body: {
              'name': name,
              'email': email,
              'password': password,
              'passwordConfirm': password,
              'phone': phone,
              'role': 'renter',
              'is_phone_verified': false,
              'is_id_verified': false,
            },
          );
      // Auto-login after register
      final result = await _pb.pb
          .collection(AppConstants.colUsers)
          .authWithPassword(email, password);
      state = AsyncData(AuthState(isAuthenticated: true, user: result.record));
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> logout() async {
    await _pb.clearAuth();
    state = const AsyncData(AuthState(isAuthenticated: false));
  }

  Future<void> updateUserRecord(Map<String, dynamic> data) async {
    final userId = _pb.currentUserId;
    if (userId == null) return;
    final updated = await _pb.pb
        .collection(AppConstants.colUsers)
        .update(userId, body: data);
    state = AsyncData(AuthState(isAuthenticated: true, user: updated));
  }
}

final authStateProvider = AsyncNotifierProvider<AuthNotifier, AuthState>(
  AuthNotifier.new,
);
