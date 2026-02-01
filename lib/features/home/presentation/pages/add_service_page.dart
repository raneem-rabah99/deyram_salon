import 'package:deyram_salon/core/classes/icons_classes.dart';
import 'package:deyram_salon/core/theme/app_color.dart';
import 'package:deyram_salon/features/home/presentation/manager/product_and_service_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddServicePage extends StatefulWidget {
  @override
  _AddServicePageState createState() => _AddServicePageState();
}

class _AddServicePageState extends State<AddServicePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String? _selectedBranch;
  String? _selectedServiceType;
  String? _selectedType;
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProductCubit>();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Iconarrowleft.arowleft,
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Add Service'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildTitleAndTextField('Service Name', _nameController),
              buildTitleAndDropdown(
                'Type',
                _selectedType,
                (value) {
                  setState(() => _selectedType = value);
                },
                cubit.state.branches,
                isCategoryDropdown: false,
              ),
              Row(
                children: [
                  Expanded(
                    child: RadioListTile<String>(
                      value: 'Salon',
                      groupValue: _selectedServiceType,
                      title: Text(
                        'Salon',
                        style: TextStyle(fontFamily: 'Serif', fontSize: 10),
                      ),
                      onChanged:
                          (value) =>
                              setState(() => _selectedServiceType = value),
                      visualDensity: VisualDensity.compact,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<String>(
                      value: 'Salon & Home',
                      groupValue: _selectedServiceType,
                      title: Text(
                        'Salon & Home',
                        style: TextStyle(fontFamily: 'Serif', fontSize: 10),
                      ),
                      onChanged:
                          (value) =>
                              setState(() => _selectedServiceType = value),
                      visualDensity: VisualDensity.compact,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ],
              ),
              buildTitleAndTextField('Price', _priceController, isNumber: true),
              buildTitleAndDropdown(
                'Branches',
                _selectedBranch,
                (value) {
                  setState(() => _selectedBranch = value);
                },
                cubit.state.branches,
                isCategoryDropdown: false,
              ),
              buildTitleAndTextField(
                'Description',
                _descriptionController,
                isMultiline: true,
              ),
              SizedBox(height: 2),
              buildUploadPhotoBox(),
              SizedBox(height: 2),
              buildAddButton(
                AppColor.darkpink,
                'Add Product',
                cubit,
                _nameController,
                _selectedType,
                _selectedBranch,
                _priceController,
                _descriptionController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildTitleAndTextField(
  String title,
  TextEditingController controller, {
  bool isNumber = false,
  bool isMultiline = false,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 4.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontFamily: 'Serif',
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: isNumber ? TextInputType.number : TextInputType.text,
          maxLines: isMultiline ? 2 : 1,
          style: TextStyle(
            fontFamily: 'Serif',
            color: const Color.fromARGB(255, 6, 6, 6),
          ),
          decoration: InputDecoration(
            labelText: title,
            labelStyle: TextStyle(fontFamily: 'Serif', color: AppColor.gray),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColor.gray),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColor.gray),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildTitleAndDropdown(
  String title,
  String? selectedValue,
  Function(String?) onChanged,
  List<String> items, {
  required bool isCategoryDropdown,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontFamily: 'Serif',
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: selectedValue,
          hint: Text(
            title,
            style: TextStyle(
              fontFamily: 'Serif',
              color: Color.fromARGB(255, 147, 146, 146),
            ),
          ),
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Color(0xFFE3E3E3)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Color(0xFFE3E3E3)),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 13),
          ),
          icon: Icon(Icons.keyboard_arrow_down),
          onChanged: onChanged,
          items: [
            ...items.map(
              (value) => DropdownMenuItem(value: value, child: Text(value)),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget buildUploadPhotoBox() {
  return Padding(
    padding: const EdgeInsets.only(top: 12.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Upload a Product Photo',
          style: TextStyle(
            fontFamily: 'Serif',
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 8),
        Container(
          height: 80,
          decoration: BoxDecoration(
            border: Border.all(color: AppColor.gray),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.upload, size: 30, color: Colors.grey),
                Text(
                  'Upload Photo',
                  style: TextStyle(fontFamily: 'Serif', color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildAddButton(
  Color color,
  String title,
  ProductCubit cubit,
  TextEditingController nameController,
  String? selectedCategory,
  String? selectedBranch,
  TextEditingController priceController,
  TextEditingController descriptionController,
) {
  return Padding(
    padding: const EdgeInsets.only(top: 50.0),
    child: SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          cubit.addServiceLocally(
            nameController.text,
            selectedCategory!,
            selectedBranch!,
            priceController.text,
            descriptionController.text,
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: EdgeInsets.symmetric(vertical: 13),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontFamily: 'Serif',
            fontSize: 10,
            color: Colors.white,
          ),
        ),
      ),
    ),
  );
}
