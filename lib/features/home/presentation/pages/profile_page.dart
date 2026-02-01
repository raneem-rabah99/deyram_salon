import 'package:deyram_salon/features/home/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:deyram_salon/core/classes/icons_classes.dart';
import 'package:deyram_salon/features/home/presentation/widget/first_section_profilepage.dart';
import 'package:deyram_salon/features/home/presentation/widget/second_section_profilepage.dart';
import 'package:deyram_salon/features/home/presentation/widget/third_section_profilepage.dart';

class MyProfilePage extends StatelessWidget {
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Iconarrowleft.arowleft,
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => Home()),
              (route) => false,
            );
          },
        ),
        title: Text(
          'My Profile',
          style: TextStyle(fontFamily: 'Serif', fontWeight: FontWeight.bold),
        ),

        backgroundColor: Color.fromARGB(0, 184, 183, 183),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Center(
                    child: FutureBuilder<Map<String, String?>>(
                      future: _getUserData(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        }

                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        }
                        /*                        final userData = snapshot.data;
                        final username = userData?['username'];
                        final imagePath = userData?['image'];

                        ImageProvider? imageProvider;
                        if (imagePath != null) {
                          if (kIsWeb) {
                            imageProvider = NetworkImage(imagePath);
                          } else if (File(imagePath).existsSync()) {
                            imageProvider =
                                FileImage(File(imagePath)) as ImageProvider;
                          }
                        }
*/

                        final userData = snapshot.data;
                        final username = userData?['username'];
                        final imagePath = userData?['image'];

                        // Set a default image path
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
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 27,
                              backgroundImage: imageProvider,
                            ),
                            SizedBox(height: 10),
                            Container(
                              width: 89,
                              height: 25,
                              margin: EdgeInsets.only(top: 5.5, left: 5.5),
                              child: Text(
                                username ?? 'No username set',
                                style: TextStyle(
                                  fontFamily: 'Serif',
                                  fontSize: 19,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                FirstSectionProfilepage(),
                SizedBox(width: 20),
                SecondSectionProfilepage(),
                SizedBox(width: 20),
                ThirdSectionProfilepage(),
              ],
            ),
          ],
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
