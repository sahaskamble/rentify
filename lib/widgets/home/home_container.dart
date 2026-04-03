import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rentify/providers/home_provider.dart';
import 'package:rentify/screens/chat/chat_screen.dart';
import 'package:rentify/screens/give_on_rent/give_on_rent_screen.dart';
import 'package:rentify/screens/home/home_screen.dart';
import 'package:rentify/screens/profile/profile_screen.dart';
import 'package:rentify/theme/app_theme.dart';
import 'package:rentify/widgets/home/bottom_nav_bar.dart';

/// HomeContainer: manages tab navigation with IndexedStack
///
/// Preserves scroll state across tab switches
/// Tabs: Home (0), Browse (1), Give on Rent (2), Profile (3)
class HomeContainer extends ConsumerWidget {
  const HomeContainer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTabIndex = ref.watch(selectedHomeTabProvider);

    return Scaffold(
      body: IndexedStack(
        index: currentTabIndex,
        children: [
          // Tab 0: Home
          const HomeScreen(),

          // Tab 1: Browse
          const _BrowseScreen(),

          // Tab 2: Give on Rent
          const GiveOnRentScreen(),

          // Tab 3: Profile
          const ProfileScreen(),
        ],
      ),
      floatingActionButton: currentTabIndex == 0
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ChatScreen()),
                );
              },
              backgroundColor: AppColors.primary,
              child: const Icon(Icons.chat_bubble_rounded, color: Colors.white),
            )
          : null,
      bottomNavigationBar: HomeBottomNavBar(
        currentIndex: currentTabIndex,
        onTap: (index) {
          ref.read(selectedHomeTabProvider.notifier).state = index;
        },
      ),
    );
  }
}

/// Placeholder Browse Screen
class _BrowseScreen extends StatelessWidget {
  const _BrowseScreen();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('Browse Screen')));
  }
}
