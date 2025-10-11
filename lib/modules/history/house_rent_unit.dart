import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../service/shared_preferences_service.dart';

class HouseRentUnit extends StatefulWidget {
  const HouseRentUnit({super.key});

  @override
  State<StatefulWidget> createState()=> _HouseRentUnit();
}

class _HouseRentUnit extends State<HouseRentUnit>{

  void loadData() async {
    final prefs = await SharedPreferences.getInstance();
    final spService = SharedPreferencesService(prefs);

    List<Map<String, dynamic>> data = spService.getUnitBuildingList();

    setState(() {
      var buildingList = data;
      var _hasData = data.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "বাড়ি ভাড়ার ইতিহাস",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.green,
        shadowColor: Colors.lightGreen,
        automaticallyImplyLeading: false
      ),
      body: _buildListView(),
    );
  }

  Widget _buildListView(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),


    );
  }

}