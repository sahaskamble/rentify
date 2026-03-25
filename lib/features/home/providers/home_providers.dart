import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rentify/models/listing_model.dart';
import 'package:rentify/models/category_model.dart';
import 'package:rentify/services/pocketbase_service.dart';

final pocketbaseServiceProvider = Provider<PocketbaseService>((ref) {
  return PocketbaseService();
});

final listingsProvider = FutureProvider<List<ListingModel>>((ref) async {
  final pbService = ref.watch(pocketbaseServiceProvider);
  return pbService.getListings();
});

final featuredListingsProvider = FutureProvider<List<ListingModel>>((
  ref,
) async {
  final pbService = ref.watch(pocketbaseServiceProvider);
  return pbService.getListings(filter: 'is_featured = true');
});

final categoriesProvider = FutureProvider<List<CategoryModel>>((ref) async {
  final pbService = ref.watch(pocketbaseServiceProvider);
  return pbService.getCategories();
});
