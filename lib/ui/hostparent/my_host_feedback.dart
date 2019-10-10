import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:homestay/ui/hostparent/my_view_student_feedback.dart';
import 'package:homestay/utils/routes.dart';
import 'package:provider/provider.dart';

class MyFeedbackHost extends StatefulWidget {
  @override
  _MyFeedbackHostState createState() => _MyFeedbackHostState();
}

class _MyFeedbackHostState extends State<MyFeedbackHost> {
  final CollectionReference collectionReference =
      Firestore.instance.collection('studentFeedback');

  @override
  Widget build(BuildContext context) {
    var fUser = Provider.of<FirebaseUser>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Feedback from Students',
          //Host Parent Feedback
          style: TextStyle(fontSize: 17),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/coodinatorhomepage');
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: collectionReference
            .where('hostUid', isEqualTo: fUser.uid)
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

                  int distanceFromSchool =
                      int.parse(item['distanceFromSchool']);
                  int comfort = int.parse(item['comfortableHomestay']);
                  int studying = int.parse(item['convinientStudy']);
                  int friendliness = int.parse(item['friendliness']);
                  int social = int.parse(item['sociable']);
                  int feelPart = int.parse(item['feelPartOfFamily']);
                  int cleanliness = int.parse(item['cleanliness']);
                  int freshFood = int.parse(item['freshFood']);
                  int overalRating = int.parse(item['overalRating']);

                  int summation = distanceFromSchool +
                      comfort +
                      studying +
                      friendliness +
                      social +
                      feelPart +
                      cleanliness +
                      freshFood +
                      overalRating;

                  double average = summation / 9;

//                  print(summation);
//                  print(average);

                  return GestureDetector(
                    // onTap: () => navigateToDetail(snapshot.data.documents[index]),
                    onTap: () {
                      Navigator.of(context).push(new FadePageRoute(
                        builder: (c) {
                          return ViewFeedbackFromStudent(
                              hostFeedback: snapshot.data.documents[index]);
                        },
                        settings: new RouteSettings(),
                      ));
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
                                'Host name: ' +
                                    item['hostFirstName'] +
                                    ' ' +
                                    item['hostLastName'],
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 14),
                              ),
                              subtitle: Column(
                                // mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('Feedback from:'),
                                  Text(
                                    item['studentFullName'] ??
                                        item['studentNumber'],
                                    style: TextStyle(color: Colors.purple),
                                  ),
                                ],
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
                                        color: Colors.black54,
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
