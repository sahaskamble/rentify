import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:rentify/screens/categories/categories_screen.dart';
import 'package:rentify/screens/chat/chat_screen.dart';
import 'package:rentify/screens/home/home_screen.dart';
import 'package:rentify/screens/profile/profile_screen.dart';
import 'package:rentify/theme/app_theme.dart';

class AnimatedBottomNav extends StatefulWidget {
  const AnimatedBottomNav({super.key});

  @override
  State<AnimatedBottomNav> createState() => _AnimatedBottomNavState();
}

class _AnimatedBottomNavState extends State<AnimatedBottomNav>
    with TickerProviderStateMixin {
  int _currentIndex = 0;

  late final List<AnimationController> _controllers;
  late final List<Animation<double>> _scaleAnimations;
  late final AnimationController _waveController;

  final List<_NavItem> _navItems = const [
    _NavItem(icon: Icons.home_outlined, activeIcon: Icons.home, label: 'Home'),
    _NavItem(
      icon: Icons.grid_view_outlined,
      activeIcon: Icons.grid_view,
      label: 'Categories',
    ),
    _NavItem(
      icon: Icons.chat_bubble_outline,
      activeIcon: Icons.chat_bubble,
      label: 'Chat',
    ),
    _NavItem(
      icon: Icons.person_outline,
      activeIcon: Icons.person,
      label: 'Profile',
    ),
  ];

  final List<Widget> _screens = [
    const HomeScreen(),
    const CategoriesScreen(),
    const ChatScreen(),
    const ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _controllers = List.generate(
      _navItems.length,
      (index) => AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 200),
      ),
    );

    _scaleAnimations = _controllers.map((controller) {
      return Tween<double>(
        begin: 1.0,
        end: 1.2,
      ).animate(CurvedAnimation(parent: controller, curve: Curves.easeOutBack));
    }).toList();
  }

  @override
  void dispose() {
    _waveController.dispose();
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _onItemTapped(int index) {
    if (_currentIndex == index) return;

    _controllers[index].forward().then((_) {
      _controllers[index].reverse();
    });

    _waveController.forward(from: 0);

    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      height: 85,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.15),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(children: [_buildWaveBackground(), _buildNavItems()]),
      ),
    );
  }

  Widget _buildWaveBackground() {
    return AnimatedBuilder(
      animation: _waveController,
      builder: (context, child) {
        return CustomPaint(
          size: const Size(double.infinity, 60),
          painter: _WavePainter(
            progress: _waveController.value,
            activeIndex: _currentIndex,
            itemCount: _navItems.length,
          ),
        );
      },
    );
  }

  Widget _buildNavItems() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(_navItems.length, (index) {
          return _NavBarItem(
            item: _navItems[index],
            isSelected: _currentIndex == index,
            scaleAnimation: _scaleAnimations[index],
            onTap: () => _onItemTapped(index),
          );
        }),
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final IconData activeIcon;
  final String label;

  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });
}

class _NavBarItem extends StatelessWidget {
  final _NavItem item;
  final bool isSelected;
  final Animation<double> scaleAnimation;
  final VoidCallback onTap;

  const _NavBarItem({
    required this.item,
    required this.isSelected,
    required this.scaleAnimation,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 64,
        height: 60,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: scaleAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: isSelected ? scaleAnimation.value : 1.0,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primary.withValues(alpha: 0.15)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      isSelected ? item.activeIcon : item.icon,
                      size: 24,
                      color: isSelected ? AppColors.primary : AppColors.muted,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 2),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: TextStyle(
                fontSize: isSelected ? 11 : 0,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                color: isSelected ? AppColors.primary : Colors.transparent,
              ),
              child: Text(item.label),
            ),
          ],
        ),
      ),
    );
  }
}

class _WavePainter extends CustomPainter {
  final double progress;
  final int activeIndex;
  final int itemCount;

  _WavePainter({
    required this.progress,
    required this.activeIndex,
    required this.itemCount,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primary.withValues(alpha: 0.15)
      ..style = PaintingStyle.fill;

    final itemWidth = size.width / itemCount;
    final centerX = itemWidth * activeIndex + itemWidth / 2;
    final baseY = size.height;

    final waveHeight = 25.0 + (15.0 * math.sin(progress * math.pi));

    final path = Path();
    path.moveTo(centerX - 50, baseY);
    path.quadraticBezierTo(
      centerX - 25,
      baseY - waveHeight * 2,
      centerX,
      baseY - waveHeight,
    );
    path.quadraticBezierTo(
      centerX + 25,
      baseY - waveHeight * 2,
      centerX + 50,
      baseY,
    );
    path.lineTo(centerX - 50, baseY);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _WavePainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.activeIndex != activeIndex;
  }
}
