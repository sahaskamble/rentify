import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rentify/generated/pocketbase/categories_record.dart';
import 'package:rentify/generated/pocketbase/listings_record.dart';
import 'package:rentify/providers/auth_provider.dart';
import 'package:rentify/screens/categories/categories_screen.dart';
import 'package:rentify/screens/search/search_page.dart';
import 'package:rentify/services/listing_service.dart';
import 'package:rentify/theme/app_theme.dart';
import 'package:rentify/widgets/home/brand_banner.dart';
import 'package:rentify/widgets/home/category_section.dart';
import 'package:rentify/widgets/home/home_app_bar.dart';
import 'package:rentify/widgets/home/listings_grid.dart';
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
            Expanded(
              child: ListingsGrid(
                listings: _listings,
                hasMore: _hasMore,
                isLoadingMore: _isLoadingMore,
                onLoadMore: _loadMoreListings,
                onTapListing: (listing) {},
                onBookmarkTap: (listing) {},
              ),
            ),
          ],
        ),
      ),
      // drawer: const _AppDrawer(),
    );
  }

  Widget _buildBanner() {
    return BrandBanner(
      onExploreTap: () {},
      headlineText: 'Rent Anything, Anytime',
      subheadlineText: 'Use karo, Kharido mat',
      buttonText: 'Explore Now',
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
