import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rentify/providers/auth_provider.dart';
import 'package:rentify/providers/profile_provider.dart';
import 'package:rentify/theme/app_theme.dart';

/// Professional Profile Screen with real data from PocketBase
///
/// Displays:
/// - User avatar (from PocketBase or initials)
/// - Name, email, rating
/// - Stats: rentals, listings, reviews
/// - Account details from seller_profiles
/// - Settings and logout
class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    final user = authState.user;

    if (user == null) {
      return const Scaffold(body: Center(child: Text('Not authenticated')));
    }

    final sellerProfile = ref.watch(sellerProfileProvider);
    final totalListings = ref.watch(totalListingsProvider);
    final totalRentals = ref.watch(totalRentalsProvider);
    final averageRating = ref.watch(averageRatingProvider);
    final totalReviews = ref.watch(totalReviewsProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile header section
            _ProfileHeader(user: user),
            const SizedBox(height: 24),

            // Stats section with real data
            _StatsSection(
              totalListings: totalListings,
              totalRentals: totalRentals,
              averageRating: averageRating,
              totalReviews: totalReviews,
            ),
            const SizedBox(height: 24),

            // Quick actions
            _QuickActionsSection(context: context, user: user),
            const SizedBox(height: 24),

            // Account details from seller profile
            _AccountDetailsSection(user: user, sellerProfile: sellerProfile),
            const SizedBox(height: 24),

            // Settings menu
            _SettingsMenuSection(context: context),
            const SizedBox(height: 24),

            // Logout button
            _LogoutButton(ref: ref, context: context),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: const Text(
        'My Profile',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: AppColors.ink,
        ),
      ),
      centerTitle: true,
      elevation: 0,
      backgroundColor: AppColors.surface,
      surfaceTintColor: Colors.transparent,
    );
  }
}

/// Profile header with avatar, name, email, rating
class _ProfileHeader extends StatelessWidget {
  final dynamic user;

  const _ProfileHeader({required this.user});

  String _getInitials(String? name) {
    if (name == null || name.isEmpty) return 'U';
    final parts = name.trim().split(' ');
    if (parts.length == 1) return parts[0][0].toUpperCase();
    return '${parts[0][0]}${parts[parts.length - 1][0]}'.toUpperCase();
  }

  /// Get avatar URL from PocketBase
  String? _getAvatarUrl() {
    if (user.avatar == null || user.avatar.isEmpty) return null;
    return 'https://backend.rentifystore.com/api/files/${user.collectionId}/${user.id}/${user.avatar}';
  }

  @override
  Widget build(BuildContext context) {
    final initials = _getInitials(user.name);
    final avatarUrl = _getAvatarUrl();

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Avatar
            avatarUrl != null
                ? Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.primary, width: 2),
                    ),
                    child: ClipOval(
                      child: Image.network(
                        avatarUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return _buildInitialsAvatar(initials);
                        },
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        },
                      ),
                    ),
                  )
                : _buildInitialsAvatar(initials),
            const SizedBox(height: 16),

            // Name
            Text(
              user.name ?? 'User',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.ink,
              ),
            ),
            const SizedBox(height: 4),

            // Email
            Text(
              user.email,
              style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
            ),
            const SizedBox(height: 12),

            // Rating row (will be populated from real data)
            Consumer(
              builder: (context, ref, _) {
                final averageRating = ref.watch(averageRatingProvider);
                final totalReviews = ref.watch(totalReviewsProvider);

                return averageRating.when(
                  data: (rating) {
                    return totalReviews.when(
                      data: (reviewCount) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.star_rounded,
                              size: 16,
                              color: Color(0xFFFFB800),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              rating.toStringAsFixed(1),
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColors.ink,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '($reviewCount reviews)',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        );
                      },
                      loading: () => const SizedBox(height: 20),
                      error: (_, __) => const SizedBox(height: 20),
                    );
                  },
                  loading: () => const SizedBox(height: 20),
                  error: (_, __) => const SizedBox(height: 20),
                );
              },
            ),

            // Verification badge
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.green.shade200),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.verified_user_rounded,
                    size: 14,
                    color: Colors.green.shade700,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Verified User',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.green.shade700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInitialsAvatar(String initials) {
    return CircleAvatar(
      radius: 40,
      backgroundColor: AppColors.primary,
      child: Text(
        initials,
        style: const TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
    );
  }
}

/// Stats section with real data from providers
class _StatsSection extends ConsumerWidget {
  final AsyncValue<int> totalListings;
  final AsyncValue<int> totalRentals;
  final AsyncValue<double> averageRating;
  final AsyncValue<int> totalReviews;

  const _StatsSection({
    required this.totalListings,
    required this.totalRentals,
    required this.averageRating,
    required this.totalReviews,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          totalRentals.when(
            data: (count) => _StatCard(
              icon: Icons.shopping_bag_rounded,
              label: 'Total Rentals',
              value: count.toString(),
            ),
            loading: () => _StatCard(
              icon: Icons.shopping_bag_rounded,
              label: 'Total Rentals',
              value: '-',
            ),
            error: (_, __) => _StatCard(
              icon: Icons.shopping_bag_rounded,
              label: 'Total Rentals',
              value: '0',
            ),
          ),
          const SizedBox(width: 12),
          totalListings.when(
            data: (count) => _StatCard(
              icon: Icons.inventory_2_rounded,
              label: 'Items Listed',
              value: count.toString(),
            ),
            loading: () => _StatCard(
              icon: Icons.inventory_2_rounded,
              label: 'Items Listed',
              value: '-',
            ),
            error: (_, __) => _StatCard(
              icon: Icons.inventory_2_rounded,
              label: 'Items Listed',
              value: '0',
            ),
          ),
          const SizedBox(width: 12),
          totalReviews.when(
            data: (count) => _StatCard(
              icon: Icons.rate_review_rounded,
              label: 'Reviews',
              value: count.toString(),
            ),
            loading: () => _StatCard(
              icon: Icons.rate_review_rounded,
              label: 'Reviews',
              value: '-',
            ),
            error: (_, __) => _StatCard(
              icon: Icons.rate_review_rounded,
              label: 'Reviews',
              value: '0',
            ),
          ),
        ],
      ),
    );
  }
}

/// Individual stat card
class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Icon(icon, size: 24, color: AppColors.primary),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.ink,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
    );
  }
}

/// Quick actions: Edit profile, Verify ID, Settings
class _QuickActionsSection extends StatelessWidget {
  final BuildContext context;
  final dynamic user;

  const _QuickActionsSection({required this.context, required this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          _ActionButton(
            icon: Icons.edit_rounded,
            label: 'Edit Profile',
            onTap: () {
              // TODO: Navigate to edit profile screen
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Edit profile coming soon')),
              );
            },
          ),
          const SizedBox(width: 12),
          _ActionButton(
            icon: Icons.verified_user_rounded,
            label: 'Verify ID',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('ID verification coming soon')),
              );
            },
          ),
          const SizedBox(width: 12),
          _ActionButton(
            icon: Icons.settings_rounded,
            label: 'Settings',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Settings coming soon')),
              );
            },
          ),
        ],
      ),
    );
  }
}

/// Individual action button
class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.primary.withOpacity(0.3)),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(
            children: [
              Icon(icon, size: 24, color: AppColors.primary),
              const SizedBox(height: 6),
              Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Account details from seller profile
class _AccountDetailsSection extends ConsumerWidget {
  final dynamic user;
  final AsyncValue<dynamic> sellerProfile;

  const _AccountDetailsSection({
    required this.user,
    required this.sellerProfile,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          children: [
            // Title
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: const [
                  Icon(Icons.info_rounded, size: 18, color: AppColors.primary),
                  SizedBox(width: 8),
                  Text(
                    'Account Information',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.ink,
                    ),
                  ),
                ],
              ),
            ),

            // Phone
            _DetailRow(
              icon: Icons.phone_rounded,
              label: 'Phone',
              value: user.phone ?? 'Not provided',
            ),

            // Location from seller profile
            sellerProfile.when(
              data: (profile) {
                final city = profile?.city ?? 'Not provided';
                final state = profile?.state ?? '';
                final location = state.isNotEmpty ? '$city, $state' : city;

                return _DetailRow(
                  icon: Icons.location_on_rounded,
                  label: 'Location',
                  value: location,
                );
              },
              loading: () => _DetailRow(
                icon: Icons.location_on_rounded,
                label: 'Location',
                value: 'Loading...',
              ),
              error: (_, __) => _DetailRow(
                icon: Icons.location_on_rounded,
                label: 'Location',
                value: 'Not provided',
              ),
            ),

            // Member since (format created date)
            _DetailRow(
              icon: Icons.calendar_today_rounded,
              label: 'Member Since',
              value: _formatDate(user.created),
              isLast: true,
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'Unknown';
    final months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return '${months[date.month - 1]} ${date.year}';
  }
}

/// Individual detail row
class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final bool isLast;

  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Icon(icon, size: 18, color: Colors.grey.shade600),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      value,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.ink,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (!isLast)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Divider(height: 1, color: Colors.grey.shade200),
          ),
      ],
    );
  }
}

/// Settings menu section
class _SettingsMenuSection extends StatelessWidget {
  final BuildContext context;

  const _SettingsMenuSection({required this.context});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          children: [
            _SettingsTile(
              icon: Icons.payment_rounded,
              title: 'Payment Methods',
              subtitle: 'Add or manage payment methods',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Payment methods coming soon')),
                );
              },
            ),
            _SettingsTile(
              icon: Icons.notifications_rounded,
              title: 'Notifications',
              subtitle: 'Manage notification preferences',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Notifications coming soon')),
                );
              },
            ),
            _SettingsTile(
              icon: Icons.help_rounded,
              title: 'Help & Support',
              subtitle: 'Get help with your account',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Help center coming soon')),
                );
              },
            ),
            _SettingsTile(
              icon: Icons.description_rounded,
              title: 'Terms & Privacy',
              subtitle: 'View our terms and privacy policy',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Terms coming soon')),
                );
              },
              isLast: true,
            ),
          ],
        ),
      ),
    );
  }
}

/// Individual settings tile
class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final bool isLast;

  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  Icon(icon, size: 22, color: AppColors.primary),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppColors.ink,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          subtitle,
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.chevron_right_rounded,
                    size: 20,
                    color: Colors.grey.shade400,
                  ),
                ],
              ),
            ),
          ),
        ),
        if (!isLast)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Divider(height: 1, color: Colors.grey.shade200),
          ),
      ],
    );
  }
}

/// Logout button with confirmation
class _LogoutButton extends ConsumerWidget {
  final WidgetRef ref;
  final BuildContext context;

  const _LogoutButton({required this.ref, required this.context});

  void _showLogoutConfirmation() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              ref.read(authStateProvider.notifier).logout();
            },
            child: Text('Logout', style: TextStyle(color: Colors.red.shade700)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: _showLogoutConfirmation,
          icon: const Icon(Icons.logout_rounded),
          label: const Text('Logout'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red.shade50,
            foregroundColor: Colors.red.shade700,
            padding: const EdgeInsets.symmetric(vertical: 12),
            side: BorderSide(color: Colors.red.shade200),
          ),
        ),
      ),
    );
  }
}
