import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:homestay/models/user.dart';
import 'package:homestay/services/firestore_services.dart';
import 'package:homestay/ui/about_homestay.dart';
import 'package:homestay/ui/hostparent/host_parent_policy.dart';
import 'package:homestay/ui/hostparent/mylistings.dart';
import 'package:homestay/ui/hostparent/parent_accommodation.dart';
import 'package:homestay/ui/hostparent/parent_feedback_form.dart';
import 'package:homestay/ui/hostparent/parent_listing_form.dart';
import 'package:homestay/ui/hostparent/parent_signin.dart';
import 'package:homestay/ui/hostparent/student_hostp_feedback.dart';
import 'package:homestay/utils/routes.dart';
import 'package:provider/provider.dart';

class ParentDrawer extends StatefulWidget {
  @override
  _ParentDrawerState createState() => _ParentDrawerState();
}

class _ParentDrawerState extends State<ParentDrawer> {
  final auth = FirebaseAuth.instance;

  final fs = FirestoreServices();

  @override
  Widget build(BuildContext context) {
    _logOut() async {
      await auth.signOut().then((_) {
        Navigator.of(context).pop();
        Navigator.of(context).pushNamedAndRemoveUntil(
            "/parentsigninpage", ModalRoute.withName("/parentsigninpage"));
      });
    }

    var fUser = Provider.of<FirebaseUser>(context);
    return StreamBuilder<User>(
        stream: fs.streamHostParent(fUser.uid),
        builder: (context, snapshot) {
          var user = snapshot.data;
          if (user != null) {
            //print(user.firstName);
            //print(user.displayName);
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
                        'Listing Form',
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
                              return HostPListingForm();
                            },
                            settings: new RouteSettings(),
                          ),
                        );
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        FontAwesomeIcons.pen,
                        color: Colors.teal,
                      ),
                      title: Text(
                        'Update Listing Details',
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
                              return MyListings();
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
                        'Feedback form',
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
                              return HostPFeedbackForm();
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
                        'Student Feedback',
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
                              return HostPStudentFeedback();
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
                              return HostPAccommodation();
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
                        'Host Parent Policy',
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
                              return HostPPolicy();
                            },
                            settings: new RouteSettings(),
                          ),
                        );
                      },
                    ),
//                    ListTile(
//                      leading: Icon(
//                        FontAwesomeIcons.infoCircle,
//                        color: Colors.teal,
//                      ),
//                      title: Text(
//                        'About Homestay',
//                        style: TextStyle(
//                            fontSize: 15.0,
//                            fontWeight: FontWeight.w500,
//                            fontFamily: 'Muli'),
//                      ),
//                      onTap: () {
////                        Navigator.pop(context);
////                        Navigator.of(context).push(
////                          FadePageRoute(
////                            builder: (c) {
//////return AboutPage();
////                            },
////                            settings: new RouteSettings(),
////                          ),
////                        );
//                      },
//                    ),
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
