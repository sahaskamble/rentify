import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../theme/app_colors.dart';
import '../../../core/constants/app_constants.dart';
import '../providers/auth_provider.dart';
import '../../../core/router/app_router.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigate();
  }

  Future<void> _navigate() async {
    await Future.delayed(const Duration(milliseconds: 2200));
    if (!mounted) return;
    final authState = ref.read(authStateProvider);
    authState.when(
      data: (state) {
        if (state.isAuthenticated) {
          context.go(AppRoutes.shell);
        } else {
          context.go(AppRoutes.onboarding);
        }
      },
      loading: () async {
        await Future.delayed(const Duration(milliseconds: 1000));
        if (mounted) context.go(AppRoutes.onboarding);
      },
      error: (_, __) => context.go(AppRoutes.onboarding),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 30,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: const Icon(Icons.storefront_rounded, size: 56, color: AppColors.primary),
            )
                .animate()
                .scale(duration: 600.ms, curve: Curves.elasticOut)
                .fade(duration: 400.ms),
            const SizedBox(height: 24),
            const Text(
              AppConstants.appName,
              style: TextStyle(
                fontSize: 38,
                fontWeight: FontWeight.w800,
                color: Colors.white,
                letterSpacing: -0.5,
              ),
            )
                .animate(delay: 300.ms)
                .slideY(begin: 0.3, duration: 500.ms, curve: Curves.easeOut)
                .fade(duration: 400.ms),
            const SizedBox(height: 8),
            const Text(
              AppConstants.appTagline,
              style: TextStyle(
                fontSize: 14,
                color: Colors.white70,
                fontStyle: FontStyle.italic,
              ),
            )
                .animate(delay: 500.ms)
                .fade(duration: 400.ms),
            const SizedBox(height: 80),
            const SizedBox(
              width: 28,
              height: 28,
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                color: Colors.white60,
              ),
            ).animate(delay: 700.ms).fade(duration: 400.ms),
          ],
        ),
      ),
    );
  }
}
