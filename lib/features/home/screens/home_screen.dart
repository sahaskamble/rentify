import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import '../../../theme/app_colors.dart';

import '../../../services/pocketbase_service.dart';
import '../../../core/constants/app_constants.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  List<Map<String, dynamic>> _categories = [];
  List<Map<String, dynamic>> _recentListings = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final pb = PocketbaseService().pb;
    try {
      final cats = await pb
          .collection(AppConstants.colCategories)
          .getList(
            filter: 'is_active = true && parent = ""',
            sort: 'sort_order',
            perPage: 10,
          );
      final recent = await pb
          .collection(AppConstants.colListings)
          .getList(
            filter: "status = 'active'",
            expand: 'seller,category',
            perPage: 10,
            sort: '-created',
          );
      if (mounted) {
        setState(() {
          _categories = cats.items.map((e) => e.toJson()).toList();
          _recentListings = recent.items.map((e) => e.toJson()).toList();
          _loading = false;
        });
      }
    } catch (_) {
      if (mounted) setState(() => _loading = false);
    }
  }

  String _imageUrl(Map<String, dynamic> item, String field) {
    final files = item[field];
    if (files == null) return '';
    final fileName = files is List
        ? (files.isNotEmpty ? files.first : '')
        : files.toString();
    if (fileName.isEmpty) return '';
    return '${AppConstants.pbUrl}/api/files/${item['collectionId']}/${item['id']}/$fileName?thumb=400x300';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: RefreshIndicator(
        onRefresh: _loadData,
        color: AppColors.primary,
        child: CustomScrollView(
          slivers: [
            // Top Header Section
            SliverToBoxAdapter(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF145E2B),
                      Color(0xFF0D47A1),
                    ], // Dark green to blue
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24),
                  ),
                ),
                child: SafeArea(
                  bottom: false,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // App Bar Row
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                        child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.menu_rounded,
                                color: Colors.white,
                              ),
                              onPressed: () {},
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                            ),
                            const Expanded(
                              child: Center(
                                child: Text(
                                  'Rentify',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                            ),
                            const CircleAvatar(
                              radius: 16,
                              backgroundColor: Colors.white24,
                              child: Icon(
                                Icons.person,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Search Bar
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            height: 48,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.search,
                                  color: AppColors.textSecondary,
                                  size: 22,
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  'What do you want to rent?',
                                  style: TextStyle(
                                    color: AppColors.textSecondary.withOpacity(
                                      0.7,
                                    ),
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Categories
                      _loading ? _shimmerCategories() : _buildCategories(),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  // Wavy Banner Section
                  _buildWavyBanner(),
                  const SizedBox(height: 24),

                  // Recent listings
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Recently Added',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  _loading
                      ? _shimmerGrid()
                      : _recentListings.isEmpty
                      ? const Padding(
                          padding: EdgeInsets.all(40),
                          child: Center(
                            child: Column(
                              children: [
                                Icon(
                                  Icons.inventory_2_outlined,
                                  size: 48,
                                  color: AppColors.textSecondary,
                                ),
                                SizedBox(height: 12),
                                Text(
                                  'No listings yet.\nBe the first to list!',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: AppColors.textSecondary,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : GridView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                                childAspectRatio: 0.75,
                              ),
                          itemCount: _recentListings.length,
                          itemBuilder: (ctx, i) =>
                              _GridListingCard(
                                    item: _recentListings[i],
                                    imageUrlFn: _imageUrl,
                                  )
                                  .animate(delay: (i * 60).ms)
                                  .fade()
                                  .scale(begin: const Offset(0.95, 0.95)),
                        ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWavyBanner() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      height: 100,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFE8F5EE), Color(0xFFC8E6C9)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -20,
            top: -20,
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Colors.white.withOpacity(0.3),
            ),
          ),
          Positioned(
            right: 40,
            bottom: -30,
            child: CircleAvatar(
              radius: 40,
              backgroundColor: Colors.white.withOpacity(0.3),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Rent Anything, Anytime.',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryDark,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Use karo, own mat karo',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryDark,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  IconData _getCategoryIcon(String name) {
    final lower = name.toLowerCase();
    if (lower.contains('camera') || lower.contains('photo'))
      return Icons.camera_alt_outlined;
    if (lower.contains('bike') || lower.contains('cycle'))
      return Icons.pedal_bike_outlined;
    if (lower.contains('furniture') || lower.contains('chair'))
      return Icons.chair_outlined;
    if (lower.contains('tool') || lower.contains('drill'))
      return Icons.handyman_outlined;
    if (lower.contains('electronics') || lower.contains('laptop'))
      return Icons.laptop_mac_outlined;
    if (lower.contains('party') || lower.contains('event'))
      return Icons.celebration_outlined;
    if (lower.contains('book')) return Icons.menu_book_outlined;
    if (lower.contains('car') || lower.contains('vehicle'))
      return Icons.directions_car_outlined;
    if (lower.contains('sport') || lower.contains('fitness'))
      return Icons.fitness_center_outlined;
    if (lower.contains('music') || lower.contains('audio'))
      return Icons.headphones_outlined;
    if (lower.contains('eco') || lower.contains('plant'))
      return Icons.eco_outlined;
    return Icons.category_outlined;
  }

  Widget _buildCategories() {
    final defaultIcons = [
      Icons.pedal_bike_outlined,
      Icons.camera_alt_outlined,
      Icons.chair_outlined,
      Icons.handyman_outlined,
      Icons.laptop_mac_outlined,
      Icons.celebration_outlined,
    ];

    return SizedBox(
      height: 90,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: _categories.isEmpty ? 6 : _categories.length,
        itemBuilder: (ctx, i) {
          if (_categories.isEmpty) {
            return _CategoryChip(
              icon: defaultIcons[i % defaultIcons.length],
              label: 'Category ${i + 1}',
            );
          }
          final cat = _categories[i];
          final name = cat['name'] ?? '';
          return _CategoryChip(
            icon: _getCategoryIcon(name),
            label: name,
            onTap: () {},
          ).animate(delay: (i * 60).ms).slideX(begin: 0.3).fade();
        },
      ),
    );
  }

  Widget _shimmerCategories() {
    return SizedBox(
      height: 90,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: 6,
        itemBuilder: (_, __) => Shimmer.fromColors(
          baseColor: Colors.white.withOpacity(0.1),
          highlightColor: Colors.white.withOpacity(0.2),
          child: Container(
            width: 76,
            margin: const EdgeInsets.symmetric(horizontal: 6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
      ),
    );
  }

  Widget _shimmerGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.75,
        ),
        itemCount: 6,
        itemBuilder: (_, __) => Shimmer.fromColors(
          baseColor: Colors.grey.shade200,
          highlightColor: Colors.grey.shade100,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  const _CategoryChip({required this.icon, required this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 76,
        margin: const EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withOpacity(0.2)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 28),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GridListingCard extends StatelessWidget {
  final Map<String, dynamic> item;
  final String Function(Map<String, dynamic>, String) imageUrlFn;

  const _GridListingCard({required this.item, required this.imageUrlFn});

  @override
  Widget build(BuildContext context) {
    final price = item['price_per_day'] ?? 0;
    final imgUrl = imageUrlFn(item, 'images');

    return GestureDetector(
      onTap: () => context.push('/listing/${item['id']}'),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with Price Badge
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                    child: imgUrl.isNotEmpty
                        ? CachedNetworkImage(
                            imageUrl: imgUrl,
                            fit: BoxFit.cover,
                          )
                        : Container(
                            color: AppColors.primaryLight,
                            child: const Icon(
                              Icons.image_outlined,
                              size: 40,
                              color: AppColors.primary,
                            ),
                          ),
                  ),
                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '₹ $price/day',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Details
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['title'] ?? '',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on_outlined,
                            size: 14,
                            color: AppColors.textSecondary,
                          ),
                          const SizedBox(width: 2),
                          const Text(
                            '88 km',
                            style: TextStyle(
                              fontSize: 11,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primaryLight,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text(
                          'Rent now',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
