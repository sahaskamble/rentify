import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rentify/providers/auth_provider.dart';
import 'package:rentify/theme/app_theme.dart';

/// HomeAppBar is a SliverAppBar widget that displays:
/// - App name "Rentify" with a location selector
/// - User profile avatar
/// - SearchBar widget below (non-focusable, tappable)
class HomeAppBar extends ConsumerWidget {
  /// Called when location text is tapped to show location picker
  final VoidCallback? onLocationTap;

  /// Called when SearchBar is tapped to navigate to SearchPage
  final VoidCallback? onSearchTap;

  const HomeAppBar({super.key, this.onLocationTap, this.onSearchTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return SliverAppBar(
      pinned: true,
      elevation: 0,
      backgroundColor: AppColors.surface,
      surfaceTintColor: Colors.transparent,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          color: AppColors.surface,
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
            top: 8,
            bottom: 8,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top row: App name + Profile avatar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Left: App name + Location
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Rentify',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: AppColors.ink,
                          ),
                        ),
                        const SizedBox(height: 0),
                        // Location row (tappable)
                        GestureDetector(
                          onTap: onLocationTap,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.location_on,
                                size: 14,
                                color: AppColors.primary,
                              ),
                              const SizedBox(width: 4),
                              const Text(
                                'San Francisco, CA',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.muted,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Icon(
                                Icons.expand_more,
                                size: 14,
                                color: AppColors.muted,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Right: User avatar
                  _UserAvatar(authState: authState),
                ],
              ),
              const SizedBox(height: 12),
              // SearchBar (tappable, non-focusable)
              _HomeSearchBar(onTap: onSearchTap),
            ],
          ),
        ),
      ),
      toolbarHeight: 120, // Adjusted for title + location + search bar
    );
  }
}

/// User avatar circle with initials
class _UserAvatar extends StatelessWidget {
  final AuthState authState;

  const _UserAvatar({required this.authState});

  String _getInitials(String? name) {
    if (name == null || name.isEmpty) return 'U';
    final parts = name.trim().split(' ');
    if (parts.length == 1) {
      return parts[0][0].toUpperCase();
    }
    return '${parts[0][0]}${parts[parts.length - 1][0]}'.toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final initials = _getInitials(authState.user?.name);

    return GestureDetector(
      onTap: () {
        // Navigate to ProfileScreen using pushNamed
        Navigator.pushNamed(context, '/profile');
      },
      child: CircleAvatar(
        radius: 22,
        backgroundColor: AppColors.primary,
        child: Text(
          initials,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

/// Non-focusable SearchBar widget for HomeAppBar
class _HomeSearchBar extends StatelessWidget {
  final VoidCallback? onTap;

  const _HomeSearchBar({this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey.shade100,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          children: [
            Icon(Icons.search, size: 18, color: Colors.grey.shade600),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'Search for anything...',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade500,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Icon(Icons.mic, size: 18, color: Colors.grey.shade600),
          ],
        ),
      ),
    );
  }
}
