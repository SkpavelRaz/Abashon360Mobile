
import 'package:abashon_360_mobile/modules/otp/views/otp_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController phoneController = TextEditingController();

  void _onSubmit() {
    final phone = phoneController.text.trim();
    if (phone.isEmpty || phone.length<11) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter your phone number")),
      );
    } else {
      Navigator.push(context,MaterialPageRoute(builder: (context)=>OtpScreen()));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Phone submitted: $phone")),

      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          // gradient: LinearGradient(
          //   begin: Alignment.topCenter,
          //   end: Alignment.center,
          //   colors: [Color(0xFF4CAF50), Color(0xFF4CAF50)],
          // ),
          color: Color(0xFF4CAF50)
        ),
        child: Column(
          children: [
            const SizedBox(height: 40),
            // Top text
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:16.0,vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("স্বাগতম,", style: TextStyle(color: Colors.white,fontSize: 22)),
                ],
              ),
            ),
            const SizedBox(height: 80),
            const Text(
              "ABASHON 360°",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5),
            ),
            const SizedBox(height: 60),

            // White card
            SizedBox(
              child: Container(
                margin: const EdgeInsets.all(20),
                height: 400,
                // padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 40),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      spreadRadius: 2,
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 24),
                      const Text(
                        "এখানে লগইন\nকরুন",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height:4),
                      Container(
                        height: 2,
                        width: 116,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.red, Colors.green],
                          ),
                        ),
                      ),
                      const SizedBox(height: 60),

                      // Phone input
                      TextField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        maxLength: 11,
                        decoration: InputDecoration(
                          hintText: "আপনার ফোন নম্বর লিখুন",
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Submit Button
                      Center(
                        child: SizedBox(
                          width: 200,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 14),
                            ),
                            onPressed: _onSubmit,
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
            ),
          ],
        ),
      ),
    );
  }
}