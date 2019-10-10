import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:homestay/ui/student/feedback_page.dart';
import 'package:homestay/utils/routes.dart';
import 'package:provider/provider.dart';

class SelectParentForFeedback extends StatefulWidget {
  @override
  _SelectParentForFeedbackState createState() =>
      _SelectParentForFeedbackState();
}

class _SelectParentForFeedbackState extends State<SelectParentForFeedback> {
  final CollectionReference collectionReference =
      Firestore.instance.collection('hostParents');

  @override
  Widget build(BuildContext context) {
    var fUser = Provider.of<FirebaseUser>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Search Host Parent',
          //Host Parent Feedback
          style: TextStyle(fontSize: 17),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/studenthomepage');
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: collectionReference
            .where('userType', isEqualTo: 'Host Parent')
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

                  return GestureDetector(
                    // onTap: () => navigateToDetail(snapshot.data.documents[index]),
                    onTap: () {
                      Navigator.of(context).push(new FadePageRoute(
                        builder: (c) {
                          return FeedbackForm(
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
                                '' + item['displayName'],
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 18),
                              ),
                              subtitle: Text('Click to send feedback'),
                              trailing: Icon(
                                Icons.forward,
                                color: Colors.black54,
                              ),
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
