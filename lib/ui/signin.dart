import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:toast/toast.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String _email;
  String _password;
  bool passwordVisible;

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image(
            image: AssetImage('assets/images/home.jpg'),
            fit: BoxFit.cover,
            colorBlendMode: BlendMode.darken,
            color: Colors.black.withOpacity(0.4),
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
              child: Center(
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  children: <Widget>[
                    Card(
                      elevation: 30,
                      margin: EdgeInsets.all(2),
                      color: Colors.black.withOpacity(0.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.home,
                                  size: 70,
                                  color: Colors.teal,
                                ),
                                Text(
                                  'Homestay',
                                  textScaleFactor: 1.2,
                                  softWrap: true,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.normal,
                                    fontFamily: 'Monoton',
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              width: 330,
                              child: TextField(
                                onChanged: (value) {
                                  setState(() {
                                    _email = value;
                                  });
                                },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                      const Radius.circular(30),
                                    ),
                                  ),
                                  labelText: 'Email Address',
                                  labelStyle: TextStyle(
                                    fontFamily: 'Muli',
                                    color: Colors.white,
                                  ),
                                  prefixIcon: Icon(
                                    Icons.mail,
                                    color: Colors.teal,
                                  ),
                                ),
                                style: TextStyle(
                                    fontFamily: 'Muli', color: Colors.white),
                              ),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Container(
                              width: 330,
                              child: TextField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                      const Radius.circular(30),
                                    ),
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
                                onChanged: (value) {
                                  setState(() {
                                    _password = value;
                                  });
                                },
                                obscureText: passwordVisible,
                                style: TextStyle(
                                    fontFamily: 'Muli', color: Colors.white),
                              ),
                            ),
                            Container(
                              width: 330,
                              alignment: Alignment(1.0, 0.0),
                              padding: EdgeInsets.only(top: 15.0, left: 20.0),
                              child: InkWell(
                                child: Text(
                                  'Forgot Password',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontFamily: 'Muli',
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Container(
                              width: 330,
                              child: RaisedButton(
                                padding: EdgeInsets.all(16),
                                color: Colors.teal.withOpacity(0.7),
                                onPressed: () {
//                                  FirebaseAuth.instance
//                                      .signInWithEmailAndPassword(
//                                          email: _email, password: _password)
//                                      .then((FirebaseUser user) {
//                                    if (user.isEmailVerified) {
//                                      Navigator.of(context)
//                                          .pushReplacementNamed('/homepage');
//                                    } else {
//                                      //print('Not verified');
//                                      showToast(
//                                          'Please verify you email address',
//                                          gravity: Toast.BOTTOM,
//                                          duration: Toast.LENGTH_LONG);
//                                    }
//                                  }).catchError((e) {
//                                    print(e);
//                                  });
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
                                      'Signin',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontFamily: 'Muli',
                                          color: Colors.white),
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
                              height: 15.0,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context)
                                    .pushReplacementNamed('/signuppage');
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(
                                    'Don\'t have an account? Signup',
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
        ],
      ),
    );
  }

  void showToast(String msg, {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity);
  }
}
