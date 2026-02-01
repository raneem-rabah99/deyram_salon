import 'package:deyram_salon/core/theme/app_color.dart';
import 'package:deyram_salon/features/auth/presentation/widget/password.dart';
import 'package:deyram_salon/features/home/data/models/coupon.dart';
import 'package:deyram_salon/features/home/presentation/manager/copoun_cubit.dart';
import 'package:deyram_salon/features/home/presentation/pages/edit_manage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class AddCouponScreen extends StatefulWidget {
  @override
  _AddCouponScreenState createState() => _AddCouponScreenState();
}

class _AddCouponScreenState extends State<AddCouponScreen> {
  final TextEditingController _couponCodeController = TextEditingController();
  final TextEditingController _discountRateController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;
  String? _selectedCategory;
  bool _sendNotification = false;

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Coupons',
          style: TextStyle(fontFamily: 'Serif', color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add Coupons',
                style: TextStyle(
                  fontFamily: 'Serif',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 12),
              Text(
                "Coupon code",
                style: TextStyle(
                  fontFamily: 'Serif',
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              PasswordInput(controller: _couponCodeController),

              SizedBox(height: 12),

              buildTextFieldWithoutIcon(
                "Discount rate",
                "Discount rate",
                _discountRateController,
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _selectDate(context, true),
                      child: InputDecorator(
                        decoration: InputDecoration(
                          labelText: 'Start Date',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xffE3E3E3),
                              width: 1,
                            ),
                          ),
                          labelStyle: TextStyle(
                            fontFamily: 'Serif',
                            color: Colors.black,
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColor.gray,
                              width: 2,
                            ), // Border when not focused
                            borderRadius: BorderRadius.circular(
                              8,
                            ), // Rounded corners
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColor.gray,
                              width: 2,
                            ), // Border when focused
                            borderRadius: BorderRadius.circular(
                              8,
                            ), // Rounded corners
                          ),
                        ),
                        child: Text(
                          _startDate == null
                              ? 'Select Date'
                              : DateFormat('dd-MM-yyyy').format(_startDate!),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12),

                  Expanded(
                    child: GestureDetector(
                      onTap: () => _selectDate(context, false),
                      child: InputDecorator(
                        decoration: InputDecoration(
                          labelText: 'End Date',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xffE3E3E3),
                              width: 1,
                            ),
                          ),
                          labelStyle: TextStyle(
                            fontFamily: 'Serif',
                            color: Colors.black,
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColor.gray,
                              width: 2,
                            ), // Border when not focused
                            borderRadius: BorderRadius.circular(
                              8,
                            ), // Rounded corners
                          ),

                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColor.gray,
                              width: 2,
                            ), // Border when focused
                            borderRadius: BorderRadius.circular(
                              8,
                            ), // Rounded corners
                          ),
                        ),
                        child: Text(
                          _endDate == null
                              ? 'Select Date'
                              : DateFormat('dd-MM-yyyy').format(_endDate!),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Text(
                "Services Category",
                style: TextStyle(
                  fontFamily: 'Serif',
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Services Category',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffE3E3E3), width: 1),
                  ),

                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColor.gray,
                      width: 2,
                    ), // Border when not focused
                    borderRadius: BorderRadius.circular(8), // Rounded corners
                  ),
                ),
                items:
                    ['Category 1', 'Category 2', 'Category 3']
                        .map(
                          (category) => DropdownMenuItem(
                            value: category,
                            child: Text(category),
                          ),
                        )
                        .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value;
                  });
                },
              ),
              SizedBox(height: 12),
              Text(
                "Services Category",
                style: TextStyle(
                  fontFamily: 'Serif',
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              TextField(
                controller: _messageController,
                decoration: InputDecoration(
                  labelText: 'Message',

                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffE3E3E3), width: 1),
                  ),

                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColor.gray,
                      width: 2,
                    ), // Border when not focused
                    borderRadius: BorderRadius.circular(8), // Rounded corners
                  ),
                ),
              ),
              SizedBox(height: 12),
              Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Color(0xffEBEBEB),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          '  Sending a notification of the coupon’s success',
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          height: 20,
                          width: 60,
                          child: Switch(
                            activeColor: AppColor.darkpink,
                            inactiveTrackColor: Colors.white,

                            value: _sendNotification,
                            onChanged: (value) {
                              setState(() {
                                _sendNotification = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 50.0,
                    right: 50,
                    left: 50,
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.darkpink,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      if (_couponCodeController.text.isNotEmpty &&
                          _discountRateController.text.isNotEmpty) {
                        final newCoupon = Coupon(
                          code: _couponCodeController.text,
                          discount: double.parse(_discountRateController.text),
                          message: _messageController.text,
                          startDate: _startDate ?? DateTime.now(),
                          endDate: _endDate ?? DateTime.now(),
                          category: _selectedCategory ?? 'Uncategorized',
                          sendNotification: _sendNotification,
                        );

                        context.read<CouponCubit>().addCoupon(newCoupon);
                      }
                    },
                    child: Text(
                      'Done',
                      style: TextStyle(
                        fontFamily: 'Serif',
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
