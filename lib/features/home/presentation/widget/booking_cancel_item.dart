import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:deyram_salon/core/theme/app_assets.dart';
import 'package:deyram_salon/core/theme/app_color.dart';
import 'package:deyram_salon/features/home/data/models/bookingcard_model.dart';

class BookingCancelItem extends StatelessWidget {
  final BookingCardModel bookingCancel;
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  BookingCancelItem({Key? key, required this.bookingCancel}) : super(key: key);

  Future<String?> _getUserImage() async {
    return await _secureStorage.read(key: 'image');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: _getUserImage(),
      builder: (context, snapshot) {
        String? imagePath = snapshot.data;
        String defaultImagePath = AppAssets.user;

        ImageProvider? imageProvider;
        if (imagePath != null && File(imagePath).existsSync()) {
          if (kIsWeb) {
            imageProvider = NetworkImage(imagePath);
          } else {
            imageProvider = FileImage(File(imagePath));
          }
        } else {
          imageProvider = AssetImage(defaultImagePath);
        }

        return Container(
          width: 800,
          margin: const EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 6,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                child: Container(
                  width: 10,
                  decoration: BoxDecoration(
                    color: AppColor.darkpink,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomLeft: Radius.circular(12),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 24,
                          backgroundImage: imageProvider,
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              bookingCancel.userName,
                              style: const TextStyle(
                                fontFamily: 'Serif',
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              bookingCancel.location,
                              style: const TextStyle(
                                fontFamily: 'Serif',
                                fontSize: 12,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Text(
                          '\$${bookingCancel.price}',
                          style: TextStyle(
                            fontFamily: 'Serif',
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                            color: AppColor.darkpink,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.calendar_today, size: 10),
                        const SizedBox(width: 5),
                        Text(
                          "From: ${bookingCancel.date}",
                          style: TextStyle(
                            fontFamily: 'Serif',
                            fontSize: 10,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Icon(Icons.access_time, size: 10),
                        const SizedBox(width: 5),
                        Text(
                          "At: ${bookingCancel.time}",
                          style: TextStyle(
                            fontFamily: 'Serif',
                            fontSize: 10,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(width: 25),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 3,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color:
                                bookingCancel.isInHome
                                    ? Color(0xFFFD9D9D9)
                                    : Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            bookingCancel.isInHome
                                ? "• In Home"
                                : "• In Clinic",
                            style: TextStyle(
                              fontFamily: 'Serif',
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color:
                                  bookingCancel.isInHome
                                      ? AppColor.darkpink
                                      : Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Reason of Cancellation",
                          style: TextStyle(
                            fontFamily: 'Serif',
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.red.shade700,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            "Change My Mind",
                            style: TextStyle(
                              fontFamily: 'Serif',
                              color: Color.fromARGB(255, 74, 72, 72),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
