import 'package:flutter/material.dart';
import 'package:deyram_salon/features/home/presentation/pages/changepassword_profile.dart';
import 'package:deyram_salon/features/home/presentation/widget/textField_and_dropDown_widget.dart';

import '../pages/conformation.dart';

class SecondSectionProfilepage extends StatelessWidget {
  const SecondSectionProfilepage({super.key});

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
                'Setting',
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
                  title: 'Change Password',
                  destinationPage: ChangePasswordProfile(), // Destination page
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(top: 2.0, left: 2, right: 8),
                child: buildNavigationTilewithToggle(
                  context: context,
                  title: 'App Notification',
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(top: 2.0, left: 2, right: 8),
                child: buildNavigationTileRed(
                  context: context,
                  title: 'Log Out',
                  onTap: () => confirmLogout(context), // Destination page
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(top: 2.0, left: 2, right: 8),
                child: buildNavigationTileRed(
                  context: context,
                  title: 'Delete My Account',
                  onTap: () => confirmDelete(context), // Destination page
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildNavigationTile({
    required BuildContext context,
    required String title,
    required Widget destinationPage,
  }) {
    return GestureDetector(
      onTap: () async {
        final result = await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destinationPage),
        );
        if (result == true) {
          setState(() {}); // Refresh profile page to load updated data
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
}

Widget buildNavigationTilewithToggle({
  required BuildContext context,
  required String title,
}) {
  return Container(
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
      ],
    ),
  );
}

Widget buildNavigationTileRed({
  required BuildContext context,
  required String title,
  required VoidCallback onTap, // ✅ Change Widget to VoidCallback
}) {
  return GestureDetector(
    onTap: onTap, // ✅ Directly call the function (no need for async/await)
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xff4E1830)),
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
              color: Colors.red,
            ),
          ),
        ],
      ),
    ),
  );
}
