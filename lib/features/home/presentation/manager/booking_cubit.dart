//import 'package:deyram_salon/features/home/data/models/booking_model.dart';
import 'package:deyram_salon/features/home/data/models/booking_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookingCubit extends Cubit<List<BookingModel>> {
  BookingCubit() : super([]);

  void fetchBookings() {
    emit([
      BookingModel(
        userName: "Alice Johnson",
        providerName: "Dr. Smith",
        location: "Location Name - Street 23",
        date: "30 - 7 - 2024",
        time: "08:30 AM",
        price: 12.3,
        isInHome: true,
      ),
      BookingModel(
        userName: "John Doe",
        providerName: "Dr. Brown",
        location: "Main Street 45",
        date: "31 - 7 - 2024",
        time: "10:00 AM",
        price: 20.0,
        isInHome: false,
      ),
    ]);
  }

  void deleteBooking(BookingModel booking) {
    emit(state.where((b) => b != booking).toList());
  }
}
