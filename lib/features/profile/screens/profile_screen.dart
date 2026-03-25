import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../theme/app_colors.dart';
import '../../../core/router/app_router.dart';
import '../../auth/providers/auth_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    final user = authState.maybeWhen(
      data: (data) => data.user,
      orElse: () => null,
    );
    final name = user?.getStringValue('name') ?? 'User';
    final email = user?.getStringValue('email') ?? '';
    final isPhoneVerified = user?.getBoolValue('is_phone_verified') ?? false;
    final isIdVerified = user?.getBoolValue('is_id_verified') ?? false;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: AppColors.primary,
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: AppColors.primary,
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      CircleAvatar(
                        radius: 38,
                        backgroundColor: Colors.white.withOpacity(0.2),
                        child: Text(
                          name.isNotEmpty ? name[0].toUpperCase() : 'U',
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        email,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(height: 20),
                // Verification status
                _SectionCard(
                  title: 'Verification Status',
                  children: [
                    _StatusRow(
                      icon: Icons.phone_outlined,
                      label: 'Phone Verified',
                      done: isPhoneVerified,
                    ),
                    _StatusRow(
                      icon: Icons.badge_outlined,
                      label: 'ID Verified',
                      done: isIdVerified,
                    ),
                    _StatusRow(
                      icon: Icons.account_balance_outlined,
                      label: 'Bank Verified',
                      done: false,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                _SectionCard(
                  title: 'Seller',
                  children: [
                    _MenuRow(
                      icon: Icons.storefront_outlined,
                      label: 'My Listings',
                      onTap: () {},
                    ),
                    _MenuRow(
                      icon: Icons.add_box_outlined,
                      label: 'Create Listing',
                      onTap: () => context.push(AppRoutes.createListing),
                    ),
                    _MenuRow(
                      icon: Icons.account_balance_wallet_outlined,
                      label: 'Earnings & Payouts',
                      onTap: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                _SectionCard(
                  title: 'Account',
                  children: [
                    _MenuRow(
                      icon: Icons.person_outline,
                      label: 'Edit Profile',
                      onTap: () => context.push(AppRoutes.editProfile),
                    ),
                    _MenuRow(
                      icon: Icons.verified_user_outlined,
                      label: 'Verification',
                      onTap: () => context.push(AppRoutes.verification),
                    ),
                    _MenuRow(
                      icon: Icons.help_outline_rounded,
                      label: 'Help & Support',
                      onTap: () {},
                    ),
                    _MenuRow(
                      icon: Icons.logout_rounded,
                      label: 'Sign Out',
                      labelColor: Colors.red,
                      onTap: () async {
                        await ref.read(authStateProvider.notifier).logout();
                        if (context.mounted) context.go(AppRoutes.login);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 80),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const _SectionCard({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 8),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: AppColors.textSecondary,
                letterSpacing: 0.8,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(children: children),
          ),
        ],
      ),
    );
  }
}

class _MenuRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? labelColor;
  const _MenuRow({
    required this.icon,
    required this.label,
    required this.onTap,
    this.labelColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: labelColor ?? AppColors.textPrimary, size: 22),
      title: Text(
        label,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: labelColor ?? AppColors.textPrimary,
        ),
      ),
      trailing: const Icon(
        Icons.chevron_right_rounded,
        color: AppColors.textSecondary,
        size: 20,
      ),
      onTap: onTap,
    );
  }
}

class _StatusRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool done;
  const _StatusRow({
    required this.icon,
    required this.label,
    required this.done,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppColors.textPrimary, size: 22),
      title: Text(
        label,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppColors.textPrimary,
        ),
      ),
      trailing: done
          ? const Icon(
              Icons.check_circle_rounded,
              color: AppColors.primary,
              size: 22,
            )
          : const Icon(
              Icons.radio_button_unchecked_rounded,
              color: AppColors.textSecondary,
              size: 22,
            ),
    );
  }
}
