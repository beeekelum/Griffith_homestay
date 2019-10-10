import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class PasswordReset extends StatefulWidget {
  PasswordReset({Key key}) : super(key: key);

  _PasswordResetState createState() => _PasswordResetState();
}

class _PasswordResetState extends State<PasswordReset> {
  //  _formKey and _autoValidate
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  String _emailAddress;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          'Reset Password',
        ),
        flexibleSpace: Container(
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
                colors: [
                  const Color(0xFF00796B),
                  const Color(0xFF4DB6AC),
                ],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image(
            image: AssetImage('assets/images/home.jpg'),
            fit: BoxFit.cover,
            colorBlendMode: BlendMode.darken,
            color: Colors.black.withOpacity(0.8),
          ),
          Theme(
            data: ThemeData(
                brightness: Brightness.dark,
                //primaryColor: Colors.green.withOpacity(0.5),
                inputDecorationTheme: InputDecorationTheme(
                  hintStyle: TextStyle(color: Colors.white),
                  labelStyle: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Muli',
                    fontSize: 20,
                  ),
                ),
                hintColor: Colors.grey),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
                margin: new EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    new Container(
                      margin: new EdgeInsets.all(15.0),
                      child: new Form(
                        key: _formKey,
                        autovalidate: _autoValidate,
                        child: formUI(),
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

  Widget formUI() {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(margin: EdgeInsets.only(top: 24.0)),
            //Logo(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Forgot your Password?",
                    style: TextStyle(fontSize: 22.0, color: Colors.white),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 16.0),
              child: Text(
                "Enter registered Email Address to send you the password reset instructions.",
                style: TextStyle(
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                    fontSize: 17),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 0),
              child: TextFormField(
                decoration: const InputDecoration(
                  hintText: "Enter your email address",
                  hintStyle: TextStyle(fontFamily: 'Muli'),
                  labelText: "Email Address",
                  labelStyle: TextStyle(
                    fontFamily: 'Muli',
                    fontSize: 16,
                    color: Colors.white,
                  ),
                  border: OutlineInputBorder(),
                  isDense: true,
                  prefixIcon: Icon(
                    Icons.email,
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: _validateEmailAddress,
                onSaved: (String val) {
                  _emailAddress = val;
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: SizedBox(
                height: 60.0,
                child: ButtonTheme(
                  minWidth: 310.0,
                  child: new RaisedButton(
                    elevation: 5.0,
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    color: Theme.of(context).primaryColor,
                    child: Container(
                      width: 300,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(FontAwesomeIcons.unlock),
                          SizedBox(
                            width: 10,
                          ),
                          new Text(
                            'Reset Password',
                            style: new TextStyle(
                                fontSize: 18.0,
                                color: Colors.white,
                                fontFamily: 'Muli'),
                          ),
                        ],
                      ),
                    ),
                    onPressed: _validateInputs,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future _validateInputs() async {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      _resetPassword();
    } else {
      setState(() => _autoValidate = true);
    }
  }

  Future<bool> _prompt(BuildContext context) {
    return showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: new Text('Password Reset'),
                content: new Text(
                    'You will shortly receive an email containing further instructions to continue with the password reset process.'),
                actions: <Widget>[
                  new FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: new Text('Back To Login'),
                  ),
                ],
              ),
        ) ??
        false;
  }

  String _validateEmailAddress(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter a valid Email Address';
    else
      return null;
  }

  Future _resetPassword() async {
    await _auth.sendPasswordResetEmail(email: _emailAddress);
    await _prompt(context);
    Navigator.of(context).pop();
  }
}
