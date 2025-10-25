import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../service/shared_preferences_service.dart';

class CollectHouseRent extends StatefulWidget {
  final String buildingData;

  const CollectHouseRent({super.key, required this.buildingData});

  @override
  State<StatefulWidget> createState() => _CollectHouseRent();
}

class _CollectHouseRent extends State<CollectHouseRent> {

  final TextEditingController collectRentController = TextEditingController();
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
        title: Text(widget.buildingData.replaceAll("\n", " ")),
        backgroundColor: Colors.green,
        elevation: 0,
      ),
        body: _buildListView(crossAxisCount)
    );
  }

  Widget _buildListView(int crossAxisCount) {
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
                    Row(
                      children: [
                        Expanded(child:  Text(
                          "ইউনিট: ${unit['floor']}-${unit['unit']}",
                          style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
                        ),),
                        Expanded(child:  _infoTitleLine("","January"),
                        )
                      ],
                    ),
                    SizedBox(height: 8),
                    Text("👤 ${unit['name'] ?? 'N/A'}",
                        style: const TextStyle(fontWeight: FontWeight.w500)),
                    const SizedBox(height: 2),
                    _infoLine("📞", unit['phone'] ?? "N/A"),
                    SizedBox(height: 2,),
                    _infoLine("👤", unit['name'] ?? "N/A"),
                    SizedBox(height: 2,),
                    _infoLine("💵 ভাড়া:", unit['rent'] ?? "N/A"),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerRight,
                      child: SizedBox(
                        width:100,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          onPressed: () => _openEditDialog(buildingUnitList.indexOf(unit)),
                          child: const Text(
                            "সংগৃহীত",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            }).toList(),
          ),
        );
      }).toList(),
    );
  }

  Widget _infoLine(String icon, String value) {
    return Text(
      "$icon $value",
      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _infoTitleLine(String icon, String value) {
    return Text(
      "$icon $value",
      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800,color: Colors.lightGreen),
      textAlign: TextAlign.end,
      overflow: TextOverflow.ellipsis,
    );
  }

  void _openEditDialog(int index) {
    final data = buildingUnitList[index];
    // Pre-fill controllers
    // floorDialogController.text = data["floor"];
    // unitDialogController.text = data["unit"];
    // phoneNumberDialogController.text = data["phone"];
    // renterNameDialogController.text = data["name"];
    // houseRentDialogController.text = data["rent"];
    // chargeDialogController.text = data["charge"];
    // gasBillDialogController.text = data["gas_bill"];
    // currentBillDialogController.text = data["current_bill"];
    // waterBillDialogController.text = data["water_bill"];
    // garageDialogController.text = data["garage_charge"];

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return Dialog(
              insetPadding: const EdgeInsets.symmetric(horizontal: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: const BorderSide(color: Colors.green, width: 2),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                       "ইউনিট: ${data["floor"]}-${data["unit"]}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        "January: 15000BDT",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.lightGreen
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Total: 15000BDT",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Due: 15000BDT",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.red
                        ),
                      ),
                      const SizedBox(height: 15),
                      _buildPhoneTextField(
                        collectRentController,
                        "সংগৃহীত ভাড়া",
                        TextInputType.number,
                      ),

                      const SizedBox(height: 16),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text("বাতিল"),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: () =>{},
                            child: const Text("জমা দিন"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildPhoneTextField(
      TextEditingController controller,
      String hint,
      TextInputType type,
      ) {
    return TextField(
      controller: controller,
      keyboardType: type,
      decoration: InputDecoration(
        labelText:hint ,
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
      ),
    );
  }
}
