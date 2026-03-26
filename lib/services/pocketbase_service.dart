import "package:pocketbase/pocketbase.dart";

class PocketBaseService {
  static final PocketBaseService _instance = PocketBaseService._internal();
  factory PocketBaseService() => _instance;
  late final PocketBase pb;
  PocketBaseService._internal() {
    pb = PocketBase('https://backend.rentifystore.com');
  }
}
