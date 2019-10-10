import 'dart:io';

import 'package:flutter/material.dart';

Widget MultiImagePickerList(
    {List<File> imageList, VoidCallback removeNewImage(int position)}) {
  return Padding(
    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
    child: imageList == null || imageList.length == 0
        ? Container()
        : SizedBox(
            height: 107.0,
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: imageList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(left: 3.0, right: 3.0),
                  child: Stack(
                    children: <Widget>[
                      Container(
                        width: 90.0,
                        height: 90.0,
                        decoration: BoxDecoration(
                          color: Colors.grey.withAlpha(100),
                          borderRadius: BorderRadius.all(
                            Radius.circular(15.0),
                          ),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: FileImage(
                              imageList[index],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.red[500],
                          child: IconButton(
                            icon: Icon(
                              Icons.clear,
                              size: 14,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              removeNewImage(index);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
  );
}

Widget titleWidget(String title) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 21,
        fontWeight: FontWeight.w900,
        color: Colors.teal,
      ),
    ),
  );
}

Widget titleWidget2(String title) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 19,
        fontWeight: FontWeight.w900,
        color: Colors.white,
      ),
    ),
  );
}

Widget formHeading(String title) {
  return Padding(
    padding: const EdgeInsets.all(2.0),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Colors.teal,
        //decoration: TextDecoration.underline,
      ),
    ),
  );
}
