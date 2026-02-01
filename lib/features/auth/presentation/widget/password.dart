import 'package:deyram_salon/core/classes/icons_classes.dart';
import 'package:flutter/material.dart';

class PasswordInput extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final FormFieldValidator<String>? validator;

  const PasswordInput({
    Key? key,
    required this.controller,
    this.hintText = "Password",
    this.validator,
  }) : super(key: key);

  @override
  _PasswordInputState createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: !isPasswordVisible,
      validator: widget.validator,
      decoration: InputDecoration(
        prefixIcon: IconKey.iconkey,
        suffixIcon: IconButton(
          icon: Iconeye.eye,
          onPressed: () {
            setState(() {
              isPasswordVisible = !isPasswordVisible;
            });
          },
        ),
        hintText: widget.hintText,
        hintStyle: TextStyle(color: Color(0xffA3A3A3), fontSize: 10),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Color(0xffE3E3E3)),
        ),
      ),
    );
  }
}
