import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:homestay/ui/hostparent/parent_feedback_form.dart';
import 'package:homestay/utils/routes.dart';
import 'package:provider/provider.dart';

class StudentsList extends StatefulWidget {
  @override
  _StudentsListState createState() => _StudentsListState();
}

class _StudentsListState extends State<StudentsList> {
  final CollectionReference collectionReference =
      Firestore.instance.collection('students');

  @override
  Widget build(BuildContext context) {
    var fUser = Provider.of<FirebaseUser>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Search student',
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
        stream: collectionReference.snapshots(),
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
                  return GestureDetector(
                    // onTap: () => navigateToDetail(snapshot.data.documents[index]),
                    onTap: () {
                      Navigator.of(context).push(new FadePageRoute(
                        builder: (c) {
                          return HostPFeedbackForm(
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
                                item['displayName'] ??
                                    item['firstName'] + ' ' + item['lastName'],
                                style: TextStyle(
                                    fontWeight: FontWeight.w100,
                                    color: Colors.black54),
                              ),
                              subtitle: Text(
                                'Student No : ' + item['studentNumber'],
                                style: TextStyle(
                                    color: Colors.teal,
                                    fontWeight: FontWeight.bold),
                              ),
                              trailing: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(new FadePageRoute(
                                    builder: (c) {
                                      return HostPFeedbackForm(
                                          hostFeedback:
                                              snapshot.data.documents[index]);
                                    },
                                    settings: new RouteSettings(),
                                  ));
                                },
                                child: Hero(
                                  tag: index,
                                  child: CircleAvatar(
                                    child: Text(
                                      item['userType'][0],
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FontStyle.normal,
                                        fontFamily: 'Muli',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, bottom: 5),
                                  child: Text(
                                    'Tap to complete student feedback',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black45,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
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
