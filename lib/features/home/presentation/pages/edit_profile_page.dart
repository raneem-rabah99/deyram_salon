import 'dart:io';
import 'package:deyram_salon/core/classes/icons_classes.dart';
import 'package:deyram_salon/features/auth/presentation/widget/country.dart';
import 'package:deyram_salon/features/auth/presentation/widget/textfield_button_background_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class EditPage extends StatefulWidget {
  const EditPage({super.key});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  XFile? _image;
  final _formKey = GlobalKey<FormState>();
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  String? selectedGender;
  String? selectedCity;
  String? selectedRegion;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final username = await _secureStorage.read(key: 'username');
    final email = await _secureStorage.read(key: 'email');
    final phone = await _secureStorage.read(key: 'phone');
    final imagePath = await _secureStorage.read(key: 'image');

    setState(() {
      usernameController.text = username ?? '';
      emailController.text = email ?? '';
      phoneController.text = phone ?? '';
      if (imagePath != null) {
        _image = XFile(imagePath);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Iconarrowleft.arowleft,
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.transparent,

        title: Text(
          "Edit Profile",
          style: TextStyle(
            fontFamily: 'Serif',
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: _buildProfileSection()),
              SizedBox(height: 10),
              Text(
                "Type",
                style: TextStyle(
                  fontFamily: 'Serif',
                  fontWeight: FontWeight.bold,
                ),
              ),
              _buildTypeButton('Salon'),
              Text(
                "Display Name",
                style: TextStyle(
                  fontFamily: 'Serif',
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              buildTextField(usernameController, "User Name", Icons.person),

              SizedBox(height: 10),
              Text(
                "Email",
                style: TextStyle(
                  fontFamily: 'Serif',
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              buildTextField(emailController, "Email (Optional)", Icons.email),
              SizedBox(height: 10),
              Text(
                "Phone Number",
                style: TextStyle(
                  fontFamily: 'Serif',
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              buildTextField(phoneController, "Phone Number", Icons.phone),
              SizedBox(height: 10),
              _buildDropdownField("Gender", [
                "Male",
                "Female",
              ], (value) => setState(() => selectedGender = value)),
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
                "Region",
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

              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 40.0),
                child: buildButtonProfilewithonpressed(
                  'Save Edit',
                  _saveChanges,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileSection() {
    return Column(
      children: [
        GestureDetector(
          onTap: _pickImage,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage:
                    _image != null
                        ? (kIsWeb
                            ? NetworkImage(_image!.path)
                            : FileImage(File(_image!.path)) as ImageProvider)
                        : AssetImage('assets/images/default_profile.png'),
              ),
              Positioned(
                child: SizedBox(
                  width: 30,
                  height: 30,
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
        SizedBox(height: 10),
        Text(
          "Company Name",
          style: TextStyle(
            fontFamily: 'Serif',
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 5),
        Text(
          "+971 323 43 23213",
          style: TextStyle(
            fontFamily: 'Serif',
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
      ],
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

  Widget _buildDropdownField(
    String label,
    List<String> items,
    ValueChanged<String?> onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontFamily: 'Serif', fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 5),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xffE3E3E3)),
            borderRadius: BorderRadius.circular(10),
          ),
          child: DropdownButtonFormField<String>(
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 16,
              ),

              border: InputBorder.none,
            ),

            items:
                items.map((String item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  Future<void> _saveChanges() async {
    if (_formKey.currentState?.validate() ?? false) {
      await _secureStorage.write(
        key: 'username',
        value: usernameController.text,
      );
      await _secureStorage.write(key: 'email', value: emailController.text);
      await _secureStorage.write(key: 'phone', value: phoneController.text);
      if (_image != null) {
        await _secureStorage.write(key: 'image', value: _image!.path);
      }
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Profile updated successfully!')));
    }
  }
}

Widget _buildTypeButton(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 80),
    child: Container(
      decoration: BoxDecoration(
        color: Color(0xffA64D79),
        borderRadius: BorderRadius.circular(14),
      ),
      child: ElevatedButton(
        onPressed: () {}, // Now dynamic
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 70),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontFamily: 'Serif',
            color: Colors.white,
            fontSize: 16,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    ),
  );
}
