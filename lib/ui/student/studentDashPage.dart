import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:homestay/ui/student/student_drawer.dart';

class StudentOptions extends StatefulWidget {
  @override
  _StudentOptionsState createState() => _StudentOptionsState();
}

class _StudentOptionsState extends State<StudentOptions> {
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Student Home',
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
      drawer: StudentDrawer(),
      body: SafeArea(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 3.0),
            child: GridView.count(
              physics: BouncingScrollPhysics(),
              crossAxisCount: 2,
              padding: EdgeInsets.all(3.0),
              children: <Widget>[
                makeDashboardItem('Browse Accommodation', Icons.home, context),
                makeDashboardItem(
                    'Fill Preference Form', FontAwesomeIcons.wpforms, context),
                makeDashboardItem(
                    'Fill Feedback Form', FontAwesomeIcons.listAlt, context),
                makeDashboardItem(
                    'View Student Policy', FontAwesomeIcons.file, context),
//                makeDashboardItem('My Profile', Icons.person, context),
//                makeDashboardItem('Dashboard', Icons.dashboard, context),
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
      Navigator.of(context).pushNamedAndRemoveUntil(
          "/studentsigninpage", ModalRoute.withName("/studentsigninpage"));
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
            if (title == 'Dashboard') {}
            if (title == 'Browse Accommodation') {
              Navigator.of(context).pushNamed('/accommodation');
            }
            if (title == 'Fill Preference Form') {
              Navigator.of(context).pushNamed('/stdntpreferenceform');
            }
            if (title == 'Fill Feedback Form') {
              //Navigator.of(context).pushNamed('/feedbackform');
              Navigator.of(context).pushNamed('/sendfeedbacktoparent');
            }
            if (title == 'View Student Policy') {
              Navigator.of(context).pushNamed('/studentpolicy');
            }
            if (title == 'My Profile') {
              Navigator.of(context).pushNamed('/studentprofile');
            }
          },
          child: Column(
//            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//            mainAxisSize: MainAxisSize.min,
//            verticalDirection: VerticalDirection.down,
            crossAxisAlignment: CrossAxisAlignment.center,
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
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
