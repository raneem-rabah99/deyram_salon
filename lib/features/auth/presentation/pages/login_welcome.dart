import 'package:deyram_salon/core/theme/app_color.dart';
import 'package:deyram_salon/features/auth/presentation/pages/change_password.dart';
import 'package:deyram_salon/features/auth/presentation/pages/signUp_page.dart';
import 'package:deyram_salon/features/auth/presentation/widget/password.dart';
import 'package:deyram_salon/features/auth/presentation/widget/textfield_button_background_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:deyram_salon/features/home/presentation/widget/phone_number_widget.dart';
import 'package:deyram_salon/features/home/presentation/pages/home_page.dart'; // Adjust this import to your home screen

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _completePhoneNumber = '';
  final TextEditingController passwordController = TextEditingController();
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  bool isPasswordVisible = false; // State for password visibility toggle

  void _login() async {
    // Read the stored phone number and password from secure storage
    final storedPhone = await _secureStorage.read(key: 'phoneNumber');
    final storedPassword = await _secureStorage.read(key: 'password');

    print("Entered Phone Number: $_completePhoneNumber");
    print("Stored Phone Number: $storedPhone");
    print("Entered Password: ${passwordController.text}");
    print("Stored Password: $storedPassword");

    // Ensure phone number is trimmed and formatted correctly
    String formattedPhone = _completePhoneNumber.trim();

    // Check if the entered phone number matches the stored phone number format
    // Assuming stored phone number has a country code (e.g., +966)
    if (formattedPhone != storedPhone) {
      // Normalize phone number format (add country code if not present)
      if (!formattedPhone.startsWith('+')) {
        formattedPhone =
            '+966' +
            formattedPhone; // Ensure consistency with your sign-up logic
      }
      print("Normalized Phone Number: $formattedPhone");
    }

    // Check if the phone number and password match
    if (formattedPhone == storedPhone) {
      print("Phone number matches");
      if (passwordController.text == storedPassword) {
        print("Password matches");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Home(), // Replace with your actual home page
          ),
        );
      } else {
        print("Password does not match");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid phone number or password.')),
        );
      }
    } else {
      print("Phone number does not match");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid phone number or password.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            // 🔹 الخلفية العلوية (تدرج)
            Container(
              height: height,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [AppColor.darkpink, AppColor.lightpink],
                ),
              ),
            ),

            // White Background (Covers Bottom)
            Positioned(
              top:
                  MediaQuery.of(context).size.height *
                  0.40, // Start white earlier
              left: 0,
              right: 0,
              bottom: 0, // Fully cover bottom
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
              ),
            ),

            // Content (No Changes to Texts, Inputs, or Buttons)
            SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 240),

                  Padding(
                    padding: const EdgeInsets.only(
                      top: 80.0,
                      left: 30,
                      right: 30,
                    ),
                    child: Form(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 235.0),
                            child: Text(
                              "Login",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Serif',
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          PhoneNumberInput(
                            initialPhoneNumber: '',
                            onChanged: (phone) {
                              setState(() {
                                _completePhoneNumber = phone;
                              });
                            },
                            showCountryCode: false,
                          ),
                          const SizedBox(height: 10),
                          PasswordInput(controller: passwordController),

                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) =>
                                            ChangePassword(), // Replace with your actual home page
                                  ),
                                );
                              },
                              child: const Text(
                                "Forgot Password?",
                                style: TextStyle(
                                  fontFamily: 'Serif',
                                  color: Color(0xffA3A3A3),
                                ),
                              ),
                            ),
                          ),

                          buildButton100("confirm", _login),
                          Container(
                            width: 245,
                            height: 35,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(60),
                                topRight: Radius.circular(60),
                                bottomLeft: Radius.circular(60),
                                bottomRight: Radius.circular(60),
                              ),

                              color: Color.fromARGB(255, 245, 195, 208),
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  "Confirmation failed. Please check the number",
                                  style: TextStyle(
                                    fontFamily: 'Serif',
                                    fontSize: 8,
                                    color: Color(0xffA64D79),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 35),
                          Padding(
                            padding: const EdgeInsets.only(right: 140.0),
                            child: const Text(
                              "Don't have an account?",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontFamily: 'Serif',
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xffF1F1F1),
                              side: const BorderSide(
                                color: Colors.black,
                                width: 1,
                              ),
                              padding: const EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 100,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignUpPage(),
                                ),
                              );
                            },
                            child: const Text(
                              "Sign up",
                              style: TextStyle(
                                fontFamily: 'Serif',
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
