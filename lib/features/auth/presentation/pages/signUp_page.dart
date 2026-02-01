import 'dart:io';
import 'package:deyram_salon/core/classes/icons_classes.dart';
import 'package:deyram_salon/core/theme/app_color.dart';

import 'package:deyram_salon/features/auth/presentation/pages/phone_number_page.dart';
import 'package:deyram_salon/features/auth/presentation/widget/country.dart';
import 'package:deyram_salon/features/auth/presentation/widget/password.dart';
import 'package:deyram_salon/features/auth/presentation/widget/signupWidgit.dart';
import 'package:deyram_salon/features/auth/presentation/widget/uploadphoto.dart';
import 'package:deyram_salon/features/auth/presentation/widget/validator.dart';
import 'package:deyram_salon/features/home/presentation/widget/phone_number_widget.dart';
import 'package:deyram_salon/features/home/presentation/widget/select_one_from_options_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmController =
      TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  bool isTermsAccepted = false;

  XFile? _image;
  final _formKey = GlobalKey<FormState>();
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildBackground(),
          Positioned(
            left: 13,
            top: 60,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _buildFormContainer(),
          ),
        ],
      ),
    );
  }

  Widget _buildBackground() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColor.darkpink, AppColor.lightpink],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }

  Widget _buildFormContainer() {
    return Container(
      height: 730,
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
              buildHeaderTop("Create new account"),
              SizedBox(height: 10),
              buildHeader("Enter the following info to create new account."),
              SizedBox(height: 10),
              _buildProfileImage(),
              SizedBox(height: 20),
              Text(
                "Full Name",
                style: TextStyle(
                  fontFamily: 'Serif',
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              buildTextField(
                usernameController,
                "John Doe",
                IconePerson.person,
                validator: Validators.validateName,
              ),
              SizedBox(height: 10),
              Text(
                "Type",
                style: TextStyle(
                  fontFamily: 'Serif',
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              SelectOneFromOptionsWidget(items: ["Salon", "Freelancer"]),
              SizedBox(height: 10),
              Text(
                "Gender",
                style: TextStyle(
                  fontFamily: 'Serif',
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 5),

              SelectOneFromOptionsWidget(items: ["Male", "Female"]),
              SizedBox(height: 10),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Email ',
                      style: TextStyle(
                        fontFamily: 'Serif',
                        fontWeight: FontWeight.bold,
                        color: Colors.black, // اللون الأساسي للنص
                      ),
                    ),
                    TextSpan(
                      text: '( Optional )',
                      style: TextStyle(
                        fontFamily: 'Serif',

                        color: Color(0xffA3A3A3), // اللون المطلوب لـ (Optional)
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 5),
              buildTextField(
                emailController,
                "Example@email.com",
                IconMail.iconmail,
                validator: Validators.validateEmail,
              ),

              SizedBox(height: 10),
              Text(
                "Phone Number",
                style: TextStyle(
                  fontFamily: 'Serif',
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              FormField<String>(
                validator:
                    (value) =>
                        Validators.validatePhoneNumber(phoneController.text),
                builder: (field) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PhoneNumberInput(
                        onChanged: (phone) {
                          phoneController.text = phone;
                          field.didChange(phone);
                        },
                        initialCountryCode: '+966',
                        showPhoneIcon: false,
                        initialPhoneNumber: phoneController.text,
                        hintText: '|  _ _ _ _ _ _ _ _ _ _',
                        showFlag: false,
                      ),
                      if (field.hasError)
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0, top: 4.0),
                          child: Text(
                            field.errorText!,
                            style: TextStyle(color: Colors.red, fontSize: 12),
                          ),
                        ),
                    ],
                  );
                },
              ),

              SizedBox(height: 10),
              Text(
                "City",
                style: TextStyle(
                  fontFamily: 'Serif',
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              BlocProvider.value(
                value: context.read<CitiesCubit>(),
                child: CountrySelector(
                  onSelected: (city) {
                    print('Selected city: $city');
                  },
                  isCitySelector: true,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Country",
                style: TextStyle(
                  fontFamily: 'Serif',
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              BlocProvider.value(
                value: context.read<CitiesCubit>(),
                child: CountrySelector(
                  onSelected: (country) {
                    print('Selected country: $country');
                  },
                  isCitySelector: false,
                ),
              ),

              SizedBox(height: 10),
              Text(
                "Password",
                style: TextStyle(
                  fontFamily: 'Serif',
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              PasswordInput(
                hintText: '*************',
                controller: passwordController,
                validator: Validators.validatePassword,
              ),
              SizedBox(height: 10),
              Text(
                "Confirm Password",

                style: TextStyle(
                  fontFamily: 'Serif',
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              PasswordInput(
                hintText: '*************',
                controller: passwordConfirmController,
                validator: Validators.validatePassword,
              ),
              SizedBox(height: 10),
              UploadDocumentWidget(
                title: "Upload Document",
                placeholderText:
                    "Upload Document ( Certificate and certificates)",

                height: 80,
                onFilePicked: (file) {
                  print('Picked file: ${file?.path}');
                },
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Checkbox(
                    side: BorderSide(width: 1),
                    value: isTermsAccepted,
                    onChanged: (value) {
                      setState(() {
                        isTermsAccepted = value ?? false;
                      });
                    },
                  ),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(color: Colors.black),
                        children: [
                          TextSpan(text: 'By Continuing you agree to '),
                          TextSpan(
                            text: 'Deyram',
                            style: TextStyle(
                              color: AppColor.darkpink,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                              decorationThickness: 1.5, // سمك الخط
                              decorationStyle: TextDecorationStyle.solid,
                            ),
                          ),
                          TextSpan(text: ' Term of use, you may read our '),
                          TextSpan(
                            text: 'privacy policy',
                            style: TextStyle(
                              color: AppColor.darkpink,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                              decorationThickness: 1.5, // سمك الخط
                              decorationStyle: TextDecorationStyle.solid,
                            ),
                          ),
                          TextSpan(text: ' here.'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 15),
              buildButton100("sign up", isTermsAccepted ? _signUp : null),
              SizedBox(height: 5),

              buildLoginLink(),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _image = image;
      });
    }
  }

  Widget _buildProfileImage() {
    return Row(
      children: [
        GestureDetector(
          onTap: _pickImage,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage:
                    _image != null
                        ? (kIsWeb
                            ? NetworkImage(_image!.path)
                            : FileImage(File(_image!.path)) as ImageProvider)
                        : AssetImage('assets/images/deram 1.png')
                            as ImageProvider,
              ),
              Positioned(
                child: SizedBox(
                  width: 40,
                  height: 40,
                  child: Image.asset(
                    'assets/icons/camera-01.png',
                    fit: BoxFit.contain,
                    color: const Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 10),
        Text(
          "Add Profile Photo",
          style: TextStyle(
            fontFamily: 'Serif',
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            decoration: TextDecoration.underline,
            decorationThickness: 1.5, // سمك الخط
            decorationStyle: TextDecorationStyle.solid,
          ),
        ),
      ],
    );
  }

  void _signUp() async {
    if (_formKey.currentState?.validate() ?? false) {
      // Check if passwords match

      try {
        // Storing data in secure storage
        await _secureStorage.write(
          key: 'username',
          value: usernameController.text,
        );
        await _secureStorage.write(key: 'email', value: emailController.text);
        await _secureStorage.write(
          key: 'password',
          value: passwordController.text,
        );
        await _secureStorage.write(key: 'image', value: _image?.path);
        await _secureStorage.write(
          key: 'phoneNumber',
          value: phoneController.text, // Ensure consistency in format
        );

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Registration successful! Please log in.'),
          ),
        );

        // Redirect to the login page after registration
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => PhoneNumberPage()),
        );
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
      }
    }
  }
}
