import 'package:deyram_salon/core/theme/app_color.dart';
import 'package:flutter/material.dart';

Widget buildButton80(String text, VoidCallback onPressed) {
  return Padding(
    padding: const EdgeInsets.only(top: 1, bottom: 30, left: 50, right: 40),
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
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: 13),
          textAlign: TextAlign.center,
        ),
      ),
    ),
  );
}

Widget buildButtonProfilewithonpressed(String text, VoidCallback onPressed) {
  return Padding(
    padding: const EdgeInsets.only(top: 16, bottom: 16, left: 30, right: 30),
    child: Container(
      decoration: BoxDecoration(
        color: Color(0xffA64D79),
        borderRadius: BorderRadius.circular(14),
      ),
      child: ElevatedButton(
        onPressed: onPressed, // Now dynamic
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 60),
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

Widget buildButton100(String text, VoidCallback onPressed) {
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

Widget buildHeaderTop(String title) {
  return Text(
    title,
    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
    textAlign: TextAlign.left,
  );
}

Widget buildHeader(String title) {
  return Text(
    title,
    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
    textAlign: TextAlign.left,
  );
}

Widget buildHeader2(String title) {
  final String target = "******94";
  final int index = title.indexOf(target);

  if (index == -1) {
    // لو ما لقى ******94، يرجّع النص عادي
    return Text(
      title,
      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      textAlign: TextAlign.left,
    );
  }

  return RichText(
    textAlign: TextAlign.left,
    text: TextSpan(
      style: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      children: [
        TextSpan(text: title.substring(0, index)),
        TextSpan(
          text: target,
          style: TextStyle(
            color: AppColor.darkpink, // غيّر اللون كما تشاء

            decoration: TextDecoration.underline,
            decorationThickness: 1.5, // سمك الخط
            decorationStyle: TextDecorationStyle.solid,
          ),
        ),
        TextSpan(text: title.substring(index + target.length)),
      ],
    ),
  );
}

Widget buildpasswordField(
  TextEditingController controller,
  String hintText,
  IconData icon, {
  bool isPassword = false,
}) {
  // Variable to control password visibility (only if isPassword is true)
  bool _isObscure = isPassword;

  return Padding(
    padding: const EdgeInsets.only(bottom: 4.0),
    child: TextFormField(
      controller: controller,
      obscureText: _isObscure, // Toggle visibility of password
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(icon, color: AppColor.gray),
        suffixIcon:
            isPassword
                ? IconButton(
                  icon: Icon(
                    _isObscure ? Icons.visibility_off : Icons.visibility,
                    color: AppColor.gray,
                  ),
                  onPressed: () {
                    // Toggle password visibility when the eye icon is pressed
                    _isObscure = !_isObscure;
                  },
                )
                : null, // Only show the eye icon if it's a password field
        border: OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.gray, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.gray, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.gray, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      validator: (value) => value!.isEmpty ? 'Please enter $hintText' : null,
    ),
  );
}

Widget buildTextField(
  TextEditingController controller,
  String hintText,
  IconData icon, {
  bool isPassword = false,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 4.0),
    child: TextFormField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(
          icon,
          color: AppColor.gray,
        ), // Optional: Adjust the icon color
        // Custom border similar to the one in `buildCityDropdown` and `buildTitleAndTextField`
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColor.gray,
            width: 2,
          ), // Gray border color and 2px width
          borderRadius: BorderRadius.circular(
            8,
          ), // Rounded corners, same as before
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColor.gray,
            width: 2,
          ), // Border when not focused
          borderRadius: BorderRadius.circular(8), // Rounded corners
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColor.gray,
            width: 2,
          ), // Border when focused
          borderRadius: BorderRadius.circular(8), // Rounded corners
        ),
      ),
      validator: (value) => value!.isEmpty ? 'Please enter $hintText' : null,
    ),
  );
}

Widget buildBackground([String? title]) {
  return Stack(
    children: [
      Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColor.darkpink, AppColor.lightpink],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
      ),
      if (title != null) // Only display the title if it's provided
        Positioned(
          top: 150, // Adjust the position as needed
          left: 0,
          right: 0,
          child: Center(
            child: Text(
              title,
              style: TextStyle(
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

Widget buildLoginLink(String sentence, String buttomText) {
  return Center(
    child: Column(
      children: [
        Text(sentence, style: TextStyle(color: Colors.pink.shade400)),
        TextButton(
          onPressed: () {},
          child: Text(
            buttomText,
            style: TextStyle(color: Colors.pink.shade400),
          ),
        ),
      ],
    ),
  );
}

Widget OTPNumber(TextEditingController controller, {bool isActive = false}) {
  return Container(
    width: 50,
    height: 50,
    margin: EdgeInsets.symmetric(horizontal: 5),
    decoration: BoxDecoration(
      border: Border.all(
        color:
            isActive
                ? Colors.black
                : Colors.grey, // Border turns black when active
        width: 2,
      ),
      borderRadius: BorderRadius.circular(10),
    ),
    alignment: Alignment.center,
    child: TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      maxLength: 1,
      style: TextStyle(fontSize: 20),
      decoration: InputDecoration(counterText: '', border: InputBorder.none),
      onChanged: (value) {
        // Trigger UI update when text changes
      },
    ),
  );
}
