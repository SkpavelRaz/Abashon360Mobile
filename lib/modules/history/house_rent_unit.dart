import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../service/shared_preferences_service.dart';

class HouseRentUnit extends StatefulWidget {
  const HouseRentUnit({super.key});

  @override
  State<StatefulWidget> createState() => _HouseRentUnit();
}

class _HouseRentUnit extends State<HouseRentUnit> {
  // store submitted data as list
  List<Map<String, dynamic>> buildingUnitList = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadData(); // Reloads every time when page becomes active again
  }

  void loadData() async {
    final prefs = await SharedPreferences.getInstance();
    final spService = SharedPreferencesService(prefs);

    List<Map<String, dynamic>> data = spService.getUnitBuildingList();
    print('Unit Data: $data');

    setState(() {
      buildingUnitList = data;
    });
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
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Center(child: Text("কোনো ইউনিট যুক্ত করা হয়নি")),
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
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 6),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _infoLine("📞", unit['phone']??"N/A"),
                        _infoLine("👤", unit['name']??"N/A"),
                        _infoLine("💵 ভাড়া:", unit['rent']??"N/A"),
                        _infoLine("🔥 গ্যাস:", unit['gas_bill']??"N/A"),
                        _infoLine("💧 পানি:", unit['water_bill']??"N/A"),
                        _infoLine("⚡ বিদ্যুৎ:", unit['current_bill']??"N/A"),
                        _infoLine("💼 সার্ভিস:", unit['charge']??"N/A"),
                        _infoLine("🚗 গ্যারেজ:", unit['garage_charge']??"N/A"),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Stack(
                    children: [
                      Text(
                        "বিস্তারিত ->",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: Colors.green,
                        ),
                      ),
                      Positioned(
                        bottom: -1, // gap below text
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 2,        // underline thickness
                          color: Colors.green, // underline color
                        ),
                      ),
                    ],
                  ),
                )

                // Row(
                //   mainAxisAlignment: MainAxisAlignment.end,
                //   children: [
                //     Text(
                //       "বিস্তারিত ->",
                //       style: TextStyle(fontSize: 20,fontWeight: FontWeight.w800,color: Colors.green,decoration:TextDecoration.underline,decorationColor: Colors.green,      // underline color
                //         decorationThickness: 2.5),
                //       textAlign: TextAlign.end,
                //     ),
                //   ],
                // )
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
