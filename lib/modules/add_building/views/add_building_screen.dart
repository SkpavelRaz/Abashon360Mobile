import 'package:abashon_360_mobile/service/shared_preferences_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'add_unit_details.dart';

class AddBuildingScreen extends StatefulWidget {
  const AddBuildingScreen({super.key});

  @override
  State<AddBuildingScreen> createState() => AddBuildingScreenState();
}

class AddBuildingScreenState extends State<AddBuildingScreen> {
  SharedPreferencesService? service;
  bool _hasData = false;

  final TextEditingController floorController = TextEditingController();
  final TextEditingController unitController = TextEditingController();
  final TextEditingController holdingNoController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController chargeController = TextEditingController();

  bool isCheckedLift = false;
  bool isCheckedGarage = false;
  bool isCheckedGuard = false;

  // store submitted data as list
  List<Map<String, dynamic>> buildingList = [];

  void _onSubmit() async {
    if (floorController.text.isEmpty ||
        unitController.text.isEmpty ||
        holdingNoController.text.isEmpty ||
        addressController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("সব তথ্য পূরণ করুন")));
      return;
    }

    // Add data locally
    final newData = {
      "floor": floorController.text,
      "unit": unitController.text,
      "holding_no": holdingNoController.text,
      "address": addressController.text,
      "charge": chargeController.text,
      "lift": isCheckedLift,
      "garage": isCheckedGarage,
      "guard": isCheckedGuard,
    };

    setState(() {
      buildingList.add(newData);

      floorController.clear();
      unitController.clear();
      holdingNoController.clear();
      addressController.clear();
      chargeController.clear();
      isCheckedLift = false;
      isCheckedGarage = false;
      isCheckedGuard = false;
    });

    final sharedPreferences = await SharedPreferences.getInstance();
    await SharedPreferencesService(
      sharedPreferences,
    ).addBuildingDetails(newData);

    // Navigate
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => AddUnitDetails(buildingData: newData),
    //   ),
    // );
    loadData();

    FocusScope.of(context).unfocus();
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    final prefs = await SharedPreferences.getInstance();
    final spService = SharedPreferencesService(prefs);

    List<Map<String, dynamic>> data = spService.getBuildingDetails();
    for (var item in data) {
      item["lift"] = item["lift"] ?? false;
      item["garage"] = item["garage"] ?? false;
      item["guard"] = item["guard"] ?? false;
    }

    setState(() {
      buildingList = data;
      _hasData = data.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "বাসা যোগ করুন",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.green,
        shadowColor: Colors.lightGreen,
        automaticallyImplyLeading: false,
      ),
      body: _hasData ? _buildBuildingListView() : _buildFormView(),
      floatingActionButton: _hasData
          ? FloatingActionButton.extended(
              onPressed: () {
                setState(() {
                  _hasData = false;
                });
              },
              label: const Text("যোগ করুন"),
              icon: const Icon(Icons.add_home_work_rounded, size: 32),
              backgroundColor: Colors.green,
            )
          : null,
    );
  }

  Widget _buildBuildingListView() {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: buildingList.length,
      itemBuilder: (context, index) {
        final data = buildingList[index];
        final features = <String>[];

        if (data["lift"]) features.add("লিফ্ট আছে");
        if (data["garage"]) features.add("গ্যারেজ আছে");
        if (data["guard"]) features.add("দারোয়ান আছে");

        return Card(
          margin: const EdgeInsets.symmetric(vertical: 6),
          child: ListTile(
            title: Text(
              "বাসা নং-: ${data["holding_no"]}",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "তলা: ${data["floor"] ?? "N/A"}, ইউনিট: ${data["unit"] ?? "N/A"}",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),
                Text(
                  "ঠিকানা: ${data["address"] ?? "N/A"}",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                ),
                Text(
                  "সার্ভিস চার্জ: ${data["charge"].isEmpty ? "নেই" : data["charge"]}",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),
                if (features.isNotEmpty)
                  Text(
                    "সুবিধা: ${features.join(", ")}",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _deleteItem(index),
                  iconSize: 44,
                ),

                IconButton(
                  icon: const Icon(
                    Icons.edit_note_rounded,
                    color: Colors.black,
                  ),
                  onPressed: () => _openEditDialog(index),
                  iconSize: 44,
                ),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context)=>
                      AddUnitDetails(buildingData: buildingList[index]),
                ),
              );
            },
          ),
        );
      },
    );
  }

  void _deleteItem(int index) async {
    setState(() {
      buildingList.removeAt(index);
    });
    // Save updated list
    final prefs = await SharedPreferences.getInstance();
    await SharedPreferencesService(prefs).saveAll(buildingList);

    // If all deleted => show form
    if (buildingList.isEmpty) {
      setState(() {
        _hasData = false;
      });
    }
  }

  Widget _buildFormView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            const Text(
              "বিদ্রঃ আপনার বিল্ডিং কতো তলা ও প্রত্যেকটি তলাতে কতগুলো ইউনিট তথ্য দিয়ে সহায়তা করুন ।",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w300,
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              "বিল্ডিং এর তথ্যঃ  ",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w400,
                decoration: TextDecoration.underline,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: floorController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "আপনার বিল্ডিংটি কতো তলা*",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: unitController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "আপনার বিল্ডিংটি কতগুলো ইউনিট*",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: holdingNoController,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                hintText: "বাসা নং*",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: addressController,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                hintText: "ঠিকানা (রোড নং,ব্লক নং,থানা,জেলা,বিভাগ)*",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: chargeController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "সার্ভিস চারজ (যদি থাকে)",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Checkbox(
                  value: isCheckedLift,
                  onChanged: (value) {
                    setState(() {
                      isCheckedLift = value!;
                    });
                  },
                  activeColor: Colors.green,
                ),
                const Text("লিফ্ট আছে।"),
              ],
            ),
            Row(
              children: [
                Checkbox(
                  value: isCheckedGarage,
                  onChanged: (value) {
                    setState(() {
                      isCheckedGarage = value!;
                    });
                  },
                  activeColor: Colors.green,
                ),
                const Text("গ্যারেজ আছে।"),
              ],
            ),
            Row(
              children: [
                Checkbox(
                  value: isCheckedGuard,
                  onChanged: (value) {
                    setState(() {
                      isCheckedGuard = value!;
                    });
                  },
                  activeColor: Colors.green,
                ),
                const Text("দারোয়ান আছে।"),
              ],
            ),
            Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: SizedBox(
                width: 200,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  onPressed: () {
                    _onSubmit();
                  },
                  child: const Text(
                    "জমা দিন",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openEditDialog(int index) {
    final data = buildingList[index];

    // Pre-fill controllers
    floorController.text = data["floor"];
    unitController.text = data["unit"];
    holdingNoController.text = data["holding_no"];
    addressController.text = data["address"];
    chargeController.text = data["charge"];
    isCheckedLift = data["lift"];
    isCheckedGarage = data["garage"];
    isCheckedGuard = data["guard"];

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
                      const Text(
                        "তথ্য সম্পাদনা করুন",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),

                      _buildTextField("তলা", floorController),
                      _buildTextField("ইউনিট", unitController),
                      _buildTextField("বাসা নং", holdingNoController),
                      _buildTextField("ঠিকানা", addressController),
                      _buildTextField("সার্ভিস চার্জ", chargeController),

                      const SizedBox(height: 16),

                      // ✅ Working Checkbox
                      CheckboxListTile(
                        title: const Text("লিফ্ট আছে"),
                        value: isCheckedLift,
                        onChanged: (val) {
                          setStateDialog(() {
                            // <-- use this, not main setState!
                            isCheckedLift = val!;
                          });
                        },
                      ),

                      CheckboxListTile(
                        title: const Text("গ্যারেজ আছে"),
                        value: isCheckedGarage,
                        onChanged: (val) {
                          setStateDialog(() {
                            isCheckedGarage = val!;
                          });
                        },
                      ),

                      CheckboxListTile(
                        title: const Text("দারোয়ান আছে"),
                        value: isCheckedGuard,
                        onChanged: (val) {
                          setStateDialog(() {
                            isCheckedGuard = val!;
                          });
                        },
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
                            onPressed: () => _saveEditedData(index),
                            child: const Text("সংরক্ষণ"),
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

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  void _saveEditedData(int index) async {
    final updatedData = {
      "floor": floorController.text,
      "unit": unitController.text,
      "holding_no": holdingNoController.text,
      "address": addressController.text,
      "charge": chargeController.text,
      "lift": isCheckedLift,
      "garage": isCheckedGarage,
      "guard": isCheckedGuard,
    };

    setState(() {
      buildingList[index] = updatedData;
    });

    final prefs = await SharedPreferences.getInstance();
    await SharedPreferencesService(prefs).updateAtIndex(index, updatedData);

    Navigator.pop(context); // Close dialog
  }
}
