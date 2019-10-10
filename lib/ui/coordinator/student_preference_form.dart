import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:homestay/ui/coordinator/view_student_preference.dart';
import 'package:homestay/utils/routes.dart';
import 'package:provider/provider.dart';

class StudentPreferenceForm extends StatefulWidget {
  @override
  _StudentPreferenceFormState createState() => _StudentPreferenceFormState();
}

class _StudentPreferenceFormState extends State<StudentPreferenceForm> {
  final CollectionReference collectionReference =
      Firestore.instance.collection('studentPreferences');

  @override
  Widget build(BuildContext context) {
    var fUser = Provider.of<FirebaseUser>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Student Preferences',
          style: TextStyle(fontSize: 17),
        ),
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
                          return ViewStudentPreferencePge(
                              preference: snapshot.data.documents[index]);
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
                                item['studentFullName'] ?? 'No name',
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
