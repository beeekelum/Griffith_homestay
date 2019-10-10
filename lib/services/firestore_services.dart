import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:homestay/models/user.dart';

class FirestoreServices {
  final Firestore _fs = Firestore.instance;

  Future<User> getUser(String id) async {
    var snap = await _fs.collection('users').document(id).get();
    return User.fromMap(snap.data);
  }

  //Get a stream of a single document
  Stream<User> streamHostParent(String id) {
    return _fs
        .collection('hostParents')
        .document(id)
        .snapshots()
        .map((snap) => User.fromMap(snap.data));
  }

  Stream<User> streamStudent(String id) {
    return _fs
        .collection('students')
        .document(id)
        .snapshots()
        .map((snap) => User.fromMap(snap.data));
  }
}
