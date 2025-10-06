
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

  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController renterNameController = TextEditingController();
  final TextEditingController houseRentController = TextEditingController();
  final TextEditingController chargeController = TextEditingController();
  final TextEditingController gasBillController = TextEditingController();
  final TextEditingController waterBillController = TextEditingController();
  final TextEditingController garageController = TextEditingController();
  final TextEditingController currentBillController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final data=widget.buildingData;
    if(!data["charge"].isEmpty){
      chargeController.text=data["charge"];
    }
  }

  void _onSubmit() async {

    if (phoneNumberController.text.isEmpty ||
        renterNameController.text.isEmpty ||
        houseRentController.text.isEmpty ||
        gasBillController.text.isEmpty ||
        waterBillController.text.isEmpty ||
        currentBillController.text.isEmpty){
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("সব তথ্য পূরণ করুন")));
      return;
    }

    // Add data locally
    final newData = {
      "phone": phoneNumberController.text,
      "name": renterNameController.text,
      "rent": houseRentController.text,
      "charge": chargeController.text,
      "gas_bill": chargeController.text,
      "current_bill": chargeController.text,
      "water_bill": chargeController.text,
      "garage_charge": chargeController.text,

    };

    setState(() {
      // buildingList.add(newData);


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
        title: const Text("ইউনিট যুক্ত করুন"),
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
            TextField(
              controller: phoneNumberController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "ভাড়াটিয়ার ফোন নাম্বার*",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: renterNameController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "ভাড়াটিয়ার নাম*",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: houseRentController,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                hintText: "বাসা ভাড়া*",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: gasBillController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "গ্যাস বিল",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8,),
                Expanded(
                  child: TextField(
                    controller: waterBillController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "পানি বিল",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                ),

                SizedBox(width: 8,),
                Expanded(
                  child: TextField(
                    controller: currentBillController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "বিদ্যুৎ বিল",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                ),

              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: chargeController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "সার্ভিস চার্জ (যদি থাকে)",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8,),
                Expanded(
                  child: TextField(
                    controller: garageController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "গ্যারেজ চার্জ (যদি থাকে)",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                ),

              ],
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
          _unitList()
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




