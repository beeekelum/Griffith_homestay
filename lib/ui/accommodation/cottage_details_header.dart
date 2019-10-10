import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:homestay/ui/accommodation/cottage_colored_image.dart';

class CottageDetailsHeader extends StatefulWidget {
  CottageDetailsHeader(this.cottage);

  final DocumentSnapshot cottage;

  @override
  _CottageDetailsHeaderState createState() => _CottageDetailsHeaderState();
}

class _CottageDetailsHeaderState extends State<CottageDetailsHeader> {
  static const BACKGROUND_IMAGE = 'assets/images/profile_header_background.png';

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    var screenWidth = MediaQuery.of(context).size.width;
    var diagonalBackground = new DiagonallyCutColoredImage(
      Image.asset(
        BACKGROUND_IMAGE,
        width: screenWidth,
        height: 130,
        fit: BoxFit.cover,
      ),
    );
    var avatar = Hero(
      tag: '',
      child: CircleAvatar(
        child: Text(
          widget.cottage.data['cottageColorName'][0],
          style: TextStyle(
            color: Colors.white,
            fontSize: 50,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.normal,
            fontFamily: 'Monoton',
          ),
        ),
        backgroundColor: Colors.teal,
        // backgroundImage: NetworkImage(widget.cottage.data['photoUrl']),
        radius: 50,
      ),
    );

    var cottageName = Text(
      widget.cottage.data['cottageColorName'] + ' Cottage',
      style: TextStyle(fontSize: 20, color: Colors.white),
    );

    var likeInfo = Padding(
      padding: const EdgeInsets.only(
        top: 8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.thumb_up,
            color: Colors.white,
            size: 16,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 8,
            ),
            child: Text(
              '0',
              style: textTheme.subhead.copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    );

    var actionButtons = Padding(
      padding: const EdgeInsets.only(
        top: 16,
        left: 16,
        right: 16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: RaisedButton(
              color: Colors.green,
              disabledColor: Colors.grey,
              textColor: Colors.white,
              onPressed: () async {},
              child: Text('LIKE'),
            ),
          ),
        ],
      ),
    );

    return Stack(
      children: <Widget>[
        diagonalBackground,
        Align(
          alignment: FractionalOffset.bottomCenter,
          heightFactor: 1.4,
          child: Column(
            children: <Widget>[
              avatar,
              cottageName,
//              likeInfo,
//              actionButtons,
            ],
          ),
        ),
        Positioned(
          top: 26,
          left: 4,
          child: BackButton(
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
