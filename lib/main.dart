import 'package:deyram_salon/features/auth/presentation/widget/country.dart';
import 'package:deyram_salon/features/home/presentation/manager/copoun_cubit.dart';
import 'package:deyram_salon/features/home/presentation/manager/technical_cubit.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:deyram_salon/features/home/presentation/manager/Order_cubit.dart';
import 'package:deyram_salon/features/home/presentation/manager/celender_cubit.dart';
import 'package:deyram_salon/features/home/presentation/manager/edit_cubit.dart';
import 'package:deyram_salon/features/home/presentation/manager/gallery_cubit.dart';
import 'package:deyram_salon/features/home/presentation/manager/header_cubit.dart';
import 'package:deyram_salon/features/home/presentation/manager/loyalt_cubit.dart';
import 'package:deyram_salon/features/home/presentation/manager/product_and_service_cubit.dart';
import 'package:deyram_salon/features/home/presentation/pages/splash_screen.dart';

void main() {
  final Dio dio = Dio();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ProductCubit(dio)),
        BlocProvider(create: (context) => AvailableForWorkCubit()),
        BlocProvider(create: (context) => OrderCubit()),
        BlocProvider(create: (context) => GalleryCubit()),
        BlocProvider(create: (context) => CalendarCubit()),
        BlocProvider(create: (context) => TextCubit()),
        BlocProvider(create: (context) => LoyaltyCubit()),
        BlocProvider(create: (context) => CitiesCubit()),
        BlocProvider(create: (context) => TechnicialCubit()),
        BlocProvider(create: (context) => CouponCubit()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
