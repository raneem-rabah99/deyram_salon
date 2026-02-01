import 'package:deyram_salon/features/home/data/models/booking_model.dart';
import 'package:deyram_salon/features/home/presentation/manager/booking_cubit.dart';
import 'package:deyram_salon/features/home/presentation/widget/booking_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClientAppointment extends StatelessWidget {
  const ClientAppointment({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BookingCubit()..fetchBookings(),
      child: BlocBuilder<BookingCubit, List<BookingModel>>(
        builder: (context, bookings) {
          if (bookings.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                "Client Appointment",
                style: TextStyle(fontFamily: 'Serif'),
              ),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),

                SizedBox(
                  height: 530,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    padding: const EdgeInsets.only(left: 15.0),
                    itemCount: bookings.length,
                    itemBuilder: (context, index) {
                      return BookingItem(booking: bookings[index]);
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
