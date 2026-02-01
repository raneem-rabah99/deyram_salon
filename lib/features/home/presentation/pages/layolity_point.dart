import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:deyram_salon/core/theme/app_color.dart';
import 'package:deyram_salon/features/home/presentation/manager/loyalt_cubit.dart';

class LoyaltyPointsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoyaltyCubit(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            'Loyalty Points',
            style: TextStyle(fontFamily: 'Serif', color: Colors.black),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              BlocBuilder<LoyaltyCubit, LoyaltyState>(
                builder:
                    (context, state) => buildCard(
                      'Cache',
                      'How much is it in dirhams?',
                      state.cache,
                      (value) =>
                          context.read<LoyaltyCubit>().updateCache(value),
                    ),
              ),
              SizedBox(height: 12),
              BlocBuilder<LoyaltyCubit, LoyaltyState>(
                builder:
                    (context, state) => buildCard(
                      'Points',
                      'How many points is it worth?',
                      state.points,
                      (value) =>
                          context.read<LoyaltyCubit>().updatePoints(value),
                    ),
              ),
              SizedBox(height: 12),
              BlocBuilder<LoyaltyCubit, LoyaltyState>(
                builder:
                    (context, state) => buildCard(
                      'Balance',
                      'What is the point price?',
                      state.balance,
                      (value) =>
                          context.read<LoyaltyCubit>().updateBalance(value),
                    ),
              ),
              SizedBox(height: 80),
              buildButtonacount("Save", () {
                context.read<LoyaltyCubit>().save();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Loyalty points saved successfully!")),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCard(
    String title,
    String subtitle,
    String value,
    ValueChanged<String> onChanged,
  ) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColor.darkpink, // Background of the card
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [
          // Dark Red Circle inside the card (not covering text)
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              width: 80, // Adjust size as needed
              height: 80,
              decoration: BoxDecoration(
                color: Color(0xFF310303), // Dark red color
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12), // Matches card's radius
                  bottomRight: Radius.circular(40), // Soft curve effect
                ),
              ),
            ),
          ),

          // Text and Input Fields (on top of the dark red container)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontFamily: 'Serif',
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  fontFamily: 'Serif',
                  color: Colors.white70,
                  fontSize: 12,
                ),
              ),
              SizedBox(height: 12),
              TextField(
                onChanged: onChanged,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 14,
                  ),
                  hintText: value,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildButtonacount(String text, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.only(top: 70, bottom: 16, left: 30, right: 30),
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.darkpink,
          borderRadius: BorderRadius.circular(14),
        ),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 115),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
          child: Text(
            text,
            style: TextStyle(
              fontFamily: 'Serif',
              color: Colors.white,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
