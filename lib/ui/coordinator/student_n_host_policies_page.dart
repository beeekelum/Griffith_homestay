import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class StudentNHostPoliciesPage extends StatefulWidget {
  @override
  _StudentNHostPoliciesPageState createState() =>
      _StudentNHostPoliciesPageState();
}

class _StudentNHostPoliciesPageState extends State<StudentNHostPoliciesPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  _showSnackBar() {
    final snackBar = new SnackBar(
      content: Row(
        children: <Widget>[
          CircularProgressIndicator(),
          SizedBox(
            width: 10,
          ),
          Text('Uploading document please wait ...'),
        ],
      ),
      //duration: new Duration(seconds: 3),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Policies page'),
        actions: <Widget>[],
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Click to upload PDF',
              style: TextStyle(fontSize: 20),
            ),
          ),
          Expanded(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MaterialButton(
                      color: Colors.teal,
                      onPressed: () {
                        getPdfAndUpload('Host Parent Handbook', 'parent');
                      },
                      child: Text(
                        'Host Parent Handbook',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MaterialButton(
                      onPressed: () {
                        getPdfAndUpload(
                            'Inspection host family form', 'parent');
                      },
                      color: Colors.teal,
                      child: Text(
                        'Inspection host family form',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MaterialButton(
                      onPressed: () {
                        getPdfAndUpload('Host parent agreement', 'parent');
                      },
                      color: Colors.teal,
                      child: Text(
                        'Host parent agreement',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.black,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MaterialButton(
                      color: Colors.teal,
                      onPressed: () {
                        getPdfAndUpload('Student homestay handbook', 'student');
                      },
                      child: Text(
                        'Student homestay handbook',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MaterialButton(
                      onPressed: () {
                        getPdfAndUpload('Homestay rules', 'student');
                      },
                      color: Colors.teal,
                      child: Text(
                        'Homestay rules',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MaterialButton(
                      onPressed: () {
                        getPdfAndUpload('Homestay agreement', 'student');
                      },
                      color: Colors.teal,
                      child: Text(
                        'Homestay agreement',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future getPdfAndUpload(String filename, String userType) async {
    File file = await FilePicker.getFile(type: FileType.ANY);
    String fileName = '${filename}.pdf';
    print(fileName);
    print('${file.readAsBytesSync()}');
    savePdf(file.readAsBytesSync(), fileName, filename, userType);
  }

  Future savePdf(
      List<int> asset, String name, String ogName, String userType) async {
    _showSnackBar();
    StorageReference reference =
        FirebaseStorage.instance.ref().child('homestayDocs').child(name);
    StorageUploadTask uploadTask = reference.putData(asset);
    String url = await (await uploadTask.onComplete).ref.getDownloadURL();
    print(url);
    Toast.show("Upload successful", context,
        duration: Toast.LENGTH_SHORT,
        gravity: Toast.BOTTOM,
        backgroundColor: Colors.green);
    Navigator.of(context).pop();
    documentFileUpload(name, ogName, url, userType);
    return url;
  }

  void documentFileUpload(
      String docName, String ogName, String str, String userType) {
    Map<String, dynamic> documentDetails = {
      'documentNamePdf': docName,
      'documentName': ogName,
      'docUrl': str,
      'userType': userType
    };
    Firestore.instance
        .collection('/homestayDocs')
        .document(docName)
        .setData(documentDetails)
        .then((value) {
      Toast.show(docName + " Document uploaded successfully", context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.BOTTOM,
          backgroundColor: Colors.green);
    });
  }
}
