import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:rentify/services/pocketbase_service.dart';

class AuthState {
  final RecordModel? user;
  final bool isAuthenticated;

  AuthState({this.user, required this.isAuthenticated});
}

class AuthNotifier extends Notifier<AuthState> {
  @override
  AuthState build() {
    final pb = PocketbaseService().pb;

    // Listen to changes
    // Note: In a real app, you might want to cancel this subscription when the provider is disposed.
    // But since this is a global auth provider, it usually lives for the app's lifetime.
    pb.authStore.onChange.listen((event) {
      state = AuthState(
        user: event.model is RecordModel ? event.model as RecordModel : null,
        isAuthenticated: pb.authStore.isValid,
      );
    });

    return AuthState(
      user: pb.authStore.model is RecordModel
          ? pb.authStore.model as RecordModel
          : null,
      isAuthenticated: pb.authStore.isValid,
    );
  }

  void logout() {
    PocketbaseService().pb.authStore.clear();
    // The listener will update the state
  }
}

final authProvider = NotifierProvider<AuthNotifier, AuthState>(
  AuthNotifier.new,
);
