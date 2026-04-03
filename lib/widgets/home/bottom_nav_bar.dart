import 'package:flutter/material.dart';
import 'package:rentify/theme/app_theme.dart';

/// Premium animated bottom navigation bar with synchronized pill + notch
///
/// 4-tab navigation: Home | Browse | Chat | Profile
/// No FAB in the nav bar (FAB is a separate floating button)
class HomeBottomNavBar extends StatefulWidget {
  final int currentIndex;
  final void Function(int) onTap;

  const HomeBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
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

  // 4 tabs only (no FAB)
  static const List<IconData> _icons = [
    Icons.home_rounded,
    Icons.grid_view_rounded,
    Icons.add_circle_outline_rounded,
    Icons.person_outline_rounded,
  ];

  static const List<String> _labels = [
    'Home',
    'Browse',
    'Give on Rent',
    'Profile',
  ];

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
                    color: AppColors.primary,
                  ),
                  child: _IconsRow(
                    icons: _icons,
                    labels: _labels,
                    tabWidth: tabW,
                    activeIndex: widget.currentIndex,
                    progress: _pillAnim.value,
                    barHeight: _barHeight,
                    onTap: widget.onTap,
                  ),
                ),
              ),

              // ── Circular pill (slides horizontally) ─────────────────────
              Positioned(
                top: 0,
                left: pillCX - _pillSize / 2,
                child: Container(
                  width: _pillSize,
                  height: _pillSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.3),
                        blurRadius: 20,
                        spreadRadius: 1,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Icon(
                      _icons[widget.currentIndex],
                      size: 30,
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

// ── Icon row ────────────────────────────────────────────────────────────────

class _IconsRow extends StatelessWidget {
  final List<IconData> icons;
  final List<String> labels;
  final double tabWidth;
  final int activeIndex;
  final double progress;
  final double barHeight;
  final void Function(int) onTap;

  const _IconsRow({
    required this.icons,
    required this.labels,
    required this.tabWidth,
    required this.activeIndex,
    required this.progress,
    required this.barHeight,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.zero,
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
              height: barHeight,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Opacity(
                    opacity: iconOpacity,
                    child: Icon(icons[i], size: 28, color: AppColors.surface),
                  ),
                  const SizedBox(height: 2),
                  AnimatedOpacity(
                    opacity: isActive ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 250),
                    child: Text(
                      labels[i],
                      style: const TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w600,
                        color: AppColors.surface,
                        height: 1.0,
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

// ── Notch painter ──────────────────────────────────────────────────────────────

/// Draws the nav-bar background with a smooth U-shaped notch cut out of the
/// top edge, centred at [notchCX] with radius [notchR].
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

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(cx - r - shoulder, 0)
      // ── Left shoulder: cubic curve smoothly diving into the notch ──────
      ..cubicTo(cx - r, 0, cx - r, r, cx, r)
      // ── Right shoulder: cubic curve climbing back out ───────────────────
      ..cubicTo(cx + r, r, cx + r, 0, cx + r + shoulder, 0)
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
