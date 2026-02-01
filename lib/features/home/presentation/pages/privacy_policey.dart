import 'package:flutter/material.dart';

class PrivacyPolicey extends StatelessWidget {
  const PrivacyPolicey({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Privacy Policy"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Container(
            color: const Color.fromARGB(
              255,
              176,
              176,
              176,
            ), // Change color as needed
            height: 1.0,
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Privacy Policy for Deyram',
                style: TextStyle(
                  fontFamily: 'Serif',
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Text(
                'At Deyram.com, accessible from makemeup.com, one of our main priorities is the privacy of our visitors. This Privacy Policy document contains types of information that is collected and recorded by Deyram.com and how we use it.If you have additional questions or require more information about our Privacy Policy, do not hesitate to contact us.This Privacy Policy applies only to our online activities and is valid for visitors to our website with regards to the information that they shared and/or collect in Deyram.com. This policy is not applicable to any information collected offline or via channels other than this website.ConsentBy using our website, you hereby consent to our Privacy Policy and agree to its terms.',
                style: TextStyle(fontFamily: 'Serif', fontSize: 15),
              ),
              SizedBox(height: 20),
              Text(
                'Information we collect',
                style: TextStyle(
                  fontFamily: 'Serif',
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Text(
                'At Deyram.com, accessible from makemeup.com, one of our main priorities is the privacy of our visitors. This Privacy Policy document contains types of information that is collected and recorded by Deyram.com and how we use it.If you have additional questions or require more information about our Privacy Policy, do not hesitate to contact us.This Privacy Policy applies only to our online activities and is valid for visitors to our website with regards to the information that they shared and/or collect in Deyram.com. This policy is not applicable to any information collected offline or via channels other than this website.ConsentBy using our website, you hereby consent to our Privacy Policy and agree to its terms.At Deyram.com, accessible from makemeup.com,At Deyram.com, accessible from makemeup.com,At Deyram.com, accessible from makemeup.com,At Deyram.com, accessible from makemeup.com,At Deyram.com, accessible from makemeup.com,At Deyram.com, accessible from makemeup.com,At Deyram.com, accessible from makemeup.com,At Deyram.com, accessible from makemeup.com,At Deyram.com, accessible from makemeup.com,At Deyram.com, accessible from makemeup.com,At Deyram.com, accessible from makemeup.com,At Deyram.com, accessible from makemeup.com,At Deyram.com, accessible from makemeup.com,',
                style: TextStyle(fontFamily: 'Serif', fontSize: 15),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
