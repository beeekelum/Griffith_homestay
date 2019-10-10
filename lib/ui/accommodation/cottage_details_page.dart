import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:homestay/ui/accommodation/cottage_details_body.dart';
import 'package:homestay/ui/accommodation/cottage_details_header.dart';

class CottageDetails extends StatefulWidget {
  CottageDetails({this.cottage});
  final DocumentSnapshot cottage;

  @override
  _CottageDetailsState createState() => _CottageDetailsState();
}

class _CottageDetailsState extends State<CottageDetails> {
  @override
  Widget build(BuildContext context) {
    var linearGradient = BoxDecoration(
      gradient: LinearGradient(
        begin: FractionalOffset.centerRight,
        end: FractionalOffset.bottomLeft,
        colors: [
          Colors.teal.withOpacity(0.7),
          Colors.teal,
        ],
      ),
    );

    return Scaffold(
      backgroundColor: Colors.teal.withOpacity(0.6),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          decoration: linearGradient,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CottageDetailsHeader(widget.cottage),
              Padding(
                padding: const EdgeInsets.all(15),
                child: CottageDetailsBody(widget.cottage),
              ),
              // CottageDetailsFooter(widget.cottage),
            ],
          ),
        ),
      ),
    );
  }
}
