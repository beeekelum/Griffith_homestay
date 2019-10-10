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

class FeedbackForm extends StatefulWidget {
  FeedbackForm({this.hostFeedback});
  final DocumentSnapshot hostFeedback;
  @override
  _FeedbackFormState createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<FeedbackForm> {
  String dropdownValue = '1';
  String distanceFromSchool = '1';
  String comHomestay = '1';
  String studyConvinient = '1';
  String friendliness = '1';
  String socialable = '1';
  String partOfFamily = '1';
  String cleanliness = '1';
  String freshFood = '1';
  String overalRating = '1';
  String feedBack = 'Choose Option:';

  String hostFirstName = '';
  String hostLastName = '';

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
              title: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Accommodation',
                    style: TextStyle(),
                  ),
                  Text(
                    'Feedback Form',
                    style: TextStyle(fontSize: 16),
                  )
                ],
              ),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.home),
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacementNamed('/studenthomepage');
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('Host name: '),
                            Container(
                              width: 200,
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Name',
                                  labelText: 'Name',
                                ),
                                enabled: false,
                                initialValue:
                                    widget.hostFeedback.data['firstName'],
                                onSaved: (value) {
                                  setState(() {
                                    hostFirstName =
                                        widget.hostFeedback.data['firstName'];
                                  });
                                },
                              ),
                            )
                          ],
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('Host surname: '),
                            Container(
                              width: 200,
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Surname',
                                  labelText: 'Surname',
                                ),
                                enabled: false,
                                initialValue:
                                    widget.hostFeedback.data['lastName'],
                                onSaved: (value) {
                                  setState(() {
                                    hostLastName =
                                        widget.hostFeedback.data['lastName'];
                                  });
                                },
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
                        titleWidget('Host property'),
                        Row(
                          children: <Widget>[
                            formHeading('1. Distance from school'),
                            Spacer(),
                            rateDistanceWidget(distanceFromSchool),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            formHeading('2. Comfortable homestay'),
                            Spacer(),
                            rateComfortWidget(comHomestay),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            formHeading('3. Convinient for studying'),
                            Spacer(),
                            rateStudyWidget(studyConvinient),
                          ],
                        ),
                        Divider(),
                        titleWidget('Host parent hospitality'),
                        Row(
                          children: <Widget>[
                            formHeading('4. Friendliness'),
                            Spacer(),
                            rateFriendliness(friendliness)
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            formHeading('5. Sociable and good communication'),
                            Spacer(),
                            rateSocial(socialable),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            formHeading(
                                '6. Did you feel like part of the family'),
                            Spacer(),
                            rateFeelPartOfFmily(partOfFamily)
                          ],
                        ),
                        Divider(),
                        titleWidget('General living conditions'),
                        Row(
                          children: <Widget>[
                            formHeading('7. Cleanliness'),
                            Spacer(),
                            rateCleanliness(cleanliness),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            formHeading('8. Fresh and quality of food'),
                            Spacer(),
                            rateFreshFood(freshFood),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            formHeading('9. Overall rating'),
                            Spacer(),
                            rateOverally(overalRating)
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
                                  if (_formKey.currentState.validate()) {
                                    _formKey.currentState.save();
                                    Map<String, dynamic> feedBackData = {
                                      'studentUid': fUser.uid,
                                      'studentEmail': fUser.email,
                                      'studentPhotoUrl': fUser.photoUrl,
                                      'studentFullName': fUser.displayName,
                                      'studentNumber': user.studentNumber,
                                      'distanceFromSchool': distanceFromSchool,
                                      'comfortableHomestay': comHomestay,
                                      'convinientStudy': studyConvinient,
                                      'friendliness': friendliness,
                                      'sociable': socialable,
                                      'feelPartOfFamily': partOfFamily,
                                      'cleanliness': cleanliness,
                                      'freshFood': freshFood,
                                      'overalRating': overalRating,
                                      'hostFirstName': hostFirstName,
                                      'hostLastName': hostLastName,
                                      'hostUid':
                                          widget.hostFeedback.data['uid'],
                                      'feedBack': feedBack,
                                    };
                                    FeedBackManagement()
                                        .saveParentFeedback(feedBackData)
                                        .then((e) {
                                      Toast.show(
                                          'Host parent feedback submitted successfully',
                                          context,
                                          duration: Toast.LENGTH_LONG,
                                          gravity: Toast.BOTTOM);
                                      Navigator.of(context).pop();
                                      Navigator.of(context)
                                          .pushReplacementNamed(
                                              '/studenthomepage');
                                    });
                                  } else {
                                    setState(() {
                                      _validate = true;
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

  Widget rateDistanceWidget(String _value) {
    return Center(
      child: DropdownButton<String>(
        value: _value,
        onChanged: (String newValue) {
          setState(() {
            distanceFromSchool = newValue;
            //print(newValue);
          });
        },
        items: <String>['1', '2', '3', '4', '5']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
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

  Widget rateComfortWidget(String _value) {
    return Center(
      child: DropdownButton<String>(
        value: _value,
        onChanged: (String newValue) {
          setState(() {
            comHomestay = newValue;
            //print(newValue);
          });
        },
        items: <String>['1', '2', '3', '4', '5']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  Widget rateStudyWidget(String _value) {
    return Center(
      child: DropdownButton<String>(
        value: _value,
        onChanged: (String newValue) {
          setState(() {
            studyConvinient = newValue;
            //print(newValue);
          });
        },
        items: <String>['1', '2', '3', '4', '5']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  Widget rateFriendliness(String _value) {
    return Center(
      child: DropdownButton<String>(
        value: _value,
        onChanged: (String newValue) {
          setState(() {
            friendliness = newValue;
            //print(newValue);
          });
        },
        items: <String>['1', '2', '3', '4', '5']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  Widget rateSocial(String _value) {
    return Center(
      child: DropdownButton<String>(
        value: _value,
        onChanged: (String newValue) {
          setState(() {
            socialable = newValue;
            //print(newValue);
          });
        },
        items: <String>['1', '2', '3', '4', '5']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  Widget rateFeelPartOfFmily(String _value) {
    return Center(
      child: DropdownButton<String>(
        value: _value,
        onChanged: (String newValue) {
          setState(() {
            partOfFamily = newValue;
            //print(newValue);
          });
        },
        items: <String>['1', '2', '3', '4', '5']
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
        items: <String>['1', '2', '3', '4', '5']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  Widget rateFreshFood(String _value) {
    return Center(
      child: DropdownButton<String>(
        value: _value,
        onChanged: (String newValue) {
          setState(() {
            freshFood = newValue;
            //print(newValue);
          });
        },
        items: <String>['1', '2', '3', '4', '5']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  Widget rateOverally(String _value) {
    return Center(
      child: DropdownButton<String>(
        value: _value,
        onChanged: (String newValue) {
          setState(() {
            overalRating = newValue;
            //print(newValue);
          });
        },
        items: <String>['1', '2', '3', '4', '5']
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
