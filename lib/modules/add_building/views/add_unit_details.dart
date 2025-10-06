
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../service/shared_preferences_service.dart';

class AddUnitDetails extends StatefulWidget {
  final Map<String, dynamic> buildingData;

  const AddUnitDetails({super.key, required this.buildingData});

  @override
  State<StatefulWidget> createState() => _AddUnitDetails();
}
class _AddUnitDetails extends State<AddUnitDetails> {

  final TextEditingController floorController = TextEditingController();
  final TextEditingController unitController = TextEditingController();
  final TextEditingController holdingNoController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController chargeController = TextEditingController();

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
    };

    setState(() {
      // buildingList.add(newData);

      // Reset form
      floorController.clear();
      unitController.clear();
      holdingNoController.clear();
      addressController.clear();
      chargeController.clear();
    });

    // Save to SharedPreferences (MUST be outside setState)
    final sharedPreferences = await SharedPreferences.getInstance();
    await SharedPreferencesService(
      sharedPreferences,
    ).addBuildingDetails(newData);

    // Navigate
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddUnitDetails(buildingData: newData),
      ),
    );

    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("ইউনিত যুক্ত করুন"),
        backgroundColor: Colors.green,
        shadowColor: Colors.lightGreen,
      ),
      body:_buildFormView()
    );
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
              "বিদ্রঃ আপনার বিল্ডিং এর প্রতিটি ইউনিট এর ভাড়াটিয়ার এবং দা তথ্য দিয়ে সহায়তা করুন ।",
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

  Widget _unitList() {
    final data = widget.buildingData;
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("🏢 বিল্ডিং এর তথ্য",
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                      )),
                  const SizedBox(height: 8),
                  Text("তলা: ${data['floor']}"),
                  Text("ইউনিট: ${data['unit']}"),
                  Text("বাসা-নং: ${data['holding_no']}"),
                  Text("ঠিকানা: ${data['address']}"),
                  Text("সার্ভিস চার্জ: ${data["charge"].isEmpty ? "নেই" : data["charge"]}"),
                  Text("লিফ্ট আছে: ${data['lift'] ? 'হ্যাঁ' : 'না'}"),
                  Text("গ্যারেজ আছে: ${data['garage'] ? 'হ্যাঁ' : 'না'}"),
                  Text("দারোয়ান আছে: ${data['guard'] ? 'হ্যাঁ' : 'না'}"),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          // later you can add unit detail form here
        ],
      ),
    );
  }


}




