import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:homestay/models/user.dart';
import 'package:homestay/services/firestore_services.dart';
import 'package:homestay/services/preference_management.dart';
import 'package:homestay/widgets/app_widgets.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class StudentPreferencePge extends StatefulWidget {
  @override
  _StudentPreferencePgeState createState() => _StudentPreferencePgeState();
}

class _StudentPreferencePgeState extends State<StudentPreferencePge> {
  String _studyProgram = "1";
  String _language_ = "1";
  String _studyLevel = "1";
  String _diet = "1";
  String _language_preferred = "1";
  String _hobbies_activities = "1";
  String _acc_duration = "1";
  String _smoker = "1";
  String _pets = "1";
  String _allergies = "1";
  String _conditions_medical = "1";
  String _host_fam = "1";
  String _religion_ = "1";
  String _nationality = 'Select Option:';

  final _formKey = GlobalKey<FormState>();
  bool _validate = false;

  final auth = FirebaseAuth.instance;
  final fs = FirestoreServices();

  @override
  Widget build(BuildContext context) {
    var fUser = Provider.of<FirebaseUser>(context);
    return StreamBuilder<User>(
      stream: fs.streamStudent(fUser.uid),
      builder: (context, snapshot) {
        var user = snapshot.data;
        if (user != null) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Student Preference Form',
                style: TextStyle(fontSize: 17),
              ),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.home),
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/studenthomepage', ModalRoute.withName('/'));
                  },
                ),
              ],
            ),
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Form(
                  key: _formKey,
                  autovalidate: _validate,
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        titleWidget('Student Personal Details: '),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            formHeading('Nationality -'),
                            //Spacer(),
                            _buildNationality(_nationality),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: <Widget>[
                            formHeading('Program of study -'),
                            Spacer(),
                            _programOfStudy(),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            formHeading('Level of study -'),
                            //Spacer(),
                            _levelOfStudy(),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            formHeading('Student\'s Language -'),
                            Spacer(),
                            _language(),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            formHeading('Student\'s Religion -'),
                            _religion(),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        titleWidget('Student Preferences: '),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            formHeading('Preferred Diet - '),
                            _preferredDiet(),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            formHeading('Preferred Language - '),
                            _preferredLanguage(),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            formHeading('Host Family Composition - '),
                            _hostFamily(),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            formHeading('Hobbies and Interests - '),
                            _preferredHobbiesnInterests(),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            formHeading('Accommodation - '),
                            _accommodationDuration(),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            formHeading('Smoking Preference -'),
                            _smokingWidget(),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            formHeading('Pets Preference -'),
                            _petPreferences(),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            formHeading('Allergies - '),
                            _allergiesPreferences(),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            formHeading('Medical Conditions -'),
                            _medicalCondition(),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              width: 330,
                              child: RaisedButton(
                                padding: EdgeInsets.all(16),
                                color: Colors.teal.withOpacity(0.7),
                                onPressed: () {
//                                  if (_formKey.currentState.validate()) {
//                                    _formKey.currentState.save();
//
//                                  }
//
                                  print(user.displayName);
                                  if (_studyProgram == "1") {
                                    Toast.show('Select study program.', context,
                                        duration: Toast.LENGTH_LONG,
                                        gravity: Toast.BOTTOM);
                                  } else if (_nationality == "1") {
                                    Toast.show('Select nationality.', context,
                                        duration: Toast.LENGTH_LONG,
                                        gravity: Toast.BOTTOM);
                                  } else if (_studyLevel == "1") {
                                    Toast.show('Select study level.', context,
                                        duration: Toast.LENGTH_LONG,
                                        gravity: Toast.BOTTOM);
                                  } else if (_language_ == "1") {
                                    Toast.show('Select your language.', context,
                                        duration: Toast.LENGTH_LONG,
                                        gravity: Toast.BOTTOM);
                                  } else if (_language_preferred == "1") {
                                    Toast.show(
                                        'Select preffered language.', context,
                                        duration: Toast.LENGTH_LONG,
                                        gravity: Toast.BOTTOM);
                                  } else if (_religion_ == "1") {
                                    Toast.show('Select your religion.', context,
                                        duration: Toast.LENGTH_LONG,
                                        gravity: Toast.BOTTOM);
                                  } else if (_diet == "1") {
                                    Toast.show('Select your dieat.', context,
                                        duration: Toast.LENGTH_LONG,
                                        gravity: Toast.BOTTOM);
                                  } else if (_host_fam == "1") {
                                    Toast.show('Select host family.', context,
                                        duration: Toast.LENGTH_LONG,
                                        gravity: Toast.BOTTOM);
                                  } else if (_hobbies_activities == "1") {
                                    Toast.show('Select any hobbies.', context,
                                        duration: Toast.LENGTH_LONG,
                                        gravity: Toast.BOTTOM);
                                  } else if (_acc_duration == "1") {
                                    Toast.show('Select accommodation duration.',
                                        context,
                                        duration: Toast.LENGTH_LONG,
                                        gravity: Toast.BOTTOM);
                                  } else if (_smoker == "1") {
                                    Toast.show(
                                        'Select smoking preference.', context,
                                        duration: Toast.LENGTH_LONG,
                                        gravity: Toast.BOTTOM);
                                  } else if (_pets == "1") {
                                    Toast.show(
                                        'Select pets preference.', context,
                                        duration: Toast.LENGTH_LONG,
                                        gravity: Toast.BOTTOM);
                                  } else if (_allergies == "1") {
                                    Toast.show('Select allergies.', context,
                                        duration: Toast.LENGTH_LONG,
                                        gravity: Toast.BOTTOM);
                                  } else if (_conditions_medical == "1") {
                                    Toast.show(
                                        'Select medical conditions.', context,
                                        duration: Toast.LENGTH_LONG,
                                        gravity: Toast.BOTTOM);
                                  } else {
                                    Map<String, dynamic> studentPreferenceData =
                                        {
                                      'studentUid': fUser.uid,
                                      'studentEmail': user.email,
                                      'studentPhotoUrl': user.photoUrl,
                                      'studentFullName': user.displayName,
                                      'studentNumber': user.studentNumber,
                                      'nationality': _nationality,
                                      'programOfStudy': _studyProgram,
                                      'levelOfStudy': _studyLevel,
                                      'studentLanguage': _language_,
                                      'studentReligion': _religion_,
                                      'studentPreferredDiet': _diet,
                                      'studentPreferredLanguage':
                                          _language_preferred,
                                      'hostFamilyComposition': _host_fam,
                                      'hobbiesNInterests': _hobbies_activities,
                                      'accommodationDuration': _acc_duration,
                                      'smokingPreference': _smoker,
                                      'petsPreference': _pets,
                                      'allergies': _allergies,
                                      'medicalConditions': _conditions_medical,
                                    };
                                    PreferenceManagement()
                                        .saveStudentPreference(
                                            studentPreferenceData)
                                        .then((e) {
                                      Toast.show(
                                          'Student preferences submitted successfully',
                                          context,
                                          duration: Toast.LENGTH_LONG,
                                          gravity: Toast.BOTTOM);
                                      Navigator.of(context).pop();
                                      Navigator.of(context)
                                          .pushReplacementNamed(
                                              '/studenthomepage');

//                                      Alert(
//                                        context: context,
//                                        type: AlertType.success,
//                                        title: "Preferences saved",
//                                        desc:
//                                            "Student preferences submitted successfully. ",
//                                        buttons: [
//                                          DialogButton(
//                                            child: Text(
//                                              "OK",
//                                              style: TextStyle(
//                                                  color: Colors.white,
//                                                  fontSize: 20),
//                                            ),
//                                            onPressed: () {
//                                              Navigator.pop(context);
//                                              Navigator.of(context)
//                                                  .popAndPushNamed(
//                                                      '/studenthomepage');
//                                            },
//                                            width: 120,
//                                          )
//                                        ],
//                                      ).show();
                                    });
                                  }
                                },
                                elevation: 0,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Icon(
                                      FontAwesomeIcons.save,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'Submit',
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
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _buildNationality(String _value) {
    return Center(
      child: DropdownButton<String>(
        value: _value,
        onChanged: (String newValue) {
          setState(() {
            _nationality = newValue;
            print(newValue);
          });
        },
        items: <String>[
          'Select Option:',
          "Afghanistan",
          "Albania",
          "Algeria",
          "American",
          "Andorra",
          "Angola",
          "Anguilla",
          "Antarctica",
          "Antigua",
          "Argentina",
          "Armenia",
          "Aruba",
          "Australia",
          "Austria",
          "Azerbaijan",
          "Bahamas",
          "Bahrain",
          "Bangladesh",
          "Barbados",
          "Belarus",
          "Belgium",
          "Belize",
          "Benin",
          "Bermuda",
          "Bhutan",
          "Bolivia",
          "Botswana",
          "Bouvet Island",
          "Brazil",
          "British",
          "Bulgaria",
          "Burkina Faso",
          "Burundi",
          "Cambodia",
          "Cameroon",
          "Canada",
          "Cape Verde",
          "Cayman Islands",
          "Chad",
          "Chile",
          "China",
          "Colombia",
          "Comoros",
          "Congo",
          "DRC",
          "Cook Islands",
          "Costa Rica",
          "Cote d'Ivoire",
          "Croatia",
          "Cuba",
          "Cyprus",
          "Czech Republic",
          "Denmark",
          "Djibouti",
          "Dominica",
          "East Timor",
          "Ecuador",
          "Egypt",
          "El Salvador",
          "Equatorial Guinea",
          "Eritrea",
          "Estonia",
          "Ethiopia",
          "Faroe Islands",
          "Fiji",
          "Finland",
          "France",
          "Gabon",
          "Gambia",
          "Georgia",
          "Germany",
          "Ghana",
          "Gibraltar",
          "Greece",
          "Greenland",
          "Grenada",
          "Guadeloupe",
          "Guam",
          "Guatemala",
          "Guinea",
          "Guinea-Bissau",
          "Guyana",
          "Haiti",
          "Honduras",
          "Hong Kong",
          "Hungary",
          "Iceland",
          "India",
          "Indonesia",
          "Iran",
          "Iraq",
          "Ireland",
          "Israel",
          "Italy",
          "Jamaica",
          "Japan",
          "Jordan",
          "Kazakhstan",
          "Kenya",
          "Kiribati",
          "Korea",
          "Kuwait",
          "Kyrgyzstan",
          "Latvia",
          "Lebanon",
          "Lesotho",
          "Liberia",
          "Libyan",
          "Liechtenstein",
          "Lithuania",
          "Luxembourg",
          "Macau",
          "Macedonia",
          "Madagascar",
          "Malawi",
          "Malaysia",
          "Maldives",
          "Mali",
          "Malta",
          "Marshall Islands",
          "Martinique",
          "Mauritania",
          "Mauritius",
          "Mayotte",
          "Mexico",
          "Moldova",
          "Monaco",
          "Mongolia",
          "Montserrat",
          "Morocco",
          "Mozambique",
          "Myanmar",
          "Namibia",
          "Nauru",
          "Nepal",
          "Netherlands",
          "New Caledonia",
          "New Zealand",
          "Nicaragua",
          "Niger",
          "Nigeria",
          "Niue",
          "Norfolk Island",
          "Norway",
          "Oman",
          "Pakistan",
          "Palau",
          "Panama",
          "Paraguay",
          "Peru",
          "Philippines",
          "Pitcairn",
          "Poland",
          "Portugal",
          "Puerto Rico",
          "Qatar",
          "Reunion",
          "Romania",
          "Russian ",
          "Rwanda",
          "Samoa",
          "San Marino",
          "Saudi Arabia",
          "Senegal",
          "Seychelles",
          "Sierra Leone",
          "Singapore",
          "Slovenia",
          "Somalia",
          "South Africa",
          "Spain",
          "Sri Lanka",
          "St. Helena",
          "Sudan",
          "Suriname",
          "Swaziland",
          "Sweden",
          "Switzerland",
          "Taiwan",
          "Tajikistan",
          "Tanzania",
          "Thailand",
          "Togo",
          "Tokelau",
          "Tonga",
          "Tunisia",
          "Turkey",
          "Turkmenistan",
          "Tuvalu",
          "Uganda",
          "Ukraine",
          "UAE",
          "United Kingdom",
          "United States",
          "Uruguay",
          "Uzbekistan",
          "Vanuatu",
          "Venezuela",
          "Vietnam",
          "Western Sahara",
          "Yemen",
          "Yugoslavia",
          "Zambia",
          "Zimbabwe"
        ].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  Widget _programOfStudy() {
    return Wrap(
      children: <Widget>[
        Container(
          width: 200,
          child: DropdownMenuItem(
            child: DropdownButton<String>(
              isExpanded: true,
              style: TextStyle(
                fontFamily: 'Muli',
                fontSize: 18,
                color: Colors.black,
              ),
              items: [
                DropdownMenuItem(
                  value: "1",
                  child: Padding(
                    padding: const EdgeInsets.only(left: 1),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Select option:',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
                DropdownMenuItem(
                  value: "BSc in Computing(Level 7)",
                  child: Padding(
                    padding: const EdgeInsets.only(left: 1),
                    child: Row(
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            'BSc in Computing(Level 7)',
                            style: TextStyle(color: Colors.black, fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                DropdownMenuItem(
                  value: "BSc in Computing(Level 8)",
                  child: Padding(
                    padding: const EdgeInsets.only(left: 1),
                    child: Row(
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            'BSc in Computing(Level 8)',
                            style: TextStyle(color: Colors.black, fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                DropdownMenuItem(
                  value: "BA in Business Studies(Level 7)",
                  child: Padding(
                    padding: const EdgeInsets.only(left: 1),
                    child: Row(
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            'BA in Business Studies(Level 7)',
                            style: TextStyle(color: Colors.black, fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                DropdownMenuItem(
                  value: "BA in Business Studies(Level 8)",
                  child: Padding(
                    padding: const EdgeInsets.only(left: 1),
                    child: Row(
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            'BA in Business Studies(Level 8)',
                            style: TextStyle(color: Colors.black, fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                DropdownMenuItem(
                  value: "Diploma in International Hospitality(Level 7)",
                  child: Padding(
                    padding: const EdgeInsets.only(left: 1),
                    child: Row(
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            'Diploma in International Hospitality(Level 7)',
                            style: TextStyle(color: Colors.black, fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                DropdownMenuItem(
                  value: "BA in International Hospitality Management(Level 8)",
                  child: Padding(
                    padding: const EdgeInsets.only(left: 1),
                    child: Row(
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            'BA in International Hospitality Management(Level 8)',
                            style: TextStyle(color: Colors.black, fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                DropdownMenuItem(
                  value: "MSc in Network Information Security(Level 9)",
                  child: Padding(
                    padding: const EdgeInsets.only(left: 1),
                    child: Row(
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            'MSc in Network Information Security(Level 9)',
                            style: TextStyle(color: Colors.black, fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                DropdownMenuItem(
                  value:
                      "MSc International Business (International Tourism and Hospitality Management)(Level 9)",
                  child: Padding(
                    padding: const EdgeInsets.only(left: 1),
                    child: Row(
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            'MSc International Business (International Tourism and Hospitality Management)(Level 9)',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.black, fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                DropdownMenuItem(
                  value: "General English",
                  child: Padding(
                    padding: const EdgeInsets.only(left: 1),
                    child: Row(
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            'General English',
                            style: TextStyle(color: Colors.black, fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  _studyProgram = value;
                  //print(_studyProgram);
                });
              },
              value: _studyProgram,
            ),
          ),
        ),
      ],
    );
  }

  Widget _levelOfStudy() {
    return Container(
      child: DropdownMenuItem(
        child: DropdownButton<String>(
          style:
              TextStyle(fontFamily: 'Muli', fontSize: 18, color: Colors.black),
          items: [
            DropdownMenuItem(
              value: "1",
              child: Padding(
                padding: const EdgeInsets.only(left: 1),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Select Option:',
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            DropdownMenuItem(
              value: "Undergraduate",
              child: Padding(
                padding: const EdgeInsets.only(left: 1),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Undergraduate',
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            DropdownMenuItem(
              value: "Postgraduate",
              child: Padding(
                padding: const EdgeInsets.only(left: 1),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Postgraduate',
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            DropdownMenuItem(
              value: "Diploma/Certificate",
              child: Padding(
                padding: const EdgeInsets.only(left: 1),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Diploma/Certificate',
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          ],
          onChanged: (value) {
            setState(() {
              _studyLevel = value;
              print(_studyLevel);
            });
          },
          value: _studyLevel,
        ),
      ),
    );
  }

  Widget _language() {
    return Container(
      child: DropdownMenuItem(
        child: DropdownButton<String>(
          style:
              TextStyle(fontFamily: 'Muli', fontSize: 18, color: Colors.black),
          items: [
            DropdownMenuItem(
              value: "1",
              child: Padding(
                padding: const EdgeInsets.only(left: 1),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Select Option:',
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            DropdownMenuItem(
              value: "English",
              child: Padding(
                padding: const EdgeInsets.only(left: 1),
                child: Row(
                  children: <Widget>[
                    Text(
                      'English',
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            DropdownMenuItem(
              value: "Irish Gaelic",
              child: Padding(
                padding: const EdgeInsets.only(left: 1),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Irish Gaelic',
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            DropdownMenuItem(
              value: "French",
              child: Padding(
                padding: const EdgeInsets.only(left: 1),
                child: Row(
                  children: <Widget>[
                    Text(
                      'French',
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            DropdownMenuItem(
              value: "German",
              child: Padding(
                padding: const EdgeInsets.only(left: 1),
                child: Row(
                  children: <Widget>[
                    Text(
                      'German',
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            DropdownMenuItem(
              value: "Spanish",
              child: Padding(
                padding: const EdgeInsets.only(left: 1),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Spanish',
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          ],
          onChanged: (value) {
            setState(() {
              _language_ = value;
            });
          },
          value: _language_,
        ),
      ),
    );
  }

  Widget _religion() {
    return Container(
      child: DropdownMenuItem(
        child: DropdownButton<String>(
          style:
              TextStyle(fontFamily: 'Muli', fontSize: 18, color: Colors.black),
          items: [
            DropdownMenuItem(
              value: "1",
              child: Padding(
                padding: const EdgeInsets.only(left: 1),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Select Option:',
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            DropdownMenuItem(
              value: "Christianity",
              child: Padding(
                padding: const EdgeInsets.only(left: 1),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Christianity',
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            DropdownMenuItem(
              value: "Buddhism",
              child: Padding(
                padding: const EdgeInsets.only(left: 1),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Buddhism',
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            DropdownMenuItem(
              value: "Hinduism",
              child: Padding(
                padding: const EdgeInsets.only(left: 1),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Hinduism',
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            DropdownMenuItem(
              value: "Islam",
              child: Padding(
                padding: const EdgeInsets.only(left: 1),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Islam',
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            DropdownMenuItem(
              value: "Judaism",
              child: Padding(
                padding: const EdgeInsets.only(left: 1),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Judaism',
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            DropdownMenuItem(
              value: "Taoism",
              child: Padding(
                padding: const EdgeInsets.only(left: 1),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Taoism',
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          ],
          onChanged: (value) {
            setState(() {
              _religion_ = value;
            });
          },
          value: _religion_,
        ),
      ),
    );
  }

  Widget _preferredDiet() {
    return Container(
      child: DropdownMenuItem(
        child: DropdownButton<String>(
          style:
              TextStyle(fontFamily: 'Muli', fontSize: 18, color: Colors.black),
          items: [
            DropdownMenuItem(
              value: "1",
              child: Padding(
                padding: const EdgeInsets.only(left: 1),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Select Otption:',
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            DropdownMenuItem(
              value: "Not Specific",
              child: Padding(
                padding: const EdgeInsets.only(left: 1),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Not Specific',
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            DropdownMenuItem(
              value: "Vegan",
              child: Padding(
                padding: const EdgeInsets.only(left: 1),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Vegan',
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            DropdownMenuItem(
              value: "Vegetarian",
              child: Padding(
                padding: const EdgeInsets.only(left: 1),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Vegetarian',
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            DropdownMenuItem(
              value: "Halal",
              child: Padding(
                padding: const EdgeInsets.only(left: 1),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Halal',
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          ],
          onChanged: (value) {
            setState(() {
              _diet = value;
            });
          },
          value: _diet,
        ),
      ),
    );
  }

  Widget _preferredLanguage() {
    return Container(
      child: DropdownMenuItem(
        child: DropdownButton<String>(
          style:
              TextStyle(fontFamily: 'Muli', fontSize: 18, color: Colors.black),
          items: [
            DropdownMenuItem(
              value: "1",
              child: Padding(
                padding: const EdgeInsets.only(left: 1),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Select Option:',
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            DropdownMenuItem(
              value: "Gaelic",
              child: Padding(
                padding: const EdgeInsets.only(left: 1),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Gaelic',
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            DropdownMenuItem(
              value: "English",
              child: Padding(
                padding: const EdgeInsets.only(left: 1),
                child: Row(
                  children: <Widget>[
                    Text(
                      'English',
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            DropdownMenuItem(
              value: "German",
              child: Padding(
                padding: const EdgeInsets.only(left: 1),
                child: Row(
                  children: <Widget>[
                    Text(
                      'German',
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            DropdownMenuItem(
              value: "French",
              child: Padding(
                padding: const EdgeInsets.only(left: 1),
                child: Row(
                  children: <Widget>[
                    Text(
                      'French',
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            DropdownMenuItem(
              value: "Spanish",
              child: Padding(
                padding: const EdgeInsets.only(left: 1),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Spanish',
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          ],
          onChanged: (value) {
            setState(() {
              _language_preferred = value;
            });
          },
          value: _language_preferred,
        ),
      ),
    );
  }

  Widget _hostFamily() {
    return Container(
      child: DropdownMenuItem(
        child: DropdownButton<String>(
          style:
              TextStyle(fontFamily: 'Muli', fontSize: 18, color: Colors.black),
          items: [
            DropdownMenuItem(
              value: "1",
              child: Padding(
                padding: const EdgeInsets.only(left: 1),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Select Option:',
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            DropdownMenuItem(
              value: "< 2 Children",
              child: Padding(
                padding: const EdgeInsets.only(left: 1),
                child: Row(
                  children: <Widget>[
                    Text(
                      '< 2 Children',
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            DropdownMenuItem(
              value: "> 2 Children",
              child: Padding(
                padding: const EdgeInsets.only(left: 1),
                child: Row(
                  children: <Widget>[
                    Text(
                      '> 2 Children',
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            DropdownMenuItem(
              value: "No Children",
              child: Padding(
                padding: const EdgeInsets.only(left: 1),
                child: Row(
                  children: <Widget>[
                    Text(
                      'No Children',
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          ],
          onChanged: (value) {
            setState(() {
              _host_fam = value;
            });
          },
          value: _host_fam,
        ),
      ),
    );
  }

  Widget _preferredHobbiesnInterests() {
    return Container(
      child: DropdownMenuItem(
        child: DropdownButton<String>(
          style:
              TextStyle(fontFamily: 'Muli', fontSize: 18, color: Colors.black),
          items: [
            DropdownMenuItem(
              value: "1",
              child: Padding(
                padding: const EdgeInsets.only(left: 1),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Select Option:',
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            DropdownMenuItem(
              value: "Pool",
              child: Padding(
                padding: const EdgeInsets.only(left: 1),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Pool',
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            DropdownMenuItem(
              value: "Reading",
              child: Padding(
                padding: const EdgeInsets.only(left: 1),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Reading',
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            DropdownMenuItem(
              value: "Hiking",
              child: Padding(
                padding: const EdgeInsets.only(left: 1),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Hiking',
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            DropdownMenuItem(
              value: "Music",
              child: Padding(
                padding: const EdgeInsets.only(left: 1),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Music',
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          ],
          onChanged: (value) {
            setState(() {
              _hobbies_activities = value;
            });
          },
          value: _hobbies_activities,
        ),
      ),
    );
  }

  Widget _accommodationDuration() {
    return Container(
      child: DropdownMenuItem(
        child: DropdownButton<String>(
          style:
              TextStyle(fontFamily: 'Muli', fontSize: 18, color: Colors.black),
          items: [
            DropdownMenuItem(
              value: "1",
              child: Padding(
                padding: const EdgeInsets.only(left: 1),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Select Option',
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            DropdownMenuItem(
              value: "Short",
              child: Padding(
                padding: const EdgeInsets.only(left: 1),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Short term',
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            DropdownMenuItem(
              value: "Long",
              child: Padding(
                padding: const EdgeInsets.only(left: 1),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Long Term',
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          ],
          onChanged: (value) {
            setState(() {
              _acc_duration = value;
            });
          },
          value: _acc_duration,
        ),
      ),
    );
  }

  Widget _smokingWidget() {
    return Container(
      child: DropdownMenuItem(
        child: DropdownButton<String>(
          style:
              TextStyle(fontFamily: 'Muli', fontSize: 18, color: Colors.black),
          items: [
            DropdownMenuItem(
              value: "1",
              child: Padding(
                padding: const EdgeInsets.only(left: 1),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Select Option:',
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            DropdownMenuItem(
              value: "Not specific",
              child: Padding(
                padding: const EdgeInsets.only(left: 1),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Not specific',
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            DropdownMenuItem(
              value: "Yes",
              child: Padding(
                padding: const EdgeInsets.only(left: 1),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Yes',
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            DropdownMenuItem(
              value: "No",
              child: Padding(
                padding: const EdgeInsets.only(left: 1),
                child: Row(
                  children: <Widget>[
                    Text(
                      'No',
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          ],
          onChanged: (value) {
            setState(() {
              _smoker = value;
            });
          },
          value: _smoker,
        ),
      ),
    );
  }

  Widget _petPreferences() {
    return Container(
      child: DropdownMenuItem(
        child: DropdownButton<String>(
          style:
              TextStyle(fontFamily: 'Muli', fontSize: 18, color: Colors.black),
          items: [
            DropdownMenuItem(
              value: "1",
              child: Padding(
                padding: const EdgeInsets.only(left: 1),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Select Option:',
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            DropdownMenuItem(
              value: "Not specific",
              child: Padding(
                padding: const EdgeInsets.only(left: 1),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Not specific',
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            DropdownMenuItem(
              value: "Yes",
              child: Padding(
                padding: const EdgeInsets.only(left: 1),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Yes',
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            DropdownMenuItem(
              value: "No",
              child: Padding(
                padding: const EdgeInsets.only(left: 1),
                child: Row(
                  children: <Widget>[
                    Text(
                      'No',
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          ],
          onChanged: (value) {
            setState(() {
              _pets = value;
            });
          },
          value: _pets,
        ),
      ),
    );
  }

  Widget _allergiesPreferences() {
    return Container(
      child: DropdownMenuItem(
        child: DropdownButton<String>(
          style:
              TextStyle(fontFamily: 'Muli', fontSize: 18, color: Colors.black),
          items: [
            DropdownMenuItem(
              value: "1",
              child: Padding(
                padding: const EdgeInsets.only(left: 1),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Select Option:',
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            DropdownMenuItem(
              value: "Not specific",
              child: Padding(
                padding: const EdgeInsets.only(left: 1),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Not specific',
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            DropdownMenuItem(
              value: "Yes",
              child: Padding(
                padding: const EdgeInsets.only(left: 1),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Yes',
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            DropdownMenuItem(
              value: "No",
              child: Padding(
                padding: const EdgeInsets.only(left: 1),
                child: Row(
                  children: <Widget>[
                    Text(
                      'No',
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          ],
          onChanged: (value) {
            setState(() {
              _allergies = value;
            });
          },
          value: _allergies,
        ),
      ),
    );
  }

  Widget _medicalCondition() {
    return Container(
      child: DropdownMenuItem(
        child: DropdownButton<String>(
          style:
              TextStyle(fontFamily: 'Muli', fontSize: 18, color: Colors.black),
          items: [
            DropdownMenuItem(
              value: "1",
              child: Padding(
                padding: const EdgeInsets.only(left: 1),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Select option:',
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            DropdownMenuItem(
              value: "Not specific",
              child: Padding(
                padding: const EdgeInsets.only(left: 1),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Not specific',
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            DropdownMenuItem(
              value: "Yes",
              child: Padding(
                padding: const EdgeInsets.only(left: 1),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Yes',
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            DropdownMenuItem(
              value: "No",
              child: Padding(
                padding: const EdgeInsets.only(left: 1),
                child: Row(
                  children: <Widget>[
                    Text(
                      'No',
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          ],
          onChanged: (value) {
            setState(() {
              _conditions_medical = value;
            });
          },
          value: _conditions_medical,
        ),
      ),
    );
  }
}
