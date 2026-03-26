import 'package:rentify/generated/pocketbase/listings_record.dart';
import 'package:rentify/services/pocketbase_service.dart';

class ListingService {
  final pb = PocketBaseService().pb;

  Future<List<ListingsRecord>> getListings() async {
    final result = await pb
        .collection('listings')
        .getList(filter: "status='active'", expand: "seller,category");

    return result.items
        .map((e) => ListingsRecord.fromJson(e.toJson()))
        .toList();
  }
}
