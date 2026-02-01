import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:latlong2/latlong.dart';
import 'package:deyram_salon/core/theme/app_color.dart';

class AppointmentScreen extends StatelessWidget {
  static const String Imageservice = 'assets/images/serviceImage.png';
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
                        // Use the default image if no custom image exists
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
                                    Imageservice,
                                    width: 75,
                                    height: 55,
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
                                      "1 hr 30 mins",
                                      style: TextStyle(
                                        fontFamily: 'Serif',
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Text(
                              "\$12.3",
                              style: TextStyle(
                                fontFamily: 'Serif',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff952323),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12),
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: AssetImage(Imageservice),
                              radius: 25,
                            ),
                            SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Technical Name",
                                  style: TextStyle(
                                    fontFamily: 'Serif',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "Skin Care Specialist",
                                  style: TextStyle(
                                    fontFamily: 'Serif',
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          print("Edit button clicked");
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => AppointmentScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.darkpink,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 60,
                            vertical: 15,
                          ),
                        ),
                        child: const Text(
                          "Edit",
                          style: TextStyle(
                            fontFamily: 'Serif',
                            color: Color.fromARGB(255, 255, 253, 253),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 10),
                  Column(
                    children: [
                      TextButton(
                        onPressed: () {},

                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: BorderSide(color: Color(0xffE3E3E3)),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 60,
                            vertical: 15,
                          ),
                        ),
                        child: const Text(
                          "Cancel",
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
