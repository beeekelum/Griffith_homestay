import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:homestay/ui/coordinator/view_student_feedback.dart';
import 'package:homestay/utils/routes.dart';
import 'package:provider/provider.dart';

class HostPStudentFeedback extends StatefulWidget {
  @override
  _HostPStudentFeedbackState createState() => _HostPStudentFeedbackState();
}

class _HostPStudentFeedbackState extends State<HostPStudentFeedback> {
  final CollectionReference collectionReference =
      Firestore.instance.collection('hostParentFeedback');

  @override
  Widget build(BuildContext context) {
    var fUser = Provider.of<FirebaseUser>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Students Feedback',
          style: TextStyle(fontSize: 17),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/parenthomepage');
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: collectionReference
            .where('hostParentUid', isEqualTo: fUser.uid)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) return new Text('${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              return ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  final item = snapshot.data.documents[index];
//                final itemID = snapshot.data.documents[index].documentID;
//                final list = snapshot.data.documents;

                  int academics = int.parse(item['academics']);
                  int cleanliness = int.parse(item['cleanliness']);
                  int overallRating = int.parse(item['overallRating']);
                  int settlingIn = int.parse(item['settlingIn']);
                  int socialSkills = int.parse(item['socialSkills']);
                  int studentBehaviour = int.parse(item['studentBehaviour']);

                  int summation = academics +
                      cleanliness +
                      overallRating +
                      settlingIn +
                      socialSkills +
                      studentBehaviour;

                  double average = summation / 6;

//                  print(academics);
//                  print(cleanliness);
//                  print(overallRating);
//                  print(settlingIn);
//                  print(socialSkills);
//                  print(studentBehaviour);
//                  print(summation);
//                  print(average);

                  return GestureDetector(
                    // onTap: () => navigateToDetail(snapshot.data.documents[index]),
                    onTap: () {
                      Navigator.of(context).push(
                        new FadePageRoute(
                          builder: (c) {
                            return VieStudentFeedback(
                                studentFeedback:
                                    snapshot.data.documents[index]);
                          },
                          settings: new RouteSettings(),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Card(
                        elevation: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            ListTile(
                              leading: Icon(
                                Icons.account_circle,
                                color: Colors.teal,
                                size: 50,
                              ),
                              title: Text(
                                'Student name: ' +
                                    item['studentFirstName'] +
                                    ' ' +
                                    item['studentLastName'],
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                              subtitle: Text(
                                'Tap to see more details',
                                style: TextStyle(color: Colors.purple),
                              ),
                              trailing: Icon(
                                Icons.forward,
                                color: Colors.black54,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    average.toStringAsFixed(2) + ' / 5',
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                FlutterRatingBar(
                                  initialRating: average,
                                  itemSize: 20,
                                  fillColor: Colors.amber,
                                  borderColor: Colors.amber.withAlpha(70),
                                  allowHalfRating: true,
                                  onRatingUpdate: (rating) {
                                    print(rating);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
          }
        },
      ),
    );
  }
}
