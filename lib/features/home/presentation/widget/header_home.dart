import 'package:deyram_salon/features/home/presentation/widget/notification.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:deyram_salon/core/classes/icons_classes.dart';
import 'package:deyram_salon/core/theme/app_color.dart';
import 'package:deyram_salon/features/home/presentation/manager/header_cubit.dart';

class Header extends StatelessWidget {
  Header({super.key});
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Top section with gray background
        Container(
          color: Color.fromARGB(255, 224, 224, 224), // Background color
          padding: const EdgeInsets.only(
            top: 30.0,
            left: 20,
            right: 20,
            bottom: 5,
          ),

          child: Row(
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
                    children: [
                      CircleAvatar(radius: 20, backgroundImage: imageProvider),
                      SizedBox(width: 10),
                      Text(
                        username ?? 'User Name',
                        style: TextStyle(
                          fontFamily: 'Serif',
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  );
                },
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Text(
                          "Your Location",
                          style: TextStyle(
                            fontFamily: 'Serif',
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "Location Name",
                            style: TextStyle(fontFamily: 'Serif', fontSize: 12),
                          ),
                          Iconarowdown.arowdown,
                        ],
                      ),
                    ],
                  ),
                  SizedBox(width: 10),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.notifications_none_outlined, size: 30),
                        onPressed: () {
                          // Navigate to the new page when the bell icon is clicked
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NotificationScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),

        // Available for work section
        Padding(
          padding: const EdgeInsets.only(top: 20.0, left: 20),
          child: Row(
            children: [
              BlocBuilder<AvailableForWorkCubit, bool>(
                builder: (context, isAvailable) {
                  return Text(
                    "Available for Work",
                    style: TextStyle(
                      fontFamily: 'Serif',
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color:
                          isAvailable ? AppColor.darkpink : Color(0xFFD9D9D9),
                    ),
                  );
                },
              ),
              SizedBox(width: 10),

              BlocBuilder<AvailableForWorkCubit, bool>(
                builder: (context, isAvailable) {
                  return GestureDetector(
                    onTap: () {
                      context
                          .read<AvailableForWorkCubit>()
                          .toggleAvailability();
                    },
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 100),
                      height: 21,
                      width: 40,
                      decoration: BoxDecoration(
                        color:
                            isAvailable ? AppColor.darkpink : Color(0xFFD9D9D9),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Align(
                        alignment:
                            isAvailable
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                        child: Container(
                          margin: EdgeInsets.all(0.5),
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        SizedBox(height: 15),
      ],
    );
  }

  Future<Map<String, String?>> _getUserData() async {
    String? username = await _secureStorage.read(key: 'username');
    String? imagePath = await _secureStorage.read(key: 'image');
    return {'username': username, 'image': imagePath};
  }
}
