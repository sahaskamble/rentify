import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rentify/screens/home/home_screen.dart';
import 'package:rentify/widgets/home/bottom_nav_bar.dart';

/// HomeContainer: manages tab navigation with IndexedStack
///
/// Preserves scroll state across tab switches
class HomeContainer extends ConsumerStatefulWidget {
  const HomeContainer({super.key});

  @override
  ConsumerState<HomeContainer> createState() => _HomeContainerState();
}

class _HomeContainerState extends ConsumerState<HomeContainer> {
  int _currentTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentTabIndex,
        children: [
          // Tab 0: Home
          const HomeScreen(),

          // Tab 1: Browse
          const _BrowseScreen(),

          // Tab 2: Add Listing (placeholder - FAB pressed)
          Container(),

          // Tab 3: Chat
          const _ChatScreen(),

          // Tab 4: Profile
          const _ProfileScreen(),
        ],
      ),
      bottomNavigationBar: HomeBottomNavBar(
        currentIndex: _currentTabIndex,
        onTap: (index) {
          if (index == 2) {
            // FAB tap - open add listing
            _showAddListingSheet();
          } else {
            setState(() => _currentTabIndex = index);
          }
        },
        onFabPress: _showAddListingSheet,
      ),
    );
  }

  void _showAddListingSheet() {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Add listing coming soon!')));
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

/// Placeholder Chat Screen
class _ChatScreen extends StatelessWidget {
  const _ChatScreen();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('Chat Screen')));
  }
}

/// Placeholder Profile Screen
class _ProfileScreen extends StatelessWidget {
  const _ProfileScreen();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('Profile Screen')));
  }
}
