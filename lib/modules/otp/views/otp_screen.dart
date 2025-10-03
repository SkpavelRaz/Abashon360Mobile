import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import '../../login/auth_service.dart';
import '../../pin_setup/views/pin_screen.dart';

class OtpScreen extends StatefulWidget {
  final String phone;
  const OtpScreen({super.key,required this.phone});

  @override
  State<StatefulWidget> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {

  final TextEditingController _otpController = TextEditingController();
  int _start = 30;
  bool _canResend = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    _canResend = false;
    _start = 30;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start == 0) {
        setState(() {
          _canResend = true;
          timer.cancel();
        });
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:false,
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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 24),
                          const Text(
                            "ওটিপি যাচাই\nকরুন",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            height: 2,
                            width: 110,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.red, Colors.green],
                              ),
                            ),
                          ),
                          const SizedBox(height: 60),

                          // OTP Box (using Pinput package for better UI)
                          Pinput(
                            length: 6,
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
                          const SizedBox(height: 25),


                          Row(
                            children: [
                              // 🔹 Verify OTP button
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                    minimumSize: const Size(double.infinity, 45),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  onPressed: _onSubmit,
                                  child: const Text("যাচাই করুন"),
                                ),
                              ),

                              const SizedBox(width: 12),
                              // 🔹 Back button
                              SizedBox(
                                width: 68,
                                height: 45,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.orangeAccent,
                                      minimumSize: const Size(double.infinity, 45),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context); // go back
                                    },
                                    child: Icon(Icons.arrow_back_rounded,color: Colors.black,size: 32,)
                                ),
                              ),

                            ],
                          ),
                          const SizedBox(height: 15),

                          // Resend timer
                          _canResend
                              ? GestureDetector(
                            onTap: () {
                              startTimer();
                            },
                            child: const Text(
                              "ওটিপি পুনরায় পাঠান",
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )
                              : Text(
                            "ওটিপি পুনরায় পাঠানোর অনুরোধ সময়: $_start s",
                            style: const TextStyle(color: Colors.grey),
                          ),
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

  Future<void> _onSubmit() async {
    final otp=_otpController.text.trim();
    if(otp.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter your otp")),
      );
      return;
    }

    try {
      // Show loading
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => const Center(child: CircularProgressIndicator()),
      );

      final auth = AuthService();
      final response = await auth.verifyOtp(phone: widget.phone, otp: otp);

      // Close loading BEFORE any navigation
      Navigator.pop(context);

      if (response.status) {
        Navigator.push(context,MaterialPageRoute(builder: (context)=>PinViewSetupScreen(phone: widget.phone,set_pin: true,)));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(response.message)));
      }
    } catch (e) {
      Navigator.pop(context); // Close loading if error
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }
}
