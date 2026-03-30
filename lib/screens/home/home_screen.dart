import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rentify/generated/pocketbase/categories_record.dart';
import 'package:rentify/generated/pocketbase/listings_record.dart';
import 'package:rentify/providers/auth_provider.dart';
import 'package:rentify/screens/categories/categories_screen.dart';
import 'package:rentify/screens/search/search_page.dart';
import 'package:rentify/services/listing_service.dart';
import 'package:rentify/theme/app_theme.dart';
import 'package:rentify/widgets/home/category_section.dart';
import 'package:rentify/widgets/home/home_app_bar.dart';
import 'package:rentify/widgets/search/filter_bottom_sheet.dart';

final categoriesProvider = FutureProvider<List<CategoriesRecord>>((ref) async {
  final service = ListingService();
  return service.getCategories();
});

final listingsProvider = FutureProvider.family<List<ListingsRecord>, int>((
  ref,
  page,
) async {
  final service = ListingService();
  return service.getListings(page: page);
});

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  List<ListingsRecord> _listings = [];
  int _page = 1;
  bool _hasMore = true;
  bool _isLoading = false;
  bool _isLoadingMore = false;
  String? _selectedCategoryId;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _loadInitialListings();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadInitialListings() async {
    _isLoading = true;
    try {
      final service = ListingService();
      _listings = await service.getListings(page: _page);
      _hasMore = _listings.length >= 10;
    } finally {
      _isLoading = false;
      if (mounted) setState(() {});
    }
  }

  Future<void> _loadMoreListings() async {
    if (_isLoadingMore || !_hasMore) return;
    _isLoadingMore = true;
    try {
      _page++;
      final service = ListingService();
      final newListings = await service.getListings(page: _page);
      _hasMore = newListings.length >= 10;
      _listings = [..._listings, ...newListings];
    } finally {
      _isLoadingMore = false;
      if (mounted) setState(() {});
    }
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      _loadMoreListings();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          HomeAppBar(
            onLocationTap: () {},
            onSearchTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SearchPage()),
              );
            },
          ),
          SliverToBoxAdapter(
            child: CategorySection(
              onSeeAll: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CategoriesScreen()),
                );
              },
              onTapCategory: (category) {
                ref.read(selectedCategoryProvider.notifier).state = category.id;
              },
            ),
          ),
        ],
        body: Column(
          children: [
            _buildBanner(),
            Expanded(child: _buildListings()),
          ],
        ),
      ),
      // drawer: const _AppDrawer(),
    );
  }

  Widget _buildBanner() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.accentStrong],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Rent Anything, Anytime',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'use karo, own mat karo',
            style: TextStyle(fontSize: 14, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildListings() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_listings.isEmpty) {
      return const Center(
        child: Text(
          'No listings added',
          style: TextStyle(color: AppColors.muted),
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: _listings.length + (_hasMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index >= _listings.length) {
          return const Center(child: CircularProgressIndicator());
        }
        final listing = _listings[index];
        return _ListingCard(listing: listing);
      },
    );
  }

  IconData _getCategoryIcon(String? iconName) {
    switch (iconName?.toLowerCase()) {
      case 'car':
        return Icons.directions_car;
      case 'bike':
        return Icons.two_wheeler;
      case 'camera':
        return Icons.camera_alt;
      case 'electronics':
        return Icons.devices;
      case 'furniture':
        return Icons.chair;
      case 'tools':
        return Icons.build;
      case 'sports':
        return Icons.sports_soccer;
      case 'party':
        return Icons.celebration;
      default:
        return Icons.category;
    }
  }
}

class _ListingCard extends StatelessWidget {
  final ListingsRecord listing;

  const _ListingCard({required this.listing});

  @override
  Widget build(BuildContext context) {
    final imageUrl = listing.images.isNotEmpty
        ? 'https://backend.rentifystore.com/api/files/listings/${listing.id}/${listing.images.first}'
        : null;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: imageUrl != null
                ? Image.network(
                    imageUrl,
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        height: 120,
                        color: AppColors.surfaceTint,
                        child: const Center(child: CircularProgressIndicator()),
                      );
                    },
                    errorBuilder: (_, __, ___) => Container(
                      height: 120,
                      color: AppColors.surfaceTint,
                      child: const Icon(
                        Icons.image,
                        size: 40,
                        color: AppColors.muted,
                      ),
                    ),
                  )
                : Container(
                    height: 120,
                    color: AppColors.surfaceTint,
                    child: const Icon(
                      Icons.image,
                      size: 40,
                      color: AppColors.muted,
                    ),
                  ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    listing.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '₹${listing.pricePerDay.toStringAsFixed(0)}/day',
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AppDrawer extends ConsumerWidget {
  const _AppDrawer();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: AppColors.primary),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 35, color: AppColors.primary),
                ),
                const SizedBox(height: 12),
                Consumer(
                  builder: (context, ref, _) {
                    final user = ref.watch(authStateProvider).user;
                    return Text(
                      user?.name ?? 'Guest',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),
                Consumer(
                  builder: (context, ref, _) {
                    final email = ref.watch(authStateProvider).user?.email;
                    if (email == null) return const SizedBox();
                    return Text(
                      email,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.8),
                        fontSize: 12,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.category),
            title: const Text('Categories'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.chat_bubble_outline),
            title: const Text('Chat'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onTap: () => Navigator.pop(context),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Logout', style: TextStyle(color: Colors.red)),
            onTap: () {
              Navigator.pop(context);
              ref.read(authStateProvider.notifier).logout();
            },
          ),
        ],
      ),
    );
  }
}
