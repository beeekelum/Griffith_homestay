import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:homestay/models/user.dart';
import 'package:homestay/services/firestore_services.dart';
import 'package:homestay/ui/about_homestay.dart';
import 'package:homestay/ui/student/accommodation_list.dart';
import 'package:homestay/ui/student/feedback_page.dart';
import 'package:homestay/ui/student/student_policy_page.dart';
import 'package:homestay/ui/student/student_preference_page.dart';
import 'package:homestay/ui/student/student_signin.dart';
import 'package:homestay/utils/routes.dart';
import 'package:provider/provider.dart';

class StudentDrawer extends StatefulWidget {
  @override
  _StudentDrawerState createState() => _StudentDrawerState();
}

class _StudentDrawerState extends State<StudentDrawer> {
  final auth = FirebaseAuth.instance;

  final fs = FirestoreServices();

  @override
  Widget build(BuildContext context) {
    _logOut() async {
      await auth.signOut().then((_) {
        Navigator.of(context).pop();
        Navigator.of(context).pushNamedAndRemoveUntil(
            "/studentsigninpage", ModalRoute.withName("/studentsigninpage"));
      });
    }

    var fUser = Provider.of<FirebaseUser>(context);
    return StreamBuilder<User>(
      stream: fs.streamStudent(fUser.uid),
      builder: (context, snapshot) {
        //print(fUser.uid);
        var user = snapshot.data;
        if (user != null) {
          return Container(
            width: 270,
            child: Drawer(
              elevation: 0.0,
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: <Widget>[
                  UserAccountsDrawerHeader(
                    accountName: Text(
                      user.userType + ': ' + user.fullName,
                      style: TextStyle(fontSize: 15, fontFamily: 'Muli'),
                    ),
                    accountEmail: Text(
                      'Student No. ' + user.studentNumber,
                      style: TextStyle(fontSize: 14, fontFamily: 'Muli'),
                    ),
                    currentAccountPicture: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white,
                      backgroundImage: NetworkImage(user.photoUrl),
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      FontAwesomeIcons.home,
                      color: Colors.teal,
                    ),
                    title: Text(
                      'Browse Accommodation',
                      style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Muli'),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.of(context).push(
                        FadePageRoute(
                          builder: (c) {
                            return AccommodationList();
                          },
                          settings: new RouteSettings(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      FontAwesomeIcons.wpforms,
                      color: Colors.teal,
                    ),
                    title: Text(
                      'Fill Preference Form',
                      style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Muli'),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(
                        FadePageRoute(
                          builder: (c) {
                            return StudentPreferencePge();
                          },
                          settings: new RouteSettings(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      FontAwesomeIcons.listAlt,
                      color: Colors.teal,
                    ),
                    title: Text(
                      'Fill Feedback form',
                      style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Muli'),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.of(context).push(
                        FadePageRoute(
                          builder: (c) {
                            return FeedbackForm();
                          },
                          settings: new RouteSettings(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      FontAwesomeIcons.file,
                      color: Colors.teal,
                    ),
                    title: Text(
                      'View Student Policy',
                      style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Muli'),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.of(context).push(
                        FadePageRoute(
                          builder: (c) {
                            return StudentPolicy();
                          },
                          settings: new RouteSettings(),
                        ),
                      );
                    },
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(
                      FontAwesomeIcons.infoCircle,
                      color: Colors.teal,
                    ),
                    title: Text(
                      'About Homestay',
                      style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Muli'),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.of(context).push(
                        FadePageRoute(
                          builder: (c) {
                            return AboutHomestay();
                          },
                          settings: new RouteSettings(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}

Future<StudentSignIn> _signOut() async {
  await FirebaseAuth.instance.signOut();
  return new StudentSignIn();
}
