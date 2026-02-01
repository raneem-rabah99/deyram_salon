import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:latlong2/latlong.dart';
import 'package:deyram_salon/core/theme/app_color.dart';
import 'package:deyram_salon/features/home/data/models/order_model.dart';
import 'package:deyram_salon/features/home/presentation/manager/Order_cubit.dart';

class AppointmentCompleteScreen extends StatelessWidget {
  late final OrderModel order;
  static const String Imageproduct = 'assets/images/Maskpink1.png';
  static const String user = 'assets/images/user1.png';
  final String country = "United Arab Emirates";
  final String city = "Dubai";
  final int street = 13;
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Appointment Details"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Color(0xffF1F1F1),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Order ID #46501",
                style: TextStyle(
                  fontFamily: 'Serif',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                "Nov 16, 2024",
                style: TextStyle(fontFamily: 'Serif', color: Colors.grey),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FutureBuilder<Map<String, String?>>(
                    future: _getUserData(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      }

                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }

                      final userData = snapshot.data;
                      final username = userData?['username'];
                      final imagePath = userData?['image'];

                      String defaultImagePath = 'assets/images/deram 1.png';

                      ImageProvider? imageProvider;
                      if (imagePath != null && File(imagePath).existsSync()) {
                        if (kIsWeb) {
                          imageProvider = NetworkImage(imagePath);
                        } else {
                          imageProvider =
                              FileImage(File(imagePath)) as ImageProvider;
                        }
                      } else {
                        imageProvider = AssetImage(defaultImagePath);
                      }

                      return Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundImage: imageProvider,
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                username ?? 'User Name',
                                style: TextStyle(
                                  fontFamily: 'Serif',
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),

                              Text(
                                "1 hr 30 mins",
                                style: TextStyle(
                                  fontFamily: 'Serif',
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Location Info Section with hardcoded values
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Country
                      Text(
                        'Country: $country',
                        style: TextStyle(
                          fontFamily: 'Serif',
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 3), // Space between items
                      // City
                      Text(
                        'City: $city',
                        style: TextStyle(
                          fontFamily: 'Serif',
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 3), // Space between items
                      // Street
                      Text(
                        'Street: $street',
                        style: TextStyle(
                          fontFamily: 'Serif',
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10),
              Container(
                height: 200,
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
              SizedBox(height: 16),
              Text(
                "SERVICES DETAILS",
                style: TextStyle(
                  fontFamily: 'Serif',
                  fontWeight: FontWeight.bold,
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 2,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.asset(
                                    Imageproduct,
                                    width: 120,
                                    height: 70,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Party Makeup",
                                      style: TextStyle(
                                        fontFamily: 'Serif',
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "\$12.3",
                                      style: TextStyle(
                                        fontFamily: 'Serif',
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 12),
                      ],
                    ),
                  );
                },
              ),
              Divider(),
              ListTile(title: Text("Services Price"), trailing: Text("\$36.9")),
              ListTile(title: Text("Delivery Price"), trailing: Text("\$3")),
              ListTile(title: Text("Tax"), trailing: Text("\$1.3")),
              Divider(),
              ListTile(
                title: Text(
                  "Total",
                  style: TextStyle(
                    fontFamily: 'Serif',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Text(
                  "\$39.9",
                  style: TextStyle(
                    fontFamily: 'Serif',
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          print("Edit button clicked");
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => AppointmentCompleteScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.darkpink,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 15,
                          ),
                        ),
                        child: const Text(
                          "Completed",
                          style: TextStyle(
                            fontFamily: 'Serif',
                            color: Color.fromARGB(255, 255, 253, 253),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 20),
                  Column(
                    children: [
                      TextButton(
                        onPressed: () {
                          context.read<OrderCubit>().Rejected(order);
                        },

                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: BorderSide(color: Color(0xffE3E3E3)),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 15,
                          ),
                        ),
                        child: const Text(
                          "Rejected",
                          style: TextStyle(
                            fontFamily: 'Serif',
                            color: Color(0xff666666),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<Map<String, String?>> _getUserData() async {
    String? username = await _secureStorage.read(key: 'username');
    String? imagePath = await _secureStorage.read(key: 'image');
    return {'username': username, 'image': imagePath};
  }
}
