# Rentify Home Screen Implementation Plan

> **For agentic workers:** REQUIRED: Use superpowers:subagent-driven-development (if subagents available) or superpowers:executing-plans to implement this plan. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Build pixel-perfect Rentify rental marketplace home screen UI in Flutter with SliverAppBar, search bar, categories row, hero banner, listings grid, and bottom navigation with FAB.

**Architecture:** Single-screen Flutter app using CustomScrollView with SliverAppBar + SliverList. Widget-based architecture following the provided file structure.

**Tech Stack:** Flutter 3.x, google_fonts, Material Design 3

---

## Task 1: Update Dependencies

**Files:**
- Modify: `pubspec.yaml`

- [ ] **Step 1: Update pubspec.yaml with required dependencies**

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  google_fonts: ^6.1.0
  cached_network_image: ^3.3.0
  flutter_svg: ^2.0.9
```

Run: `flutter pub get`

---

## Task 2: Create Theme Files

**Files:**
- Create: `lib/theme/app_colors.dart`
- Create: `lib/theme/app_text_styles.dart`

- [ ] **Step 1: Create app_colors.dart**

```dart
import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF1B8A3E);
  static const Color primaryDark = Color(0xFF145E2B);
  static const Color primaryLight = Color(0xFFE8F5EE);
  static const Color accent = Color(0xFFFFD600);
  static const Color badgeVerified = Color(0xFFFF9800);
  static const Color badgeTopRated = Color(0xFF4CAF50);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color background = Color(0xFFF5F5F5);
  static const Color textPrimary = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFF666666);
  static const Color priceTag = Color(0xFF1B8A3E);
  static const Color navActive = Color(0xFF1B8A3E);
  static const Color navInactive = Color(0xFF9E9E9E);
}
```

- [ ] **Step 2: Create app_text_styles.dart**

```dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  static TextStyle get appTitle => GoogleFonts.poppins(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      );

  static TextStyle get sectionHeading => GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      );

  static TextStyle get tagline => GoogleFonts.poppins(
        fontSize: 13,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      );

  static TextStyle get cardTitle => GoogleFonts.poppins(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      );

  static TextStyle get cardPrice => GoogleFonts.poppins(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        color: AppColors.priceTag,
      );

  static TextStyle get categoryLabel => GoogleFonts.poppins(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary,
      );

  static TextStyle get sectionTitle => GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      );
}
```

- [ ] **Step 3: Commit**

```bash
git add pubspec.yaml lib/theme/app_colors.dart lib/theme/app_text_styles.dart
git commit -m "feat: add theme files with colors and text styles"
```

---

## Task 3: Create Model and Mock Data

**Files:**
- Create: `lib/models/listing_model.dart`
- Create: `lib/data/mock_listings.dart`

- [ ] **Step 1: Create listing_model.dart**

```dart
import 'package:flutter/material.dart';

class ListingModel {
  final String id;
  final String title;
  final String price;
  final String distance;
  final String badge;
  final Color badgeColor;
  final Color imageColor;
  final IconData icon;

  const ListingModel({
    required this.id,
    required this.title,
    required this.price,
    required this.distance,
    required this.badge,
    required this.badgeColor,
    required this.imageColor,
    required this.icon,
  });
}
```

- [ ] **Step 2: Create mock_listings.dart**

```dart
import 'package:flutter/material.dart';
import '../models/listing_model.dart';
import '../theme/app_colors.dart';

const List<ListingModel> mockListings = [
  ListingModel(
    id: '1',
    title: 'Honda Activa',
    price: '₹9/hr',
    distance: '3.9 km',
    badge: 'Verified',
    badgeColor: AppColors.badgeVerified,
    imageColor: AppColors.primaryLight,
    icon: Icons.two_wheeler,
  ),
  ListingModel(
    id: '2',
    title: 'DSLR Camera',
    price: '₹500/day',
    distance: '8.8 km',
    badge: 'Top-rated',
    badgeColor: AppColors.badgeTopRated,
    imageColor: const Color(0xFFEEF2FF),
    icon: Icons.camera_alt,
  ),
  ListingModel(
    id: '3',
    title: 'Royal Enfield',
    price: '₹15/hr',
    distance: '1.2 km',
    badge: 'Verified',
    badgeColor: AppColors.badgeVerified,
    imageColor: const Color(0xFFF3F4F6),
    icon: Icons.two_wheeler,
  ),
  ListingModel(
    id: '4',
    title: 'Xbox Console',
    price: '₹50/day',
    distance: '5.5 km',
    badge: 'Top-rated',
    badgeColor: AppColors.badgeTopRated,
    imageColor: const Color(0xFFF0FDF4),
    icon: Icons.sports_esports,
  ),
];

const List<Map<String, String>> categories = [
  {'icon': '🏍️', 'label': 'Bikes'},
  {'icon': '📷', 'label': 'Camera'},
  {'icon': '🌱', 'label': 'Sapling'},
  {'icon': '🪑', 'label': 'Furniture'},
  {'icon': '🔧', 'label': 'Tools'},
  {'icon': '🎮', 'label': 'Gaming'},
  {'icon': '💻', 'label': 'Electronics'},
];
```

- [ ] **Step 3: Commit**

```bash
git add lib/models/listing_model.dart lib/data/mock_listings.dart
git commit -m "feat: add listing model and mock data"
```

---

## Task 4: Create UI Widgets

**Files:**
- Create: `lib/screens/home/widgets/search_bar.dart`
- Create: `lib/screens/home/widgets/category_chip.dart`
- Create: `lib/screens/home/widgets/categories_row.dart`
- Create: `lib/screens/home/widgets/hero_banner.dart`
- Create: `lib/screens/home/widgets/listing_card.dart`
- Create: `lib/screens/home/widgets/listings_grid.dart`

- [ ] **Step 1: Create search_bar.dart**

```dart
import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class RentifySearchBar extends StatelessWidget {
  const RentifySearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.10),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: const TextField(
        decoration: InputDecoration(
          hintText: 'What do you want to rent?',
          hintStyle: TextStyle(
            color: AppColors.navInactive,
            fontSize: 14,
          ),
          prefixIcon: Icon(
            Icons.search,
            color: AppColors.navInactive,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
    );
  }
}
```

- [ ] **Step 2: Create category_chip.dart**

```dart
import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';

class CategoryChip extends StatelessWidget {
  final String emoji;
  final String label;

  const CategoryChip({
    super.key,
    required this.emoji,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () {},
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                emoji,
                style: const TextStyle(fontSize: 26),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: AppTextStyles.categoryLabel,
          ),
        ],
      ),
    );
  }
}
```

- [ ] **Step 3: Create categories_row.dart**

```dart
import 'package:flutter/material.dart';
import '../../../data/mock_listings.dart';
import 'category_chip.dart';

class CategoriesRow extends StatelessWidget {
  const CategoriesRow({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: CategoryChip(
              emoji: category['icon']!,
              label: category['label']!,
            ),
          );
        },
      ),
    );
  }
}
```

- [ ] **Step 4: Create hero_banner.dart**

```dart
import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';

class HeroBanner extends StatelessWidget {
  const HeroBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      height: 120,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primary, Color(0xFF0D5C28)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -20,
            top: -20,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.07),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Rent Anything, Anytime.',
                  style: AppTextStyles.sectionHeading,
                ),
                SizedBox(height: 4),
                Text(
                  'Use karo, own mat karo',
                  style: AppTextStyles.tagline,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
```

- [ ] **Step 5: Create listing_card.dart**

```dart
import 'package:flutter/material.dart';
import '../../models/listing_model.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';

class ListingCard extends StatelessWidget {
  final ListingModel item;

  const ListingCard({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            height: 120,
            decoration: BoxDecoration(
              color: item.imageColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(14),
                topRight: Radius.circular(14),
              ),
            ),
            child: Center(
              child: Icon(
                item.icon,
                size: 56,
                color: Colors.grey.shade400,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: AppTextStyles.cardTitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: item.badgeColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    item.badge,
                    style: TextStyle(
                      fontSize: 10,
                      color: item.badgeColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item.price,
                      style: AppTextStyles.cardPrice,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          size: 12,
                          color: AppColors.navInactive,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          item.distance,
                          style: const TextStyle(
                            fontSize: 11,
                            color: AppColors.navInactive,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
```

- [ ] **Step 6: Create listings_grid.dart**

```dart
import 'package:flutter/material.dart';
import '../../../data/mock_listings.dart';
import 'listing_card.dart';

class ListingsGrid extends StatelessWidget {
  const ListingsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.78,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return ListingCard(item: mockListings[index]);
        },
        childCount: mockListings.length,
      ),
    );
  }
}
```

- [ ] **Step 7: Commit**

```bash
git add lib/screens/home/widgets/
git commit -m "feat: add all home screen UI widgets"
```

---

## Task 5: Create HomeScreen and Main App

**Files:**
- Create: `lib/screens/home/home_screen.dart`
- Modify: `lib/main.dart`

- [ ] **Step 1: Create home_screen.dart**

```dart
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import 'widgets/search_bar.dart';
import 'widgets/categories_row.dart';
import 'widgets/hero_banner.dart';
import 'widgets/listings_grid.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: AppColors.primary,
            leading: IconButton(
              icon: const Icon(Icons.menu, color: Colors.white),
              onPressed: () {},
            ),
            title: const Text(
              'Rentify',
              style: AppTextStyles.appTitle,
            ),
            actions: [
              CircleAvatar(
                radius: 18,
                backgroundColor: AppColors.primaryDark,
                child: const Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 16),
            ],
          ),
          const SliverToBoxAdapter(
            child: RentifySearchBar(),
          ),
          const SliverToBoxAdapter(
            child: CategoriesRow(),
          ),
          const SliverToBoxAdapter(
            child: HeroBanner(),
          ),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(left: 16, bottom: 12),
              child: Text(
                'Available Near You',
                style: AppTextStyles.sectionTitle,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: ListingsGrid(),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 100),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        elevation: 12,
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.home_rounded, 'Home', true),
              _buildNavItem(Icons.grid_view_rounded, 'Categories', false),
              const SizedBox(width: 48),
              _buildNavItem(Icons.shopping_cart_outlined, 'Cart', false),
              _buildNavItem(Icons.person_outline_rounded, 'Profile', false),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () {},
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isActive) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isActive ? AppColors.navActive : AppColors.navInactive,
              size: 24,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: isActive ? AppColors.navActive : AppColors.navInactive,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

- [ ] **Step 2: Update main.dart**

```dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'theme/app_colors.dart';
import 'screens/home/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const RentifyApp());
}

class RentifyApp extends StatelessWidget {
  const RentifyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rentify',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: Brightness.light,
        ),
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: const HomeScreen(),
    );
  }
}
```

- [ ] **Step 3: Run flutter pub get**

```bash
flutter pub get
```

- [ ] **Step 4: Verify build**

```bash
flutter build apk --debug
```

- [ ] **Step 5: Commit**

```bash
git add lib/main.dart lib/screens/home/home_screen.dart
git commit -m "feat: add home screen with complete UI implementation"
```

---

## Task 6: Final Verification

**Files:**
- All created files

- [ ] **Step 1: Run flutter analyze**

```bash
flutter analyze
```

- [ ] **Step 2: Final commit**

```bash
git add -A
git commit -m "feat: complete Rentify home screen UI implementation"
```

---

**Plan complete and saved to `docs/superpowers/plans/2026-03-22-rentify-home-screen.md`. Ready to execute?**