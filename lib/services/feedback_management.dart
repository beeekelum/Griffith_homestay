import 'package:cloud_firestore/cloud_firestore.dart';

class FeedBackManagement {
  Future<String> saveFeedback(feedBackData) async {
    String documentID;

    final collRef = Firestore.instance.collection('hostParentFeedback');
    DocumentReference docReference = collRef.document();
    await docReference.setData(feedBackData).then((doc) {
      documentID = docReference.documentID;
      //print('hop ${docReference.documentID}');
    }).catchError((error) {
      print(error);
    });

    return documentID;
  }

  Future<String> saveParentFeedback(feedBackData) async {
    String documentID;

    final collRef = Firestore.instance.collection('studentFeedback');
    DocumentReference docReference = collRef.document();
    await docReference.setData(feedBackData).then((doc) {
      documentID = docReference.documentID;
      //print('hop ${docReference.documentID}');
    }).catchError((error) {
      print(error);
    });

    return documentID;
  }
}
