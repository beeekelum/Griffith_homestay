import 'package:cloud_firestore/cloud_firestore.dart';

class PreferenceManagement {
  Future<String> saveStudentPreference(preferenceData) async {
    String documentID;

    final collRef = Firestore.instance.collection('studentPreferences');
    DocumentReference docReference = collRef.document();
    await docReference.setData(preferenceData).then((doc) {
      documentID = docReference.documentID;
      //print('hop ${docReference.documentID}');
    }).catchError((error) {
      print(error);
    });

    return documentID;
  }
}
