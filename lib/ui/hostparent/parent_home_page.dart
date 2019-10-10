import 'package:flutter/material.dart';
import 'package:homestay/ui/hostparent/parentDashPage.dart';

class ParentHomePage extends StatefulWidget {
  @override
  _ParentHomePageState createState() => _ParentHomePageState();
}

class _ParentHomePageState extends State<ParentHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(
//        title: Text('Student Home'),
//      ),
      //drawer: StudentDrawer(),
      body: ParentOptions(),
    );
  }
}
