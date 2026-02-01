import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:deyram_salon/features/home/data/models/bookingcard_model.dart';

class BookingCardCubit extends Cubit<List<BookingCardModel>> {
  BookingCardCubit() : super([]);

  void fetchBookings() {
    emit([
      BookingCardModel(
        userName: "Alice Johnson",

        location: "Main Street 45",
        date: "30 - 7 - 2024",
        time: "08:30 AM",
        price: 12.3,
        isInHome: true,
      ),
      BookingCardModel(
        userName: "John Doe",

        location: "Main Street 45",
        date: "31 - 7 - 2024",
        time: "10:00 AM",
        price: 20.0,
        isInHome: false,
      ),
    ]);
  }

  void deleteBooking(BookingCardModel booking) {
    emit(state.where((b) => b != booking).toList());
  }
}
