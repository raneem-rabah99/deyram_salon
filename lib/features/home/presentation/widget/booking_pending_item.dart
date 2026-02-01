import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:deyram_salon/core/theme/app_assets.dart';
import 'package:deyram_salon/core/theme/app_color.dart';
import 'package:deyram_salon/features/home/data/models/bookingcard_model.dart';
import 'package:deyram_salon/features/home/presentation/manager/bookingcard_cubit.dart';
import 'package:deyram_salon/features/home/presentation/pages/appointment_edit_details.dart';

class BookingPendingItem extends StatefulWidget {
  final BookingCardModel bookingPending;

  const BookingPendingItem({Key? key, required this.bookingPending})
    : super(key: key);

  @override
  _BookingPendingItemState createState() => _BookingPendingItemState();
}

class _BookingPendingItemState extends State<BookingPendingItem> {
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();
  String? imagePath;

  @override
  void initState() {
    super.initState();
    _loadUserImage();
  }

  Future<void> _loadUserImage() async {
    String? storedImagePath = await _secureStorage.read(key: 'image');
    setState(() {
      imagePath = storedImagePath;
    });
    print("Retrieved Booking Image Path: $imagePath");
  }

  @override
  Widget build(BuildContext context) {
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
            padding: const EdgeInsets.all(22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundImage:
                          imagePath != null && File(imagePath!).existsSync()
                              ? FileImage(File(imagePath!))
                              : AssetImage(AppAssets.user) as ImageProvider,
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.bookingPending.userName,
                          style: const TextStyle(
                            fontFamily: 'Serif',
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(Icons.location_on, size: 16),
                            const SizedBox(width: 5),
                            Text(
                              widget.bookingPending.location,
                              style: const TextStyle(
                                fontFamily: 'Serif',
                                fontSize: 12,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '\$${widget.bookingPending.price}',
                          style: TextStyle(
                            fontFamily: 'Serif',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColor.darkpink,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.calendar_today, size: 16),
                    const SizedBox(width: 5),
                    Text("From: ${widget.bookingPending.date}"),
                    const SizedBox(width: 10),
                    Icon(Icons.access_time, size: 16),
                    const SizedBox(width: 5),
                    Text("At: ${widget.bookingPending.time}"),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => AppointmentScreen(),
                          ),
                        );
                      },
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(color: Color(0xffE3E3E3)),
                        ),
                      ),
                      child: const Text(
                        "Edit",
                        style: TextStyle(
                          fontFamily: 'Serif',
                          color: Color(0xff666666),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    TextButton(
                      onPressed: () {
                        context.read<BookingCardCubit>().deleteBooking(
                          widget.bookingPending,
                        );
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
  }
}
