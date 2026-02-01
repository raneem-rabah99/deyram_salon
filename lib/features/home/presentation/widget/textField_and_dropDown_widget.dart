import 'package:flutter/material.dart';
import 'package:deyram_salon/core/theme/app_color.dart';
import 'package:deyram_salon/features/home/presentation/manager/product_and_service_cubit.dart';

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
          style: TextStyle(fontFamily: 'Serif', color: AppColor.gray),
          decoration: InputDecoration(
            labelText: title,
            labelStyle: TextStyle(fontFamily: 'Serif', color: AppColor.gray),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColor.gray, width: 2),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColor.gray, width: 2),
            ),
          ),
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
            border: Border.all(
              color: AppColor.gray, // Gray border for the whole container
              width: 2.0, // Border width
            ),
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
          cubit.addProductLocally(
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

Widget buildCityDropdown(
  String title,
  List<String> items,
  String? selectedValue,
  Function(String?) onChanged,
) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 4.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Text(
          title,
          style: const TextStyle(
            fontFamily: 'Serif',
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),

        // Custom Dropdown UI
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColor.gray, // Gray border for the whole container
              width: 2.0, // Border width
            ),
            borderRadius: BorderRadius.circular(8), // Rounded corners
          ),
          child: Row(
            children: [
              // Location Icon + Selected Value (on the left side)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedValue,
                      hint: Row(
                        children: [
                          const Icon(Icons.location_on, color: Colors.grey),
                          const SizedBox(width: 8),
                          Text(
                            selectedValue ?? "Select City", // Default hint text
                            style: TextStyle(
                              fontFamily: 'Serif',
                              color:
                                  Colors
                                      .grey, // Apply gray color to hint and selected value
                            ),
                          ),
                        ],
                      ),
                      isExpanded: true,
                      onChanged: (String? newValue) {
                        onChanged(
                          newValue,
                        ); // Update the selected value when clicked
                      },
                      items:
                          items.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(
                                  fontFamily: 'Serif',
                                  color: Colors.black, // Items text in black
                                ),
                              ),
                            );
                          }).toList(),
                      // Placing the icon on the right inside the DropdownButton
                      icon: Container(
                        decoration: BoxDecoration(
                          color:
                              AppColor
                                  .gray, // Background color for the icon button
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 12,
                        ),
                        child: const Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.black, // Arrow icon color
                        ),
                      ),
                    ),
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

Widget icondropdown() {
  return Container(
    decoration: BoxDecoration(
      color: AppColor.gray, // Background color for the icon button
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(8),
        bottomRight: Radius.circular(8),
      ),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    child: const Icon(
      Icons.keyboard_arrow_down,
      color: Colors.black, // Arrow icon color
    ),
  );
}

Widget buildNavigationTile({
  required BuildContext context,
  required String title,
  required Widget destinationPage,
}) {
  return GestureDetector(
    onTap: () async {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => destinationPage),
      );
      if (result == true) {
        setState(() {}); // Refresh profile page to load updated data
      }
    },

    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontFamily: 'Serif',
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey),
        ],
      ),
    ),
  );
}

void setState(Null Function() param0) {}
