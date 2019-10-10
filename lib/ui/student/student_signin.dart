import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:toast/toast.dart';

class StudentSignIn extends StatefulWidget {
  @override
  _StudentSignInState createState() => _StudentSignInState();
}

class _StudentSignInState extends State<StudentSignIn> {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _validate = false;
  String _studentNumber;
  String _password;
  bool passwordVisible;
  String authError;

  _showSnackBar() {
    final snackBar = new SnackBar(
      content: Row(
        children: <Widget>[
          CircularProgressIndicator(),
          SizedBox(
            width: 10,
          ),
          Text('Student logging in please wait ...'),
        ],
      ),
      //duration: new Duration(seconds: 3),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      //resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text(
          'Homestay Student Login',
          style: TextStyle(fontSize: 17),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/launcherpage', ModalRoute.withName('/'));
            },
          ),
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image(
            image: AssetImage('assets/images/stud.jpg'),
            fit: BoxFit.cover,
            colorBlendMode: BlendMode.darken,
            color: Colors.black.withOpacity(0.7),
          ),
          Theme(
            data: ThemeData(
                primaryColor: Colors.teal,
                inputDecorationTheme: InputDecorationTheme(
                  hintStyle: TextStyle(color: Colors.teal),
                  labelStyle: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Muli',
                    fontSize: 20,
                  ),
                ),
                hintColor: Colors.white),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                autovalidate: _validate,
                child: Center(
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    children: <Widget>[
                      Container(
                        height: 150,
                        child: Image.asset(
                          'assets/images/logo.png',
                        ),
                      ),
                      Card(
                        elevation: 30,
                        margin: EdgeInsets.all(2),
                        color: Colors.black.withOpacity(0.6),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: 330,
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  maxLength: 7,
                                  onSaved: (value) {
                                    setState(() {
                                      _studentNumber = value;
                                    });
                                  },
                                  validator: validateStudentNumber,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                        const Radius.circular(10),
                                      ),
                                    ),
                                    enabledBorder: const OutlineInputBorder(
                                      // width: 0.0 produces a thin "hairline" border
                                      borderSide: const BorderSide(
                                          color: Colors.teal, width: 1.5),
                                    ),
                                    labelText: 'Student Number',
                                    labelStyle: TextStyle(
                                      fontFamily: 'Muli',
                                      color: Colors.white,
                                    ),
                                    prefixIcon: Icon(
                                      Icons.account_circle,
                                      color: Colors.teal,
                                    ),
                                  ),
                                  style: TextStyle(
                                      fontFamily: 'Muli',
                                      color: Colors.white,
                                      fontSize: 17),
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Container(
                                width: 330,
                                child: TextFormField(
                                  maxLength: 10,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                        const Radius.circular(10),
                                      ),
                                    ),
                                    enabledBorder: const OutlineInputBorder(
                                      // width: 0.0 produces a thin "hairline" border
                                      borderSide: const BorderSide(
                                          color: Colors.teal, width: 1.5),
                                    ),
                                    labelText: 'Password',
                                    labelStyle: TextStyle(
                                      fontFamily: 'Muli',
                                      color: Colors.white,
                                    ),
                                    prefixIcon: Icon(
                                      FontAwesomeIcons.key,
                                      color: Colors.teal,
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        passwordVisible
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                      ),
                                      color: Colors.teal,
                                      onPressed: () {
                                        setState(() {
                                          passwordVisible = !passwordVisible;
                                        });
                                      },
                                    ),
                                  ),
                                  onSaved: (value) {
                                    setState(() {
                                      _password = value;
                                    });
                                  },
                                  validator: validatePassword,
                                  obscureText: passwordVisible,
                                  style: TextStyle(
                                      fontFamily: 'Muli',
                                      color: Colors.white,
                                      fontSize: 17),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: 330,
                                child: RaisedButton(
                                  padding: EdgeInsets.all(16),
                                  color: Colors.teal,
                                  onPressed: () {
                                    if (_formKey.currentState.validate()) {
                                      _formKey.currentState.save();
                                      _showSnackBar();
                                      FirebaseAuth.instance
                                          .signInWithEmailAndPassword(
                                              email: _studentNumber +
                                                  '@griffith.edu',
                                              password: _password)
                                          .then((FirebaseUser user) {
                                        Toast.show("Login successful", context,
                                            duration: Toast.LENGTH_LONG,
                                            gravity: Toast.BOTTOM,
                                            backgroundColor: Colors.green);
                                        Navigator.of(context)
                                            .pushReplacementNamed(
                                                '/studenthomepage');
                                      }).catchError((e) {
                                        switch (e.code) {
                                          case 'ERROR_INVALID_EMAIL':
                                            authError = 'Invalid Email';
                                            break;
                                          case 'ERROR_USER_NOT_FOUND':
                                            authError = 'User Not Found';
                                            break;
                                          case 'ERROR_WRONG_PASSWORD':
                                            authError = 'Wrong Password';
                                            break;
                                          default:
                                            authError = 'Error';
                                            break;
                                        }
                                        showToast(authError,
                                            gravity: Toast.BOTTOM,
                                            duration: Toast.LENGTH_LONG);
                                      });
                                    } else {
                                      _validate = true;
                                    }
                                  },
                                  elevation: 0,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Icon(
                                        FontAwesomeIcons.signInAlt,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 9,
                                      ),
                                      Text(
                                        'Login',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontFamily: 'Muli',
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  shape: StadiumBorder(
                                    side: BorderSide(
                                        color: Colors.black, width: 0),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushReplacementNamed(
                                      '/studentsignuppage');
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Text(
                                      'Don\'t have an account? Register',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontFamily: 'Muli',
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 15,
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
          ),
        ],
      ),
    );
  }

  void showToast(String msg, {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity);
  }

  String validatePassword(String _password) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&%*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    if (_password.isEmpty) {
      return 'Password is empty';
    } else if (!regExp.hasMatch(_password)) {
      return 'Uppercase, lowercase and alphanumerics';
    } else if (_password.toString().length < 8) {
      return 'Must have atleast 8 characters';
    }
    return null;
  }

  String validateEmail(String _email) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (_email.isEmpty) {
      return 'Email is empty';
    } else if (!regex.hasMatch(_email)) {
      return 'Invalid Email';
    }
    return null;
  }

  String validateStudentNumber(String _studentNumber) {
    String pattern = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(pattern);
    if (_studentNumber.isEmpty) {
      return 'Student number is empty';
    } else if (!regExp.hasMatch(_studentNumber)) {
      return 'Please enter valid student number';
    } else if (_studentNumber.length != 7)
      return 'Student Number must have 7 digits';
    else
      return null;
  }
}
