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
  Map<String, List<Map<String, dynamic>>> groupedUnits = {};

  Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();
    final spService = SharedPreferencesService(prefs);

    final data = spService.getUnitBuildingList();
    setState(() {
      buildingUnitList = data;
      groupedUnits = _groupByHoldingNo(data);
    });
  }

  /// Groups list by holding_no
  Map<String, List<Map<String, dynamic>>> _groupByHoldingNo(List<Map<String, dynamic>> units) {
    final Map<String, List<Map<String, dynamic>>> grouped = {};
    for (var unit in units) {
      final holding = unit['holding_no'] ?? 'Unknown';
      if (grouped.containsKey(holding)) {
        grouped[holding]!.add(unit);
      } else {
        grouped[holding] = [unit];
      }
    }
    return grouped;
  }

  @override
  void initState() {
    super.initState();
    loadData();
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
        automaticallyImplyLeading: false,
      ),
      body: _buildGroupedListView(),
    );
  }

  Widget _buildGroupedListView() {
    if (groupedUnits.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Text("কোনো ইউনিট যুক্ত করা হয়নি"),
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.all(10),
      children: groupedUnits.entries.map((entry) {
        final holdingNo = entry.key;
        final units = entry.value;

        return Card(
          margin: const EdgeInsets.only(bottom: 10),
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: ExpansionTile(
            title: Text(
              "হোল্ডিং নং: $holdingNo",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            children: units.map((unit) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "ইউনিট: ${unit['floor']}-${unit['unit']}",
                      style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
                    ),
                    const SizedBox(height: 6),
                    Text("👤 ${unit['name'] ?? 'N/A'}",
                        style: const TextStyle(fontWeight: FontWeight.w500)),
                    const SizedBox(height: 2),
                    Text("📞 ${unit['phone'] ?? 'N/A'}"),
                    const SizedBox(height: 2),
                    Text("💵 ভাড়া: ${unit['rent'] ?? 'N/A'}"),
                    const SizedBox(height: 2),
                    Text("🔥 গ্যাস: ${unit['gas_bill'] ?? 'N/A'}"),
                    const SizedBox(height: 2),
                    Text("💧 পানি: ${unit['water_bill'] ?? 'N/A'}"),
                    const SizedBox(height: 2),
                    Text("⚡ বিদ্যুৎ: ${unit['current_bill'] ?? 'N/A'}"),
                    const SizedBox(height: 2),
                    Text("💼 সার্ভিস: ${unit['charge'] ?? 'N/A'}"),
                    const SizedBox(height: 2),
                    Text("🚗 গ্যারেজ: ${unit['garage_charge'] ?? 'N/A'}"),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HouseRentDetails(
                                index: buildingUnitList.indexOf(unit),
                              ),
                            ),
                          );
                        },
                        child: const Text(
                          "বিস্তারিত →",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.green,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.green,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        );
      }).toList(),
    );
  }
}
