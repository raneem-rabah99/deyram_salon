import 'package:deyram_salon/core/classes/icons_classes.dart';
import 'package:deyram_salon/core/theme/app_color.dart';
import 'package:flutter/material.dart';

class GiftForFriendScreen extends StatefulWidget {
  @override
  _GiftForFriendScreenState createState() => _GiftForFriendScreenState();
}

class _GiftForFriendScreenState extends State<GiftForFriendScreen> {
  final TextEditingController _phoneNumberController = TextEditingController();
  String? _selectedContact;

  final List<Map<String, String>> contacts = [
    {"name": "Y.K", "phone": "+999 333 555 222"},
    {"name": "R.U", "phone": "+999 333 555 222"},
    {"name": "M.A", "phone": "+999 333 555 222"},
    {"name": "M.A", "phone": "+999 333 555 222"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,

        title: Text(
          "gift",
          style: TextStyle(
            fontFamily: 'Serif',
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),

        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icongift.gift,
              SizedBox(height: 16),
              Text(
                "Gift For A Friend",
                style: TextStyle(
                  fontFamily: 'Serif',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _phoneNumberController,
                decoration: InputDecoration(
                  hintText: "Enter Phone Number",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 16),
              Column(
                children:
                    contacts.map((contact) {
                      return RadioListTile(
                        title: Text("${contact["name"]}  ${contact["phone"]}"),
                        value: contact["phone"],
                        groupValue: _selectedContact,
                        onChanged: (value) {
                          setState(() {
                            _selectedContact;
                          });
                        },
                        activeColor: AppColor.darkpink,
                      );
                    }).toList(),
              ),
              SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.darkpink,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    "Send",
                    style: TextStyle(fontFamily: 'Serif', color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.black),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    "Cancel",
                    style: TextStyle(fontFamily: 'Serif', color: Colors.black),
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
