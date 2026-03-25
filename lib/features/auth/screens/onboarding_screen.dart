import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../theme/app_colors.dart';
import '../../../core/router/app_router.dart';

class _OnboardingPage {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final Color bgColor;
  const _OnboardingPage({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.bgColor,
  });
}

const _pages = [
  _OnboardingPage(
    icon: Icons.inventory_2_rounded,
    iconColor: AppColors.primary,
    title: 'Rent Anything,\nAnytime',
    subtitle:
        'Find cameras, furniture, tools, electronics & more from people near you in Mumbai.',
    bgColor: Colors.white,
  ),
  _OnboardingPage(
    icon: Icons.shield_rounded,
    iconColor: AppColors.primary,
    title: 'Safe &\nSecure',
    subtitle:
        'Verified sellers, security deposits, and in-app dispute resolution keep every rental protected.',
    bgColor: Colors.white,
  ),
  _OnboardingPage(
    icon: Icons.account_balance_wallet_rounded,
    iconColor: AppColors.primary,
    title: 'List Your Gear,\nEarn Money',
    subtitle:
        'Got idle equipment? List it in minutes and start earning from what you already own.',
    bgColor: Colors.white,
  ),
];

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _controller = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _next() {
    if (_currentPage < _pages.length - 1) {
      _controller.nextPage(duration: 400.ms, curve: Curves.easeInOut);
    } else {
      context.go(AppRoutes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _pages[_currentPage].bgColor,
      body: SafeArea(
        child: Column(
          children: [
            // Skip button
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: () => context.go(AppRoutes.login),
                child: const Text(
                  'Skip',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            // Page view
            Expanded(
              child: PageView.builder(
                controller: _controller,
                onPageChanged: (i) => setState(() => _currentPage = i),
                itemCount: _pages.length,
                itemBuilder: (context, i) {
                  final page = _pages[i];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                              width: 140,
                              height: 140,
                              decoration: BoxDecoration(
                                color: page.iconColor.withValues(alpha: 0.15),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                page.icon,
                                size: 72,
                                color: page.iconColor,
                              ),
                            )
                            .animate(key: ValueKey(i))
                            .scale(duration: 500.ms, curve: Curves.elasticOut),
                        const SizedBox(height: 40),
                        Text(
                              page.title,
                              style: const TextStyle(
                                fontSize: 34,
                                fontWeight: FontWeight.w800,
                                color: AppColors.textPrimary,
                                height: 1.2,
                              ),
                              textAlign: TextAlign.center,
                            )
                            .animate(key: ValueKey('t$i'))
                            .slideY(begin: 0.2, duration: 400.ms)
                            .fade(),
                        const SizedBox(height: 16),
                        Text(
                              page.subtitle,
                              style: const TextStyle(
                                fontSize: 16,
                                height: 1.6,
                                color: AppColors.textSecondary,
                              ),
                              textAlign: TextAlign.center,
                            )
                            .animate(key: ValueKey('s$i'), delay: 100.ms)
                            .slideY(begin: 0.2, duration: 400.ms)
                            .fade(),
                      ],
                    ),
                  );
                },
              ),
            ),
            // Indicator dots + button
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 0, 32, 32),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _pages.length,
                      (i) => AnimatedContainer(
                        duration: 300.ms,
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: _currentPage == i ? 28 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: _currentPage == i
                              ? AppColors.primary
                              : AppColors.primary.withValues(alpha: 0.25),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _next,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        _currentPage < _pages.length - 1
                            ? 'Next'
                            : 'Get Started',
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account? ",
                        style: TextStyle(color: AppColors.textSecondary),
                      ),
                      GestureDetector(
                        onTap: () => context.go(AppRoutes.login),
                        child: const Text(
                          'Sign In',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
