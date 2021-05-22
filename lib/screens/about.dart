import 'package:browser786/constants.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  Future<void> _launchInBrowser() async {
    if (await canLaunch(sam)) {
      await launch(
        sam,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $sam';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
        color: Colors.black,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Made with ❤️ in Tatooine", style: musicCardTextStyle),
          ],
        ),
      ),
      body: Container(
        child: Center(
          child: Column(children: [
            SizedBox(height: 10),
            GestureDetector(
              onTap: _launchInBrowser,
              child: ClipRRect(
                  child: Image.asset('assets/icons/sam.jpg',
                      height: 150, width: 150),
                  borderRadius: BorderRadius.circular(150)),
            ),
            SizedBox(height: 8),
            Text("Lofi beats belongs to Samuel Kim Music",
                style: TextStyle(fontSize: 20, color: Colors.white)),
            Text("This application is made for educational purposes",
                style: TextStyle(fontSize: 15, color: Colors.white)),
            Text("Please don't sue us Sam!",
                style: TextStyle(fontSize: 10, color: Colors.white)),
            Divider(color: Colors.white)
          ]),
        ),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/icons/binary.jpg'), fit: BoxFit.cover),
        ),
      ),
    );
  }
}
