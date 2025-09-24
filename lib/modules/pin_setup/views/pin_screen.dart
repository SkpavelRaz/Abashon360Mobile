
import 'package:abashon_360_mobile/modules/home/views/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class PinViewSetupScreen extends StatefulWidget{
  const PinViewSetupScreen({super.key});

  @override
  State<StatefulWidget> createState() => _PinViewSetupScreen();

}

class _PinViewSetupScreen extends State<PinViewSetupScreen>{
  final TextEditingController _otpController = TextEditingController();

  void _onSubmit() {
    final phone = _otpController.text.trim();
    if (phone.isEmpty || phone.length<5) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please set your pin properly")),
      );
    } else {
      Navigator.push(context,MaterialPageRoute(builder: (context)=>HomeScreen()));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("submitted: $phone"))
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // Background image
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/auth_bg.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 40),
                // Top text
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "স্বাগতম,",
                        style: TextStyle(color: Colors.white, fontSize: 22),
                      ),
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
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 60),

                // White card
                SizedBox(
                  child: Container(
                    margin: const EdgeInsets.all(20),
                    height: 400,
                    // padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40,),
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
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 24),
                          const Text(
                            "পিন সেট\nকরুন",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            height: 2,
                            width: 76,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.red, Colors.green],
                              ),
                            ),
                          ),
                          const SizedBox(height: 60),

                          // OTP Box (using Pinput package for better UI)
                          Center(
                            child: Pinput(
                              length: 5,
                              controller: _otpController,
                              defaultPinTheme: PinTheme(
                                width: 50,
                                height: 50,
                                textStyle: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.green),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 25),

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

                          const SizedBox(height: 15),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],

      ),
    );
  }

}