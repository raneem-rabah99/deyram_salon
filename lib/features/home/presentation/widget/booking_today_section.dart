import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:deyram_salon/features/home/data/models/bookingcard_model.dart';
import 'package:deyram_salon/features/home/presentation/manager/bookingcard_cubit.dart';
import 'package:deyram_salon/features/home/presentation/widget/booking_today_item.dart';

class BookingTodaySection extends StatelessWidget {
  const BookingTodaySection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BookingCardCubit()..fetchBookings(),
      child: BlocBuilder<BookingCardCubit, List<BookingCardModel>>(
        builder: (context, bookings) {
          if (bookings.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              height: 230,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                padding: const EdgeInsets.only(left: 15.0),
                itemCount: bookings.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: BookingTodayItem(bookingToday: bookings[index]),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
