import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rentify/providers/auth_provider.dart';
import 'package:rentify/providers/home_provider.dart';
import 'package:rentify/providers/location_provider.dart';
import 'package:rentify/theme/app_theme.dart';
import 'package:rentify/widgets/location_picker_bottom_sheet.dart';

/// HomeAppBar is a SliverAppBar - scrollable, not sticky
class HomeAppBar extends ConsumerWidget {
  final VoidCallback? onSearchTap;

  const HomeAppBar({super.key, this.onSearchTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    final locationState = ref.watch(locationProvider);

    return SliverAppBar(
      pinned: false, // NOT sticky - scrolls away
      floating: false, // Doesn't float back
      snap: false,
      elevation: 0,
      backgroundColor: AppColors.surface,
      surfaceTintColor: Colors.transparent,
      toolbarHeight: 160,
      title: Container(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top row: Rentify title + Profile avatar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Rentify',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: AppColors.ink,
                  ),
                ),
                _UserAvatar(authState: authState, ref: ref),
              ],
            ),
            const SizedBox(height: 12),

            // Location chip - under title
            locationState
                .whenData((location) {
                  return _LocationChip(
                    location: location,
                    onTap: () => _showLocationPicker(context),
                  );
                })
                .maybeWhen(
                  data: (widget) => widget,
                  orElse: () => _LocationChip(
                    location: null,
                    onTap: () => _showLocationPicker(context),
                  ),
                ),
            const SizedBox(height: 12),

            // SearchBar
            _HomeSearchBar(onTap: onSearchTap),
          ],
        ),
      ),
    );
  }

  void _showLocationPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => LocationPickerBottomSheet(onLocationConfirmed: () {}),
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
    );
  }
}

/// User avatar with initials
class _UserAvatar extends StatelessWidget {
  final AuthState authState;
  final WidgetRef ref;

  const _UserAvatar({required this.authState, required this.ref});

  String _getInitials(String? name) {
    if (name == null || name.isEmpty) return 'U';
    final parts = name.trim().split(' ');
    if (parts.length == 1) return parts[0][0].toUpperCase();
    return '${parts[0][0]}${parts[parts.length - 1][0]}'.toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final initials = _getInitials(authState.user?.name);

    return GestureDetector(
      onTap: () {
        // Navigate to profile tab (index 3) in bottom nav bar
        ref.read(selectedHomeTabProvider.notifier).state = 3;
      },
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.primary,
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.2),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: Text(
            initials,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

/// Location chip with clean design
class _LocationChip extends StatelessWidget {
  final dynamic location;
  final VoidCallback onTap;

  const _LocationChip({required this.location, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final hasLocation = location?.hasLocation ?? false;
    final displayText = hasLocation
        ? location?.displayAddress ?? 'Select Location'
        : 'Select Location';

    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(
            Icons.location_on_rounded,
            size: 18,
            color: hasLocation ? AppColors.primary : Colors.grey.shade600,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              displayText,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: hasLocation ? AppColors.primary : Colors.grey.shade700,
              ),
            ),
          ),
          Icon(
            Icons.expand_more_rounded,
            size: 18,
            color: hasLocation ? AppColors.primary : Colors.grey.shade500,
          ),
        ],
      ),
    );
  }
}

/// SearchBar
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
          border: Border.all(color: Colors.grey.shade200),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          children: [
            Icon(Icons.search_rounded, size: 18, color: Colors.grey.shade600),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'Search for anything...',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade500,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Icon(Icons.mic_none_rounded, size: 18, color: Colors.grey.shade600),
          ],
        ),
      ),
    );
  }
}
