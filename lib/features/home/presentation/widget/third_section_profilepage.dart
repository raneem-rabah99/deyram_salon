import 'package:deyram_salon/features/home/presentation/pages/subscribe.dart';
import 'package:deyram_salon/features/home/presentation/widget/faq.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:deyram_salon/features/home/presentation/manager/loyalt_cubit.dart';
import 'package:deyram_salon/features/home/presentation/pages/add_technical.dart';
import 'package:deyram_salon/features/home/presentation/pages/addcopun.dart';
import 'package:deyram_salon/features/home/presentation/pages/layolity_point.dart';
import 'package:deyram_salon/features/home/presentation/pages/privacy_policey.dart';
import 'package:deyram_salon/features/home/presentation/widget/gift_page.dart';
import 'package:deyram_salon/features/home/presentation/widget/textField_and_dropDown_widget.dart';

class ThirdSectionProfilepage extends StatelessWidget {
  const ThirdSectionProfilepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 300,
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
                'More',
                style: TextStyle(
                  fontFamily: 'Serif',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(top: 2.0, left: 2, right: 8),
                child: buildNavigationTile(
                  context: context,
                  title: 'Privacy Policey',
                  destinationPage: PrivacyPolicey(), // Destination page
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(top: 2.0, left: 2, right: 8),
                child: buildNavigationTile(
                  context: context,
                  title: 'FAQ',
                  destinationPage: FAQScreen(), // Destination page
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(top: 2.0, left: 2, right: 8),
                child: buildNavigationTilecontact(
                  context: context,
                  title: 'Contact Us',
                  destinationPage: null, // Destination page
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(top: 2.0, left: 2, right: 8),
                child: buildNavigationTile(
                  context: context,
                  title: 'Loyalty Points',
                  destinationPage: BlocProvider.value(
                    value: context.read<LoyaltyCubit>(),
                    child: LoyaltyPointsPage(),
                  ), // Destination page
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(top: 2.0, left: 2, right: 8),
                child: buildNavigationTilecontact(
                  context: context,
                  title: 'Add Technical',
                  destinationPage: AddTechnicaPage(), // Destination page
                ),
              ),
              SizedBox(height: 10),

              Padding(
                padding: const EdgeInsets.only(top: 2.0, left: 2, right: 8),
                child: buildNavigationTilecontact(
                  context: context,
                  title: 'Add Coupon',
                  destinationPage: AddCouponScreen(), // Destination page
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(top: 2.0, left: 2, right: 8),
                child: buildNavigationTilecontact(
                  context: context,
                  title: 'Gift',
                  destinationPage: GiftForFriendScreen(), // Destination page
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(top: 2.0, left: 2, right: 8),
                child: buildNavigationTilecontact(
                  context: context,
                  title: 'Subscription features',
                  destinationPage: SubscriptionPage(), // Destination page
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void showContactUsDialog(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return Container(
        height: 400,
        width: double.infinity, // Full width
        child: Container(
          margin: EdgeInsets.only(top: 40), // Space for the circle
          padding: EdgeInsets.all(20),
          width: double.infinity, // Ensure full width
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30), // Space for the circle
              Text(
                "Contact Us",
                style: TextStyle(
                  fontFamily: 'Serif',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text("Message:"),
              SizedBox(height: 20),
              Container(
                height: 80, // Controls the height of the box
                child: TextField(
                  maxLines: 3,
                  style: TextStyle(
                    fontSize: 10, // 👈 Controls the actual input text size
                  ),
                  decoration: InputDecoration(
                    hintText: 'Tell Us Your Message Here',
                    hintStyle: TextStyle(
                      fontSize: 10, // 👈 Controls the hint text size
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey.shade400),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 5),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Close"),
              ),
            ],
          ),
        ),
      );
    },
  );
}

// Modify Only Contact Us Tile

Widget buildNavigationTilecontact({
  required BuildContext context,
  required String title,
  required Widget? destinationPage,
}) {
  return GestureDetector(
    onTap: () {
      if (title == 'Contact Us') {
        showContactUsDialog(context); // Open Dialog Instead
      } else if (destinationPage != null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destinationPage),
        );
      }
    },

    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontFamily: 'Serif',
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey),
        ],
      ),
    ),
  );
}
