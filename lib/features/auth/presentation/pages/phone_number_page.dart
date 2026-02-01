import 'package:deyram_salon/features/auth/presentation/pages/otp_number.dart';
import 'package:deyram_salon/features/auth/presentation/widget/textfield_button_background_ui.dart';
import 'package:deyram_salon/features/home/presentation/widget/phone_number_widget.dart';
import 'package:flutter/material.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PhoneNumberPage extends StatefulWidget {
  const PhoneNumberPage({super.key});

  @override
  State<PhoneNumberPage> createState() => _PhoneNumberPageState();
}

class _PhoneNumberPageState extends State<PhoneNumberPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmController =
      TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          buildBackground(),

          Positioned(bottom: 0, left: 0, right: 0, child: buildFormContainer()),
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 10),

                // 🔹 Keep Existing White Header (No Changes)
                Padding(
                  padding: const EdgeInsets.only(top: 60.0),
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
      height: 550,
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
                "Phone Number",
                style: TextStyle(
                  fontFamily: 'Serif',
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                ),
              ),
              SizedBox(height: 8),
              buildHeader("Enter your number to send OTP Number"),

              SizedBox(height: 20),

              PhoneNumberInput(
                onChanged: (phone) {
                  phoneController.text = phone;
                },
                showCountryCode: false,
                initialPhoneNumber: phoneController.text,
                hintText: '+966 5656 5656 665',
                showFlag: true, // This hides the flag
              ),
              SizedBox(height: 10),

              SizedBox(height: 120),
              buildButton100("Next", _next),
            ],
          ),
        ),
      ),
    );
  }

  void _next() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        await _secureStorage.write(
          key: 'Phone Number"',
          value: phoneController.text,
        );

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Registration successful! Please log in.'),
          ),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => OtpNumber()),
        );
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
      }
    }
  }
}
