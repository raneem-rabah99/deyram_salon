import 'package:flutter/material.dart';

class FAQScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'FAQ',
          style: TextStyle(fontFamily: 'Serif', color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          _buildFAQCategory('Account', [
            'How will my personal data be used & protected?',
            'What will happen if I join the clinical research study?',
            'What is an investigational medication?',
          ]),
          _buildFAQCategory('Payment', [
            'How are research study participants protected?',
            'What are the risks and benefits of joining?',
          ]),
          _buildFAQCategory('Services', [
            'How does staff augmentation differ from traditional outsourcing?',
            'What is the cost of staff augmentation services and how is it calculated?',
          ]),
        ],
      ),
    );
  }

  Widget _buildFAQCategory(String title, List<String> questions) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontFamily: 'Serif',
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        ...questions.map(
          (q) => ListTile(
            title: Text(q, style: TextStyle(fontFamily: 'Serif', fontSize: 16)),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
