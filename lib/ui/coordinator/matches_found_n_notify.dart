import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:toast/toast.dart';

class MatchFoundNotify extends StatefulWidget {
  MatchFoundNotify({this.preference});

  final DocumentSnapshot preference;

  @override
  _MatchFoundNotifyState createState() => _MatchFoundNotifyState();
}

class _MatchFoundNotifyState extends State<MatchFoundNotify> {
  @override
  Widget build(BuildContext context) {
    CollectionReference col = Firestore.instance.collection('listings');
    Query accommodationQuery = col.where('accommodationDuration',
        isEqualTo: widget.preference.data['accommodationDuration']);
    Query religion = accommodationQuery.where('hostReligion',
        isEqualTo: widget.preference.data['studentReligion']);
    Query levelOfStudyQuery = accommodationQuery.where('preferedLevelOfStudy',
        isEqualTo: widget.preference.data['levelOfStudy']);

    Query language = levelOfStudyQuery.where('hostLanguage',
        isEqualTo: widget.preference.data['studentPreferredLanguage']);
    Query smokingPreference = language.where('smokingStudent',
        isEqualTo: widget.preference.data['smokingPreference']);
    Query pets = smokingPreference.where('studentWithPets',
        isEqualTo: widget.preference.data['petsPreference']);
//    Query levelOfStudy = pets.where('preferedLevelOfStudy',
//        isEqualTo: widget.preference.data['levelOfStudy']);
    //    Query nationalityQuery = levelOfStudyQuery.where('hostNationality',
//        isEqualTo: widget.preference.data['nationality']);

    return Scaffold(
      appBar: AppBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Property Matched for student: ',
              style: TextStyle(fontSize: 15),
            ),
            Text(
              widget.preference.data['studentFullName'] ?? '',
              style: TextStyle(fontSize: 17),
            ),
          ],
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
        stream: religion.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                final item = snapshot.data.documents[index];
                return GestureDetector(
                  onTap: () {},
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
                              Icons.home,
                              color: Colors.teal,
                              size: 30,
                            ),
                            title: Text(
                              item['cottageColorName'] + ' Cottage',
                              style: TextStyle(
                                  fontWeight: FontWeight.w100,
                                  color: Colors.black,
                                  fontSize: 14),
                            ),
                            subtitle: Text(
                              'Host: ' + item['hostFullName'],
                              style: TextStyle(
                                color: Colors.teal,
                              ),
                            ),
                            trailing: MaterialButton(
                              elevation: 7,
                              color: Colors.teal,
                              onPressed: () async {
                                Map<String, dynamic> matchDetails = {
                                  'match': 'Match Found',
                                  'hostParent': item['hostFullName'],
                                  'studentName':
                                      widget.preference.data['studentFullName'],
                                  'studentNumber':
                                      widget.preference.data['studentNumber'],
                                  'studentEmail':
                                      widget.preference.data['studentEmail'],
                                  'hostEmail': item['hostEmail'],
                                  'status':
                                      'Waiting for host feedback and notify student',
                                  'isStudentNotified': 'No'
                                };
                                Firestore.instance
                                    .collection('matchesFound')
                                    .document(widget
                                            .preference.data['studentNumber'] +
                                        '_' +
                                        item['hostFirstName'] +
                                        '_' +
                                        item['hostLastName'])
                                    .get()
                                    .then((onValue) {
                                  if (onValue.exists) {
                                    Toast.show(
                                        "Match notification email already sent to host parent " +
                                            item['hostFullName'],
                                        context,
                                        duration: Toast.LENGTH_LONG,
                                        gravity: Toast.BOTTOM);
                                  } else {
                                    Firestore.instance
                                        .collection('matchesFound')
                                        .document(widget.preference
                                                .data['studentNumber'] +
                                            '_' +
                                            item['hostFirstName'] +
                                            '_' +
                                            item['hostLastName'])
                                        .setData(matchDetails);
                                    _sendEmail(item['hostEmail'],
                                        widget.preference.data['studentEmail']);
                                  }
                                });
                              },
                              child: Text(
                                'Notify',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return new Text('${snapshot.error}');
          } else {
            return Center(
              child: Text(
                'No matches found !!!',
                style: TextStyle(fontSize: 20),
              ),
            );
          }
        },
      ),
    );
  }

  _sendEmail(String _email, String _studentEmail) async {
    final Email email = Email(
      body:
          'Dear host parent you have been matched with a student. For further details contact program coordinator on phone number 061 00000 or reply this email',
      subject: 'Griffith College Homestay matching',
      recipients: [_email],
      //cc: [_studentEmail],
    );
    await FlutterEmailSender.send(email);
  }
}
