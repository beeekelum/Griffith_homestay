import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:homestay/ui/hostparent/parent_drawer.dart';

class ParentOptions extends StatefulWidget {
  @override
  _ParentOptionsState createState() => _ParentOptionsState();
}

class _ParentOptionsState extends State<ParentOptions> {
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Host Parent Home',
          style: TextStyle(fontFamily: 'Muli'),
        ),
        centerTitle: false,
        actions: <Widget>[
          IconButton(
            icon: Icon(FontAwesomeIcons.signOutAlt),
            onPressed: () {
              _showDialog();
            },
          ),
        ],
      ),
      drawer: ParentDrawer(),
      body: SafeArea(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 3.0),
            child: GridView.count(
              physics: BouncingScrollPhysics(),
              crossAxisCount: 2,
              padding: EdgeInsets.all(3.0),
              children: <Widget>[
                makeDashboardItem(
                    'Fill Listing Form', FontAwesomeIcons.wpforms, context),
                makeDashboardItem(
                    'My Listings', FontAwesomeIcons.edit, context),
                makeDashboardItem(
                    'Fill Feedback Form', FontAwesomeIcons.listAlt, context),
                makeDashboardItem('View Host Feedback',
                    FontAwesomeIcons.chalkboardTeacher, context),
                makeDashboardItem('Previous Student Feedback',
                    FontAwesomeIcons.history, context),
                makeDashboardItem(
                    'Browse Accommodation', FontAwesomeIcons.home, context),
                makeDashboardItem(
                    'View Host Parent Policy', FontAwesomeIcons.file, context),
                //makeDashboardItem('My Profile', Icons.person, context),
                //makeDashboardItem('ChatBot', FontAwesomeIcons.robot, context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Row(
            children: <Widget>[
//              Text(
//                'We hate to see you go ',
//                style: TextStyle(
//                    fontSize: 15, decoration: TextDecoration.underline),
//              ),
              Icon(FontAwesomeIcons.sadCry),
            ],
          ),
          content: new Text("Are you sure you want to logout?"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text(
                "Yes",
                style: TextStyle(color: Colors.redAccent),
              ),
              onPressed: () {
                //Navigator.of(context).pop();
                _logOut();
              },
            ),
          ],
        );
      },
    );
  }

  _logOut() async {
    await auth.signOut().then((_) {
      Navigator.of(context).pop();
      Navigator.of(context).pushNamedAndRemoveUntil(
          "/parentsigninpage", ModalRoute.withName("/parentsigninpage"));
    });
  }
}

Card makeDashboardItem(String title, IconData icon, BuildContext context) {
  return Card(
    elevation: 10,
    margin: EdgeInsets.all(10),
    child: Container(
      color: Colors.white,
      child: Center(
        child: InkWell(
          onTap: () {
            if (title == 'Fill Listing Form') {
              Navigator.of(context).pushNamed('/parentlistingform');
            }
            if (title == 'My Listings') {
              Navigator.of(context).pushNamed('/mylistings');
            }
            if (title == 'Fill Feedback Form') {
              Navigator.of(context).pushNamed('/studentsListforfeedback');
            }
            if (title == 'View Host Feedback') {
              Navigator.of(context).pushNamed('/myfeedback');
            }
            if (title == 'Previous Student Feedback') {
              Navigator.of(context).pushNamed('/parentstudentfeedback');
            }
            if (title == 'Browse Accommodation') {
              Navigator.of(context).pushNamed('/parentaccommodation');
            }
            if (title == 'View Host Parent Policy') {
              Navigator.of(context).pushNamed('/parentpolicy');
            }
            if (title == 'My Profile') {
              Navigator.of(context).pushNamed('/parentprofile');
            }
          },
          child: Column(
//            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//            mainAxisSize: MainAxisSize.min,
//            verticalDirection: VerticalDirection.down,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: CircleAvatar(
                    backgroundColor: Colors.teal,
                    radius: 35,
                    child: Icon(
                      icon,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Center(
                child: Text(
                  title,
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Muli'),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
