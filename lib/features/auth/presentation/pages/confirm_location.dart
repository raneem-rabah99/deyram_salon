import 'package:deyram_salon/core/theme/app_color.dart';
import 'package:deyram_salon/features/auth/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class ConfirmLocation extends StatelessWidget {
  const ConfirmLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Location", style: TextStyle(fontFamily: 'Serif')),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Container(
            color: const Color.fromARGB(
              255,
              176,
              176,
              176,
            ), // Change color as needed
            height: 1.0,
          ),
        ),
      ),
      body: Stack(
        children: [
          /// Fullscreen Map
          Positioned.fill(
            child: FlutterMap(
              options: MapOptions(
                initialCenter: LatLng(25.276987, 55.296249), // Example: Dubai
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

          /// Floating Button at Bottom
          Positioned(
            bottom: 30,
            left: 30,
            right: 30,
            child: buildButtonProfile("Confirm Location", context),
          ),
        ],
      ),
    );
  }

  Widget buildButtonProfile(String text, BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 16, left: 15, right: 15),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColor.darkpink, AppColor.lightpink],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Login()),
            );
          }, // Add action
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 15),
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
