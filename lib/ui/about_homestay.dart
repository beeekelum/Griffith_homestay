import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AboutHomestay extends StatefulWidget {
  @override
  _AboutHomestayState createState() => _AboutHomestayState();
}

class _AboutHomestayState extends State<AboutHomestay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About EasyPharm'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            Icon(
              FontAwesomeIcons.home,
              size: 80,
              color: Colors.teal,
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text(
                'Homestay is a mobile app that helps international students find parents to stay with during the coarse of the study basing on both the student and parent preferences whether they match or not.',
                style: TextStyle(
                    fontSize: 22,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w600),
              ),
            )
          ],
        ),
      ),
    );
  }
}
