import 'package:deyram_salon/features/home/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:deyram_salon/core/classes/icons_classes.dart';
import 'package:deyram_salon/core/theme/app_color.dart';
import 'package:deyram_salon/features/home/presentation/widget/booking_cancel_section.dart';
import 'package:deyram_salon/features/home/presentation/widget/booking_today_section.dart';
import 'package:deyram_salon/features/home/presentation/widget/order_section.dart';

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Iconarrowleft.arowleft,
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => Home()),
              (route) => false,
            );
          },
        ),
        title: Text(
          'Request',
          style: TextStyle(fontFamily: 'Serif', fontWeight: FontWeight.bold),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppColor.darkpink,
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(width: 3.0, color: AppColor.darkpink),
            insets: EdgeInsets.symmetric(horizontal: 120.0),
          ),
          labelColor: AppColor.darkpink,
          labelStyle: TextStyle(
            fontFamily: 'Serif',
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelStyle: TextStyle(
            fontFamily: 'Serif',
            color: Color(0xffA4A4A4),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          tabs: [
            Tab(text: 'Pending'),
            Tab(text: 'Complete'),
            Tab(text: 'Canceled'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          OrderSection(),
          BookingTodaySection(),
          BookingCancelSection(),
        ],
      ),
    );
  }
}
