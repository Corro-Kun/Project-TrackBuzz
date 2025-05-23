import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class NavigationBarCustom extends StatefulWidget {
  const NavigationBarCustom({super.key, required this.pageController});
  final PageController pageController;

  @override
  State<NavigationBarCustom> createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBarCustom> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8),
        child: GNav(
          selectedIndex: 1,
          color: Theme.of(context).colorScheme.secondary,
          activeColor: Theme.of(context).colorScheme.primary,
          tabActiveBorder: Border(
            top: BorderSide(color: Theme.of(context).colorScheme.primary),
            bottom: BorderSide(color: Theme.of(context).colorScheme.primary),
            right: BorderSide(color: Theme.of(context).colorScheme.primary),
            left: BorderSide(color: Theme.of(context).colorScheme.primary),
          ),
          padding: const EdgeInsets.all(16),
          tabs: const [
            GButton(icon: Icons.timer, text: 'Reloj'),
            GButton(icon: Icons.home, text: 'Proyectos'),
            GButton(icon: Icons.timeline, text: 'Reportes'),
          ],
          onTabChange: (index) {
            widget.pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.ease,
            );
          },
        ),
      ),
    );
  }
}
