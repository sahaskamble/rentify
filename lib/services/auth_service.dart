import 'package:rentify/generated/pocketbase/users_record.dart';
import 'package:rentify/services/pocketbase_service.dart';

class AuthService {
  final pb = PocketBaseService().pb;

  Future<UsersRecord> login({
    required String email,
    required String password,
  }) async {
    final authData = await pb
        .collection('users')
        .authWithPassword(email, password);
    return UsersRecord.fromJson(authData.record.toJson());
  }

  Future<UsersRecord> register({
    required String email,
    // required String name,
    // required String phone,
    // required String role,
    // required String city,
    // required String area,
    required String password,
  }) async {
    final record = await pb
        .collection('users')
        .create(
          body: {
            "email": email,
            "password": password,
            "passwordConfirm": password,
            // "name": name,
            // "phone": phone,
            // "role": role,
            // "city": city,
            // "area": area,
          },
        );
    return UsersRecord.fromJson(record.toJson());
  }

  void logout() {
    pb.authStore.clear();
  }

  UsersRecord? get currentUser {
    final record = pb.authStore.record;
    if (record == null) return null;

    return UsersRecord.fromJson(record.toJson());
  }

  bool get isLoggedIn => pb.authStore.isValid;
}
