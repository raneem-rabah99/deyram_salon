import 'dart:io';

import 'package:deyram_salon/features/auth/presentation/widget/password.dart';
import 'package:deyram_salon/features/auth/presentation/widget/textfield_button_background_ui.dart';
import 'package:deyram_salon/features/home/data/models/technical_model.dart';
import 'package:deyram_salon/features/home/presentation/manager/technical_cubit.dart';
import 'package:deyram_salon/features/home/presentation/pages/edit_manage.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart';

class AddTechnicaPage extends StatefulWidget {
  const AddTechnicaPage({super.key});

  @override
  State<AddTechnicaPage> createState() => _AddTechnicaPageState();
}

class _AddTechnicaPageState extends State<AddTechnicaPage> {
  final TextEditingController numberController = TextEditingController();
  final TextEditingController CategoryController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmController =
      TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  XFile? _image;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,

        title: Text(
          "Add Technical",
          style: TextStyle(
            fontFamily: 'Serif',
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              SizedBox(height: 10),
              _buildProfileImage(),
              SizedBox(height: 20),

              SizedBox(height: 5),
              buildTextFieldWithoutIcon(
                "Name Services Provider",
                "Add Name",
                usernameController,
              ),

              SizedBox(height: 10),
              buildTextFieldWithoutIcon(
                "Number",
                "Add Number",
                numberController,
              ),
              buildTextFieldWithoutIcon(
                "Category",
                "Add Gategory",
                CategoryController,
              ),

              SizedBox(height: 10),
              SizedBox(height: 10),
              Text(
                "Password",
                style: TextStyle(
                  fontFamily: 'Serif',
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              PasswordInput(controller: passwordController),

              SizedBox(height: 170),
              buildButton100("Add Technical", _add),
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
              Padding(
                padding: const EdgeInsets.only(right: 120.0, left: 120),
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage:
                      _image != null
                          ? (kIsWeb
                              ? NetworkImage(_image!.path)
                              : FileImage(File(_image!.path)) as ImageProvider)
                          : AssetImage('assets/images/deram 1.png')
                              as ImageProvider,
                ),
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
      ],
    );
  }

  void _add() {
    if (_formKey.currentState?.validate() ?? false) {
      final newTechnician = Technicial(
        name: usernameController.text,
        number: numberController.text,
        category: CategoryController.text,
        password: passwordController.text,
        imagePath: _image?.path,
      );

      context.read<TechnicialCubit>().addTechnician(newTechnician);

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Technician added successfully!')));

      Navigator.pop(context); // Return to previous screen after adding
    }
  }
}
