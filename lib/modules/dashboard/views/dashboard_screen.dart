import 'package:flutter/material.dart';

import '../../add_building/views/add_building_screen.dart';
import '../../history/house_rent_unit.dart';
import '../../home/views/home_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final GlobalKey<HouseRentUnitState> houseRentKey = GlobalKey<HouseRentUnitState>();

  int _selectedIndex = 0;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      const HomeScreen(),
      HouseRentUnit(key: houseRentKey), // key passed here
      const AddBuildingScreen(),
      const Placeholder(), // Search page
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 1) {
      houseRentKey.currentState?.loadData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
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
            icon: Icon(Icons.history_outlined),
            label: "বাড়ি ভাড়ার ইতিহাস",
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
