import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:provider/provider.dart';

class MatchesFoundHistory extends StatefulWidget {
  @override
  _MatchesFoundHistoryState createState() => _MatchesFoundHistoryState();
}

class _MatchesFoundHistoryState extends State<MatchesFoundHistory> {
  final CollectionReference collectionReference =
      Firestore.instance.collection('matchesFound');

  @override
  Widget build(BuildContext context) {
    var fUser = Provider.of<FirebaseUser>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Matches found',
          style: TextStyle(fontSize: 17),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/coodinatorhomepage', ModalRoute.withName('/'));
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
                  final itemID = snapshot.data.documents[index].documentID;
                  return GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Card(
                        elevation: 8,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 5, right: 5, bottom: 5),
                          child: Column(
                            children: <Widget>[
                              Text(
                                'Notified by email: ',
                                style:
                                    TextStyle(fontSize: 17, color: Colors.teal),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'Host Parent:',
                                        style: TextStyle(
                                            decoration:
                                                TextDecoration.underline,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 2,
                                      ),
                                      Text(
                                        item['hostParent'],
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black54),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'Student Name:',
                                        style: TextStyle(
                                            decoration:
                                                TextDecoration.underline,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        item['studentName'],
                                        style: TextStyle(color: Colors.black54),
                                      ),
                                      Text(
                                        'Student Number:',
                                        style: TextStyle(
                                            decoration:
                                                TextDecoration.underline,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(item['studentNumber']),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  item['isStudentNotified'] == 'No'
                                      ? MaterialButton(
                                          onPressed: () {
                                            _notifyStudent(itemID);
                                            _sendEmail(
                                                item['studentEmail'],
                                                item['hostParent'],
                                                item['studentName']);
                                          },
                                          color: Colors.green,
                                          child: Text(
                                            'Notify Student',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        )
                                      : Container(),
                                  item['isStudentNotified'] == 'Yes'
                                      ? MaterialButton(
                                          onPressed: () {
                                            _notifyParent(itemID);
                                            _sendHostEmail(
                                                item['hostEmail'],
                                                item['hostParent'],
                                                item['studentName']);
                                          },
                                          color: Colors.blue,
                                          child: Text(
                                            'Notify Parent',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        )
                                      : Container(),
                                  item['isStudentNotified'] == 'AllNotified'
                                      ? Text(
                                          'Both student and host have been notified. 😊')
                                      : Container(),
                                ],
                              ),
                            ],
                          ),
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

  _notifyStudent(String id) {
    Firestore.instance
        .collection('matchesFound')
        .document(id)
        .updateData({'isStudentNotified': 'Yes'});
  }

  _sendEmail(String _email, String hostFullName, String studentFullName) async {
    final Email email = Email(
      body:
          'Goodday $studentFullName \t\tThis is to confirm that you have been matched to host parent $hostFullName. \tFor further details contact program coordinator on 06100000 or reply to this email. \t\tRegards \tGriffith College Coordinator',
      subject: 'Griffith College Homestay matching',
      recipients: [_email],
      //cc: [_studentEmail],
    );
    await FlutterEmailSender.send(email);
  }

  _sendHostEmail(
      String _email, String hostFullName, String studentFullName) async {
    final Email email = Email(
      body:
          'Goodday $hostFullName \t\tFinal Confirmation of Match \t\t This is to confirm that you will host student $studentFullName. For further details contact program coordinator on 06100000 or reply to this email. \t\tRegards \tGriffith College Coordinator',
      subject: 'Griffith College Homestay matching',
      recipients: [_email],
      //cc: [_studentEmail],
    );
    await FlutterEmailSender.send(email);
  }

  _notifyParent(String itemID) {
    Firestore.instance
        .collection('matchesFound')
        .document(itemID)
        .updateData({'isStudentNotified': 'AllNotified'});
  }
}
