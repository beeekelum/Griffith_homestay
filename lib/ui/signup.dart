import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  String _fullName = '';
  String _phoneNumber = '';
  String _address = '';
  bool passwordVisible;
  var _userType = "1";

//  final auth = FirebaseAuth.instance;
//  final fs = FirestoreServices();

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
  }

  Future<String> signUp(String email, String password) async {
//    FirebaseUser user = await auth
//        .createUserWithEmailAndPassword(email: email, password: password)
//        .then(
//      (FirebaseUser signedInUser) {
//        signedInUser.sendEmailVerification();
//        UserUpdateInfo updateUser = UserUpdateInfo();
//        updateUser.displayName = _fullName;
//        updateUser.photoUrl =
//            'https://scontent-jnb1-1.xx.fbcdn.net/v/t1.0-9/62007815_2288046624593190_4016071382726082560_o.jpg?_nc_cat=107&_nc_ht=scontent-jnb1-1.xx&oh=07c2e7db9095bccfd7cf651fe710e4b9&oe=5D9D4617';
//        signedInUser.updateProfile(updateUser).then((user) {
//          FirebaseAuth.instance.currentUser().then((user) {
//            UserManagement()
//                .storeNewUser(user, context, _userType, _address, _phoneNumber);
//          }).catchError((e) {
//            print(e);
//          });
//        }).catchError((e) {
//          print(e);
//        });
//      },
//    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomPadding: false,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image(
            image: AssetImage('assets/images/home.jpg'),
            fit: BoxFit.cover,
            colorBlendMode: BlendMode.darken,
            color: Colors.black.withOpacity(0.5),
          ),
          Theme(
            data: ThemeData(
                primaryColor: Colors.teal,
                canvasColor: Colors.black.withOpacity(0.5),
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
              padding: const EdgeInsets.all(5.0),
              child: Center(
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  children: <Widget>[
                    Card(
                      elevation: 10,
                      color: Colors.black.withOpacity(0.4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Form(
                        key: _formKey,
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
                              child: TextFormField(
                                onSaved: (value) {
                                  setState(() {
                                    _fullName = value;
                                  });
                                },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                      const Radius.circular(30),
                                    ),
                                  ),
                                  labelText: 'Co Name or Individual',
                                  labelStyle: TextStyle(
                                    fontFamily: 'Muli',
                                    color: Colors.white,
                                  ),
                                  prefixIcon: Icon(
                                    FontAwesomeIcons.user,
                                    color: Colors.teal.withOpacity(0.7),
                                  ),
                                ),
                                style: TextStyle(
                                  fontFamily: 'Muli',
                                  color: Colors.white,
                                ),
                                validator: (_fullName) {
                                  if (_fullName.isEmpty) {
                                    return 'Empty Field';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Container(
                              width: 330,
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                onSaved: (value) {
                                  setState(() {
                                    _phoneNumber = value;
                                  });
                                },
                                validator: (_phoneNumber) {
                                  if (_phoneNumber.isEmpty) {
                                    return 'Empty Field';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                      const Radius.circular(30),
                                    ),
                                  ),
                                  labelText: 'Contact Number',
                                  labelStyle: TextStyle(
                                    fontFamily: 'Muli',
                                    color: Colors.white,
                                  ),
                                  prefixIcon: Icon(
                                    Icons.phone,
                                    color: Colors.teal.withOpacity(0.7),
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
                              child: TextFormField(
                                onSaved: (value) {
                                  setState(() {
                                    _email = value;
                                  });
                                },
                                validator: (_email) {
                                  if (_email.isEmpty) {
                                    return 'Empty Field';
                                  }
                                  return null;
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
                                    color: Colors.teal.withOpacity(0.7),
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
                              child: TextFormField(
                                validator: (_password) {
                                  if (_password.isEmpty) {
                                    return 'Empty Password';
                                  }
                                  return null;
                                },
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
                                    color: Colors.teal.withOpacity(0.7),
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      passwordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                    color: Colors.teal.withOpacity(0.7),
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
                                obscureText: passwordVisible,
                                style: TextStyle(
                                    fontFamily: 'Muli', color: Colors.white),
                              ),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Wrap(
                              children: <Widget>[
                                Container(
                                  width: 330,
                                  height: 60,
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      style: TextStyle(
                                          fontFamily: 'Muli',
                                          fontSize: 18,
                                          color: Colors.white),
                                      items: [
                                        DropdownMenuItem(
                                          value: "1",
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 14),
                                            child: Row(
                                              children: <Widget>[
                                                Center(
                                                  child: Icon(
                                                    FontAwesomeIcons.userAlt,
                                                    color: Colors.teal
                                                        .withOpacity(0.7),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 7,
                                                ),
                                                Text(
                                                  'Select User Type',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        DropdownMenuItem(
                                          value: "Donor",
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 14),
                                            child: Row(
                                              children: <Widget>[
                                                Center(
                                                  child: Icon(
                                                    FontAwesomeIcons.userAlt,
                                                    color: Colors.teal
                                                        .withOpacity(0.7),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 7,
                                                ),
                                                Text(
                                                  'Donor',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                      onChanged: (value) {
                                        setState(() {
                                          _userType = value;
                                        });
                                      },
                                      value: _userType,
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    border: Border.all(
                                        color: Colors.white, width: 1.0),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Container(
                              width: 330,
                              child: TextFormField(
                                onSaved: (value) {
                                  setState(() {
                                    _address = value;
                                  });
                                },
                                validator: (_address) {
                                  if (_address.isEmpty) {
                                    return 'Empty Field';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                      const Radius.circular(30),
                                    ),
                                  ),
                                  labelText: 'Address',
                                  labelStyle: TextStyle(
                                    fontFamily: 'Muli',
                                    color: Colors.white,
                                  ),
                                  prefixIcon: Icon(
                                    Icons.location_on,
                                    color: Colors.teal.withOpacity(0.7),
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
                              child: RaisedButton(
                                padding: EdgeInsets.all(16),
                                color: Colors.teal.withOpacity(0.7),
                                onPressed: () {
                                  if (_formKey.currentState.validate()) {
                                    _formKey.currentState.save();
                                    signUp(_email, _password);
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
                                      'Signup',
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
                                    .pushReplacementNamed('/mainpage');
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(
                                    'Already have an account? Signin',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontFamily: 'Muli',
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 15.0,
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
}
