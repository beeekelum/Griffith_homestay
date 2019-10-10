import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:homestay/models/user.dart';
import 'package:homestay/services/firestore_services.dart';
import 'package:homestay/widgets/app_widgets.dart';
import 'package:provider/provider.dart';

class ViewHostPFeedbackForm extends StatefulWidget {
  ViewHostPFeedbackForm({this.hostFeedback});
  final DocumentSnapshot hostFeedback;
  @override
  _ViewHostPFeedbackFormState createState() => _ViewHostPFeedbackFormState();
}

class _ViewHostPFeedbackFormState extends State<ViewHostPFeedbackForm> {
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
                'Student Detailed feedback',
                style: TextStyle(fontSize: 16),
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
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            widget.hostFeedback.data['feedBack'],
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('Host name: '),
                            Text(widget.hostFeedback.data['hostFirstName']),
                          ],
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('Host surname: '),
                            Text(widget.hostFeedback.data['hostLastName']),
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
                            Text(
                                widget.hostFeedback.data['distanceFromSchool']),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            formHeading('2. Comfortable homestay'),
                            Spacer(),
                            Text(widget
                                .hostFeedback.data['comfortableHomestay']),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            formHeading('3. Convinient for studying'),
                            Spacer(),
                            Text(widget.hostFeedback.data['convinientStudy']),
                          ],
                        ),
                        Divider(),
                        titleWidget('Host parent hospitality'),
                        Row(
                          children: <Widget>[
                            formHeading('4. Friendliness'),
                            Spacer(),
                            Text(widget.hostFeedback.data['friendliness']),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            formHeading('5. Sociable and good communication'),
                            Spacer(),
                            Text(widget.hostFeedback.data['sociable']),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            formHeading(
                                '6. Did you feel like part of the family'),
                            Spacer(),
                            Text(widget.hostFeedback.data['feelPartOfFamily']),
                          ],
                        ),
                        Divider(),
                        titleWidget('General living conditions'),
                        Row(
                          children: <Widget>[
                            formHeading('7. Cleanliness'),
                            Spacer(),
                            Text(widget.hostFeedback.data['cleanliness']),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            formHeading('8. Fresh and quality of food'),
                            Spacer(),
                            Text(widget.hostFeedback.data['freshFood']),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            formHeading('9. Overall rating'),
                            Spacer(),
                            Text(widget.hostFeedback.data['overalRating']),
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
}
