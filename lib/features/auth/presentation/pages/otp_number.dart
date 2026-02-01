import 'package:deyram_salon/core/theme/app_color.dart';
import 'package:deyram_salon/features/auth/presentation/pages/login_welcome.dart';
import 'package:deyram_salon/features/auth/presentation/widget/textfield_button_background_ui.dart';
import 'package:flutter/material.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class OtpNumber extends StatefulWidget {
  const OtpNumber({super.key});

  @override
  State<OtpNumber> createState() => _OtpNumberState();
}

class _OtpNumberState extends State<OtpNumber> {
  List<TextEditingController> _controllers = List.generate(
    4,
    (index) => TextEditingController(),
  );

  final _formKey = GlobalKey<FormState>();
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          buildBackground(),
          Positioned(
            left: 16,
            top: 16,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          Positioned(bottom: 0, left: 0, right: 0, child: buildFormContainer()),
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 10),

                // 🔹 Keep Existing White Header (No Changes)
                Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: Center(
                    child: const Text(
                      "Logo",
                      style: TextStyle(
                        fontFamily: 'Serif',
                        color: Colors.white,
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildFormContainer() {
    return Container(
      height: 600,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text(
                "OTP Number",
                style: TextStyle(
                  fontFamily: 'Serif',
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                ),
              ),
              SizedBox(height: 10),
              buildHeader2(
                "Enter the Code Sent to ******94  to Continue Log in Regestration ",
              ),

              SizedBox(height: 10),

              SizedBox(height: 5),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  4,
                  (index) => OTPNumber(
                    _controllers[index],
                    isActive: _controllers[index].text.isNotEmpty,
                  ),
                ),
              ),

              SizedBox(height: 20),
              buildButton100("confirm", _confirm),
              SizedBox(height: 20),
              Center(
                child: Text(
                  "00 : 59 second",
                  style: TextStyle(color: Color(0xff666666)),
                ),
              ),

              Align(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () {
                    /* Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) =>
                                          (), // Replace with your actual home page
                                ),
                              );*/
                  },
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: "Didn’t receive a Code? ",
                      style: TextStyle(
                        fontFamily: 'Serif',
                        color: Color(0xff666666),
                      ),
                      children: [
                        TextSpan(
                          text: 'Resend Code',
                          style: TextStyle(
                            fontFamily: 'Serif',

                            color: AppColor.darkpink,
                            decoration: TextDecoration.underline,
                            decorationThickness: 1.5, // سمك الخط
                            decorationStyle: TextDecorationStyle.solid,
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
      ),
    );
  }

  void _confirm() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        // Combine all OTP digits into a single string
        String otpCode =
            _controllers.map((controller) => controller.text).join();

        // Store OTP securely
        await _secureStorage.write(key: 'OTP_Code', value: otpCode);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('OTP confirmed successfully!')),
        );

        // Navigate to Login Screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage(),
          ), //LoginScreen()),
        );
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
      }
    }
  }
}
