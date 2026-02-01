import 'package:deyram_salon/core/theme/app_color.dart';
import 'package:deyram_salon/features/auth/presentation/pages/change_password.dart';
import 'package:deyram_salon/features/auth/presentation/pages/signUp_page.dart';
import 'package:deyram_salon/features/auth/presentation/widget/password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:deyram_salon/features/home/presentation/widget/phone_number_widget.dart';
import 'package:deyram_salon/features/home/presentation/pages/home_page.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String _completePhoneNumber = '';
  final TextEditingController passwordController = TextEditingController();
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  bool isPasswordVisible = false;

  void _login() async {
    final storedPhone = await _secureStorage.read(key: 'phoneNumber');
    final storedPassword = await _secureStorage.read(key: 'password');

    String formattedPhone = _completePhoneNumber.trim();
    if (!formattedPhone.startsWith('+')) {
      formattedPhone = '+966' + formattedPhone;
    }

    if (formattedPhone == storedPhone &&
        passwordController.text == storedPassword) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid phone number or password.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
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

          // 🔹 الجزء الأبيض السفلي (مع الحواف)
          Positioned(
            top: height * 0.40,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Text(
                      "Welcome, Use Your Phone To Sign On",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xffA3A3A3),
                        fontFamily: 'Serif',
                      ),
                    ),
                    const SizedBox(height: 30),
                    PhoneNumberInput(
                      initialPhoneNumber: '',
                      onChanged: (phone) {
                        setState(() {
                          _completePhoneNumber = phone;
                        });
                      },
                      showCountryCode: false,
                    ),
                    const SizedBox(height: 15),
                    PasswordInput(controller: passwordController),

                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChangePassword(),
                            ),
                          );
                        },
                        child: const Text(
                          "Forgot Password?",
                          style: TextStyle(
                            color: Color(0xffA3A3A3),
                            fontFamily: 'Serif',
                            decoration: TextDecoration.underline,
                            decorationThickness: 1.5, // سمك الخط
                            decorationStyle: TextDecorationStyle.solid,
                            decorationColor: Color(0xffA3A3A3),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: _login,
                      child: Container(
                        width: 240,
                        height: 44,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [AppColor.darkpink, AppColor.lightpink],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          "Confirm",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
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
                    const SizedBox(height: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xffF1F1F1),
                        side: const BorderSide(color: Colors.black),
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
                          MaterialPageRoute(builder: (context) => SignUpPage()),
                        );
                      },
                      child: const Text(
                        "Sign up",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Join as a Guest",
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Serif',
                          color: Colors.black,
                          decoration: TextDecoration.underline,
                          decorationThickness: 1.5, // سمك الخط
                          decorationStyle: TextDecorationStyle.solid,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // 🔹 الشعار والنص في الأعلى (فوق الأبيض)
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 90),
                const Center(
                  child: Text(
                    "Logo",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                const Text(
                  "Have a business account?",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Serif',
                  ),
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 50,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    "Join as a partner",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Serif',
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
}
