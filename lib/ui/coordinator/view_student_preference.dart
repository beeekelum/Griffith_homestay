import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:homestay/models/user.dart';
import 'package:homestay/services/firestore_services.dart';
import 'package:homestay/widgets/app_widgets.dart';
import 'package:provider/provider.dart';

class ViewStudentPreferencePge extends StatefulWidget {
  ViewStudentPreferencePge({this.preference});
  final DocumentSnapshot preference;
  @override
  _ViewStudentPreferencePgeState createState() =>
      _ViewStudentPreferencePgeState();
}

class _ViewStudentPreferencePgeState extends State<ViewStudentPreferencePge> {
  final _formKey = GlobalKey<FormState>();
  bool _validate = false;

  final auth = FirebaseAuth.instance;
  final fs = FirestoreServices();

  @override
  Widget build(BuildContext context) {
    var fUser = Provider.of<FirebaseUser>(context);
    return StreamBuilder<User>(
      stream: fs.streamStudent(fUser.uid),
      builder: (context, snapshot) {
        var user = snapshot.data;
        if (user != null) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Student Preference Form',
                style: TextStyle(fontSize: 17),
              ),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.home),
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacementNamed('/coodinatorhomepage');
                  },
                ),
              ],
            ),
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Form(
                  key: _formKey,
                  autovalidate: _validate,
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: <Widget>[
                              Text(
                                'Student name: ',
                                style: TextStyle(fontSize: 17),
                              ),
                              Text(
                                widget.preference.data['studentFullName'] ??
                                    'No name',
                                style: TextStyle(fontSize: 17),
                              )
                            ],
                          ),
                        ),
                        titleWidget('Student Personal Details: '),
                        Divider(),
                        Row(
                          children: <Widget>[
                            formHeading('Nationality - '),
                            Spacer(),
                            Text(widget.preference.data['nationality']),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: <Widget>[
                            formHeading('Program of study -'),
                            Spacer(),
                            Flexible(
                              child: Text(
                                widget.preference.data['programOfStudy'],
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: <Widget>[
                            formHeading('Level of study -'),
                            Spacer(),
                            Text(widget.preference.data['levelOfStudy']),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: <Widget>[
                            formHeading('Student\'s Language - '),
                            Spacer(),
                            Text(widget.preference.data['studentLanguage']),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: <Widget>[
                            formHeading('Student\'s Religion -'),
                            Spacer(),
                            Text(widget.preference.data['studentReligion']),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        titleWidget('Student Preferences: '),
                        Divider(),
                        Row(
                          children: <Widget>[
                            formHeading('Preferred Diet - '),
                            Spacer(),
                            Text(
                                widget.preference.data['studentPreferredDiet']),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: <Widget>[
                            formHeading('Preferred Language - '),
                            Spacer(),
                            Text(widget
                                .preference.data['studentPreferredLanguage']),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: <Widget>[
                            formHeading('Host Family Composition - '),
                            Spacer(),
                            Text(widget
                                .preference.data['hostFamilyComposition']),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: <Widget>[
                            formHeading('Hobbies and Interests - '),
                            Spacer(),
                            Text(widget.preference.data['hobbiesNInterests']),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: <Widget>[
                            formHeading('Accommodation - '),
                            Spacer(),
                            Text(widget
                                .preference.data['accommodationDuration']),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: <Widget>[
                            formHeading('Smoking Preference -'),
                            Spacer(),
                            Text(widget.preference.data['smokingPreference']),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: <Widget>[
                            formHeading('Pets Preference -'),
                            Spacer(),
                            Text(widget.preference.data['petsPreference']),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: <Widget>[
                            formHeading('Allergies - '),
                            Spacer(),
                            Text(widget.preference.data['allergies']),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            formHeading('Medical Conditions -'),
                            Text(widget.preference.data['medicalConditions']),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
