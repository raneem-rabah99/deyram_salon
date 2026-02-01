import 'package:deyram_salon/core/theme/app_color.dart';
import 'package:flutter/material.dart';

Widget buildHeaderTop(String title) {
  return Text(
    title,
    style: TextStyle(
      fontFamily: 'Serif',
      fontSize: 22,
      fontWeight: FontWeight.bold,
    ),
    textAlign: TextAlign.left,
  );
}

Widget buildHeader(String title) {
  return Text(
    title,
    style: TextStyle(
      fontFamily: 'Serif',
      fontSize: 12,
      fontWeight: FontWeight.bold,
    ),
    textAlign: TextAlign.left,
  );
}

Widget buildDropdownField(String hintText) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.circular(10),
    ),
    child: DropdownButtonFormField<String>(
      decoration: InputDecoration(border: InputBorder.none),
      hint: Text(
        hintText,
        style: TextStyle(fontFamily: 'Serif', color: Colors.grey[600]),
      ),
      items: [],
      onChanged: (value) {},
    ),
  );
}

Widget buildTermsAndConditions() {
  return RichText(
    textAlign: TextAlign.center,
    text: TextSpan(
      text: 'By continuing, you agree to our ',
      style: TextStyle(fontFamily: 'Serif', color: Colors.grey),
      children: [
        TextSpan(
          text: 'Terms of Use',
          style: TextStyle(fontFamily: 'Serif', color: Colors.pink.shade400),
        ),
        TextSpan(text: ' and our '),
        TextSpan(
          text: 'Privacy Policy',
          style: TextStyle(fontFamily: 'Serif', color: Colors.pink.shade400),
        ),
      ],
    ),
  );
}

Widget buildLoginLink() {
  return Center(
    child: RichText(
      text: TextSpan(
        style: TextStyle(color: Colors.black),
        children: [
          TextSpan(text: ' Already have an account? '),
          TextSpan(
            text: 'Sign in',
            style: TextStyle(
              color: AppColor.darkpink,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
              decorationThickness: 1.5, // سمك الخط
              decorationStyle: TextDecorationStyle.solid,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget buildTextField(
  TextEditingController controller,
  String hintText,
  Widget icon, {
  bool isPassword = false,
  String? Function(String?)? validator,
}) {
  return TextFormField(
    controller: controller,
    obscureText: isPassword,
    decoration: InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(color: Color(0xffA3A3A3), fontSize: 10),
      prefixIcon: icon,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: Color(0xffE3E3E3),
        ), // Change color to red for testing
      ),
    ),
    validator: validator,
  );
}

Widget buildButton100(String text, VoidCallback? onPressed) {
  return Padding(
    padding: const EdgeInsets.only(top: 16, bottom: 16, left: 30, right: 30),
    child: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColor.darkpink, AppColor.lightpink],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(14),
      ),
      child: ElevatedButton(
        onPressed: onPressed, // Now dynamic
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 100),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: 16),
          textAlign: TextAlign.center,
        ),
      ),
    ),
  );
}
