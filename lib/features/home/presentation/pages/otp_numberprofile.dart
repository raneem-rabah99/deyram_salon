import 'package:flutter/material.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:deyram_salon/features/auth/presentation/pages/login_welcome.dart';
import 'package:deyram_salon/features/auth/presentation/widget/textfield_button_background_ui.dart';

class OtpNumberProfile extends StatefulWidget {
  const OtpNumberProfile({super.key});

  @override
  State<OtpNumberProfile> createState() => _OtpNumberProfileState();
}

class _OtpNumberProfileState extends State<OtpNumberProfile> {
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
          buildBackground('Logo'),
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
              buildHeaderTop("OTP Number"),
              SizedBox(height: 10),
              buildHeader("Enter the following info to create new account."),

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

              SizedBox(height: 10),

              SizedBox(height: 20),
              buildButton100("confirm", _confirm),
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
