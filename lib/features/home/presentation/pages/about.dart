import 'package:deyram_salon/features/home/presentation/pages/edit_about.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AboutPage extends StatefulWidget {
  AboutPage({super.key});

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  final FlutterSecureStorage _storage = FlutterSecureStorage();
  String aboutText = 'Initial About Text';

  @override
  void initState() {
    super.initState();
    _loadAboutText();
  }

  Future<void> _loadAboutText() async {
    final savedText = await _storage.read(key: 'aboutText');
    setState(() {
      aboutText = savedText ?? 'Initial About Text';
    });
  }

  Future<void> _saveAboutText(String text) async {
    await _storage.write(key: 'aboutText', value: text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          buildBackgroundProfile(),
          Positioned(
            left: 5,
            top: 45,
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
                SizedBox(width: 4),
                Text(
                  "About",
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
      height: 800,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView(
          children: [
            Text(
              aboutText,
              style: TextStyle(
                fontFamily: 'Serif',
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () async {
                  final editedText = await Navigator.push<String>(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditAbout(initialText: aboutText),
                    ),
                  );
                  if (editedText != null && editedText.isNotEmpty) {
                    await _saveAboutText(editedText);
                    setState(() {
                      aboutText = editedText;
                    });
                  }
                },
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(color: Color.fromARGB(255, 138, 137, 137)),
                  ),
                ),
                child: Text(
                  "Edit",
                  style: TextStyle(
                    fontFamily: 'Serif',
                    color: Color(0xff666666),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBackgroundProfile() {
    return Container(decoration: BoxDecoration(color: Color(0xffF1F1F1)));
  }
}
