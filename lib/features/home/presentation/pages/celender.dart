import 'package:deyram_salon/core/classes/icons_classes.dart';
import 'package:deyram_salon/core/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:deyram_salon/features/home/presentation/manager/celender_cubit.dart';

class CelenderProfile extends StatefulWidget {
  const CelenderProfile({super.key});

  @override
  State<CelenderProfile> createState() => _CelenderProfileState();
}

class _CelenderProfileState extends State<CelenderProfile> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<CalendarCubit>().fetchAvailableDays();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          buildBackgroundProfile(),
          Positioned(
            left: 5,
            top: 30,

            child: Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: const Color.fromARGB(255, 23, 23, 23),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                SizedBox(width: 2), // Space between icon and text
                Text(
                  "Calendar Configuration", // Your text here
                  style: TextStyle(
                    fontFamily: 'Serif',
                    color: const Color.fromARGB(255, 7, 7, 7),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Positioned(bottom: 0, left: 0, right: 0, child: buildFormContainer()),
        ],
      ),
    );
  }

  Widget buildFormContainer() {
    return Container(
      height: 750,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Availability",
              style: TextStyle(
                fontFamily: 'Serif',
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),

            Text(
              "Available Days",
              style: TextStyle(fontFamily: 'Serif', fontSize: 18),
            ),
            SizedBox(height: 10),

            BlocBuilder<CalendarCubit, List<Map<String, String>>>(
              builder: (context, shifts) {
                final cubit = context.read<CalendarCubit>();
                return Container(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: cubit.days.length,
                    itemBuilder: (context, index) {
                      String day = cubit.days[index];
                      return Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: ChoiceChip(
                          label: Text(day),
                          selected: cubit.selectedDay == day,
                          onSelected: (selected) {
                            cubit.updateSelectedDay(day);
                          },
                          selectedColor: Colors.pink[100],
                          labelStyle: TextStyle(
                            fontFamily: 'Serif',
                            color:
                                cubit.selectedDay == day
                                    ? Colors.pink
                                    : Colors.black,
                          ),
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.pink.shade200),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),

            SizedBox(height: 20),

            Text(
              "Available Times",
              style: TextStyle(
                fontFamily: 'Serif',
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),

            BlocBuilder<CalendarCubit, List<Map<String, String>>>(
              builder: (context, shifts) {
                return Column(
                  children:
                      shifts.asMap().entries.map((entry) {
                        int index = entry.key;
                        var shift = entry.value;

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            children: [
                              Expanded(
                                child: buildTimeDropdown(shift["start"]!, (
                                  newTime,
                                ) {
                                  context.read<CalendarCubit>().updateShift(
                                    index,
                                    "start",
                                    newTime,
                                  );
                                }),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: buildTimeDropdown(shift["end"]!, (
                                  newTime,
                                ) {
                                  context.read<CalendarCubit>().updateShift(
                                    index,
                                    "end",
                                    newTime,
                                  );
                                }),
                              ),
                              SizedBox(width: 10),
                              GestureDetector(
                                onTap:
                                    () => context
                                        .read<CalendarCubit>()
                                        .removeShift(index),
                                child: Iconarowdel.del,
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                );
              },
            ),

            TextButton.icon(
              onPressed: () => context.read<CalendarCubit>().addShift(),
              icon: Icon(Icons.add, color: Colors.pink),
              label: Text(
                "Add a shift",
                style: TextStyle(
                  fontFamily: 'Serif',
                  color: Colors.pink,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            Spacer(),

            buildButtonProfile("Confirm"),
          ],
        ),
      ),
    );
  }

  Widget buildTimeDropdown(String selectedTime, Function(String) onChanged) {
    List<String> timeOptions = [
      "09:00 AM",
      "10:00 AM",
      "11:00 AM",
      "12:00 PM",
      "01:00 PM",
      "02:00 PM",
      "03:00 PM",
      "04:00 PM",
      "05:00 PM",
      "06:00 PM",
      "07:00 PM",
      "08:00 PM",
      "09:00 PM",
      "10:00 PM",
      "11:00 PM",
      "12:00 AM",
    ];

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedTime,
          isExpanded: true,
          onChanged: (newValue) {
            if (newValue != null) {
              onChanged(newValue);
            }
          },
          items:
              timeOptions.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(value),
                  ),
                );
              }).toList(),
        ),
      ),
    );
  }

  Widget buildButtonProfile(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20, left: 30, right: 30),
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.darkpink,
          borderRadius: BorderRadius.circular(14),
        ),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 100),
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

Widget buildBackgroundProfile([String? title]) {
  return Stack(
    children: [
      Container(decoration: BoxDecoration(color: Color(0xffF1F1F1))),
      if (title != null) // Only display the title if it's provided
        Positioned(
          top: 100, // Adjust the position as needed
          left: 0,
          right: 0,
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                fontFamily: 'Serif',
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
    ],
  );
}
