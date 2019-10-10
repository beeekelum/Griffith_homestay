import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:homestay/services/firestore_services.dart';
import 'package:homestay/ui/coordinator/coodinator_drawer.dart';

class CoodinatorOptions extends StatefulWidget {
  @override
  _CoodinatorOptionsState createState() => _CoodinatorOptionsState();
}

class _CoodinatorOptionsState extends State<CoodinatorOptions> {
  final auth = FirebaseAuth.instance;

  final fs = FirestoreServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Coordinator Home',
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
      drawer: CoodinatorDrawer(),
      body: SafeArea(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 3.0),
            child: GridView.count(
              physics: BouncingScrollPhysics(),
              crossAxisCount: 2,
              padding: EdgeInsets.all(3.0),
              children: <Widget>[
                makeDashboardItem('View Host Parent Listing forms',
                    FontAwesomeIcons.users, context),
                makeDashboardItem(
                    'View Accommodation', FontAwesomeIcons.home, context),
                makeDashboardItem('View Students Preference Forms',
                    FontAwesomeIcons.userCircle, context),
                makeDashboardItem(
                    'Match and Notify', FontAwesomeIcons.eye, context),
                makeDashboardItem(
                    'Matches Found', FontAwesomeIcons.smile, context),
                makeDashboardItem('View Host Parent Feedback',
                    FontAwesomeIcons.chalkboardTeacher, context),
                makeDashboardItem('View Student Feedback',
                    FontAwesomeIcons.chalkboardTeacher, context),

                makeDashboardItem(
                    'Upload Policy', FontAwesomeIcons.upload, context),
                //makeDashboardItem('My Profile', Icons.person, context),
                //makeDashboardItem('ChatBot', FontAwesomeIcons.robot, context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _logOut() async {
    await auth.signOut().then((_) {
      Navigator.of(context).pop();
      Navigator.of(context).pushNamedAndRemoveUntil("/coodinatorsigninpage",
          ModalRoute.withName("/coodinatorsigninpage"));
    });
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
            if (title == 'View Host Parent Listing forms') {
              Navigator.of(context).pushNamed('/hostparentlistingform');
            }
            if (title == 'View Accommodation') {
              Navigator.of(context).pushNamed('/coodinatorbrowseaccommodation');
            }
            if (title == 'View Students Preference Forms') {
              Navigator.of(context).pushNamed('/studentpreferenceform');
            }
            if (title == 'Match and Notify') {
              Navigator.of(context).pushNamed('/matchnandnotify');
            }
            if (title == 'Matches Found') {
              Navigator.of(context).pushNamed('/matchesfoundhistory');
            }
            if (title == 'View Student Feedback') {
              Navigator.of(context).pushNamed('/hostparentfeedbackform');
            }
            if (title == 'View Host Parent Feedback') {
              Navigator.of(context).pushNamed('/studentfeedback');
            }
            if (title == 'Upload Policy') {
              Navigator.of(context).pushNamed('/studnhostpoliciesuploadpage');
            }
//            if (title == 'My Profile') {
//              Navigator.of(context).pushNamed('/parentprofile');
//            }
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
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Flexible(
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
            ],
          ),
        ),
      ),
    ),
  );
}
