import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:rentify/screens/listing_detail/listing_detail_screen.dart';
import 'package:rentify/services/listing_service.dart';
import 'package:rentify/theme/app_theme.dart';
import 'package:rentify/widgets/search/filter_bottom_sheet.dart';

// Riverpod provider for search results with debouncing
final searchQueryProvider = StateProvider<String>((ref) => '');

final searchResultsProvider = FutureProvider<List<RecordModel>>((ref) async {
  final query = ref.watch(searchQueryProvider);
  if (query.isEmpty) return [];

  final selectedCategory = ref.watch(selectedCategoryProvider);
  final selectedCondition = ref.watch(selectedConditionProvider);
  final selectedSort = ref.watch(selectedSortProvider);
  final priceRange = ref.watch(priceRangeProvider);
  final cityFilter = ref.watch(cityFilterProvider);

  final filters = <String>["status = 'active'", "title ~ '$query'"];
  if (selectedCategory != null && selectedCategory.isNotEmpty) {
    filters.add("category = '$selectedCategory'");
  }
  if (selectedCondition != null && selectedCondition != 'Any') {
    filters.add(
      "condition = '${selectedCondition.toLowerCase().replaceAll(' ', '_')}'",
    );
  }
  filters.add('price_per_day >= ${priceRange.start.round()}');
  filters.add('price_per_day <= ${priceRange.end.round()}');
  if (cityFilter.trim().isNotEmpty) {
    filters.add("location.city ~ '${cityFilter.trim()}'");
  }

  final sort = switch (selectedSort) {
    'price_low' => 'price_per_day',
    'price_high' => '-price_per_day',
    _ => '-created',
  };

  final result = await ListingService().pb
      .collection('listings')
      .getList(
        filter: filters.join(' && '),
        sort: sort,
        expand: 'seller,category,location',
        perPage: 50,
      );
  return result.items.map((e) => e).toList();
});

// Provider for recent searches (local storage via shared_preferences stub)
final recentSearchesProvider = StateProvider<List<String>>((ref) {
  return ['Camera Lens', 'Electric Scooter', 'Gaming Laptop'];
});

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  late final TextEditingController _searchController;
  final FocusNode _focusNode = FocusNode();
  Future<void>? _debounceTimer;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    // Auto-focus the search field
    Future.delayed(const Duration(milliseconds: 300), () {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    _debounceTimer?.ignore();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    // Cancel previous debounce
    _debounceTimer?.ignore();

    // Debounce 400ms
    _debounceTimer = Future.delayed(const Duration(milliseconds: 400), () {
      ref.read(searchQueryProvider.notifier).state = query;
      // Also save to recent searches
      if (query.isNotEmpty) {
        final recent = ref.read(recentSearchesProvider);
        if (!recent.contains(query)) {
          ref.read(recentSearchesProvider.notifier).state = [
            query,
            ...recent.take(4), // Keep only 5 most recent
          ];
        }
      }
    });
  }

  void _onFilterTap() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => const FilterBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final query = ref.watch(searchQueryProvider);
    final searchResults = ref.watch(searchResultsProvider);
    final recentSearches = ref.watch(recentSearchesProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildSearchAppBar(),
      body: query.isEmpty
          ? _buildEmptyState(recentSearches)
          : _buildSearchResults(searchResults),
    );
  }

  /// AppBar with back button, search field, and filter button
  PreferredSizeWidget _buildSearchAppBar() {
    return AppBar(
      backgroundColor: AppColors.surface,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      toolbarHeight: 60,
      titleSpacing: 0,
      leading: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => Navigator.pop(context),
            borderRadius: BorderRadius.circular(24),
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_back_ios_new,
                size: 16,
                color: AppColors.ink,
              ),
            ),
          ),
        ),
      ),
      title: Container(
        height: 42,
        margin: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey.shade100,
        ),
        child: TextField(
          controller: _searchController,
          focusNode: _focusNode,
          onChanged: _onSearchChanged,
          decoration: InputDecoration(
            hintText: 'Search...',
            hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 14),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 10,
            ),
            prefixIcon: Icon(
              Icons.search,
              size: 18,
              color: Colors.grey.shade600,
            ),
            suffixIcon: _searchController.text.isNotEmpty
                ? GestureDetector(
                    onTap: () {
                      _searchController.clear();
                      ref.read(searchQueryProvider.notifier).state = '';
                    },
                    child: Icon(
                      Icons.close,
                      size: 18,
                      color: Colors.grey.shade600,
                    ),
                  )
                : null,
          ),
          style: const TextStyle(fontSize: 14, color: AppColors.ink),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 12),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: _onFilterTap,
              borderRadius: BorderRadius.circular(24),
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.tune, size: 18, color: AppColors.ink),
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Empty state with recent searches as chips
  Widget _buildEmptyState(List<String> recentSearches) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Recent Searches',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.ink,
            ),
          ),
          const SizedBox(height: 12),
          if (recentSearches.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 32),
              child: Center(
                child: Text(
                  'No recent searches',
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
                ),
              ),
            )
          else
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: recentSearches
                  .map(
                    (search) => _SearchChip(
                      label: search,
                      onTap: () {
                        _searchController.text = search;
                        _onSearchChanged(search);
                      },
                    ),
                  )
                  .toList(),
            ),
        ],
      ),
    );
  }

  /// Search results list view
  Widget _buildSearchResults(AsyncValue<List<RecordModel>> results) {
    return results.when(
      data: (listings) {
        if (listings.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.search_off, size: 48, color: Colors.grey.shade300),
                  const SizedBox(height: 16),
                  Text(
                    'No results found',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Try a different search term',
                    style: TextStyle(fontSize: 13, color: Colors.grey.shade500),
                  ),
                ],
              ),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: listings.length,
          itemBuilder: (context, index) {
            final listing = listings[index];
            return _SearchResultTile(listing: listing);
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Text(
            'Error loading results',
            style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
          ),
        ),
      ),
    );
  }
}

/// Individual search result tile
class _SearchResultTile extends StatelessWidget {
  final RecordModel listing;

  const _SearchResultTile({required this.listing});

  @override
  Widget build(BuildContext context) {
    final images = (listing.data['images'] as List<dynamic>? ?? [])
        .cast<String>();
    final imageUrl = images.isNotEmpty
        ? 'https://backend.rentifystore.com/api/files/listings/${listing.id}/${images.first}'
        : null;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ListingDetailScreen(listingId: listing.id),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.surface,
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            // Thumbnail
            ClipRRect(
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(12),
              ),
              child: imageUrl != null
                  ? Image.network(
                      imageUrl,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => _buildPlaceholder(),
                    )
                  : _buildPlaceholder(),
            ),
            const SizedBox(width: 12),
            // Content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      listing.getStringValue('title'),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.ink,
                      ),
                    ),
                    const SizedBox(height: 4),
                    // Price per day
                    Text(
                      '₹${((listing.data['price_per_day'] as num?)?.toDouble() ?? 0).toStringAsFixed(0)}/day',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 12,
                          color: Colors.grey.shade600,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            (listing.expand['location']?.isNotEmpty == true
                                    ? listing
                                          .expand['location']!
                                          .first
                                          .data['city']
                                          ?.toString()
                                    : null) ??
                                'Location not set',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Icon(Icons.chevron_right, color: Colors.grey.shade400),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      width: 100,
      height: 100,
      color: AppColors.surfaceTint,
      child: const Icon(Icons.image, color: AppColors.muted, size: 32),
    );
  }
}

/// Recent search chip
class _SearchChip extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _SearchChip({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.border),
          color: AppColors.surface,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.history, size: 14, color: AppColors.muted),
            const SizedBox(width: 6),
            Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: AppColors.ink,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
