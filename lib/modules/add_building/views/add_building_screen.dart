import 'package:flutter/material.dart';

import 'add_unit_details.dart';

class AddBuildingScreen extends StatefulWidget {
  const AddBuildingScreen({super.key});

  @override
  State<StatefulWidget> createState() => _AddBuildingScreen();
}

class _AddBuildingScreen extends State<AddBuildingScreen> {
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

  void _onSubmit() {
    if (floorController.text.isEmpty ||
        unitController.text.isEmpty ||
        holdingNoController.text.isEmpty||
        addressController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("সব তথ্য পূরণ করুন")));
      return;
    }

    setState(() {
      buildingList.add({
        "floor": floorController.text,
        "unit": unitController.text,
        "holding_no": holdingNoController.text,
        "address": addressController.text,
        "charge": chargeController.text,
        "lift": isCheckedLift,
        "garage": isCheckedGarage,
        "guard": isCheckedGuard,
      });

      // clear fields after submit
      floorController.clear();
      unitController.clear();
      holdingNoController.clear();
      addressController.clear();
      chargeController.clear();
      isCheckedLift = false;
      isCheckedGarage = false;
      isCheckedGuard = false;

      if (buildingList.isNotEmpty) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddUnitDetails(
              buildingData: buildingList.last, // send last submitted
            ),
          ),
        );
      }
    });

    // hide keyboard after submit
    FocusScope.of(context).unfocus();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text(
          "বাসা যোগ করুন",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.green,
        shadowColor: Colors.lightGreen,
      ),
      body: Padding(
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
                  hintText:
                  "বাসা নং",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ), const SizedBox(height: 8),
              TextField(
                controller: addressController,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  hintText:
                  "ঠিকানা (রোড নং,ব্লক নং,থানা,জেলা,বিভাগ*)",
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
                padding: const EdgeInsets.symmetric(
                    vertical: 12, horizontal: 16),
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

      ),
    );
  }
}
