import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:deyram_salon/core/theme/app_assets.dart';
import 'package:deyram_salon/core/theme/app_color.dart';
import 'package:deyram_salon/features/home/data/models/booking_model.dart';
import 'package:deyram_salon/features/home/presentation/manager/booking_cubit.dart';
import 'package:deyram_salon/features/home/presentation/pages/appointment_edit_details.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookingItem extends StatelessWidget {
  final BookingModel booking;
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  BookingItem({Key? key, required this.booking}) : super(key: key);

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
          imageProvider =
              kIsWeb ? NetworkImage(imagePath) : FileImage(File(imagePath));
        } else {
          imageProvider = AssetImage(defaultImagePath);
        }

        return Container(
          width: 320,

          margin: const EdgeInsets.only(right: 12, top: 10),
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
                  width: 16,
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
                padding: const EdgeInsets.only(left: 22, right: 22, top: 8),
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
                              booking.userName,
                              style: const TextStyle(
                                fontFamily: 'Serif',
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              "1 hr 30 mins",
                              style: TextStyle(
                                fontFamily: 'Serif',
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '\$${booking.price}',
                              style: TextStyle(
                                fontFamily: 'Serif',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColor.darkpink,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color:
                                    booking.isInHome
                                        ? Color(0xFFFD9D9D9)
                                        : Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                booking.isInHome ? "• In Home" : "• In Clinic",
                                style: TextStyle(
                                  fontFamily: 'Serif',
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      booking.isInHome
                                          ? AppColor.darkpink
                                          : Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      booking.providerName,
                      style: const TextStyle(
                        fontFamily: 'Serif',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Icon(Icons.location_on, size: 16),
                        const SizedBox(width: 5),
                        Text(
                          booking.location,
                          style: const TextStyle(
                            fontFamily: 'Serif',
                            fontSize: 12,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Icon(Icons.calendar_today, size: 10),
                        const SizedBox(width: 5),
                        Text(
                          "From: ${booking.date}",
                          style: const TextStyle(
                            fontFamily: 'Serif',
                            fontSize: 10,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Icon(Icons.access_time, size: 10),
                        const SizedBox(width: 5),
                        Text(
                          "At: ${booking.time}",
                          style: const TextStyle(
                            fontFamily: 'Serif',
                            fontSize: 10,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
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
                          ),
                          child: const Text(
                            "Edit",
                            style: TextStyle(
                              fontFamily: 'Serif',
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        TextButton(
                          onPressed: () {
                            context.read<BookingCubit>().deleteBooking(booking);
                          },
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: BorderSide(color: Color(0xffE3E3E3)),
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
              ),
            ],
          ),
        );
      },
    );
  }
}
