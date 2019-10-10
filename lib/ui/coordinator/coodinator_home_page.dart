import 'package:flutter/material.dart';
import 'package:homestay/ui/coordinator/coodinatorDashPage.dart';

class CoodinatorHomePage extends StatefulWidget {
  @override
  _CoodinatorHomePageState createState() => _CoodinatorHomePageState();
}

class _CoodinatorHomePageState extends State<CoodinatorHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(
//        title: Text('Student Home'),
//      ),
      //drawer: StudentDrawer(),
      body: CoodinatorOptions(),
    );
  }
}
