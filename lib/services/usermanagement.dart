import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:toast/toast.dart';

class UserManagement {
  storeNewHostParent(user, context, userType, firstName, lastName) {
    Firestore.instance.collection('/hostParents').document(user.uid).setData({
      'uid': user.uid,
      'email': user.email,
      'displayName': user.displayName,
      'photoUrl': user.photoUrl,
      'userType': userType,
      'firstName': firstName,
      'lastName': lastName,
      'createdAt': FieldValue.serverTimestamp(),
    }).then((value) {
      Toast.show("Parent registration successful", context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.BOTTOM,
          backgroundColor: Colors.green);
      Navigator.of(context).pop();
      Navigator.of(context).pushReplacementNamed('/parentsigninpage');
    }).catchError((e) {
      print(e);
    });
  }

  storeNewStudent(
      user, context, userType, firstName, lastName, studentNumber, email) {
    Firestore.instance.collection('/students').document(user.uid).setData({
      'uid': user.uid,
      'email': email,
      'displayName': user.displayName,
      'studentNumber': studentNumber,
      'photoUrl': user.photoUrl,
      'userType': userType,
      'firstName': firstName,
      'lastName': lastName,
      'createdAt': FieldValue.serverTimestamp(),
    }).then((value) {
      Toast.show("Student registration successful", context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.BOTTOM,
          backgroundColor: Colors.green);
      Navigator.of(context).pop();
      Navigator.of(context).pushReplacementNamed('/studentsigninpage');
    }).catchError((e) {
      print(e);
    });
  }

  updateUserProfile(userId, data) {
    Firestore.instance
        .collection('donateUsers')
        .document(userId)
        .updateData(data);
    //Navigator.of(context).pushReplacementNamed(routeName);
  }
}
