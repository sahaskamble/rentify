import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rentify/generated/pocketbase/listings_record.dart';
import 'package:rentify/theme/app_theme.dart';

/// ListingsGrid: infinite-scrolling SliverGrid with pagination and shimmer loading
///
/// Features:
/// - 2-column grid layout (crossAxisCount: 2)
/// - Infinite pagination (load more on scroll)
/// - Shimmer placeholders (6 items) while loading
/// - Responsive card design
/// - Image with gradient overlay
/// - Star rating, distance, price display
/// - Bookmark button for favorites
class ListingsGrid extends ConsumerStatefulWidget {
  /// List of listings to display
  final List<ListingsRecord> listings;

  /// Called when more listings are needed
  final Future<void> Function() onLoadMore;

  /// Whether more listings can be loaded
  final bool hasMore;

  /// Whether currently loading more
  final bool isLoadingMore;

  /// Called when a listing card is tapped
  final void Function(ListingsRecord)? onTapListing;

  /// Called when bookmark button is tapped
  final void Function(ListingsRecord)? onBookmarkTap;

  const ListingsGrid({
    super.key,
    required this.listings,
    required this.onLoadMore,
    required this.hasMore,
    required this.isLoadingMore,
    this.onTapListing,
    this.onBookmarkTap,
  });

  @override
  ConsumerState<ListingsGrid> createState() => _ListingsGridState();
}

class _ListingsGridState extends ConsumerState<ListingsGrid> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  /// Load more items when user scrolls within 200px of bottom
  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      if (widget.hasMore && !widget.isLoadingMore) {
        widget.onLoadMore();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Show 6 shimmer placeholders while initial load is in progress
    if (widget.listings.isEmpty && widget.isLoadingMore) {
      return GridView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.72,
        ),
        itemCount: 6,
        itemBuilder: (context, index) => const _ListingCardShimmer(),
      );
    }

    // Empty state
    if (widget.listings.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.inbox, size: 64, color: Colors.grey.shade300),
              const SizedBox(height: 16),
              Text(
                'No listings found',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Try adjusting your filters',
                style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
              ),
            ],
          ),
        ),
      );
    }

    // Listings grid with infinite scroll
    return GridView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.72,
      ),
      itemCount:
          widget.listings.length +
          (widget.hasMore && widget.isLoadingMore ? 2 : 0),
      itemBuilder: (context, index) {
        // Show placeholder loading indicators at end
        if (index >= widget.listings.length) {
          return const _ListingCardShimmer();
        }

        final listing = widget.listings[index];
        return _ListingCard(
          listing: listing,
          onTap: () => widget.onTapListing?.call(listing),
          onBookmarkTap: () => widget.onBookmarkTap?.call(listing),
        );
      },
    );
  }
}

/// Individual listing card widget
class _ListingCard extends StatelessWidget {
  final ListingsRecord listing;
  final VoidCallback? onTap;
  final VoidCallback? onBookmarkTap;

  const _ListingCard({required this.listing, this.onTap, this.onBookmarkTap});

  @override
  Widget build(BuildContext context) {
    final imageUrl = listing.images.isNotEmpty
        ? 'https://backend.rentifystore.com/api/files/${ListingsRecord.$collectionId}/${listing.id}/${listing.images.first}'
        : null;

    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.border.withValues(alpha: 0.5)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image section (55% of card height)
              Expanded(
                flex: 55,
                child: Stack(
                  children: [
                    // Image with gradient overlay
                    Container(
                      color: AppColors.surfaceTint,
                      child: imageUrl != null
                          ? Image.network(
                              imageUrl,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              loadingBuilder: (context, child, progress) {
                                if (progress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: progress.expectedTotalBytes != null
                                        ? progress.cumulativeBytesLoaded /
                                              progress.expectedTotalBytes!
                                        : null,
                                  ),
                                );
                              },
                              errorBuilder: (context, error, stackTrace) =>
                                  Center(
                                    child: Icon(
                                      Icons.image_not_supported_outlined,
                                      size: 32,
                                      color: Colors.grey.shade400,
                                    ),
                                  ),
                            )
                          : Center(
                              child: Icon(
                                Icons.image_outlined,
                                size: 40,
                                color: Colors.grey.shade400,
                              ),
                            ),
                    ),

                    // Gradient overlay at bottom for text readability
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withValues(alpha: 0.3),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Bookmark button (top right)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: GestureDetector(
                        onTap: onBookmarkTap,
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.9),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.bookmark_border,
                            size: 18,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Content section (45% of card height)
              Expanded(
                flex: 45,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title (2 lines max)
                      Expanded(
                        child: Text(
                          listing.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppColors.ink,
                            height: 1.2,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),

                      // Rating + Distance row
                      Row(
                        children: [
                          // Star icon + rating
                          const Icon(
                            Icons.star_rounded,
                            size: 12,
                            color: Color(0xFFFFB800),
                          ),
                          const SizedBox(width: 3),
                          Text(
                            listing.avgRating?.toStringAsFixed(1) ?? 'New',
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: AppColors.ink,
                            ),
                          ),
                          const Spacer(),

                          // Distance (stub: hardcoded for now)
                          Text(
                            '2.3 km',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),

                      // Price row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Price per day
                          Text(
                            '₹${listing.pricePerDay.toStringAsFixed(0)}/day',
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Shimmer placeholder card for loading state
class _ListingCardShimmer extends StatefulWidget {
  const _ListingCardShimmer();

  @override
  State<_ListingCardShimmer> createState() => _ListingCardShimmerState();
}

class _ListingCardShimmerState extends State<_ListingCardShimmer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
    _opacity = Tween<double>(begin: 0.3, end: 0.8).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _opacity,
      builder: (context, child) => ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.border.withValues(alpha: 0.3)),
          ),
          child: Column(
            children: [
              // Image placeholder (55%)
              Expanded(
                flex: 55,
                child: Opacity(
                  opacity: _opacity.value,
                  child: Container(color: Colors.grey.shade200),
                ),
              ),
              // Content placeholder (45%)
              Expanded(
                flex: 45,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title shimmer
                      Opacity(
                        opacity: _opacity.value,
                        child: Container(
                          height: 10,
                          color: Colors.grey.shade200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Opacity(
                        opacity: _opacity.value,
                        child: Container(
                          height: 8,
                          width: 80,
                          color: Colors.grey.shade200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                      const Spacer(),
                      // Price shimmer
                      Opacity(
                        opacity: _opacity.value,
                        child: Container(
                          height: 10,
                          width: 60,
                          color: Colors.grey.shade200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
