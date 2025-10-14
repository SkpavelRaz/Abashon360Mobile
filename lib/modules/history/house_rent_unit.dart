import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../service/shared_preferences_service.dart';
import 'house_rent_details.dart';

class HouseRentUnit extends StatefulWidget {
  const HouseRentUnit({super.key});

  @override
  State<HouseRentUnit> createState() => HouseRentUnitState();
}

class HouseRentUnitState extends State<HouseRentUnit> {
  List<Map<String, dynamic>> buildingUnitList = [];

  Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();
    final spService = SharedPreferencesService(prefs);

    final data = spService.getUnitBuildingList();
    setState(() {
      buildingUnitList = data;
    });
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Responsive column count
    int crossAxisCount = 1;
    if (screenWidth > 800) {
      crossAxisCount = 4;
    } else if (screenWidth > 500) {
      crossAxisCount = 3;
    } else if (screenWidth > 300) {
      crossAxisCount = 2;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "বাড়ি ভাড়ার ইতিহাস",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.green,
        shadowColor: Colors.lightGreen,
        automaticallyImplyLeading: false,
      ),
      body: _buildListView(crossAxisCount),
    );
  }

  Widget _buildListView(int crossAxisCount) {
    if (buildingUnitList.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Text("কোনো ইউনিট যুক্ত করা হয়নি"),
        ),
      );
    }

    return GridView.builder(
      itemCount: buildingUnitList.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 0.80,
      ),
      itemBuilder: (context, index) {
        final unit = buildingUnitList[index];
        return Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "ইউনিট: ${unit['floor']}${unit['unit']}",
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 6),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _infoLine("📞", unit['phone'] ?? "N/A"),
                        _infoLine("👤", unit['name'] ?? "N/A"),
                        _infoLine("💵 ভাড়া:", unit['rent'] ?? "N/A"),
                        _infoLine("🔥 গ্যাস:", unit['gas_bill'] ?? "N/A"),
                        _infoLine("💧 পানি:", unit['water_bill'] ?? "N/A"),
                        _infoLine("⚡ বিদ্যুৎ:", unit['current_bill'] ?? "N/A"),
                        _infoLine("💼 সার্ভিস:", unit['charge'] ?? "N/A"),
                        _infoLine("🚗 গ্যারেজ:", unit['garage_charge'] ?? "N/A"),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Stack(
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Example: pass index = 3
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HouseRentDetails(index: index),
                            ),
                          );
                        },
                        child: const Text(
                          "বিস্তারিত ->",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: Colors.green,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: -1,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 2,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _infoLine(String icon, String value) {
    return Text(
      "$icon $value",
      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
      overflow: TextOverflow.ellipsis,
    );
  }
}
