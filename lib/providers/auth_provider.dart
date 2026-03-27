import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rentify/generated/pocketbase/users_record.dart';
import 'package:rentify/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

final authServiceProvider = Provider((ref) => AuthService());

final authStateProvider = NotifierProvider<AuthNotifier, AuthState>(
  AuthNotifier.new,
);

enum AuthMode { login, register }

class AuthState {
  const AuthState({
    required this.user,
    required this.isInitializing,
    required this.isSubmitting,
    required this.mode,
    required this.rememberedEmail,
  });

  const AuthState.initial()
    : user = null,
      isInitializing = true,
      isSubmitting = false,
      mode = AuthMode.login,
      rememberedEmail = '';

  final UsersRecord? user;
  final bool isInitializing;
  final bool isSubmitting;
  final AuthMode mode;
  final String rememberedEmail;

  bool get isAuthenticated => user != null;

  static const _noUser = Object();

  AuthState copyWith({
    Object? user = _noUser,
    bool? isInitializing,
    bool? isSubmitting,
    AuthMode? mode,
    String? rememberedEmail,
  }) {
    return AuthState(
      user: user == _noUser ? this.user : user as UsersRecord?,
      isInitializing: isInitializing ?? this.isInitializing,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      mode: mode ?? this.mode,
      rememberedEmail: rememberedEmail ?? this.rememberedEmail,
    );
  }
}

class AuthNotifier extends Notifier<AuthState> {
  static const _modeStorageKey = 'auth_mode';
  static const _emailStorageKey = 'auth_email';

  late final AuthService _authService = ref.read(authServiceProvider);
  SharedPreferences? _preferences;
  bool _didInitialize = false;

  @override
  AuthState build() {
    initialize();
    return const AuthState.initial();
  }

  Future<SharedPreferences> _prefs() async {
    return _preferences ??= await SharedPreferences.getInstance();
  }

  Future<SharedPreferences?> _prefsOrNull() async {
    try {
      return await _prefs();
    } catch (_) {
      return null;
    }
  }

  Future<void> initialize() async {
    if (_didInitialize) {
      return;
    }

    _didInitialize = true;

    final prefs = await _prefsOrNull();
    final persistedMode = _authModeFromName(prefs?.getString(_modeStorageKey));
    final rememberedEmail = prefs?.getString(_emailStorageKey) ?? '';

    try {
      await _authService.initialize();
    } finally {
      state = state.copyWith(
        user: _authService.currentUser,
        isInitializing: false,
        mode: persistedMode,
        rememberedEmail: rememberedEmail,
      );
    }
  }

  Future<void> setMode(AuthMode mode) async {
    state = state.copyWith(mode: mode);

    final prefs = await _prefsOrNull();
    if (prefs == null) {
      return;
    }

    await prefs.setString(_modeStorageKey, mode.name);
  }

  Future<void> login(String email, String password) async {
    state = state.copyWith(isSubmitting: true);

    try {
      final trimmedEmail = email.trim();
      final user = await _authService.login(
        email: trimmedEmail,
        password: password,
      );

      await _persistAuthUiState(email: trimmedEmail, mode: AuthMode.login);
      state = state.copyWith(
        user: user,
        isSubmitting: false,
        rememberedEmail: trimmedEmail,
      );
    } catch (_) {
      state = state.copyWith(isSubmitting: false);
      rethrow;
    }
  }

  Future<void> register(RegisterPayload payload) async {
    state = state.copyWith(isSubmitting: true);

    try {
      final normalizedPayload = RegisterPayload(
        email: payload.email.trim(),
        password: payload.password,
        name: payload.name.trim(),
        role: payload.role,
        phone: payload.phone?.trim(),
        city: payload.city?.trim(),
        area: payload.area?.trim(),
      );

      final user = await _authService.register(normalizedPayload);
      await _persistAuthUiState(
        email: normalizedPayload.email,
        mode: AuthMode.login,
      );

      state = state.copyWith(
        user: user,
        isSubmitting: false,
        rememberedEmail: normalizedPayload.email,
        mode: AuthMode.login,
      );
    } catch (_) {
      state = state.copyWith(isSubmitting: false);
      rethrow;
    }
  }

  Future<void> logout() async {
    await _authService.logout();
    await setMode(AuthMode.login);

    state = state.copyWith(user: null, isSubmitting: false);
  }

  Future<void> _persistAuthUiState({
    required String email,
    required AuthMode mode,
  }) async {
    final prefs = await _prefsOrNull();
    if (prefs == null) {
      return;
    }

    await prefs.setString(_emailStorageKey, email);
    await prefs.setString(_modeStorageKey, mode.name);
  }

  AuthMode _authModeFromName(String? value) {
    return AuthMode.values.firstWhere(
      (mode) => mode.name == value,
      orElse: () => AuthMode.login,
    );
  }
}
