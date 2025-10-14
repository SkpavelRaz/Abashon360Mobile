
import 'package:flutter/material.dart';

class HouseRentDetails extends StatefulWidget{
  const HouseRentDetails({super.key});

  @override
  State<StatefulWidget> createState() => _HouseRentDetails();
}

class _HouseRentDetails extends State<HouseRentDetails>{
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
                  // Expanded(flex: 1, child: _unitList(crossAxisCount)),
                ],
              )
                  : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildForm(),
                  const SizedBox(height: 16),
                  // _unitList(crossAxisCount),
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

}