import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:homestay/tools/app_data.dart';
import 'package:homestay/tools/app_methods.dart';

class ListingManagement implements AppMethods {
  Future<String> saveListing(listingData) async {
    String dcmntID;

    final collRef = Firestore.instance.collection('listings');
    DocumentReference docReference = collRef.document();
    await docReference.setData(listingData).then((doc) {
      dcmntID = docReference.documentID;
      print('hop ${docReference.documentID}');
    }).catchError((error) {
      print(error);
    });

    return dcmntID;
  }

  updateListing(listingId, data) {
    Firestore.instance
        .collection('listings')
        .document(listingId)
        .updateData(data);
    //Navigator.of(context).pushReplacementNamed(routeName);
  }

  @override
  Future<bool> updateListingImages({String docID, List<String> data}) async {
    // TODO: implement updateListingImages
    bool msg;
    await Firestore.instance
        .collection(listings)
        .document(docID)
        .updateData({listingImages: data}).whenComplete(() {
      msg = true;
    });
    return msg;
  }

  @override
  Future<List<String>> uploadListingImages(
      {String docID, List<File> imageList}) async {
    List<String> imagesUrl = new List();

    try {
      for (int s = 0; s < imageList.length; s++) {
        StorageReference storageReference = FirebaseStorage.instance
            .ref()
            .child(listings)
            .child(docID)
            .child(docID + '$s.jpg');
        StorageUploadTask uploadTask = storageReference.putFile(imageList[s]);
        StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
        String downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();
        imagesUrl.add(downloadUrl.toString());
      }
    } on PlatformException catch (e) {
      imagesUrl.add(error);
      print(e.toString());
    }
    return imagesUrl;
  }
}
