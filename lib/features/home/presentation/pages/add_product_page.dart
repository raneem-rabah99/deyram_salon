import 'package:deyram_salon/core/classes/icons_classes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:deyram_salon/core/theme/app_color.dart';
import 'package:deyram_salon/features/home/presentation/manager/product_and_service_state.dart';
import 'package:deyram_salon/features/home/presentation/manager/product_and_service_cubit.dart';

class AddProductPage extends StatefulWidget {
  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String? _selectedCategory;
  String? _selectedBranch;

  @override
  void initState() {
    super.initState();
    final cubit = context.read<ProductCubit>();
    cubit.fetchCategories();
    cubit.fetchBranches();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProductCubit>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Iconarrowleft.arowleft,
          onPressed: () => Navigator.pop(context),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Container(
            color: const Color.fromARGB(255, 176, 176, 176),
            height: 1.0,
          ),
        ),
        title: Text(
          'Add Product',
          style: TextStyle(
            fontFamily: 'Serif',
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildTextFieldWithoutIcon(
              'Product Name',
              'Enter product name',
              _nameController,
            ),
            SizedBox(height: 10),
            Text(
              'Category',
              style: TextStyle(
                fontFamily: 'Serif',
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            BlocBuilder<ProductCubit, ProductState>(
              builder: (context, state) {
                // Debugging: Log the current categories list
                debugPrint("Current categories: ${state.categories}");

                if (state.categories.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                return _buildCategoryDropdown(
                  state.categories,
                  _selectedCategory,
                  (value) {
                    setState(() {
                      _selectedCategory = value; // Update selected category
                    });
                  },
                );
              },
            ),

            SizedBox(height: 10),
            Text(
              'Branches',
              style: TextStyle(
                fontFamily: 'Serif',
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            BlocBuilder<ProductCubit, ProductState>(
              builder: (context, state) {
                if (state.branches.isEmpty) return CircularProgressIndicator();
                return _buildDropdown(state.branches, _selectedBranch, (value) {
                  setState(() => _selectedBranch = value);
                });
              },
            ),
            SizedBox(height: 10),
            buildTextFieldWithoutIcon(
              'Price',
              'Enter price',
              _priceController,
              keyboardType: TextInputType.number,
            ),
            buildTextFieldWithoutIcon(
              'Description',
              'Enter description',
              _descriptionController,
            ),
            SizedBox(height: 10),
            _buildUploadPhotoBox(),
            SizedBox(height: 20),
            buildAddButton(
              context,
              AppColor.darkpink,
              'Add Product',
              cubit,
              _nameController,
              _selectedCategory,
              _selectedBranch,
              _priceController,
              _descriptionController,
            ),
          ],
        ),
      ),
    );
  }

  // Text Field Widget without icon
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
              fontSize: 12,
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
              hintStyle: TextStyle(
                fontFamily: 'Serif',
                color: Color(0xFFE3E3E3),
              ),
              labelStyle: TextStyle(fontFamily: 'Serif', color: AppColor.gray),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColor.gray),
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

  // Build category dropdown with "Add Category" option at the bottom
  Widget _buildCategoryDropdown(
    List<String> categories,
    String? selectedCategory,
    Function(String?) onChanged,
  ) {
    List<String> extendedCategories = List.from(categories);
    extendedCategories.add(
      'Add Category',
    ); // Adding the "Add Category" option inside the list

    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: DropdownButtonFormField<String>(
        value: selectedCategory,
        onChanged: (value) {
          if (value == 'Add Category') {
            showAddCategoryDialog(context);
          } else {
            onChanged(value);
          }
        },
        items:
            extendedCategories.map<DropdownMenuItem<String>>((category) {
              return DropdownMenuItem<String>(
                value: category,
                child:
                    category == 'Add Category'
                        ? Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(
                                category,
                                style: TextStyle(
                                  fontFamily: 'Serif',
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        )
                        : Text(
                          category,
                          style: TextStyle(fontFamily: 'Serif', fontSize: 16),
                        ),
              );
            }).toList(),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Color(0xFFE3E3E3)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Color(0xFFE3E3E3)),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        ),
        icon: Icon(Icons.arrow_drop_down, color: Colors.black),
      ),
    );
  }

  // Function to show the Add Category Dialog
  // Function to show the Add Category Dialog
  void showAddCategoryDialog(BuildContext context) {
    final TextEditingController englishController = TextEditingController();
    final TextEditingController arabicController = TextEditingController();
    final cubit = context.read<ProductCubit>(); // Get the cubit

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            // <-- StatefulBuilder to refresh UI
            return Container(
              height: 300,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Add New Category',
                    style: TextStyle(
                      fontFamily: 'Serif',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: englishController,
                    decoration: InputDecoration(
                      labelText: 'Category in English',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: arabicController,
                    decoration: InputDecoration(
                      labelText: 'Category in Arabic',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () async {
                          final english = englishController.text;
                          final arabic = arabicController.text;

                          if (english.isNotEmpty && arabic.isNotEmpty) {
                            await cubit.addCategoryLocally(english, arabic);

                            setState(() {}); // <-- Force UI update

                            Navigator.pop(context);
                          } else {
                            debugPrint("Both fields are required.");
                          }
                        },
                        child: Text('Add Category'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('Cancel'),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  // Build branches dropdown
  Widget _buildDropdown(
    List<String> items,
    String? selectedValue,
    Function(String?) onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: DropdownButtonFormField<String>(
        value: selectedValue,
        onChanged: onChanged,
        items:
            items
                .map(
                  (item) => DropdownMenuItem(
                    value: item,
                    child: Text(
                      item,
                      style: TextStyle(fontFamily: 'Serif', fontSize: 16),
                    ),
                  ),
                )
                .toList(),
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
        icon: Icon(Icons.arrow_drop_down, color: Colors.black),
      ),
    );
  }

  // Upload photo box
  Widget _buildUploadPhotoBox() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Upload a Product Photo',
          style: TextStyle(
            fontFamily: 'Serif',
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 8),
        Container(
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xFFE3E3E3)),
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.upload, color: Colors.grey),
                Text(
                  'Upload Photo',
                  style: TextStyle(fontFamily: 'Serif', color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// Add product button
Widget buildAddButton(
  BuildContext context,
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
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.darkpink,
          borderRadius: BorderRadius.circular(14),
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 115),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
          onPressed: () {
            if (nameController.text.isNotEmpty &&
                selectedCategory != null &&
                selectedBranch != null &&
                priceController.text.isNotEmpty &&
                descriptionController.text.isNotEmpty) {
              cubit.addProductLocally(
                nameController.text,
                selectedCategory,
                selectedBranch,
                priceController.text,
                descriptionController.text,
              );

              debugPrint("Product added: ${nameController.text}");

              // After adding the product, pop the page and notify that a product was added
              debugPrint("Navigating back with product added.");
              Navigator.pop(context, true);
            } else {
              debugPrint("Please fill all fields before adding.");
            }
          },
          child: Text(
            'Add Product',
            style: TextStyle(
              fontFamily: 'Serif',
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      ),
    ),
  );
}
