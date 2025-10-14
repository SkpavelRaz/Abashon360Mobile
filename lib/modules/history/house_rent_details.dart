
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../service/shared_preferences_service.dart';

class HouseRentDetails extends StatefulWidget{
  final int index;
  const HouseRentDetails({super.key, required this.index});

  @override
  State<StatefulWidget> createState() => _HouseRentDetails();
}

class _HouseRentDetails extends State<HouseRentDetails>{
  List<Map<String, dynamic>> buildingUnitList = [];
  bool isEditMode = false;
  @override
  void initState() {
    super.initState();
    print("Targeted Index: ${widget.index}");
    loadData();
  }

  void loadData() async{
    final prefs = await SharedPreferences.getInstance();
    final spService = SharedPreferencesService(prefs);

    final data = spService.getUnitBuildingList();
    setState(() {
      buildingUnitList = data;

      if (widget.index < buildingUnitList.length) {
        var item = buildingUnitList[widget.index];
        floorController.text = item["floor"] ?? "";
        unitController.text = item["unit"] ?? "";
        phoneNumberController.text = item["phone"] ?? "";
        renterNameController.text = item["renterName"] ?? "";
        houseRentController.text = item["rent"] ?? "";
        gasBillController.text = item["gas"] ?? "";
        waterBillController.text = item["water"] ?? "";
        currentBillController.text = item["current"] ?? "";
        chargeController.text = item["charge"] ?? "";
        garageController.text = item["garage"] ?? "";
      }
    });

  }

  final TextEditingController floorController = TextEditingController();
  final TextEditingController unitController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController renterNameController = TextEditingController();
  final TextEditingController houseRentController = TextEditingController();
  final TextEditingController chargeController = TextEditingController();
  final TextEditingController gasBillController = TextEditingController();
  final TextEditingController waterBillController = TextEditingController();
  final TextEditingController garageController = TextEditingController();
  final TextEditingController currentBillController = TextEditingController();

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
        title: const Text("ভাড়ার বিস্তারিত"),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: Icon(isEditMode ? Icons.close : Icons.edit),
            onPressed: () {
              setState(() {
                isEditMode = !isEditMode;
              });
            },
          ),
        ],
      ),

      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth > 900;
            return SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 62),
              child: isWide
                  ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left side: form
                  Expanded(flex: 1, child: _buildForm()),
                  const SizedBox(width: 16),
                  _buildHistorySection(crossAxisCount),
                ],
              )
                  : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildForm(),
                  const SizedBox(height: 16),
                  _buildHistorySection(crossAxisCount),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // ================= FORM ===================
  Widget _buildForm() {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: _buildTextField(
                    floorController,
                    "ফ্লোর নং*",
                    TextInputType.number,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildUpperCaseTextField(
                    unitController,
                    "ইউনিট নং*",
                    TextInputType.number,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildPhoneTextField(
              phoneNumberController,
              "ভাড়াটিয়ার ফোন নাম্বার*",
              TextInputType.phone,
            ),
            const SizedBox(height: 12),
            _buildTextField(
              renterNameController,
              "ভাড়াটিয়ার নাম*",
              TextInputType.name,
            ),
            const SizedBox(height: 12),
            _buildTextField(
              houseRentController,
              "বাসা ভাড়া*",
              TextInputType.number,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildTextField(
                    gasBillController,
                    "গ্যাস বিল",
                    TextInputType.number,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildTextField(
                    waterBillController,
                    "পানি বিল",
                    TextInputType.number,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildTextField(
                    currentBillController,
                    "বিদ্যুৎ বিল",
                    TextInputType.number,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildTextField(
                    chargeController,
                    "সার্ভিস চার্জ (যদি থাকে)",
                    TextInputType.number,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildTextField(
                    garageController,
                    "গ্যারেজ চার্জ (যদি থাকে)",
                    TextInputType.number,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: isEditMode
                  ? ElevatedButton.icon(
                onPressed: _onUpdate,  // <-- new function
                icon: const Icon(Icons.update),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                label: const Text(
                  "আপডেট করুন",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              )
                  : const SizedBox.shrink(), // 👈 empty if not edit mode
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller,
      String hint,
      TextInputType type,
      ) {
    return TextField(
      controller: controller,
      readOnly: !isEditMode,
      keyboardType: type,
      decoration: InputDecoration(
        labelText:hint ,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
      ),
    );
  }

  Widget _buildUpperCaseTextField(
      TextEditingController controller,
      String hint,
      TextInputType type,
      ) {
    return TextField(
      controller: controller,
      keyboardType: type,
      readOnly: !isEditMode,
      inputFormatters: [UpperCaseTextFormatter()],
      decoration: InputDecoration(
        labelText:hint ,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
      ),
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
      readOnly: !isEditMode,
      maxLength: 11,
      decoration: InputDecoration(
        labelText:hint ,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
      ),
    );
  }

  // =========================list show================================
  Widget _buildHistorySection(int crossAxisCount) {
    // Dummy data
    final Map<String, Map<String, Map<String, dynamic>>> paymentHistory = {
      "2025": {
        "January": {"rent": 10000, "water": 500, "gas": 300, "current": 1200, "charge": 200, "garage": 300, "paid": 11000, "due": 500, "paymentDate": "2025-01-10"},
        "February": {"rent": 10000, "water": 500, "gas": 300, "current": 1300, "charge": 200, "garage": 300, "paid": 12000, "due": 600, "paymentDate": "2025-02-12"},
        "March": {"rent": 10000, "water": 500, "gas": 300, "current": 1250, "charge": 200, "garage": 300, "paid": 11000, "due": 550, "paymentDate": "2025-03-08"},
        "April": {"rent": 10000, "water": 500, "gas": 300, "current": 1200, "charge": 200, "garage": 300, "paid": 11000, "due": 500, "paymentDate": "2025-01-10"},
        "May": {"rent": 10000, "water": 500, "gas": 300, "current": 1300, "charge": 200, "garage": 300, "paid": 12000, "due": 600, "paymentDate": "2025-02-12"},
        "June": {"rent": 10000, "water": 500, "gas": 300, "current": 1250, "charge": 200, "garage": 300, "paid": 11000, "due": 550, "paymentDate": "2025-03-08"},
        "July": {"rent": 10000, "water": 500, "gas": 300, "current": 1250, "charge": 200, "garage": 300, "paid": 11000, "due": 550, "paymentDate": "2025-03-08"},
        "August": {"rent": 10000, "water": 500, "gas": 300, "current": 1250, "charge": 200, "garage": 300, "paid": 11000, "due": 550, "paymentDate": "2025-03-08"},
        "September": {"rent": 10000, "water": 500, "gas": 300, "current": 1250, "charge": 200, "garage": 300, "paid": 11000, "due": 550, "paymentDate": "2025-03-08"},
        "October": {"rent": 10000, "water": 500, "gas": 300, "current": 1250, "charge": 200, "garage": 300, "paid": 11000, "due": 550, "paymentDate": "2025-03-08"},
        "November": {"rent": 10000, "water": 500, "gas": 300, "current": 1250, "charge": 200, "garage": 300, "paid": 11000, "due": 550, "paymentDate": "2025-03-08"},
        "December": {"rent": 10000, "water": 500, "gas": 300, "current": 1250, "charge": 200, "garage": 300, "paid": 11000, "due": 550, "paymentDate": "2025-03-08"},
      },
      "2024": {
        "January": {"rent": 10000, "water": 500, "gas": 300, "current": 1200, "charge": 200, "garage": 300, "paid": 11000, "due": 500, "paymentDate": "2025-01-10"},
        "February": {"rent": 10000, "water": 500, "gas": 300, "current": 1300, "charge": 200, "garage": 300, "paid": 12000, "due": 600, "paymentDate": "2025-02-12"},
        "March": {"rent": 10000, "water": 500, "gas": 300, "current": 1250, "charge": 200, "garage": 300, "paid": 11000, "due": 550, "paymentDate": "2025-03-08"},
        "April": {"rent": 10000, "water": 500, "gas": 300, "current": 1200, "charge": 200, "garage": 300, "paid": 11000, "due": 500, "paymentDate": "2025-01-10"},
        "May": {"rent": 10000, "water": 500, "gas": 300, "current": 1300, "charge": 200, "garage": 300, "paid": 12000, "due": 600, "paymentDate": "2025-02-12"},
        "June": {"rent": 10000, "water": 500, "gas": 300, "current": 1250, "charge": 200, "garage": 300, "paid": 11000, "due": 550, "paymentDate": "2025-03-08"},
        "July": {"rent": 10000, "water": 500, "gas": 300, "current": 1250, "charge": 200, "garage": 300, "paid": 11000, "due": 550, "paymentDate": "2025-03-08"},
        "August": {"rent": 10000, "water": 500, "gas": 300, "current": 1250, "charge": 200, "garage": 300, "paid": 11000, "due": 550, "paymentDate": "2025-03-08"},
        "September": {"rent": 10000, "water": 500, "gas": 300, "current": 1250, "charge": 200, "garage": 300, "paid": 11000, "due": 550, "paymentDate": "2025-03-08"},
        "October": {"rent": 10000, "water": 500, "gas": 300, "current": 1250, "charge": 200, "garage": 300, "paid": 11000, "due": 550, "paymentDate": "2025-03-08"},
        "November": {"rent": 10000, "water": 500, "gas": 300, "current": 1250, "charge": 200, "garage": 300, "paid": 11000, "due": 550, "paymentDate": "2025-03-08"},
        "December": {"rent": 10000, "water": 500, "gas": 300, "current": 1250, "charge": 200, "garage": 300, "paid": 11000, "due": 550, "paymentDate": "2025-03-08"},
      },
      "2023": {
        "January": {"rent": 10000, "water": 500, "gas": 300, "current": 1200, "charge": 200, "garage": 300, "paid": 11000, "due": 500, "paymentDate": "2025-01-10"},
        "February": {"rent": 10000, "water": 500, "gas": 300, "current": 1300, "charge": 200, "garage": 300, "paid": 12000, "due": 600, "paymentDate": "2025-02-12"},
        "March": {"rent": 10000, "water": 500, "gas": 300, "current": 1250, "charge": 200, "garage": 300, "paid": 11000, "due": 550, "paymentDate": "2025-03-08"},
        "April": {"rent": 10000, "water": 500, "gas": 300, "current": 1200, "charge": 200, "garage": 300, "paid": 11000, "due": 500, "paymentDate": "2025-01-10"},
        "May": {"rent": 10000, "water": 500, "gas": 300, "current": 1300, "charge": 200, "garage": 300, "paid": 12000, "due": 600, "paymentDate": "2025-02-12"},
        "June": {"rent": 10000, "water": 500, "gas": 300, "current": 1250, "charge": 200, "garage": 300, "paid": 11000, "due": 550, "paymentDate": "2025-03-08"},
        "July": {"rent": 10000, "water": 500, "gas": 300, "current": 1250, "charge": 200, "garage": 300, "paid": 11000, "due": 550, "paymentDate": "2025-03-08"},
        "August": {"rent": 10000, "water": 500, "gas": 300, "current": 1250, "charge": 200, "garage": 300, "paid": 11000, "due": 550, "paymentDate": "2025-03-08"},
        "September": {"rent": 10000, "water": 500, "gas": 300, "current": 1250, "charge": 200, "garage": 300, "paid": 11000, "due": 550, "paymentDate": "2025-03-08"},
        "October": {"rent": 10000, "water": 500, "gas": 300, "current": 1250, "charge": 200, "garage": 300, "paid": 11000, "due": 550, "paymentDate": "2025-03-08"},
        "November": {"rent": 10000, "water": 500, "gas": 300, "current": 1250, "charge": 200, "garage": 300, "paid": 11000, "due": 550, "paymentDate": "2025-03-08"},
        "December": {"rent": 10000, "water": 500, "gas": 300, "current": 1250, "charge": 200, "garage": 300, "paid": 11000, "due": 550, "paymentDate": "2025-03-08"},
      },
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        const Text(
          "পেমেন্ট হিস্টোরি",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),

        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: paymentHistory.keys.length,
          itemBuilder: (context, yearIndex) {
            String year = paymentHistory.keys.elementAt(yearIndex);
            Map<String, Map<String, dynamic>> months = paymentHistory[year]!;

            return ExpansionTile(
              title: Text(
                year,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              children: [
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: months.keys.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    childAspectRatio: 0.67,
                  ),
                  itemBuilder: (context, monthIndex) {
                    String month = months.keys.elementAt(monthIndex);
                    final data = months[month]!;

                    final total = (data["rent"] ?? 0) +
                        (data["water"] ?? 0) +
                        (data["gas"] ?? 0) +
                        (data["current"] ?? 0) +
                        (data["charge"] ?? 0) +
                        (data["garage"] ?? 0);

                    final due = data["due"] ?? 0;

                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Text(
                                month,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const Divider(),

                            _buildInfoRow("ভাড়া", data["rent"]),
                            _buildInfoRow("পানি বিল", data["water"]),
                            _buildInfoRow("গ্যাস বিল ", data["gas"]),
                            _buildInfoRow("বিদ্যুৎ বিল", data["current"]),
                            _buildInfoRow("সার্ভিস চার্জ", data["charge"]),
                            _buildInfoRow("গ্যারেজ চার্জ", data["garage"]),

                            const Divider(),

                            _buildInfoRow("মোট", total),
                            _buildInfoRow("পরিশোধ হয়েছে", data["paid"]),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("বকেয়া", style: TextStyle(fontWeight: FontWeight.w500)),
                                Text(
                                  "$due",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: due > 0 ? Colors.red : Colors.green,
                                  ),
                                ),
                              ],
                            ),
                            _buildInfoRow("তারিখ", data["paymentDate"]),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label, dynamic value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
          Text(
            "$value",
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }


  // ================================update========================
  void _onUpdate() async {
      final updateData={
        "floor": floorController.text,
        "unit": unitController.text,
        "phone": phoneNumberController.text,
        "renterName": renterNameController.text,
        "rent": houseRentController.text,
        "gas": gasBillController.text,
        "water": waterBillController.text,
        "current": currentBillController.text,
        "charge": chargeController.text,
        "garage": garageController.text,
      };


      setState(() {
        buildingUnitList[widget.index] =updateData;
      });

      final prefs = await SharedPreferences.getInstance();
      final spService = SharedPreferencesService(prefs);
      spService.updateUnitAtIndex(widget.index,updateData); // 👈 Save back

      setState(() {
        isEditMode = false; // 👈 disable edit mode after save
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("সফলভাবে আপডেট হয়েছে ✅")),
      );
  }


}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}