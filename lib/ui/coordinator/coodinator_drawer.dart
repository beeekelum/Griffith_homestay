import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:homestay/models/user.dart';
import 'package:homestay/services/firestore_services.dart';
import 'package:homestay/ui/about_homestay.dart';
import 'package:homestay/ui/coordinator/coodinator_accommodation.dart';
import 'package:homestay/ui/coordinator/coodinator_match_screen.dart';
import 'package:homestay/ui/coordinator/hostparent_feedbackform.dart';
import 'package:homestay/ui/coordinator/hostparentlistingform.dart';
import 'package:homestay/ui/coordinator/student_feedbackform.dart';
import 'package:homestay/ui/coordinator/student_n_host_policies_page.dart';
import 'package:homestay/ui/coordinator/student_preference_form.dart';
import 'package:homestay/ui/hostparent/parent_signin.dart';
import 'package:homestay/utils/routes.dart';
import 'package:provider/provider.dart';

class CoodinatorDrawer extends StatefulWidget {
  @override
  _CoodinatorDrawerState createState() => _CoodinatorDrawerState();
}

class _CoodinatorDrawerState extends State<CoodinatorDrawer> {
  final auth = FirebaseAuth.instance;
  final fs = FirestoreServices();

  @override
  Widget build(BuildContext context) {
    _logOut() async {
      await auth.signOut().then((_) {
        Navigator.of(context).pop();
        Navigator.of(context).pushNamedAndRemoveUntil("/coodinatorsigninpage",
            ModalRoute.withName("/coodinatorsigninpage"));
      });
    }

    var fUser = Provider.of<FirebaseUser>(context);
    return StreamBuilder<User>(
        stream: fs.streamHostParent(fUser.uid),
        builder: (context, snapshot) {
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
                        user.email,
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
                        FontAwesomeIcons.wpforms,
                        color: Colors.teal,
                      ),
                      title: Text(
                        'View Listing Form',
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
                              return HostParentListingForm();
                            },
                            settings: new RouteSettings(),
                          ),
                        );
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        FontAwesomeIcons.home,
                        color: Colors.teal,
                      ),
                      title: Text(
                        'View Accommodation',
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
                              return CoodinatorBrowseAccomodation();
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
                        'View Student Preference form',
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
                              return StudentPreferenceForm();
                            },
                            settings: new RouteSettings(),
                          ),
                        );
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        FontAwesomeIcons.eye,
                        color: Colors.teal,
                      ),
                      title: Text(
                        'Create Match and Notification',
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
                              return MatchScreen();
                            },
                            settings: new RouteSettings(),
                          ),
                        );
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        FontAwesomeIcons.chalkboardTeacher,
                        color: Colors.teal,
                      ),
                      title: Text(
                        'View Host Feedback and Rating',
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
                              return HostParentFeedbackForm();
                            },
                            settings: new RouteSettings(),
                          ),
                        );
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        FontAwesomeIcons.chalkboardTeacher,
                        color: Colors.teal,
                      ),
                      title: Text(
                        'View Student Feedback and Rating',
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
                              return StudentFeedBackForm();
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
                        'Student and Host Parent Policy',
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
                              return StudentNHostPoliciesPage();
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
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}

Future<ParentSignIn> _signOut() async {
  await FirebaseAuth.instance.signOut();
  return new ParentSignIn();
}
