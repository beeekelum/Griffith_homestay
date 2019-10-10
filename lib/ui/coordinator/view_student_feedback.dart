import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:homestay/models/user.dart';
import 'package:homestay/services/firestore_services.dart';
import 'package:homestay/widgets/app_widgets.dart';
import 'package:provider/provider.dart';

class VieStudentFeedback extends StatefulWidget {
  VieStudentFeedback({this.studentFeedback});
  final DocumentSnapshot studentFeedback;
  @override
  _VieStudentFeedbackState createState() => _VieStudentFeedbackState();
}

class _VieStudentFeedbackState extends State<VieStudentFeedback> {
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
              title: Text(
                'Host Detailed feedback',
                style: TextStyle(fontSize: 15),
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
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey,
                  autovalidate: _validate,
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            widget.studentFeedback.data['feedBack'],
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('Student name: '),
                            Spacer(),
                            Text(widget
                                .studentFeedback.data['studentFirstName']),
                          ],
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('Student surname: '),
                            Spacer(),
                            Text(
                                widget.studentFeedback.data['studentLastName']),
                          ],
                        ),
                        Divider(),
                        _ratingKey(),
                        Divider(),
                        Row(
                          children: <Widget>[
                            formHeading('1. Student\'s Behaviour'),
                            Spacer(),
                            Text(widget
                                .studentFeedback.data['studentBehaviour']),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: <Widget>[
                            formHeading('2. Social Skills'),
                            Spacer(),
                            Text(widget.studentFeedback.data['socialSkills']),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: <Widget>[
                            formHeading('3. Cleanliness'),
                            Spacer(),
                            Text(widget.studentFeedback.data['cleanliness']),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: <Widget>[
                            formHeading('4. Academics'),
                            Spacer(),
                            Text(widget.studentFeedback.data['academics']),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: <Widget>[
                            formHeading('5. Settling In'),
                            Spacer(),
                            Text(widget.studentFeedback.data['settlingIn']),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: <Widget>[
                            formHeading('6. Overall rating'),
                            Spacer(),
                            Text(widget.studentFeedback.data['overallRating']),
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
