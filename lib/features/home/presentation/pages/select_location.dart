import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class SelectLocation extends StatelessWidget {
  const SelectLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Location"),
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
            child: buildButtonProfile("Confirm Location"),
          ),
        ],
      ),
    );
  }

  Widget buildButtonProfile(String text) {
    return Padding(
      padding: EdgeInsets.only(top: 16, left: 30, right: 30),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xffA64D79),
          borderRadius: BorderRadius.circular(14),
        ),
        child: ElevatedButton(
          onPressed: () {}, // Add action
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
              color: Colors.white,
              fontSize: 16,
              fontFamily: 'Serif',
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
