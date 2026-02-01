import 'package:deyram_salon/core/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:deyram_salon/features/home/presentation/manager/copoun_cubit.dart';
import 'package:deyram_salon/features/home/presentation/manager/copoun_state.dart';

class CouponListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Coupons',
          style: TextStyle(fontFamily: 'Serif', color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: AppColor.lightpink,
        elevation: 2,
        centerTitle: true,
      ),
      body: BlocBuilder<CouponCubit, CouponState>(
        builder: (context, state) {
          if (state.coupons.isEmpty) {
            return Center(child: Text('No Coupons Added'));
          }

          return ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: state.coupons.length,
            itemBuilder: (context, index) {
              final coupon = state.coupons[index];
              return Card(
                elevation: 4,
                margin: EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.all(12),
                  title: Text(
                    coupon.code,
                    style: TextStyle(
                      fontFamily: 'Serif',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    'Discount: ${coupon.discount}%',
                    style: TextStyle(
                      fontFamily: 'Serif',
                      color: Colors.grey[600],
                    ),
                  ),
                  trailing: Text(
                    coupon.category,
                    style: TextStyle(
                      fontFamily: 'Serif',
                      fontWeight: FontWeight.bold,
                      color: AppColor.darkpink,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
