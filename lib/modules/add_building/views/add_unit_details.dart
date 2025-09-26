
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddUnitDetails extends StatefulWidget {
  final Map<String, dynamic> buildingData;

  const AddUnitDetails({super.key, required this.buildingData});

  @override
  State<StatefulWidget> createState() => _AddUnitDetails();
}
class _AddUnitDetails extends State<AddUnitDetails> {
  @override
  Widget build(BuildContext context) {
    final data = widget.buildingData;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Unit Details"),
        backgroundColor: Colors.green,
      ),
      body: Padding(
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
      ),
    );
  }
}
