import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:homestay/ui/coordinator/coodinator_signin.dart';
import 'package:homestay/ui/hostparent/parent_signin.dart';
import 'package:homestay/ui/student/student_signin.dart';

class LauncherPage extends StatefulWidget {
  @override
  _LauncherPageState createState() => _LauncherPageState();
}

class _LauncherPageState extends State<LauncherPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image(
            image: AssetImage('assets/images/home.jpg'),
            fit: BoxFit.cover,
            colorBlendMode: BlendMode.darken,
            color: Colors.black.withOpacity(0.7),
          ),
          Theme(
            data: ThemeData(
                brightness: Brightness.dark,
                inputDecorationTheme: InputDecorationTheme(
                  hintStyle: TextStyle(color: Colors.teal),
                  labelStyle: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Muli',
                    fontSize: 18,
                  ),
                ),
                hintColor: Colors.white),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  children: <Widget>[
                    Container(
                      height: 140,
                      child: Image.asset(
                        'assets/images/logo.png',
                      ),
                    ),
                    Card(
                      elevation: 20,
                      margin: EdgeInsets.all(2),
                      color: Colors.black.withOpacity(0.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.home,
                                  size: 70,
                                  color: Colors.teal.withOpacity(0.7),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Homestay',
                                      textScaleFactor: 1.2,
                                      maxLines: 3,
                                      softWrap: true,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FontStyle.normal,
                                        fontFamily: 'Monoton',
                                      ),
                                    ),
                                    Text(
                                      'Student',
                                      textScaleFactor: 1.2,
                                      maxLines: 3,
                                      softWrap: true,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FontStyle.normal,
                                        fontFamily: 'Monoton',
                                      ),
                                    ),
                                    Text(
                                      'Accommodation',
                                      textScaleFactor: 1.2,
                                      maxLines: 3,
                                      softWrap: true,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FontStyle.normal,
                                        fontFamily: 'Monoton',
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: 330,
                              child: RaisedButton(
                                padding: EdgeInsets.all(16),
                                color: Colors.teal,
                                onPressed: () {
//                                  Navigator.of(context).pushReplacementNamed(
//                                      '/studentsigninpage');
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              StudentSignIn()));
                                },
                                elevation: 30,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Icon(FontAwesomeIcons.male),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'Student',
                                      style: TextStyle(
                                          fontSize: 20, fontFamily: 'Muli'),
                                    ),
                                  ],
                                ),
                                shape: StadiumBorder(
                                  side:
                                      BorderSide(color: Colors.black, width: 0),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Container(
                              width: 330,
                              child: RaisedButton(
                                padding: EdgeInsets.all(16),
                                color: Colors.teal,
                                onPressed: () {
//                                  Navigator.of(context)
//                                      .pushReplacementNamed('/signinpage');
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ParentSignIn()));
                                },
                                elevation: 30,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Icon(FontAwesomeIcons.users),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Text(
                                      'Host Parent',
                                      style: TextStyle(
                                          fontSize: 20, fontFamily: 'Muli'),
                                    ),
                                  ],
                                ),
                                shape: StadiumBorder(
                                  side:
                                      BorderSide(color: Colors.black, width: 0),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Container(
                              width: 330,
                              child: RaisedButton(
                                padding: EdgeInsets.all(16),
                                color: Colors.teal,
                                onPressed: () {
//                                  Navigator.of(context).pushReplacementNamed(
//                                      '/coodinatorsigninpage');
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CoodinatorSignIn()));
                                },
                                elevation: 30,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Icon(FontAwesomeIcons.userAlt),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'Co-ordinator',
                                      style: TextStyle(
                                          fontSize: 20, fontFamily: 'Muli'),
                                    ),
                                  ],
                                ),
                                shape: StadiumBorder(
                                  side:
                                      BorderSide(color: Colors.black, width: 0),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget horizontalLine() => Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: Container(
          width: 50,
          height: 1.0,
          color: Colors.grey,
        ),
      );
}
