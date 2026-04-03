import 'package:pocketbase/pocketbase.dart';
import 'package:rentify/generated/pocketbase/users_record.dart';
import 'package:rentify/services/pocketbase_service.dart';

class RegisterPayload {
  const RegisterPayload({
    required this.email,
    required this.password,
    required this.name,
    required this.role,
    this.phone,
    this.city,
    this.area,
  });

  final String email;
  final String password;
  final String name;
  final UsersRecordRoleEnum role;
  final String? phone;
  final String? city;
  final String? area;
}

class AuthService {
  AuthService() : _pocketBaseService = PocketBaseService();

  final PocketBaseService _pocketBaseService;

  PocketBase get pb {
    if (!_pocketBaseService.isInitialized) {
      throw StateError(
        'PocketBaseService not initialized. Call initialize() first.',
      );
    }
    return _pocketBaseService.pb;
  }

  bool get isInitialized => _pocketBaseService.isInitialized;

  Future<void> initialize() async {
    await _pocketBaseService.initialize();

    if (pb.authStore.token.isEmpty) return;

    if (!pb.authStore.isValid) {
      await logout();
      return;
    }

    try {
      await pb.collection('users').authRefresh();
    } catch (_) {
      await logout();
    }
  }

  // Future<UsersRecord> login({
  //   required String email,
  //   required String password,
  // }) async {
  //   final authData = await pb
  //       .collection('users')
  //       .authWithPassword(email, password);
  //   return UsersRecord.fromJson(authData.record.toJson());
  // }

  Future<UsersRecord> login({
    required String email,
    required String password,
  }) async {
    try {
      final authData = await pb
          .collection('users')
          .authWithPassword(email, password);
      return UsersRecord.fromJson(authData.record.toJson());
    } catch (e) {
      // Log actual error for debugging
      print('🔴 LOGIN ERROR: $e');
      rethrow;
    }
  }

  Future<UsersRecord> register(RegisterPayload payload) async {
    await pb
        .collection('users')
        .create(
          body: {
            'email': payload.email,
            'password': payload.password,
            'passwordConfirm': payload.password,
            'name': payload.name,
            'role': payload.role.nameInSchema,
            if (payload.phone != null && payload.phone!.isNotEmpty)
              'phone': payload.phone,
            if (payload.city != null && payload.city!.isNotEmpty)
              'city': payload.city,
            if (payload.area != null && payload.area!.isNotEmpty)
              'area': payload.area,
          },
        );

    return login(email: payload.email, password: payload.password);
  }

  Future<void> logout() async {
    pb.authStore.clear();
  }

  UsersRecord? get currentUser {
    final record = pb.authStore.record;
    if (record == null) return null;

    return UsersRecord.fromRecordModel(record);
  }

  bool get isLoggedIn => pb.authStore.isValid;

  String readErrorMessage(Object error) {
    if (error is ClientException) {
      final message = error.response['message'];
      if (message is String && message.trim().isNotEmpty) {
        return message.trim();
      }

      final data = error.response['data'];
      if (data is Map<String, dynamic>) {
        for (final value in data.values) {
          if (value is Map<String, dynamic>) {
            final fieldMessage = value['message'];
            if (fieldMessage is String && fieldMessage.trim().isNotEmpty) {
              return fieldMessage.trim();
            }
          }
        }
      }
    }

    return 'Unable to complete the request. Please try again.';
  }
}
