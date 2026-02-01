import 'package:deyram_salon/features/home/presentation/manager/copoun_cubit.dart';
import 'package:deyram_salon/features/home/presentation/manager/product_and_service_cubit.dart';
import 'package:deyram_salon/features/home/presentation/manager/technical_cubit.dart';
import 'package:deyram_salon/features/home/presentation/pages/coupon_added.dart';
import 'package:deyram_salon/features/home/presentation/pages/myprofile.dart';
import 'package:deyram_salon/features/home/presentation/pages/show_coupon.dart';
import 'package:deyram_salon/features/home/presentation/pages/technical_added.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:deyram_salon/features/home/presentation/manager/celender_cubit.dart';
import 'package:deyram_salon/features/home/presentation/manager/edit_cubit.dart';
import 'package:deyram_salon/features/home/presentation/manager/gallery_cubit.dart';
import 'package:deyram_salon/features/home/presentation/pages/about.dart';
import 'package:deyram_salon/features/home/presentation/pages/celender.dart';
import 'package:deyram_salon/features/home/presentation/pages/edit_profile_page.dart';
import 'package:deyram_salon/features/home/presentation/pages/gallery_page.dart';
import 'package:deyram_salon/features/home/presentation/pages/manage_branchpage.dart';
import 'package:deyram_salon/features/home/presentation/widget/textField_and_dropDown_widget.dart';

class FirstSectionProfilepage extends StatelessWidget {
  const FirstSectionProfilepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 400,
      margin: const EdgeInsets.only(right: 20, left: 20, top: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 216, 216, 216).withOpacity(0.2),
            blurRadius: 6,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, top: 8),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Account',
                style: TextStyle(
                  fontFamily: 'Serif',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 2.0, left: 2, right: 8),
                child: buildNavigationTile(
                  context: context,
                  title: 'Edit Profile',
                  destinationPage: EditPage(), // Destination page
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(top: 2.0, left: 2, right: 8),
                child: buildNavigationTile(
                  context: context,
                  title: 'My Profile',
                  destinationPage: BlocProvider.value(
                    value: context.read<ProductCubit>(),
                    child: ProfilePage(),
                  ), // Destination page
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(top: 2.0, left: 2, right: 8),
                child: buildNavigationTile(
                  context: context,
                  title: 'Manage Branch',
                  destinationPage: ManageBranch(), // Destination page
                ),
              ),

              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(top: 2.0, left: 2, right: 8),
                child: buildNavigationTile(
                  context: context,
                  title: 'Calendar Configuration',
                  destinationPage: BlocProvider.value(
                    value: context.read<CalendarCubit>(),
                    child: CelenderProfile(),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(top: 2.0, left: 2, right: 8),
                child: buildNavigationTile(
                  context: context,
                  title: 'About Profile',
                  destinationPage: BlocProvider.value(
                    value: context.read<TextCubit>(),
                    child: AboutPage(),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(top: 2.0, left: 2, right: 8),
                child: buildNavigationTile(
                  context: context,
                  title: 'Gallery',

                  destinationPage: BlocProvider.value(
                    value: context.read<GalleryCubit>(),
                    child: GalleryPage(),
                  ), // Destination page
                ),
              ),

              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(top: 2.0, left: 2, right: 8),
                child: buildNavigationTile(
                  context: context,
                  title: 'coupon',

                  destinationPage: BlocProvider.value(
                    value: context.read<CouponCubit>(),
                    child: CouponListScreen(),
                  ), // Destination page
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(top: 2.0, left: 2, right: 8),
                child: buildNavigationTile(
                  context: context,
                  title: 'Technical',

                  destinationPage: BlocProvider.value(
                    value: context.read<TechnicialCubit>(),
                    child: TechnicianListScreen(),
                  ), // Destination page
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(top: 2.0, left: 2, right: 8),
                child: buildNavigationTile(
                  context: context,
                  title: 'CouponsScreen',
                  destinationPage: CouponsScreen(), // Destination page
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
