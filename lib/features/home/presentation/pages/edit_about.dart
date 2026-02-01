import 'package:flutter/material.dart';

class EditAbout extends StatelessWidget {
  final String initialText;

  EditAbout({super.key, required this.initialText});

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController(text: initialText);

    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Text", style: TextStyle(fontFamily: 'Serif')),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 200, // Set height to make it square-like
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: controller,
                  maxLines: null,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Edit Your Text',
                    contentPadding: EdgeInsets.all(8),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // When the user saves, pass the text back to AbouPage
                final newText = controller.text;
                Navigator.pop(context, newText);
              },
              child: Text("Save Changes"),
            ),
          ],
        ),
      ),
    );
  }
}
