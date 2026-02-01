import 'package:deyram_salon/features/auth/presentation/widget/country.dart';
import 'package:flutter/material.dart';
import 'package:deyram_salon/core/theme/app_color.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditManage extends StatefulWidget {
  final String branchName;
  final String branchAddress;
  final String branchCity;

  EditManage({
    super.key,
    required this.branchName,
    required this.branchAddress,
    required this.branchCity,
  });

  @override
  State<EditManage> createState() => _EditManageState();
}

class _EditManageState extends State<EditManage> {
  final TextEditingController branchController = TextEditingController();
  final TextEditingController adressController = TextEditingController();
  String? selectedCity;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Initialize with the current values
    branchController.text = widget.branchName;
    adressController.text = widget.branchAddress;
    selectedCity = widget.branchCity;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Branch", style: TextStyle(fontFamily: 'Serif')),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              SizedBox(height: 10),
              buildTextFieldWithoutIcon(
                'Branch Name',
                'Branch Name',
                branchController,
              ),
              SizedBox(height: 5),
              buildTextFieldWithoutIcon('Address', 'Address', adressController),
              SizedBox(height: 5),
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
                    setState(() {
                      selectedCity = city;
                    });
                  },
                  isCitySelector: true,
                  // Preselect the current city
                ),
              ),
              SizedBox(height: 20),
              buildButtonProfile("Save Changes"),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildButtonProfile(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 60, right: 30),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xffA64D79),
          borderRadius: BorderRadius.circular(14),
        ),
        child: ElevatedButton(
          onPressed: () {
            if (_formKey.currentState?.validate() ?? false) {
              // Save the updated data
              String updatedBranchName = branchController.text.trim();
              String updatedAddress = adressController.text.trim();
              String updatedCity = selectedCity ?? '';

              // Return the updated data to ManageBranch
              Navigator.pop(context, {
                'branchName': updatedBranchName,
                'address': updatedAddress,
                'city': updatedCity,
              });

              // Optionally, show a success message
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Branch updated successfully!")),
              );
            }
          },
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 90),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            elevation: 0,
            backgroundColor: const Color.fromARGB(0, 128, 127, 127),
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
}

Widget buildButtonProfile(String text) {
  return Padding(
    padding: const EdgeInsets.only(top: 16, left: 60, right: 30),
    child: Container(
      decoration: BoxDecoration(
        color: Color(0xffA64D79),
        borderRadius: BorderRadius.circular(14),
      ),
      child: ElevatedButton(
        onPressed: () {}, // Add save logic here
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 120),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          elevation: 0,
          backgroundColor: const Color.fromARGB(0, 128, 127, 127),
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

Widget buildTextFieldWithoutIcon(
  String title,
  String label,
  TextEditingController controller, {
  TextInputType keyboardType = TextInputType.text,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontFamily: 'Serif',
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 8),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: title,
            hintText: label,
            hintStyle: TextStyle(fontFamily: 'Serif', color: Color(0xFFE3E3E3)),

            labelStyle: TextStyle(fontFamily: 'Serif', color: AppColor.gray),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Color(0xffE3E3E3),
                width: 2,
              ), // Change color to red for testing
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColor.gray),
            ),
          ),

          keyboardType: keyboardType,
        ),
      ],
    ),
  );
}
