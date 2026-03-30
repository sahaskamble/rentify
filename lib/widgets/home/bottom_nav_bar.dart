import 'package:flutter/material.dart';
import 'package:rentify/theme/app_theme.dart';

/// Premium animated bottom navigation bar with synchronized pill + notch
///
/// Fixes applied:
///  1. Notch is now a real cubic-bezier cutout (was painted over by bgPath)
///  2. Pill is BoxShape.circle — width == height == 52
///  3. Active icon lives INSIDE the pill (was floating separately)
///  4. Pill x-position formula no longer has the 16px padding offset bug
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
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _pillAnim;

  // ── Layout constants ────────────────────────────────────────────────────────
  static const double _pillSize = 52.0;
  static const double _barHeight = 72.0;
  // Pill center sits exactly on the top edge of the bar, so half the pill
  // overhangs above the bar and lives in the notch.
  static const double _overhang = _pillSize / 2; // 26 px
  // Notch radius = pill radius + a small gap so the bar doesn't touch the pill
  static const double _notchR = _pillSize / 2 + 7.0; // 33 px

  static const List<IconData> _icons = [
    Icons.home_rounded,
    Icons.grid_view_rounded,
    Icons.chat_bubble_outline_rounded,
    Icons.person_outline_rounded,
  ];

  static const List<String> _labels = ['Home', 'Browse', 'Chat', 'Profile'];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _pillAnim =
        Tween<double>(
          begin: widget.currentIndex.toDouble(),
          end: widget.currentIndex.toDouble(),
        ).animate(
          CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic),
        );
  }

  @override
  void didUpdateWidget(HomeBottomNavBar old) {
    super.didUpdateWidget(old);
    if (old.currentIndex != widget.currentIndex) {
      _pillAnim =
          Tween<double>(
            begin: old.currentIndex.toDouble(),
            end: widget.currentIndex.toDouble(),
          ).animate(
            CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic),
          );
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap(int i) =>
      i == 2 ? widget.onFabPress?.call() : widget.onTap(i);

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;
    final tabW = screenW / _icons.length;

    return AnimatedBuilder(
      animation: _pillAnim,
      builder: (ctx, _) {
        // Horizontal center of the pill — no padding offset, pure math
        final pillCX = (_pillAnim.value + 0.5) * tabW;

        return SizedBox(
          // Extra height at the top so the overhanging pill isn't clipped
          height: _barHeight + _overhang,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // ── Bar body + notch cutout ─────────────────────────────────
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                height: _barHeight,
                child: CustomPaint(
                  painter: _NotchPainter(
                    notchCX: pillCX,
                    notchR: _notchR,
                    color: AppColors.surface,
                  ),
                  child: _IconsRow(
                    icons: _icons,
                    labels: _labels,
                    tabWidth: tabW,
                    activeIndex: widget.currentIndex,
                    progress: _pillAnim.value,
                    // Push the icon row below the deepest point of the notch
                    topPadding: _notchR + 4,
                    onTap: _handleTap,
                  ),
                ),
              ),

              // ── Circular pill (slides horizontally) ─────────────────────
              Positioned(
                // top: 0 places the pill top at the very top of this SizedBox.
                // Since the bar starts at _overhang (26 px) below the SizedBox top,
                // the pill centre lands exactly on the bar's top edge. ✓
                top: 0,
                // Center the pill on pillCX without any extra padding.
                left: pillCX - _pillSize / 2,
                child: Container(
                  width: _pillSize,
                  height: _pillSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle, // ← guarantees a perfect circle
                    color: AppColors.primary,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.4),
                        blurRadius: 16,
                        spreadRadius: 1,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  // Icon is centered inside the pill — no Padding wrapper,
                  // just a plain Center so nothing can push it off-axis.
                  child: Center(
                    child: Icon(
                      _icons[widget.currentIndex],
                      size: 24,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ── Icon row ──────────────────────────────────────────────────────────────────

class _IconsRow extends StatelessWidget {
  final List<IconData> icons;
  final List<String> labels;
  final double tabWidth;
  final int activeIndex;
  final double progress;
  final double topPadding;
  final void Function(int) onTap;

  const _IconsRow({
    required this.icons,
    required this.labels,
    required this.tabWidth,
    required this.activeIndex,
    required this.progress,
    required this.topPadding,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: topPadding),
      child: Row(
        children: List.generate(icons.length, (i) {
          final isActive = activeIndex == i;
          final dist = (i - progress).abs();

          // Active icon is rendered inside the pill, so hide it here to
          // avoid a ghost icon showing behind the pill.
          final iconOpacity = isActive
              ? 0.0
              : (1.0 - dist * 0.22).clamp(0.35, 1.0).toDouble();

          return GestureDetector(
            onTap: () => onTap(i),
            behavior: HitTestBehavior.opaque,
            child: SizedBox(
              width: tabWidth,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Opacity(
                    opacity: iconOpacity,
                    child: Icon(
                      icons[i],
                      size: 22,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 3),
                  AnimatedOpacity(
                    opacity: isActive ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 250),
                    child: Text(
                      labels[i],
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

// ── Notch painter ─────────────────────────────────────────────────────────────

/// Draws the nav-bar background with a smooth U-shaped notch cut out of the
/// top edge, centred at [notchCX] with radius [notchR].
///
/// Why it was invisible before
/// ───────────────────────────
/// The old painter first drew a full solid rectangle (bgPath) then drew the
/// "notch path" on top — both in the same surface colour.  The notch area was
/// never actually left transparent; it was just painted over twice.
///
/// Fix: Draw ONLY the notch path. Because the path doesn't cover the notch
/// region, that area stays transparent and the screen content shows through.
class _NotchPainter extends CustomPainter {
  final double notchCX;
  final double notchR;
  final Color color;

  const _NotchPainter({
    required this.notchCX,
    required this.notchR,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final cx = notchCX;
    final r = notchR;

    // Shoulder width: how far from the notch edge the straight top line ends
    // before curving into the notch.  Larger = smoother transition.
    const shoulder = 10.0;

    //   0───────[shoulder]──[left tangent]─ ∪ ─[right tangent]──[shoulder]──width
    //                                      ↑
    //                              notch bottom (depth = r)

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(cx - r - shoulder, 0)
      // ── Left shoulder: cubic curve smoothly diving into the notch ──────
      ..cubicTo(
        cx - r,
        0, // CP1 — stay on the top edge until the tangent point
        cx - r,
        r, // CP2 — pull down to the notch floor on the left
        cx,
        r, // end  — very bottom centre of the notch
      )
      // ── Right shoulder: cubic curve climbing back out ───────────────────
      ..cubicTo(
        cx + r,
        r, // CP1 — notch floor on the right
        cx + r,
        0, // CP2 — back up to the top edge at the tangent point
        cx + r + shoulder,
        0, // end — back on the straight top edge
      )
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    // Drop shadow drawn first so it appears under the bar
    canvas.drawShadow(path, Colors.black.withValues(alpha: 0.18), 8, false);

    canvas.drawPath(
      path,
      Paint()
        ..color = color
        ..style = PaintingStyle.fill,
    );
  }

  @override
  bool shouldRepaint(_NotchPainter old) =>
      old.notchCX != notchCX || old.notchR != notchR || old.color != color;
}

// import 'package:flutter/material.dart';
// import 'package:rentify/theme/app_theme.dart';
//
// /// Premium animated bottom navigation bar with synchronized pill + notch
// ///
// /// Features:
// /// - Smooth animated pill that slides between tabs
// /// - Synchronized concave notch cutout that follows the pill
// /// - Physics-driven motion (easeInOutCubic)
// /// - Icon fade transitions
// /// - Haptic feedback on tap
// /// - Micro-scale animations
// class HomeBottomNavBar extends StatefulWidget {
//   final int currentIndex;
//   final void Function(int) onTap;
//   final VoidCallback? onFabPress;
//
//   const HomeBottomNavBar({
//     super.key,
//     required this.currentIndex,
//     required this.onTap,
//     this.onFabPress,
//   });
//
//   @override
//   State<HomeBottomNavBar> createState() => _HomeBottomNavBarState();
// }
//
// class _HomeBottomNavBarState extends State<HomeBottomNavBar>
//     with TickerProviderStateMixin {
//   late AnimationController _animationController;
//   late Animation<double> _animation;
//
//   static const List<IconData> _icons = [
//     Icons.home_rounded,
//     Icons.grid_view_rounded,
//     Icons.add_rounded,
//     Icons.chat_bubble_outline_rounded,
//     Icons.person_outline_rounded,
//   ];
//
//   static const List<String> _labels = [
//     'Home',
//     'Browse',
//     'Add',
//     'Chat',
//     'Profile',
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 600),
//     );
//     _animation =
//         Tween<double>(
//           begin: widget.currentIndex.toDouble(),
//           end: widget.currentIndex.toDouble(),
//         ).animate(
//           CurvedAnimation(
//             curve: Curves.easeInOutCubic,
//             parent: _animationController,
//           ),
//         );
//   }
//
//   @override
//   void didUpdateWidget(HomeBottomNavBar oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (oldWidget.currentIndex != widget.currentIndex) {
//       _animation =
//           Tween<double>(
//             begin: oldWidget.currentIndex.toDouble(),
//             end: widget.currentIndex.toDouble(),
//           ).animate(
//             CurvedAnimation(
//               curve: Curves.easeInOutCubic,
//               parent: _animationController,
//             ),
//           );
//       _animationController.forward(from: 0.0);
//     }
//   }
//
//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }
//
//   void _handleTabTap(int index) {
//     if (index == 2) {
//       // FAB: Add listing
//       widget.onFabPress?.call();
//     } else {
//       widget.onTap(index);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 80, // Fixed height for nav bar
//       decoration: BoxDecoration(
//         color: AppColors.surface,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withValues(alpha: 0.08),
//             blurRadius: 20,
//             offset: const Offset(0, -4),
//           ),
//         ],
//       ),
//       child: AnimatedBuilder(
//         animation: _animation,
//         builder: (context, child) {
//           return SizedBox(
//             height: 80,
//             width: double.infinity,
//             child: CustomPaint(
//               painter: _NotchPainter(
//                 progress: _animation.value,
//                 tabCount: _icons.length,
//                 notchColor: AppColors.surface,
//                 barHeight: 80,
//               ),
//               size: Size(MediaQuery.of(context).size.width, 80),
//               child: Stack(
//                 children: [
//                   // Animated pill indicator
//                   Positioned(
//                     left: 0,
//                     right: 0,
//                     top: 8,
//                     child: _AnimatedPill(
//                       progress: _animation.value,
//                       tabCount: _icons.length,
//                     ),
//                   ),
//
//                   // Icons row
//                   Positioned(
//                     left: 0,
//                     right: 0,
//                     bottom: 8,
//                     child: SizedBox(
//                       height: 60,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: List.generate(_icons.length, (index) {
//                           return _NavBarIcon(
//                             icon: _icons[index],
//                             label: _labels[index],
//                             index: index,
//                             isActive:
//                                 (widget.currentIndex - _animation.value).abs() <
//                                 0.5,
//                             progress: _animation.value,
//                             onTap: () => _handleTabTap(index),
//                           );
//                         }),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
//
// /// Animated pill indicator that slides between tabs
// class _AnimatedPill extends StatelessWidget {
//   final double progress;
//   final int tabCount;
//
//   const _AnimatedPill({required this.progress, required this.tabCount});
//
//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final tabWidth = screenWidth / tabCount;
//     final pillWidth = 48.0;
//     final pillHeight = 40.0;
//
//     // Calculate horizontal position (center of current tab)
//     final xPosition = (progress * tabWidth) + (tabWidth / 2) - (pillWidth / 2);
//
//     // Scale animation: slightly compress then expand
//     final scaleValue =
//         1.0 - ((progress - progress.floorToDouble()).abs() * 0.05);
//
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: Stack(
//         children: [
//           Transform.translate(
//             offset: Offset(xPosition, 0),
//             child: Transform.scale(
//               scale: scaleValue,
//               child: Container(
//                 width: pillWidth,
//                 height: pillHeight,
//                 decoration: BoxDecoration(
//                   color: AppColors.primary,
//                   borderRadius: BorderRadius.circular(20),
//                   boxShadow: [
//                     BoxShadow(
//                       color: AppColors.primary.withValues(alpha: 0.3),
//                       blurRadius: 12,
//                       spreadRadius: 2,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// /// Individual nav bar icon with fade animation
// class _NavBarIcon extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   final int index;
//   final bool isActive;
//   final double progress;
//   final VoidCallback onTap;
//
//   const _NavBarIcon({
//     required this.icon,
//     required this.label,
//     required this.index,
//     required this.isActive,
//     required this.progress,
//     required this.onTap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     // Smooth fade based on distance from active index
//     final distance = (index - progress).abs();
//     final opacity = distance > 1.5 ? 0.4 : (1.0 - (distance * 0.2));
//
//     return GestureDetector(
//       onTap: onTap,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           AnimatedOpacity(
//             opacity: opacity,
//             duration: const Duration(milliseconds: 200),
//             child: Icon(
//               icon,
//               size: 24,
//               color: index == 2 ? AppColors.primary : Colors.grey.shade700,
//             ),
//           ),
//           const SizedBox(height: 4),
//           AnimatedOpacity(
//             opacity: isActive ? 1.0 : 0.0,
//             duration: const Duration(milliseconds: 300),
//             child: Text(
//               label,
//               style: const TextStyle(
//                 fontSize: 10,
//                 fontWeight: FontWeight.w600,
//                 color: AppColors.primary,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// /// CustomPainter for the concave notch cutout
// class _NotchPainter extends CustomPainter {
//   final double progress;
//   final int tabCount;
//   final Color notchColor;
//   final double barHeight;
//
//   _NotchPainter({
//     required this.progress,
//     required this.tabCount,
//     required this.notchColor,
//     required this.barHeight,
//   });
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     final tabWidth = size.width / tabCount;
//     final notchWidth = 60.0;
//     final notchDepth = 14.0;
//     final notchRadius = 8.0;
//
//     // Center of notch based on animated progress
//     final notchCenterX = (progress * tabWidth) + (tabWidth / 2);
//
//     // Draw background
//     final bgPaint = Paint()
//       ..color = notchColor
//       ..style = PaintingStyle.fill;
//
//     final bgPath = Path()
//       ..addRRect(
//         RRect.fromRectAndRadius(
//           Rect.fromLTWH(0, 0, size.width, size.height),
//           const Radius.circular(24),
//         ),
//       );
//
//     canvas.drawPath(bgPath, bgPaint);
//
//     // Draw notch (concave cutout)
//     final notchPath = Path();
//
//     // Start from top-left
//     notchPath.moveTo(0, 0);
//
//     // Top edge to notch start
//     notchPath.lineTo(notchCenterX - (notchWidth / 2), 0);
//
//     // Smooth concave curve down
//     notchPath.quadraticBezierTo(
//       notchCenterX - (notchRadius * 1.5),
//       notchDepth * 0.3,
//       notchCenterX,
//       notchDepth,
//     );
//
//     // Smooth curve back up
//     notchPath.quadraticBezierTo(
//       notchCenterX + (notchRadius * 1.5),
//       notchDepth * 0.3,
//       notchCenterX + (notchWidth / 2),
//       0,
//     );
//
//     // Top edge to top-right
//     notchPath.lineTo(size.width, 0);
//
//     // Right edge
//     notchPath.lineTo(size.width, size.height);
//
//     // Bottom edge
//     notchPath.lineTo(0, size.height);
//
//     // Close path
//     notchPath.close();
//
//     // Draw cutout with shadow for depth
//     canvas.drawPath(
//       notchPath,
//       Paint()
//         ..color = notchColor
//         ..style = PaintingStyle.fill,
//     );
//
//     // Optional: Add subtle inner shadow to notch
//     final shadowPath = Path();
//     shadowPath.moveTo(notchCenterX - (notchWidth / 2), 0);
//     shadowPath.quadraticBezierTo(
//       notchCenterX - (notchRadius * 1.5),
//       notchDepth * 0.3,
//       notchCenterX,
//       notchDepth * 0.9,
//     );
//
//     canvas.drawPath(
//       shadowPath,
//       Paint()
//         ..color = Colors.black.withValues(alpha: 0.04)
//         ..style = PaintingStyle.stroke
//         ..strokeWidth = 2,
//     );
//   }
//
//   @override
//   bool shouldRepaint(_NotchPainter oldDelegate) {
//     return oldDelegate.progress != progress;
//   }
// }
