import 'package:deyram_salon/core/classes/icons_classes.dart';
import 'package:deyram_salon/core/theme/app_color.dart';
import 'package:deyram_salon/features/home/data/models/booking_model.dart';
import 'package:deyram_salon/features/home/presentation/manager/booking_cubit.dart';
import 'package:deyram_salon/features/home/presentation/pages/seeall_ClientAppointment.dart';
import 'package:deyram_salon/features/home/presentation/widget/booking_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookingSection extends StatelessWidget {
  const BookingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BookingCubit()..fetchBookings(),
      child: BlocBuilder<BookingCubit, List<BookingModel>>(
        builder: (context, bookings) {
          if (bookings.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Client Appointment",
                      style: TextStyle(
                        fontFamily: 'Serif',
                        fontSize: 22,
                        color: AppColor.darkpink,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (_) => BlocProvider.value(
                                  value: BlocProvider.of<BookingCubit>(context),
                                  child: ClientAppointment(),
                                ),
                          ),
                        );
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min, // لتجنب أخذ كامل العرض
                        children: [
                          const Text(
                            "See All",
                            style: TextStyle(
                              fontFamily: 'Serif',
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black54,
                            ),
                          ),
                          const SizedBox(
                            width: 6,
                          ), // مسافة صغيرة بين النص والأيقونة
                          Iconarowupp.arowupp,
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              SizedBox(
                height: 230,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.only(left: 15.0),
                  itemCount: bookings.length,
                  itemBuilder: (context, index) {
                    return BookingItem(booking: bookings[index]);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
