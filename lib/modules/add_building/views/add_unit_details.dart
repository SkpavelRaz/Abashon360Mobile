import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  final TextEditingController floorDialogController = TextEditingController();
  final TextEditingController unitController = TextEditingController();
  final TextEditingController unitDialogController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController phoneNumberDialogController =
      TextEditingController();
  final TextEditingController renterNameController = TextEditingController();
  final TextEditingController renterNameDialogController =
      TextEditingController();
  final TextEditingController houseRentController = TextEditingController();
  final TextEditingController houseRentDialogController =
      TextEditingController();
  final TextEditingController chargeController = TextEditingController();
  final TextEditingController chargeDialogController = TextEditingController();
  final TextEditingController gasBillController = TextEditingController();
  final TextEditingController gasBillDialogController = TextEditingController();
  final TextEditingController waterBillController = TextEditingController();
  final TextEditingController waterBillDialogController =
      TextEditingController();
  final TextEditingController garageController = TextEditingController();
  final TextEditingController garageDialogController = TextEditingController();
  final TextEditingController currentBillController = TextEditingController();
  final TextEditingController currentBillDialogController =
      TextEditingController();

  List<Map<String, dynamic>> buildingUnitList = [];

  @override
  void initState() {
    super.initState();
    final data = widget.buildingData;
    if (data["charge"] != null && data["charge"].toString().isNotEmpty) {
      chargeController.text = data["charge"];
    }
  }

  void _onSubmit() async {
    if (phoneNumberController.text.isEmpty ||
        renterNameController.text.isEmpty ||
        houseRentController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("সব তথ্য পূরণ করুন")));
      return;
    }

    final newUnitData = {
      "floor": floorController.text,
      "unit": unitController.text,
      "phone": phoneNumberController.text,
      "name": renterNameController.text,
      "rent": houseRentController.text,
      "charge": chargeController.text,
      "gas_bill": gasBillController.text,
      "current_bill": currentBillController.text,
      "water_bill": waterBillController.text,
      "garage_charge": garageController.text,
    };

    // 👉 Combine floor + unit as string
    final newUnitKey = "${newUnitData['floor']}${newUnitData['unit']}".trim();

    // 👉 Check if already exists
    final exists = buildingUnitList.any((unit) {
      final existingKey = "${unit['floor']}${unit['unit']}".trim();
      return existingKey == newUnitKey;
    });

    if (exists) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("এই ইউনিট আগে থেকেই যোগ করা আছে")),
      );
      return;
    }

    setState(() {
      buildingUnitList.add(newUnitData);
    });

    final sharedPreferences = await SharedPreferences.getInstance();
    await SharedPreferencesService(
      sharedPreferences,
    ).addUnitBuildingList(newUnitData);

    FocusScope.of(context).unfocus();
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
        title: const Text("ইউনিট যুক্ত করুন"),
        backgroundColor: Colors.green,
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
                        // Right side: grid list
                        Expanded(flex: 1, child: _unitList(crossAxisCount)),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildForm(),
                        const SizedBox(height: 16),
                        _unitList(crossAxisCount),
                      ],
                    ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: submitUnitsToServer,
        label: const Text("Submit"),
        icon: const Icon(Icons.cloud_upload),
        backgroundColor: Colors.green,
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
              child: ElevatedButton.icon(
                onPressed: _onSubmit,
                icon: const Icon(Icons.save),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                label: const Text(
                  "জমা দিন",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
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

  Widget _buildUpperCaseTextField(
    TextEditingController controller,
    String hint,
    TextInputType type,
  ) {
    return TextField(
      controller: controller,
      keyboardType: type,
      inputFormatters: [UpperCaseTextFormatter()],
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

  Widget _buildPhoneTextField(
    TextEditingController controller,
    String hint,
    TextInputType type,
  ) {
    return TextField(
      controller: controller,
      keyboardType: type,
      maxLength: 11,
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

  // ================= UNIT GRID ===================
  Widget _unitList(int crossAxisCount) {
    if (buildingUnitList.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Center(child: Text("কোনো ইউনিট যুক্ত করা হয়নি")),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: buildingUnitList.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 0.72,
      ),
      itemBuilder: (context, index) {
        final unit = buildingUnitList[index];
        return Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: EdgeInsets.all(10),
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
                        _infoLine("📞", unit['phone']),
                        _infoLine("👤", unit['name']),
                        _infoLine("💵 ভাড়া:", unit['rent']),
                        _infoLine("🔥 গ্যাস:", unit['gas_bill']),
                        _infoLine("💧 পানি:", unit['water_bill']),
                        _infoLine("⚡ বিদ্যুৎ:", unit['current_bill']),
                        _infoLine("💼 সার্ভিস:", unit['charge']),
                        _infoLine("🚗 গ্যারেজ:", unit['garage_charge']),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue),
                      iconSize: 24,
                      onPressed: () => _openEditDialog(index),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      iconSize: 24,
                      onPressed: () => _deleteUnit(index),
                    ),
                  ],
                ),
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

  // ================== EDIT / DELETE /SAVE ==================

  void _deleteUnit(int index) {
    setState(() {
      buildingUnitList.removeAt(index);
    });
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("ইউনিটটি মুছে ফেলা হয়েছে")));
  }

  void _openEditDialog(int index) {
    final data = buildingUnitList[index];
    // Pre-fill controllers
    floorDialogController.text = data["floor"];
    unitDialogController.text = data["unit"];
    phoneNumberDialogController.text = data["phone"];
    renterNameDialogController.text = data["name"];
    houseRentDialogController.text = data["rent"];
    chargeDialogController.text = data["charge"];
    gasBillDialogController.text = data["gas_bill"];
    currentBillDialogController.text = data["current_bill"];
    waterBillDialogController.text = data["water_bill"];
    garageDialogController.text = data["garage_charge"];

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

                      _buildTextField(
                        floorDialogController,
                        "ফ্লোর নং*",
                        TextInputType.phone,
                      ),
                      const SizedBox(height: 4),
                      _buildUpperCaseTextField(
                        unitDialogController,
                        "ইউনিট নং*",
                        TextInputType.phone,
                      ),

                      const SizedBox(height: 4),
                      _buildPhoneTextField(
                        phoneNumberDialogController,
                        "ভাড়াটিয়ার ফোন নাম্বার*",
                        TextInputType.phone,
                      ),
                      const SizedBox(height: 4),
                      _buildTextField(
                        renterNameDialogController,
                        "ভাড়াটিয়ার নাম*",
                        TextInputType.name,
                      ),
                      const SizedBox(height: 4),
                      _buildTextField(
                        houseRentDialogController,
                        "ভাড়া",
                        TextInputType.number,
                      ),
                      const SizedBox(height: 4),
                      _buildTextField(
                        gasBillDialogController,
                        "গ্যাস",
                        TextInputType.number,
                      ),
                      const SizedBox(height: 4),
                      _buildTextField(
                        waterBillDialogController,
                        "পানি",
                        TextInputType.number,
                      ),
                      const SizedBox(height: 4),
                      _buildTextField(
                        currentBillDialogController,
                        "বিদ্যুৎ",
                        TextInputType.number,
                      ),
                      const SizedBox(height: 4),
                      _buildTextField(
                        chargeDialogController,
                        "সার্ভিস চার্জ",
                        TextInputType.number,
                      ),
                      const SizedBox(height: 4),
                      _buildTextField(
                        garageDialogController,
                        "গ্যারেজ",
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

  void _saveEditedData(int index) async {
    final updatedData = {
      "floor": floorDialogController.text,
      "unit": unitDialogController.text,
      "phone": phoneNumberDialogController.text,
      "name": renterNameDialogController.text,
      "rent": houseRentDialogController.text,
      "charge": chargeDialogController.text,
      "gas_bill": gasBillDialogController.text,
      "current_bill": currentBillDialogController.text,
      "water_bill": waterBillDialogController.text,
      "garage_charge": garageDialogController.text,
    };

    setState(() {
      buildingUnitList[index] = updatedData;
    });

    Navigator.pop(context); // Close dialog
  }

  //   =======================Api CAll======================
  // ✅ Submit List to API
  Future<void> submitUnitsToServer() async {
    if (buildingUnitList.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("No units to submit!")));
      return;
    }
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
