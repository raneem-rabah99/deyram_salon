import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:deyram_salon/features/auth/presentation/widget/textfield_button_background_ui.dart';
import 'package:deyram_salon/features/home/presentation/pages/otp_numberprofile.dart';

class ChangePasswordProfile extends StatefulWidget {
  const ChangePasswordProfile({super.key});

  @override
  State<ChangePasswordProfile> createState() => _ChangePasswordProfileState();
}

class _ChangePasswordProfileState extends State<ChangePasswordProfile> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          buildBackgroundProfile(),
          Positioned(
            left: 5,
            top: 45,

            child: Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: const Color.fromARGB(255, 23, 23, 23),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                SizedBox(width: 4), // Space between icon and text
                Text(
                  "Change Password", // Your text here
                  style: TextStyle(
                    fontFamily: 'Serif',
                    color: const Color.fromARGB(255, 7, 7, 7),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Positioned(bottom: 0, left: 0, right: 0, child: buildFormContainer()),
        ],
      ),
    );
  }

  Widget buildFormContainer() {
    return Container(
      height: 740,
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
              SizedBox(height: 10),
              Text(
                "New Password",
                style: TextStyle(
                  fontFamily: 'Serif',
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              buildTextField(
                passwordController,
                "Password",
                Icons.lock,
                isPassword: true,
              ),
              SizedBox(height: 10),
              Text(
                "Confirm New Password",
                style: TextStyle(
                  fontFamily: 'Serif',
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              buildTextField(
                passwordConfirmController,
                "Confirm Password",
                Icons.lock,
                isPassword: true,
              ),
              SizedBox(height: 280),
              buildButtonProfilewithonpressed(
                "Creat New Password",
                _creatnewPassword,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _creatnewPassword() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        await _secureStorage.write(
          key: 'password',
          value: passwordController.text,
        );

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Registration successful! Please log in.'),
          ),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => OtpNumberProfile()),
        );
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
      }
    }
  }
}

Widget buildBackgroundProfile([String? title]) {
  return Stack(
    children: [
      Container(decoration: BoxDecoration(color: Color(0xffF1F1F1))),
      if (title != null) // Only display the title if it's provided
        Positioned(
          top: 150, // Adjust the position as needed
          left: 0,
          right: 0,
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                fontFamily: 'Serif',
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
    ],
  );
}
