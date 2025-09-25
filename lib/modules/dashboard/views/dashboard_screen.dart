import 'package:flutter/material.dart';

import '../../add_building/views/add_building_screen.dart';
import '../../home/views/home_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  double profileCompletion = 0.25; // Profile progress (25%)
  int _selectedIndex = 0; // Track current page index

  // Screens for bottom nav
  final List<Widget> _pages = [
    const HomeScreen(),
    const AddBuildingScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        // keeps state of all pages
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "হোমপেজ",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_outlined),
            label: "বাসা যোগ করুন",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "ভাড়া অনুসন্ধান",
          ),
        ],
      ),
    );
  }
}
