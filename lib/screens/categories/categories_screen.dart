import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rentify/generated/pocketbase/categories_record.dart';
import 'package:rentify/generated/pocketbase/listings_record.dart';
import 'package:rentify/screens/listing_detail/listing_detail_screen.dart';
import 'package:rentify/services/listing_service.dart';
import 'package:rentify/theme/app_theme.dart';

final categoriesGridProvider = FutureProvider<List<CategoriesRecord>>((ref) async {
  final pb = ListingService().pb;
  final result = await pb.collection('categories').getList(
    filter: 'is_active = true',
    sort: 'sort_order',
    perPage: 200,
  );
  return result.items.map(CategoriesRecord.fromRecordModel).toList();
});

final categoryListingsProvider =
    FutureProvider.family<List<ListingsRecord>, String>((ref, categoryId) async {
      final pb = ListingService().pb;
      final result = await pb.collection('listings').getList(
        filter: "status = 'active' && category = '$categoryId'",
        sort: '-created',
        perPage: 200,
      );
      return result.items.map(ListingsRecord.fromRecordModel).toList();
    });

class CategoriesScreen extends ConsumerWidget {
  const CategoriesScreen({super.key, this.categoryId, this.categoryName});

  final String? categoryId;
  final String? categoryName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isCategoryListings = categoryId != null && categoryId!.isNotEmpty;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          isCategoryListings ? (categoryName ?? 'Category') : 'Browse Categories',
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            color: AppColors.ink,
          ),
        ),
        backgroundColor: AppColors.surface,
        surfaceTintColor: Colors.transparent,
      ),
      body: isCategoryListings
          ? _CategoryListingsView(categoryId: categoryId!)
          : const _CategoriesGridView(),
    );
  }
}

class _CategoriesGridView extends ConsumerWidget {
  const _CategoriesGridView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesAsync = ref.watch(categoriesGridProvider);

    return categoriesAsync.when(
      data: (categories) {
        if (categories.isEmpty) {
          return const _EmptyState(
            icon: Icons.grid_view_rounded,
            message: 'No categories available',
          );
        }

        return GridView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: categories.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.15,
          ),
          itemBuilder: (context, index) {
            final category = categories[index];
            return InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CategoriesScreen(
                      categoryId: category.id,
                      categoryName: category.name,
                    ),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: _parseColor(category.color).withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.border),
                ),
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(category.icon ?? '📦', style: const TextStyle(fontSize: 32)),
                    const Spacer(),
                    Text(
                      category.name,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: AppColors.ink,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => _ErrorView(onRetry: () => ref.invalidate(categoriesGridProvider)),
    );
  }
}

class _CategoryListingsView extends ConsumerWidget {
  const _CategoryListingsView({required this.categoryId});

  final String categoryId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listingsAsync = ref.watch(categoryListingsProvider(categoryId));

    return RefreshIndicator(
      onRefresh: () async => ref.refresh(categoryListingsProvider(categoryId).future),
      child: listingsAsync.when(
        data: (listings) {
          if (listings.isEmpty) {
            return const SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: SizedBox(
                height: 500,
                child: _EmptyState(
                  icon: Icons.inbox_rounded,
                  message: 'No listings in this category yet',
                ),
              ),
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: listings.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.73,
            ),
            itemBuilder: (context, index) {
              final listing = listings[index];
              final imageUrl = listing.images.isNotEmpty
                  ? 'https://backend.rentifystore.com/api/files/listings/${listing.id}/${listing.images.first}'
                  : null;
              return InkWell(
                borderRadius: BorderRadius.circular(14),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ListingDetailScreen(listingId: listing.id),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
                          child: imageUrl == null
                              ? Container(
                                  color: AppColors.surfaceTint,
                                  child: const Center(child: Icon(Icons.image, color: AppColors.muted)),
                                )
                              : Image.network(
                                  imageUrl,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => Container(
                                    color: AppColors.surfaceTint,
                                    child: const Center(child: Icon(Icons.broken_image, color: AppColors.muted)),
                                  ),
                                ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              listing.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: AppColors.ink,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '₹${listing.pricePerDay.toStringAsFixed(0)}/day',
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: AppColors.primary,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: AppColors.surfaceTint,
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: Text(
                                _conditionLabel(listing.condition.nameInSchema),
                                style: const TextStyle(
                                  color: AppColors.ink,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => _ErrorView(onRetry: () => ref.invalidate(categoryListingsProvider(categoryId))),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.icon, required this.message});

  final IconData icon;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 48, color: AppColors.muted),
          const SizedBox(height: 12),
          Text(message, style: const TextStyle(color: AppColors.muted)),
        ],
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Something went wrong', style: TextStyle(color: AppColors.muted)),
          const SizedBox(height: 10),
          ElevatedButton(onPressed: onRetry, child: const Text('Retry')),
        ],
      ),
    );
  }
}

Color _parseColor(String? raw) {
  if (raw == null || raw.isEmpty) return AppColors.surfaceTint;
  final hex = raw.replaceAll('#', '');
  if (hex.length == 6) {
    return Color(int.parse('FF$hex', radix: 16));
  }
  return AppColors.surfaceTint;
}

String _conditionLabel(String value) {
  switch (value) {
    case 'brand_new':
      return 'Brand New';
    case 'like_new':
      return 'Like New';
    default:
      return value[0].toUpperCase() + value.substring(1);
  }
}
