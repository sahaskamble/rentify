import 'package:rentify/generated/pocketbase/categories_record.dart';
import 'package:rentify/generated/pocketbase/listings_record.dart';
import 'package:rentify/services/pocketbase_service.dart';

class ListingService {
  final pb = PocketBaseService().pb;

  Future<List<CategoriesRecord>> getCategories() async {
    final result = await pb
        .collection('categories')
        .getList(filter: "is_active = true", sort: 'sort_order');

    return result.items
        .map((e) => CategoriesRecord.fromJson(e.toJson()))
        .toList();
  }

  Future<List<ListingsRecord>> getListings({
    int page = 1,
    int perPage = 10,
    String? categoryId,
  }) async {
    String filter = "status = 'active'";
    if (categoryId != null && categoryId.isNotEmpty) {
      filter += " && category = '$categoryId'";
    }

    final result = await pb
        .collection('listings')
        .getList(
          page: page,
          perPage: perPage,
          filter: filter,
          sort: '-created',
          expand: 'seller,category',
        );

    return result.items
        .map((e) => ListingsRecord.fromJson(e.toJson()))
        .toList();
  }

  Future<bool> hasMoreListings(int currentCount) async {
    final result = await pb
        .collection('listings')
        .getList(page: 1, perPage: currentCount, filter: "status = 'active'");
    return result.totalItems > currentCount;
  }
}
