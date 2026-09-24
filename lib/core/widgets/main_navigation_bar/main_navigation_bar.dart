import 'package:flutter/material.dart';
import 'package:tatbiqa/core/style/app_color.dart';
import 'package:tatbiqa/core/widgets/main_navigation_bar/custom_bottom_nav_bar.dart';
import 'package:tatbiqa/feature/rooms/presentation/screens/rooms_screen.dart';

class MainNavigationScreen extends StatelessWidget {
  const MainNavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MainNavigationScreenView();
  }
}

class MainNavigationScreenView extends StatefulWidget {
  const MainNavigationScreenView({super.key});

  @override
  State<MainNavigationScreenView> createState() =>
      _MainNavigationScreenViewState();
}

class _MainNavigationScreenViewState extends State<MainNavigationScreenView> {
  int _currentIndex = 2;

  final List<Widget> _screens = [
    const Placeholder(),
    const Placeholder(),
    const RoomsScreen(),
    const Placeholder(),
    const Placeholder(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.blackColor,
      extendBody: true,
      body: _screens[_currentIndex],
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

