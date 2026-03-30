import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rentify/generated/pocketbase/categories_record.dart';
import 'package:rentify/services/listing_service.dart';
import 'package:rentify/theme/app_theme.dart';

/// Riverpod FutureProvider for fetching active categories
final categoryListProvider = FutureProvider<List<CategoriesRecord>>((
  ref,
) async {
  final service = ListingService();
  try {
    final result = await service.pb
        .collection('categories')
        .getList(filter: "is_active = true", sort: 'sort_order');
    return result.items
        .map((e) => CategoriesRecord.fromRecordModel(e))
        .toList();
  } catch (e) {
    return [];
  }
});

/// CategorySection: displays "Categories" header with "See All" button
/// and a horizontal scrollable list of category tiles
class CategorySection extends ConsumerWidget {
  /// Callback when "See All" button is tapped
  final VoidCallback? onSeeAll;

  /// Callback when a category tile is tapped
  final void Function(CategoriesRecord)? onTapCategory;

  /// Horizontal padding for the section
  final EdgeInsets padding;

  const CategorySection({
    super.key,
    this.onSeeAll,
    this.onTapCategory,
    this.padding = const EdgeInsets.symmetric(horizontal: 16),
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesAsync = ref.watch(categoryListProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section title row with "See All" button
        Padding(
          padding: padding.copyWith(bottom: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Categories',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: AppColors.ink,
                ),
              ),
              TextButton(
                onPressed: onSeeAll,
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.primaryDark,
                  minimumSize: const Size(32, 32),
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  visualDensity: VisualDensity.compact,
                  textStyle: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                child: const Text('See All'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),

        // Horizontal categories list
        SizedBox(
          height: 110,
          child: categoriesAsync.when(
            data: (categories) {
              if (categories.isEmpty) {
                return _CategoryPlaceholders();
              }
              return ListView.separated(
                padding: padding,
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return _CategoryTile(
                    record: category,
                    onTap: () => onTapCategory?.call(category),
                  );
                },
              );
            },
            loading: () => _CategoryPlaceholders(),
            error: (error, stack) => _CategoryPlaceholders(),
          ),
        ),
      ],
    );
  }
}

/// Individual category tile with icon container and name
class _CategoryTile extends StatelessWidget {
  final CategoriesRecord record;
  final VoidCallback? onTap;

  const _CategoryTile({required this.record, this.onTap});

  @override
  Widget build(BuildContext context) {
    // Construct PocketBase file URL for category icon
    final iconUrl = (record.icon?.isNotEmpty == true)
        ? 'https://backend.rentifystore.com/api/files/${record.collectionId}/${record.id}/${record.icon}'
        : null;

    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Icon container (80x80)
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(16),
            ),
            alignment: Alignment.center,
            child: iconUrl != null
                ? _CategoryIcon(imageUrl: iconUrl)
                : Icon(Icons.category, size: 36, color: Colors.grey.shade300),
          ),
          const SizedBox(height: 6),

          // Category name
          SizedBox(
            width: 80,
            child: Text(
              record.name,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.ink,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Category icon image loader with error handling
class _CategoryIcon extends StatelessWidget {
  final String imageUrl;

  const _CategoryIcon({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl,
      width: 44,
      height: 44,
      fit: BoxFit.contain,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return _ShimmerBox(size: 44, borderRadius: 8);
      },
      errorBuilder: (context, error, stackTrace) {
        return Icon(Icons.category, size: 36, color: Colors.grey.shade400);
      },
    );
  }
}

/// 5 placeholder shimmer cards shown while loading
class _CategoryPlaceholders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      scrollDirection: Axis.horizontal,
      itemCount: 5,
      separatorBuilder: (_, __) => const SizedBox(width: 12),
      itemBuilder: (context, index) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _ShimmerBox(size: 80, borderRadius: 16),
          const SizedBox(height: 6),
          _ShimmerBox(width: 60, height: 12, borderRadius: 6),
        ],
      ),
    );
  }
}

/// Animated shimmer loading effect (opacity pulse)
class _ShimmerBox extends StatefulWidget {
  final double size;
  final double? width;
  final double? height;
  final double borderRadius;

  const _ShimmerBox({
    this.size = 40,
    this.width,
    this.height,
    this.borderRadius = 10,
  });

  @override
  State<_ShimmerBox> createState() => _ShimmerBoxState();
}

class _ShimmerBoxState extends State<_ShimmerBox>
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
    _opacity = Tween<double>(begin: 0.3, end: 0.9).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = widget.width ?? widget.size;
    final height = widget.height ?? widget.size;

    return AnimatedBuilder(
      animation: _opacity,
      builder: (_, __) => Opacity(
        opacity: _opacity.value,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(widget.borderRadius),
          ),
        ),
      ),
    );
  }
}
