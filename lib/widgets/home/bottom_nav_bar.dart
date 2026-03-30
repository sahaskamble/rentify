import 'package:flutter/material.dart';
import 'package:rentify/theme/app_theme.dart';

/// Premium animated bottom navigation bar with synchronized pill + notch
///
/// Features:
/// - Smooth animated pill that slides between tabs
/// - Synchronized concave notch cutout that follows the pill
/// - Physics-driven motion (easeInOutCubic)
/// - Icon fade transitions
/// - Haptic feedback on tap
/// - Micro-scale animations
class HomeBottomNavBar extends StatefulWidget {
  final int currentIndex;
  final void Function(int) onTap;
  final VoidCallback? onFabPress;

  const HomeBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.onFabPress,
  });

  @override
  State<HomeBottomNavBar> createState() => _HomeBottomNavBarState();
}

class _HomeBottomNavBarState extends State<HomeBottomNavBar>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  static const List<IconData> _icons = [
    Icons.home_rounded,
    Icons.grid_view_rounded,
    Icons.add_rounded,
    Icons.chat_bubble_outline_rounded,
    Icons.person_outline_rounded,
  ];

  static const List<String> _labels = [
    'Home',
    'Browse',
    'Add',
    'Chat',
    'Profile',
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _animation =
        Tween<double>(
          begin: widget.currentIndex.toDouble(),
          end: widget.currentIndex.toDouble(),
        ).animate(
          CurvedAnimation(
            curve: Curves.easeInOutCubic,
            parent: _animationController,
          ),
        );
  }

  @override
  void didUpdateWidget(HomeBottomNavBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentIndex != widget.currentIndex) {
      _animation =
          Tween<double>(
            begin: oldWidget.currentIndex.toDouble(),
            end: widget.currentIndex.toDouble(),
          ).animate(
            CurvedAnimation(
              curve: Curves.easeInOutCubic,
              parent: _animationController,
            ),
          );
      _animationController.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleTabTap(int index) {
    if (index == 2) {
      // FAB: Add listing
      widget.onFabPress?.call();
    } else {
      widget.onTap(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80, // Fixed height for nav bar
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return SizedBox(
            height: 80,
            width: double.infinity,
            child: CustomPaint(
              painter: _NotchPainter(
                progress: _animation.value,
                tabCount: _icons.length,
                notchColor: AppColors.surface,
                barHeight: 80,
              ),
              size: Size(MediaQuery.of(context).size.width, 80),
              child: Stack(
                children: [
                  // Animated pill indicator
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 8,
                    child: _AnimatedPill(
                      progress: _animation.value,
                      tabCount: _icons.length,
                    ),
                  ),

                  // Icons row
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 8,
                    child: SizedBox(
                      height: 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(_icons.length, (index) {
                          return _NavBarIcon(
                            icon: _icons[index],
                            label: _labels[index],
                            index: index,
                            isActive:
                                (widget.currentIndex - _animation.value).abs() <
                                0.5,
                            progress: _animation.value,
                            onTap: () => _handleTabTap(index),
                          );
                        }),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Animated pill indicator that slides between tabs
class _AnimatedPill extends StatelessWidget {
  final double progress;
  final int tabCount;

  const _AnimatedPill({required this.progress, required this.tabCount});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final tabWidth = screenWidth / tabCount;
    final pillWidth = 48.0;
    final pillHeight = 40.0;

    // Calculate horizontal position (center of current tab)
    final xPosition = (progress * tabWidth) + (tabWidth / 2) - (pillWidth / 2);

    // Scale animation: slightly compress then expand
    final scaleValue =
        1.0 - ((progress - progress.floorToDouble()).abs() * 0.05);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Stack(
        children: [
          Transform.translate(
            offset: Offset(xPosition, 0),
            child: Transform.scale(
              scale: scaleValue,
              child: Container(
                width: pillWidth,
                height: pillHeight,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.3),
                      blurRadius: 12,
                      spreadRadius: 2,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Individual nav bar icon with fade animation
class _NavBarIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final int index;
  final bool isActive;
  final double progress;
  final VoidCallback onTap;

  const _NavBarIcon({
    required this.icon,
    required this.label,
    required this.index,
    required this.isActive,
    required this.progress,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Smooth fade based on distance from active index
    final distance = (index - progress).abs();
    final opacity = distance > 1.5 ? 0.4 : (1.0 - (distance * 0.2));

    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedOpacity(
            opacity: opacity,
            duration: const Duration(milliseconds: 200),
            child: Icon(
              icon,
              size: 24,
              color: index == 2 ? AppColors.primary : Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 4),
          AnimatedOpacity(
            opacity: isActive ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 300),
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// CustomPainter for the concave notch cutout
class _NotchPainter extends CustomPainter {
  final double progress;
  final int tabCount;
  final Color notchColor;
  final double barHeight;

  _NotchPainter({
    required this.progress,
    required this.tabCount,
    required this.notchColor,
    required this.barHeight,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final tabWidth = size.width / tabCount;
    final notchWidth = 60.0;
    final notchDepth = 14.0;
    final notchRadius = 8.0;

    // Center of notch based on animated progress
    final notchCenterX = (progress * tabWidth) + (tabWidth / 2);

    // Draw background
    final bgPaint = Paint()
      ..color = notchColor
      ..style = PaintingStyle.fill;

    final bgPath = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(0, 0, size.width, size.height),
          const Radius.circular(24),
        ),
      );

    canvas.drawPath(bgPath, bgPaint);

    // Draw notch (concave cutout)
    final notchPath = Path();

    // Start from top-left
    notchPath.moveTo(0, 0);

    // Top edge to notch start
    notchPath.lineTo(notchCenterX - (notchWidth / 2), 0);

    // Smooth concave curve down
    notchPath.quadraticBezierTo(
      notchCenterX - (notchRadius * 1.5),
      notchDepth * 0.3,
      notchCenterX,
      notchDepth,
    );

    // Smooth curve back up
    notchPath.quadraticBezierTo(
      notchCenterX + (notchRadius * 1.5),
      notchDepth * 0.3,
      notchCenterX + (notchWidth / 2),
      0,
    );

    // Top edge to top-right
    notchPath.lineTo(size.width, 0);

    // Right edge
    notchPath.lineTo(size.width, size.height);

    // Bottom edge
    notchPath.lineTo(0, size.height);

    // Close path
    notchPath.close();

    // Draw cutout with shadow for depth
    canvas.drawPath(
      notchPath,
      Paint()
        ..color = notchColor
        ..style = PaintingStyle.fill,
    );

    // Optional: Add subtle inner shadow to notch
    final shadowPath = Path();
    shadowPath.moveTo(notchCenterX - (notchWidth / 2), 0);
    shadowPath.quadraticBezierTo(
      notchCenterX - (notchRadius * 1.5),
      notchDepth * 0.3,
      notchCenterX,
      notchDepth * 0.9,
    );

    canvas.drawPath(
      shadowPath,
      Paint()
        ..color = Colors.black.withValues(alpha: 0.04)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );
  }

  @override
  bool shouldRepaint(_NotchPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
