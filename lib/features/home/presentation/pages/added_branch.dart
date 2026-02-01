import 'package:deyram_salon/features/auth/presentation/widget/country.dart';
import 'package:deyram_salon/features/home/presentation/pages/edit_manage.dart';
import 'package:deyram_salon/features/home/presentation/pages/select_location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class AddManage extends StatefulWidget {
  final Function(String, String, String) onBranchAdded;
  AddManage({super.key, required this.onBranchAdded});

  @override
  State<AddManage> createState() => _AddManageState();
}

class _AddManageState extends State<AddManage> {
  final TextEditingController branchController = TextEditingController();
  final TextEditingController adressController = TextEditingController();
  String? selectedCity;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Branch"),
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
                    setState(() {
                      selectedCity = city; // Update the selectedCity state
                    });
                  },
                  isCitySelector: true,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Area and Street",
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
                    print('Selected Area and Street: $city');
                  },
                  isCitySelector: true,
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: FlutterMap(
                    options: MapOptions(
                      initialCenter: LatLng(
                        25.276987,
                        55.296249,
                      ), // Example: Dubai
                      initialZoom: 13.0,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                        subdomains: ['a', 'b', 'c'],
                      ),
                      MarkerLayer(
                        markers: [
                          Marker(
                            point: LatLng(25.276987, 55.296249),
                            width: 50,
                            height: 50,
                            child: Icon(
                              Icons.location_pin,
                              color: Colors.red,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 2),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => SelectLocation(),
                        ), // Navigate to EditManage
                      );
                    },
                    child: Text('Select the location on the map'),
                  ),
                  SizedBox(height: 100),
                  buildButtonProfile2("Add"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildButtonProfile2(String text) {
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
              String branchName = branchController.text.trim();
              String address = adressController.text.trim();
              String city = selectedCity ?? ''; // Use the updated selectedCity

              // Add the new branch data locally by calling the function
              widget.onBranchAdded(branchName, address, city);

              // Pop the screen after adding the branch
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    "Branch added successfully!",
                    style: TextStyle(fontFamily: 'Serif'),
                  ),
                ),
              );
            }
          },
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
}
