import 'package:flutter/material.dart';
import 'package:homestay/ui/student/studentDashPage.dart';

class StudentHomePage extends StatefulWidget {
  @override
  _StudentHomePageState createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StudentOptions(),
    );
  }
}
