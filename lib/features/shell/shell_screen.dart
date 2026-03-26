import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rentify/features/chat/screens/conversations_screen.dart';
import 'package:rentify/features/home/screens/home_screen.dart';
import 'package:rentify/features/profile/screens/profile_screen.dart';
import 'package:rentify/features/rental/screens/my_rentals_screen.dart';
import 'package:rentify/features/search/screens/search_screen.dart';
import 'package:rentify/theme/app_colors.dart';

// ---------------------------------------------------------------------------
// Nav item model
// ---------------------------------------------------------------------------
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

const _navItems = [
  _NavItem(
    icon: Icons.home_outlined,
    activeIcon: Icons.home_rounded,
    label: 'Home',
  ),
  _NavItem(
    icon: Icons.grid_view_outlined,
    activeIcon: Icons.grid_view_rounded,
    label: 'Browse',
  ),
  _NavItem(
    icon: Icons.chat_bubble_outline_rounded,
    activeIcon: Icons.chat_bubble_rounded,
    label: 'Chat',
  ),
  _NavItem(
    icon: Icons.person_outline_rounded,
    activeIcon: Icons.person_rounded,
    label: 'Profile',
  ),
];

// Screen index mapping:
//   0 → Home    (bar slot 0, left half)
//   1 → Browse  (bar slot 1, left half)
//   2 → MyRentals (FAB — no bar slot)
//   3 → Chat    (bar slot 2, right half)
//   4 → Profile (bar slot 3, right half)
const _screenToSlot = {0: 0, 1: 1, 3: 2, 4: 3};
const _slotToScreen = {0: 0, 1: 1, 2: 3, 3: 4};

// ---------------------------------------------------------------------------
// ShellScreen
// ---------------------------------------------------------------------------
class ShellScreen extends ConsumerStatefulWidget {
  const ShellScreen({super.key});

  @override
  ConsumerState<ShellScreen> createState() => _ShellScreenState();
}

class _ShellScreenState extends ConsumerState<ShellScreen>
    with TickerProviderStateMixin {
  int _selectedIndex = 0;

  // FAB controllers
  late final AnimationController _fabCtrl;
  late final Animation<double> _fabRotation;
  late final Animation<double> _fabScale;

  // Pill slide controller
  late final AnimationController _pillCtrl;
  late Animation<double> _pillValue; // 0.0–3.0, fractional between slots

  // Per-icon bounce controllers (4 real bar tabs)
  late final List<AnimationController> _iconCtrl;
  late final List<Animation<double>> _iconScale;

  static const _screens = [
    HomeScreen(),
    SearchScreen(),
    MyRentalsScreen(),
    ConversationsScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();

    // FAB
    _fabCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _fabRotation = Tween<double>(
      begin: 0.0,
      end: 0.125,
    ).animate(CurvedAnimation(parent: _fabCtrl, curve: Curves.elasticOut));
    _fabScale = Tween<double>(
      begin: 1.0,
      end: 1.18,
    ).animate(CurvedAnimation(parent: _fabCtrl, curve: Curves.easeOutBack));

    // Pill
    _pillCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 380),
    );
    _pillValue = Tween<double>(
      begin: 0.0,
      end: 0.0,
    ).animate(CurvedAnimation(parent: _pillCtrl, curve: Curves.easeInOutCubic));

    // Icon bounces
    _iconCtrl = List.generate(
      4,
      (_) => AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300),
      ),
    );
    _iconScale = _iconCtrl.map((c) {
      return Tween<double>(
        begin: 1.0,
        end: 1.28,
      ).animate(CurvedAnimation(parent: c, curve: Curves.elasticOut));
    }).toList();

    // Initial bounce on Home icon
    _iconCtrl[0].forward().then((_) => _iconCtrl[0].reverse());
  }

  @override
  void dispose() {
    _fabCtrl.dispose();
    _pillCtrl.dispose();
    for (final c in _iconCtrl) {
      c.dispose();
    }
    super.dispose();
  }

  // ── Select a bar tab ──────────────────────────────────────────────────────
  void _selectTab(int screenIndex) {
    if (screenIndex == _selectedIndex) return;

    final fromSlot = _screenToSlot[_selectedIndex];
    final toSlot = _screenToSlot[screenIndex];

    setState(() => _selectedIndex = screenIndex);

    // Slide pill
    if (fromSlot != null && toSlot != null) {
      final currentVal = _pillValue.value.clamp(0.0, 3.0);
      _pillValue = Tween<double>(begin: currentVal, end: toSlot.toDouble())
          .animate(
            CurvedAnimation(parent: _pillCtrl, curve: Curves.easeInOutCubic),
          );
      _pillCtrl.forward(from: 0.0);
    }

    // Bounce icon
    if (toSlot != null) {
      _iconCtrl[toSlot]
          .forward(from: 0.0)
          .then((_) => _iconCtrl[toSlot].reverse());
    }

    // Reverse FAB if leaving Rentals
    if (screenIndex != 2 && _fabCtrl.value > 0) {
      _fabCtrl.reverse();
    }
  }

  // ── FAB tap → toggle My Rentals ───────────────────────────────────────────
  void _onFabTap() {
    if (_selectedIndex == 2) {
      _fabCtrl.reverse();
      _selectTab(0);
    } else {
      _fabCtrl.forward();
      setState(() => _selectedIndex = 2);
    }
  }

  // ── Build ─────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: IndexedStack(index: _selectedIndex, children: _screens),
      floatingActionButton: _buildFab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  // ── FAB ───────────────────────────────────────────────────────────────────
  Widget _buildFab() {
    return AnimatedBuilder(
      animation: _fabCtrl,
      builder: (_, __) => Transform.scale(
        scale: _fabScale.value,
        child: GestureDetector(
          onTap: _onFabTap,
          child: Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [Color(0xFF25A85A), Color(0xFF145E2B)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.45),
                  blurRadius: 18,
                  offset: const Offset(0, 7),
                ),
              ],
            ),
            child: Transform.rotate(
              angle: _fabRotation.value * 2 * 3.14159265,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                transitionBuilder: (child, anim) =>
                    ScaleTransition(scale: anim, child: child),
                child: Icon(
                  _selectedIndex == 2 ? Icons.close_rounded : Icons.add_rounded,
                  key: ValueKey(_selectedIndex == 2),
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ── Bottom bar ────────────────────────────────────────────────────────────
  Widget _buildBottomBar() {
    return BottomAppBar(
      color: Colors.white,
      elevation: 0,
      shadowColor: Colors.black.withOpacity(0.06),
      shape: const CircularNotchedRectangle(),
      notchMargin: 10,
      child: SizedBox(
        height: 64,
        child: AnimatedBuilder(
          animation: _pillCtrl,
          builder: (_, __) {
            return LayoutBuilder(
              builder: (context, constraints) {
                final totalWidth = constraints.maxWidth;

                // Bar layout:
                //  [slot0][slot1] [76px notch] [slot2][slot3]
                const notchWidth = 76.0;
                final halfBarWidth = (totalWidth - notchWidth) / 2;
                final slotWidth = halfBarWidth / 2;

                // Pixel center-X of each slot
                double slotCenterX(int slot) {
                  if (slot < 2) {
                    return slot * slotWidth + slotWidth / 2;
                  } else {
                    return halfBarWidth +
                        notchWidth +
                        (slot - 2) * slotWidth +
                        slotWidth / 2;
                  }
                }

                // Interpolate pill center from fractional _pillValue
                final pv = _pillValue.value.clamp(0.0, 3.0);
                final lo = pv.floor().clamp(0, 3);
                final hi = pv.ceil().clamp(0, 3);
                final t = pv - lo;
                final pillCX =
                    slotCenterX(lo) + t * (slotCenterX(hi) - slotCenterX(lo));

                const pillW = 58.0;
                const pillH = 38.0;
                final showPill = _selectedIndex != 2;

                return Stack(
                  children: [
                    // ── Sliding pill ──
                    AnimatedOpacity(
                      opacity: showPill ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 200),
                      child: Positioned(
                        left: pillCX - pillW / 2,
                        top: (64 - pillH) / 2,
                        child: Container(
                          width: pillW,
                          height: pillH,
                          decoration: BoxDecoration(
                            color: AppColors.primaryLight,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),

                    // ── Icons row ──
                    Row(
                      children: [
                        SizedBox(
                          width: halfBarWidth,
                          child: Row(
                            children: [
                              _buildSlot(slot: 0),
                              _buildSlot(slot: 1),
                            ],
                          ),
                        ),
                        SizedBox(width: notchWidth),
                        SizedBox(
                          width: halfBarWidth,
                          child: Row(
                            children: [
                              _buildSlot(slot: 2),
                              _buildSlot(slot: 3),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }

  // ── Single nav slot ───────────────────────────────────────────────────────
  Widget _buildSlot({required int slot}) {
    final screenIndex = _slotToScreen[slot]!;
    final item = _navItems[slot];
    final isSelected = _selectedIndex == screenIndex;

    return Expanded(
      child: GestureDetector(
        onTap: () => _selectTab(screenIndex),
        behavior: HitTestBehavior.opaque,
        child: AnimatedBuilder(
          animation: _iconCtrl[slot],
          builder: (_, __) => Transform.scale(
            scale: isSelected ? _iconScale[slot].value : 1.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 180),
                  transitionBuilder: (child, anim) =>
                      ScaleTransition(scale: anim, child: child),
                  child: Icon(
                    isSelected ? item.activeIcon : item.icon,
                    key: ValueKey(isSelected),
                    size: 22,
                    color: isSelected
                        ? AppColors.primary
                        : AppColors.navInactive,
                  ),
                ),
                const SizedBox(height: 3),
                AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 180),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                    color: isSelected
                        ? AppColors.primary
                        : AppColors.navInactive,
                  ),
                  child: Text(item.label),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:rentify/theme/app_colors.dart';
// import 'package:rentify/theme/app_text_styles.dart';
//
// class AppShell extends StatefulWidget {
//   final StatefulNavigationShell? navigationShell;
//
//   const AppShell({super.key, this.navigationShell});
//
//   @override
//   State<AppShell> createState() => _AppShellState();
// }
//
// class _AppShellState extends State<AppShell> {
//   int _currentIndex = 0;
//
//   final List<Widget> _pages = [
//     const _PlaceholderPage(title: 'Home', icon: Icons.home),
//     const _PlaceholderPage(title: 'Discover', icon: Icons.explore),
//     const _PlaceholderPage(title: 'My Rentals', icon: Icons.history),
//     const _PlaceholderPage(title: 'Chat', icon: Icons.chat),
//     const _PlaceholderPage(title: 'Profile', icon: Icons.person),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: IndexedStack(index: _currentIndex, children: _pages),
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _currentIndex,
//         onTap: (index) {
//           setState(() {
//             _currentIndex = index;
//           });
//         },
//         backgroundColor: AppColors.surface,
//         selectedItemColor: AppColors.navActive,
//         unselectedItemColor: AppColors.navInactive,
//         type: BottomNavigationBarType.fixed,
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home_outlined),
//             activeIcon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.explore_outlined),
//             activeIcon: Icon(Icons.explore),
//             label: 'Discover',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.history_outlined),
//             activeIcon: Icon(Icons.history),
//             label: 'My Rentals',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.chat_outlined),
//             activeIcon: Icon(Icons.chat),
//             label: 'Chat',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person_outline),
//             activeIcon: Icon(Icons.person),
//             label: 'Profile',
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class _PlaceholderPage extends StatelessWidget {
//   final String title;
//   final IconData icon;
//
//   const _PlaceholderPage({required this.title, required this.icon});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.background,
//       appBar: AppBar(
//         title: Text(
//           title,
//           style: AppTextStyles.appTitle.copyWith(color: AppColors.textPrimary),
//         ),
//         backgroundColor: AppColors.surface,
//         elevation: 0,
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(icon, size: 64, color: AppColors.primary),
//             const SizedBox(height: 16),
//             Text(title, style: AppTextStyles.sectionTitle),
//             const SizedBox(height: 8),
//             Text(
//               'Placeholder for $title',
//               style: AppTextStyles.tagline.copyWith(
//                 color: AppColors.textSecondary,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
