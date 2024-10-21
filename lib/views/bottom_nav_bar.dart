// lib/bottom_nav_bar.dart
import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatefulWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  const CustomBottomNavBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  _CustomBottomNavBarState createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  void _onItemTapped(int index) {
    widget.onItemTapped(index);
    _animationController.forward().then((_) => _animationController.reverse());
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: _buildIcon(Icons.home, 'Home', 0),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: _buildIcon(Icons.train, 'Trem', 1),
          label: 'Trem',
        ),
        BottomNavigationBarItem(
          icon: _buildIcon(Icons.directions_subway, 'Metrô', 2),
          label: 'Metrô',
        ),
        BottomNavigationBarItem(
          icon: _buildIcon(Icons.place, 'Turismo', 3),
          label: 'Turismo',
        ),
        BottomNavigationBarItem(
          icon: _buildIcon(Icons.settings, 'Configurações', 4),
          label: 'Configurações',
        ),
      ],
      currentIndex: widget.selectedIndex,
      onTap: _onItemTapped,
      backgroundColor: const Color(0xFF272A33),
      selectedItemColor: const Color(0xFFE7DDBF),
      unselectedItemColor: Colors.white,
      showSelectedLabels: true,
      showUnselectedLabels: true,
    );
  }

  Widget _buildIcon(IconData icon, String label, int index) {
    return ScaleTransition(
      scale: _animationController.drive(CurveTween(curve: Curves.easeInOut)),
      child: Icon(
        icon,
        color: widget.selectedIndex == index ? const Color(0xFFE7DDBF) : Colors.white,
      ),
    );
  }
}