import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:deyram_salon/features/home/data/models/order_model.dart';
import 'package:deyram_salon/features/home/presentation/manager/Order_cubit.dart';
import 'package:deyram_salon/features/home/presentation/widget/order_item.dart';

class OrderSection extends StatelessWidget {
  const OrderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrderCubit()..fetchBookings(),
      child: BlocBuilder<OrderCubit, List<OrderModel>>(
        builder: (context, orders) {
          if (orders.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              height: 230,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                padding: const EdgeInsets.only(left: 15.0),
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: OrderItem(order: orders[index]),
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
