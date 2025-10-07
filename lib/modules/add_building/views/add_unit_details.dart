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
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("সব তথ্য পূরণ করুন")));
      return;
    }

    final newData = {
      "phone": phoneNumberController.text,
      "name": renterNameController.text,
      "rent": houseRentController.text,
      "charge": chargeController.text,
      "gas_bill": gasBillController.text,
      "current_bill": currentBillController.text,
      "water_bill": waterBillController.text,
      "garage_charge": garageController.text,
    };

    setState(() {
      buildingUnitList.add(newData);
      // _clearFields();
    });

    FocusScope.of(context).unfocus();
  }

  void _clearFields() {
    phoneNumberController.clear();
    renterNameController.clear();
    houseRentController.clear();
    chargeController.clear();
    gasBillController.clear();
    waterBillController.clear();
    currentBillController.clear();
    garageController.clear();
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
            _buildPhoneTextField(phoneNumberController, "ভাড়াটিয়ার ফোন নাম্বার*", TextInputType.phone),
            const SizedBox(height: 8),
            _buildTextField(renterNameController, "ভাড়াটিয়ার নাম*", TextInputType.name),
            const SizedBox(height: 8),
            _buildTextField(houseRentController, "বাসা ভাড়া*", TextInputType.number),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(child: _buildTextField(gasBillController, "গ্যাস বিল", TextInputType.number)),
                const SizedBox(width: 8),
                Expanded(child: _buildTextField(waterBillController, "পানি বিল", TextInputType.number)),
                const SizedBox(width: 8),
                Expanded(child: _buildTextField(currentBillController, "বিদ্যুৎ বিল", TextInputType.number)),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(child: _buildTextField(chargeController, "সার্ভিস চার্জ (যদি থাকে)", TextInputType.number)),
                const SizedBox(width: 8),
                Expanded(child: _buildTextField(garageController, "গ্যারেজ চার্জ (যদি থাকে)", TextInputType.number)),
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
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
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

  Widget _buildTextField(TextEditingController controller, String hint, TextInputType type) {
    return TextField(
      controller: controller,
      keyboardType: type,
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      ),
    );
  }
  Widget _buildPhoneTextField(TextEditingController controller, String hint, TextInputType type) {
    return TextField(
      controller: controller,
      keyboardType: type,
      maxLength: 11,
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("ইউনিট ${index + 1}",
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                const SizedBox(height: 6),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _infoLine("📞", unit['phone']),
                        _infoLine("👤", unit['name']),
                        _infoLine("🏠 ভাড়া:", unit['rent']),
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
                      onPressed: () => _editUnit(index),
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
      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400,),
      overflow: TextOverflow.ellipsis,
    );
  }

  // ================== EDIT / DELETE ==================
  void _editUnit(int index) {
    final unit = buildingUnitList[index];
    phoneNumberController.text = unit['phone'];
    renterNameController.text = unit['name'];
    houseRentController.text = unit['rent'];
    chargeController.text = unit['charge'];
    gasBillController.text = unit['gas_bill'];
    waterBillController.text = unit['water_bill'];
    currentBillController.text = unit['current_bill'];
    garageController.text = unit['garage_charge'];

    setState(() {
      buildingUnitList.removeAt(index);
    });
  }

  void _deleteUnit(int index) {
    setState(() {
      buildingUnitList.removeAt(index);
    });
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("ইউনিটটি মুছে ফেলা হয়েছে")));
  }

//   =======================Api CAll======================
  // ✅ Submit List to API
  Future<void> submitUnitsToServer() async {
    if (buildingUnitList.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No units to submit!")),
      );
      return;
    }

    // try {
    //   final url = Uri.parse("https://your-api.com/units/submit");
    //   final response = await http.post(
    //     url,
    //     headers: {
    //       'Content-Type': 'application/json',
    //       'Authorization': 'Bearer YOUR_AUTH_TOKEN', // if needed
    //     },
    //     body: jsonEncode({'units': buildingUnitList}),
    //   );
    //
    //   if (response.statusCode == 200) {
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       const SnackBar(content: Text("Units submitted successfully!")),
    //     );
    //   } else {
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       SnackBar(content: Text("Failed: ${response.body}")),
    //     );
    //   }
    // } catch (e) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(content: Text("Error: $e")),
    //   );
    // }
  }
}
