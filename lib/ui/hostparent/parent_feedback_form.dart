import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:homestay/models/user.dart';
import 'package:homestay/services/feedback_management.dart';
import 'package:homestay/services/firestore_services.dart';
import 'package:homestay/widgets/app_widgets.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class HostPFeedbackForm extends StatefulWidget {
  HostPFeedbackForm({this.hostFeedback});
  final DocumentSnapshot hostFeedback;

  @override
  _HostPFeedbackFormState createState() => _HostPFeedbackFormState();
}

class _HostPFeedbackFormState extends State<HostPFeedbackForm> {
  String studentBehaviour = 'Select Option:';
  String socialSkills = 'Select Option:';
  String cleanliness = 'Select Option:';
  String academics = 'Select Option:';
  String settlingIn = 'Select Option:';
  String overallRating = 'Select Option:';
  String feedBack = 'Choose Option:';

  String studentFirstName = '';
  String studentLastName = '';

  final _formKey = GlobalKey<FormState>();
  bool _validate = false;

  final auth = FirebaseAuth.instance;
  final fs = FirestoreServices();

  @override
  Widget build(BuildContext context) {
    var fUser = Provider.of<FirebaseUser>(context);
    return StreamBuilder<User>(
      stream: fs.streamHostParent(fUser.uid),
      builder: (context, snapshot) {
        var user = snapshot.data;
        if (user != null) {
          return Scaffold(
            appBar: AppBar(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Host accommodation',
                    style: TextStyle(fontSize: 15),
                  ),
                  Text(
                    ' feeback form',
                    style: TextStyle(),
                  ),
                ],
              ),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.home),
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacementNamed('/parenthomepage');
                  },
                ),
              ],
            ),
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey,
                  autovalidate: _validate,
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('Student name: '),
                            Container(
                              width: 200,
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Name',
                                  labelText: 'Name',
                                ),
                                onSaved: (value) {
                                  setState(() {
                                    studentFirstName =
                                        widget.hostFeedback.data['firstName'];
                                  });
                                },
                                initialValue:
                                    widget.hostFeedback.data['firstName'],
                                enabled: false,
                              ),
                            )
                          ],
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('Student surname: '),
                            Container(
                              width: 200,
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Surname',
                                  labelText: 'Surname',
                                ),
                                onSaved: (value) {
                                  setState(() {
                                    studentLastName =
                                        widget.hostFeedback.data['lastName'];
                                  });
                                },
                                initialValue:
                                    widget.hostFeedback.data['lastName'],
                                enabled: false,
                              ),
                            )
                          ],
                        ),
                        Divider(),
                        Row(
                          children: <Widget>[
                            formHeading('Feedback Type: '),
                            Spacer(),
                            _feedBack(feedBack),
                          ],
                        ),
                        Divider(),
                        _ratingKey(),
                        Divider(),
                        Row(
                          children: <Widget>[
                            formHeading('1. Student\'s Behaviour'),
                            Spacer(),
                            rateStudentBehaviour(studentBehaviour),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: <Widget>[
                            formHeading('2. Social Skills'),
                            Spacer(),
                            rateSocialSkills(socialSkills),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: <Widget>[
                            formHeading('3. Cleanliness'),
                            Spacer(),
                            rateCleanliness(cleanliness),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: <Widget>[
                            formHeading('4. Academics'),
                            Spacer(),
                            rateAcademics(academics),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: <Widget>[
                            formHeading('5. Settling In'),
                            Spacer(),
                            rateSettlingIn(settlingIn),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: <Widget>[
                            formHeading('6. Overall rating'),
                            Spacer(),
                            overalRating(overallRating),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              width: 330,
                              child: RaisedButton(
                                padding: EdgeInsets.all(16),
                                color: Colors.teal.withOpacity(0.7),
                                onPressed: () {
                                  print(studentFirstName);
                                  print(studentLastName);
                                  print(widget.hostFeedback.data['firstName']);
                                  print(widget.hostFeedback.data['lastName']);
                                  if (studentBehaviour == 'Select Option:') {
                                    Toast.show(
                                        'Add rating on student behaviour',
                                        context,
                                        duration: Toast.LENGTH_LONG,
                                        gravity: Toast.BOTTOM);
                                  } else if (socialSkills == 'Select Option:') {
                                    Toast.show(
                                        'Add rating on social skills', context,
                                        duration: Toast.LENGTH_LONG,
                                        gravity: Toast.BOTTOM);
                                  } else if (cleanliness == 'Select Option:') {
                                    Toast.show(
                                        'Add rating on cleanliness', context,
                                        duration: Toast.LENGTH_LONG,
                                        gravity: Toast.BOTTOM);
                                  } else if (academics == 'Select Option:') {
                                    Toast.show(
                                        'Add rating on student academics',
                                        context,
                                        duration: Toast.LENGTH_LONG,
                                        gravity: Toast.BOTTOM);
                                  } else if (settlingIn == 'Select Option:') {
                                    Toast.show(
                                        'Add rating on settling in', context,
                                        duration: Toast.LENGTH_LONG,
                                        gravity: Toast.BOTTOM);
                                  } else if (overallRating ==
                                      'Select Option:') {
                                    Toast.show(
                                        'Add rating on overall rating', context,
                                        duration: Toast.LENGTH_LONG,
                                        gravity: Toast.BOTTOM);
                                  } else {
                                    setState(() {
                                      Map<String, dynamic> feedBackData = {
                                        'hostParentUid': fUser.uid,
                                        'hostEmail': fUser.email,
                                        'hostPhotoUrl': fUser.photoUrl,
                                        'hostFullName': fUser.displayName,
                                        'studentBehaviour': studentBehaviour,
                                        'socialSkills': socialSkills,
                                        'cleanliness': cleanliness,
                                        'academics': academics,
                                        'settlingIn': settlingIn,
                                        'overallRating': overallRating,
                                        'studentFirstName': widget
                                            .hostFeedback.data['firstName'],
                                        'studentLastName': widget
                                            .hostFeedback.data['lastName'],
                                        'studentUid':
                                            widget.hostFeedback.data['uid'],
                                        'feedBack': feedBack,
                                      };
                                      FeedBackManagement()
                                          .saveFeedback(feedBackData)
                                          .then((e) {
                                        Toast.show(
                                            'Student feedback submitted successfully',
                                            context,
                                            duration: Toast.LENGTH_LONG,
                                            gravity: Toast.BOTTOM);
                                        Navigator.of(context).pop();
                                        Navigator.of(context)
                                            .pushReplacementNamed(
                                                '/parenthomepage');
                                      });
                                    });
                                  }
                                },
                                elevation: 0,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Icon(
                                      FontAwesomeIcons.save,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'Submit',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontFamily: 'Muli',
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                                shape: StadiumBorder(
                                  side:
                                      BorderSide(color: Colors.black, width: 0),
                                ),
                              ),
                            ),
                          ],
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

  Widget _ratingKey() {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'On a scale of 1 to 5 rate the following:',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text('1 - Is Unsatisfactory'),
          Text('2 - Is Satisfactory'),
          Text('3 - Is Good'),
          Text('4 - Is Very Good'),
          Text('5 - Is Excellent'),
        ],
      ),
    );
  }

  Widget _feedBack(String _value) {
    return Center(
      child: DropdownButton<String>(
        value: _value,
        onChanged: (String newValue) {
          setState(() {
            feedBack = newValue;
            //print(newValue);
          });
        },
        items: <String>[
          'Choose Option:',
          'Initial Feedback',
          'Completed Feedback'
        ].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: TextStyle(fontSize: 14),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget rateStudentBehaviour(String _value) {
    return Center(
      child: DropdownButton<String>(
        value: _value,
        onChanged: (String newValue) {
          setState(() {
            studentBehaviour = newValue;
            //print(newValue);
          });
        },
        items: <String>['Select Option:', '1', '2', '3', '4', '5']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  Widget rateSocialSkills(String _value) {
    return Center(
      child: DropdownButton<String>(
        value: _value,
        onChanged: (String newValue) {
          setState(() {
            socialSkills = newValue;
            //print(newValue);
          });
        },
        items: <String>['Select Option:', '1', '2', '3', '4', '5']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  Widget rateCleanliness(String _value) {
    return Center(
      child: DropdownButton<String>(
        value: _value,
        onChanged: (String newValue) {
          setState(() {
            cleanliness = newValue;
            //print(newValue);
          });
        },
        items: <String>['Select Option:', '1', '2', '3', '4', '5']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  Widget rateAcademics(String _value) {
    return Center(
      child: DropdownButton<String>(
        value: _value,
        onChanged: (String newValue) {
          setState(() {
            academics = newValue;
            //print(newValue);
          });
        },
        items: <String>['Select Option:', '1', '2', '3', '4', '5']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  Widget rateSettlingIn(String _value) {
    return Center(
      child: DropdownButton<String>(
        value: _value,
        onChanged: (String newValue) {
          setState(() {
            settlingIn = newValue;
            //print(newValue);
          });
        },
        items: <String>['Select Option:', '1', '2', '3', '4', '5']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  Widget overalRating(String _value) {
    return Center(
      child: DropdownButton<String>(
        value: _value,
        onChanged: (String newValue) {
          setState(() {
            overallRating = newValue;
            //print(newValue);
          });
        },
        items: <String>['Select Option:', '1', '2', '3', '4', '5']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
