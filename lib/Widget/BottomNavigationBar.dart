import 'package:careerguidance_app/Screens/CareerMatchesScreen.dart';
import 'package:careerguidance_app/Screens/ProfileScreen.dart';
import 'package:careerguidance_app/Screens/RoadmapScreen.dart';
import 'package:flutter/material.dart';
import 'package:careerguidance_app/utils/AppColors.dart';

import '../Screens/HomeScreen.dart';
import '../Screens/QuizScreen.dart' hide RoadmapScreen;

class AppBottomNavigationBar extends StatelessWidget {
  final int currentIndex;

  const AppBottomNavigationBar({super.key, required this.currentIndex});

  static const List<_NavItem> _items = [
    _NavItem(icon: Icons.home_rounded, label: 'Home'),
    _NavItem(icon: Icons.track_changes_rounded, label: 'Quiz'),
    _NavItem(icon: Icons.grid_view_rounded, label: 'Matches'),
    _NavItem(icon: Icons.show_chart_rounded, label: 'Roadmap'),
    _NavItem(icon: Icons.person_outline_rounded, label: 'Profile'),
  ];

  void _navigateTo(BuildContext context, int index) {
    // Don't navigate if user taps the screen they are already on.
    if (index == currentIndex) return;

    Widget screen;

    switch (index) {
      case 0:
        screen = const HomeScreen();
        break;

      case 1:
        screen = const QuizScreen();
        break;

      case 2:
        screen = const MatchesScreen();
        break;

      case 3:
        screen = const RoadmapScreen();
        break;

      case 4:
        screen = const ProfileScreen();
        break;

      default:
        screen = const HomeScreen();
    }

    // NOTE: using push (not pushReplacement) so each tab screen stacks
    // on top of the previous one — this keeps navigation history intact
    // so the back arrow on each screen has something to return to.
    //
    // Tradeoff: switching tabs repeatedly will keep growing the stack
    // with duplicate screens underneath. If that becomes a problem
    // later (e.g. many back-presses needed to exit, memory growth),
    // consider IndexedStack-based tab navigation instead, which swaps
    // visible tabs without pushing new routes at all.
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => screen,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOut,
            ),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 250),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      decoration: BoxDecoration(
        color: AppColors.background,
        border: Border(
          top: BorderSide(color: AppColors.mutedText.withOpacity(0.15)),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(_items.length, (index) {
            final item = _items[index];
            final bool isActive = index == currentIndex;

            final Color color = isActive
                ? AppColors.accentYellow
                : AppColors.mutedText;

            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => _navigateTo(context, index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AnimatedScale(
                      scale: isActive ? 1.08 : 1.0,
                      duration: const Duration(milliseconds: 200),
                      child: Icon(item.icon, color: color, size: 24),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      item.label,
                      style: TextStyle(
                        color: color,
                        fontSize: 12,
                        fontWeight: isActive
                            ? FontWeight.w600
                            : FontWeight.w400,
                      ),
                    ),

                    const SizedBox(height: 4),

                    AnimatedOpacity(
                      opacity: isActive ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 200),
                      child: Container(
                        width: 4,
                        height: 4,
                        decoration: const BoxDecoration(
                          color: AppColors.accentYellow,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final String label;

  const _NavItem({required this.icon, required this.label});
}
