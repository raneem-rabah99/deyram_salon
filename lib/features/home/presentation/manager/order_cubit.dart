import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:deyram_salon/features/home/data/models/order_model.dart';

class OrderCubit extends Cubit<List<OrderModel>> {
  OrderCubit() : super([]);

  void fetchBookings() {
    emit([
      OrderModel(
        userName: "Alice Johnson",

        location: "Main Street 45",

        price: 12.3,
      ),
      OrderModel(userName: "John Doe", location: "Main Street 45", price: 20.0),
    ]);
  }

  void Rejected(OrderModel booking) {
    emit(state.where((b) => b != booking).toList());
  }
}
