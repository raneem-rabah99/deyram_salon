import 'package:deyram_salon/features/home/presentation/manager/bookingcard_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:deyram_salon/core/classes/icons_classes.dart';
import 'package:deyram_salon/core/theme/app_assets.dart';
import 'package:deyram_salon/core/theme/app_color.dart';
import 'package:deyram_salon/features/home/data/models/bookingcard_model.dart';

class BookingTodayItem extends StatefulWidget {
  final BookingCardModel bookingToday;

  const BookingTodayItem({Key? key, required this.bookingToday})
    : super(key: key);

  @override
  _BookingTodayItemState createState() => _BookingTodayItemState();
}

class _BookingTodayItemState extends State<BookingTodayItem> {
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
    print("Retrieved Today's Booking Image Path: $imagePath");
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
            padding: const EdgeInsets.only(left: 22, right: 10, bottom: 8),
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
                    const SizedBox(width: 6),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.bookingToday.userName,
                          style: const TextStyle(
                            fontFamily: 'Serif',
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        Row(
                          children: [
                            Iconlocation.location,
                            const SizedBox(width: 5),
                            Text(
                              widget.bookingToday.location,
                              style: const TextStyle(
                                fontFamily: 'Serif',
                                fontSize: 12,
                                color: Colors.black,
                                decoration: TextDecoration.underline,
                                decorationThickness: 2.0,
                                decorationStyle: TextDecorationStyle.solid,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Text(
                              '\$${widget.bookingToday.price}',
                              style: TextStyle(
                                fontFamily: 'Serif',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColor.darkpink,
                              ),
                            ),
                            PopupMenuButton<String>(
                              onSelected: (String result) {
                                if (result == 'edit') {
                                  print("Edit clicked");
                                } else if (result == 'delete') {
                                  print("Delete clicked");
                                  context
                                      .read<BookingCardCubit>()
                                      .deleteBooking(widget.bookingToday);
                                }
                              },
                              itemBuilder: (BuildContext context) {
                                return [
                                  PopupMenuItem<String>(
                                    value: 'edit',
                                    child: ListTile(
                                      leading: Iconedit.edit,
                                      title: Text('Edit'),
                                    ),
                                  ),
                                  PopupMenuItem<String>(
                                    value: 'delete',
                                    child: ListTile(
                                      leading: Iconedelete.delete,

                                      title: Text('Delete'),
                                    ),
                                  ),
                                ];
                              },
                              icon: const Icon(
                                Icons.more_horiz,
                                size: 24,
                                color: Color(0xffD2D2D2),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color:
                                widget.bookingToday.isInHome
                                    ? Color(0xFFFD9D9D9)
                                    : Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            widget.bookingToday.isInHome
                                ? "Ongoing On Time"
                                : "Ongoing Late",
                            style: TextStyle(
                              fontFamily: 'Serif',
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color:
                                  widget.bookingToday.isInHome
                                      ? AppColor.darkpink
                                      : AppColor.darkpink,
                            ),
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
                    Iconecelender.celender,
                    const SizedBox(width: 5),
                    Text(
                      "From: ${widget.bookingToday.date}",
                      style: TextStyle(
                        fontFamily: 'Serif',
                        fontSize: 10,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Iconclock.clock,
                    const SizedBox(width: 5),
                    Text(
                      "At: ${widget.bookingToday.time}",
                      style: TextStyle(
                        fontFamily: 'Serif',
                        fontSize: 10,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color:
                            widget.bookingToday.isInHome
                                ? Color(0xFFFD9D9D9)
                                : Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        widget.bookingToday.isInHome
                            ? "• In Home"
                            : "• In Clinic",
                        style: TextStyle(
                          fontFamily: 'Serif',
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color:
                              widget.bookingToday.isInHome
                                  ? AppColor.darkpink
                                  : AppColor.darkpink,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextButton(
                        onPressed: () {
                          print("Client not coming button clicked");
                        },
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: BorderSide(color: Color(0xffE3E3E3)),
                          ),
                        ),
                        child: const Text(
                          "Client not coming",
                          style: TextStyle(
                            fontFamily: 'Serif',
                            color: Color(0xff666666),
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    TextButton(
                      onPressed: () {
                        print("On the way button clicked");
                      },
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(color: Color(0xffE3E3E3)),
                        ),
                      ),
                      child: const Text(
                        "On the way",
                        style: TextStyle(
                          fontFamily: 'Serif',
                          color: Color(0xff666666),
                          fontSize: 10,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    TextButton(
                      onPressed: () {
                        print("Done button clicked");
                      },
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(color: Color(0xffE3E3E3)),
                        ),
                      ),
                      child: const Text(
                        "Done",
                        style: TextStyle(
                          fontFamily: 'Serif',
                          color: Color(0xff666666),
                          fontSize: 10,
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
