import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:rentify/generated/pocketbase/users_record.dart';
import 'package:rentify/services/auth_service.dart';

final authServiceProvider = Provider((ref) => AuthService());

final authStateProvider = StateNotifierProvider<AuthNotifier, UsersRecord?>(
  (ref) => AuthNotifier(ref),
);

class AuthNotifier extends StateNotifier<UsersRecord?> {
  final Ref ref;

  AuthNotifier(this.ref) : super(null) {
    _init();
  }

  void _init() {
    final user = ref.read(authServiceProvider).currentUser;
    state = user;
  }

  Future<void> login(String email, String password) async {
    final user = await ref
        .read(authServiceProvider)
        .login(email: email, password: password);

    state = user;
  }

  Future<void> register(String email, String password) async {
    final user = await ref
        .read(authServiceProvider)
        .register(email: email, password: password);

    state = user;
  }

  void logout() {
    ref.read(authServiceProvider).logout();
    state = null;
  }
}
