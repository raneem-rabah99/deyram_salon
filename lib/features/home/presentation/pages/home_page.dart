import 'package:deyram_salon/core/theme/app_color.dart';
import 'package:deyram_salon/features/home/presentation/manager/header_cubit.dart';
import 'package:deyram_salon/features/home/presentation/manager/order_cubit.dart';
import 'package:deyram_salon/features/home/presentation/manager/product_and_service_cubit.dart';
import 'package:deyram_salon/features/home/presentation/pages/add_product&service.dart';
import 'package:deyram_salon/features/home/presentation/pages/booking_page.dart';
import 'package:deyram_salon/features/home/presentation/pages/order_page.dart';
import 'package:deyram_salon/features/home/presentation/pages/profile_page.dart';
import 'package:deyram_salon/features/home/presentation/widget/booking_section.dart';
import 'package:deyram_salon/features/home/presentation/widget/dashboard.dart';
import 'package:deyram_salon/features/home/presentation/widget/header_home.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Home> {
  int _selectedIndex = 0;

  static final List<Widget> _pages = <Widget>[
    SingleChildScrollView(
      child: Container(
        color: Color.fromARGB(0, 255, 255, 255),
        child: Column(
          children: [
            Header(),
            const BookingSection(),
            DashboardSection(),

            RatingSection(),
          ],
        ),
      ),
    ),
    BookingPage(),
    BlocProvider(
      create: (context) => ProductCubit(Dio()),
      child: ProductServiceScreen(),
    ),
    BlocProvider(create: (context) => OrderCubit(), child: OrderPage()),
    MyProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AvailableForWorkCubit(),
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F8F8),
        body: _pages[_selectedIndex],
        bottomNavigationBar: SizedBox(
          width: 390,
          height: 100,
          child: BottomNavigationBar(
            backgroundColor: const Color(0xFFFFFFFF),
            type: BottomNavigationBarType.fixed,
            selectedItemColor: AppColor.darkpink,
            unselectedItemColor: Colors.grey,
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            items: [
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/icons/IconHome.png',
                  width: 40,
                  height: 40,
                  color: _selectedIndex == 0 ? AppColor.darkpink : Colors.grey,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/icons/calendar.png',
                  width: 40,
                  height: 40,
                  color: _selectedIndex == 1 ? AppColor.darkpink : Colors.grey,
                ),
                label: 'Bookings',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/icons/add-circle.png',
                  width: 40,
                  height: 40,
                  color: _selectedIndex == 2 ? AppColor.darkpink : Colors.grey,
                ),
                label: 'Add',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/icons/shopping-bag-02.png',
                  width: 40,
                  height: 40,
                  color: _selectedIndex == 3 ? AppColor.darkpink : Colors.grey,
                ),
                label: 'Order',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/icons/user-circle.png',
                  width: 40,
                  height: 40,
                  color: _selectedIndex == 4 ? AppColor.darkpink : Colors.grey,
                ),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
