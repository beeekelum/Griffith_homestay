import 'dart:io';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:homestay/models/user.dart';
import 'package:homestay/services/firestore_services.dart';
import 'package:homestay/services/listing_management.dart';
import 'package:homestay/widgets/app_widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:random_color/random_color.dart';
import 'package:toast/toast.dart';

class HostPListingForm extends StatefulWidget {
  @override
  _HostPListingFormState createState() => _HostPListingFormState();
}

class _HostPListingFormState extends State<HostPListingForm> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String maritalStatus = 'Select Option:';
  String language = 'Select Option:';
  String religion = 'Select Option:';
  String accommodationDuration = 'Select Option:';
  String noOfRooms = '1';
  String noOfRoomsAvailable = '1';
  String noOfBathRooms = '1';
  String noOfBathRoomsAvailable = '1';
  String location = 'Select Option:';
  String facilitiesOffered = 'Select Option:';
  String pets = 'Select Option:';
  String noOfPets = '1';
  String transportProximity = 'Select Option:';
  String otherAmenities = 'Select Option:';
  String yearsOfHosting = '1';
  String preferredStudentGender = 'Select Option:';
  String preferredLevelOfStudy = 'Select Option:';
  String smokingStudent = 'Select Option:';
  String studentWithPets = 'Select Option:';
  String _nationality = 'Select Option:';
  //DateTime _collectionDate = DateTime.now();
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();

  _showSnackBar() {
    final snackBar = new SnackBar(
      content: Row(
        children: <Widget>[
          CircularProgressIndicator(),
          SizedBox(
            width: 10,
          ),
          Text('Please wait ...'),
        ],
      ),
      //duration: new Duration(seconds: 3),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  RandomColor _randomColor = RandomColor();

  final _formKey = GlobalKey<FormState>();
  bool _validate = false;

  final formats = {
    InputType.date: DateFormat('yyyy-MM-dd'),
  };
  InputType inputType = InputType.both;
  bool editable = true;
  DateTime date;

  final auth = FirebaseAuth.instance;
  final fs = FirestoreServices();

  @override
  Widget build(BuildContext context) {
    var fUser = Provider.of<FirebaseUser>(context);
    print(fUser.uid);
    return StreamBuilder<User>(
      stream: fs.streamHostParent(fUser.uid),
      builder: (context, snapshot) {
        var user = snapshot.data;
        //print(user.lastName);
        print(fUser.uid);
        print(fUser.displayName);
        if (user != null) {
          return Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              title: Text(
                'Host Parent Listing Form',
                style: TextStyle(fontSize: 17),
              ),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.home),
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacementNamed('/parenthomepage');
                  },
                ),
              ],
            ),
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey,
                  autovalidate: _validate,
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        titleWidget('Host parent\'s personal details'),
                        Divider(),
                        Row(
                          children: <Widget>[
                            formHeading('Host marital status -'),
                            Spacer(),
                            maritalStatusDD(maritalStatus),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: <Widget>[
                            formHeading('Host parent\'s language -'),
                            Spacer(),
                            languageDD(language),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: <Widget>[
                            formHeading('Nationality -'),
                            Spacer(),
                            _buildNationality(_nationality)
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: <Widget>[
                            formHeading('Host parent\'s religion -'),
                            Spacer(),
                            religionDD(religion),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: <Widget>[
                            formHeading('Past experience of hosting (Years) -'),
                            Spacer(),
                            previousExperience(yearsOfHosting),
                          ],
                        ),
                        Divider(),
                        titleWidget('Accommodation Details'),
                        Divider(),
                        Row(
                          children: <Widget>[
                            formHeading('Accommodation term -'),
                            Spacer(),
                            accommodationDD(accommodationDuration),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: <Widget>[
                            formHeading('Available Start Date -'),
                            Spacer(),
                            startDate(),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: <Widget>[
                            formHeading('Available End Date - '),
                            Spacer(),
                            endDate(),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: <Widget>[
                            formHeading('Number of rooms -'),
                            Spacer(),
                            noOfRoomsDD(noOfRooms),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: <Widget>[
                            formHeading('Number of rooms available - '),
                            Spacer(),
                            noOfRoomsAvailableDD(noOfRoomsAvailable),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: <Widget>[
                            formHeading('Number of bathrooms - '),
                            Spacer(),
                            noOfBathRoomsDD(noOfBathRooms),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: <Widget>[
                            formHeading('Number of bathrooms available - '),
                            Spacer(),
                            noOfBathroomsAvailableDD(noOfBathRoomsAvailable),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: <Widget>[
                            formHeading('Location - '),
                            Spacer(),
                            locationDD(location),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: <Widget>[
                            formHeading('Facilites Offered -'),
                            Spacer(),
                            facilitiesOfferedDD(facilitiesOffered),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: <Widget>[
                            formHeading('Types of family pets -'),
                            Spacer(),
                            familyPetsDD(pets),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: <Widget>[
                            formHeading('No of family pets -'),
                            Spacer(),
                            noOfFamilyPetDD(noOfPets),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: <Widget>[
                            formHeading('Tranport proximity - '),
                            Spacer(),
                            transportDD(transportProximity),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: <Widget>[
                            formHeading('Other amenities - '),
                            Spacer(),
                            amenitiesDD(otherAmenities),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        formHeading('Upload images 3 Images:'),
                        Padding(
                          padding: const EdgeInsets.all(11.0),
                          child: RaisedButton.icon(
                            color: Colors.teal.withOpacity(0.9),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(30.0),
                              ),
                            ),
                            onPressed: () => pickImage(),
                            icon: Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 18,
                            ),
                            label: Text(
                              'Add Images',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ),
                        ),
                        MultiImagePickerList(
                          imageList: imageList,
                          removeNewImage: (index) {
                            removeImage(index);
                          },
                        ),
                        Divider(),
                        titleWidget('Host parent\'s preferences'),
                        Divider(),
                        Row(
                          children: <Widget>[
                            formHeading('Prefered student gender -'),
                            Spacer(),
                            studentPreferredGenderDD(preferredStudentGender),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: <Widget>[
                            formHeading('Prefered level of study'),
                            Spacer(),
                            studentPreferredLevelOfStudyDD(
                                preferredLevelOfStudy),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: <Widget>[
                            formHeading('Smoking student - '),
                            Spacer(),
                            smokingStudentDD(smokingStudent),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: <Widget>[
                            formHeading('Students with/like pets - '),
                            Spacer(),
                            studentWithPetsDD(studentWithPets),
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
                                color: Colors.teal,
                                onPressed: () {
                                  RandomColor _randomColor = RandomColor();
                                  //Color _color = _randomColor.randomColor();
                                  Color _color = _randomColor.randomColor(
                                      colorBrightness: ColorBrightness.dark);

                                  MyColor _myColor =
                                      getColorNameFromColor(_color);
                                  //print(_myColor.getName.toString());

                                  if (_formKey.currentState.validate()) {
                                    _formKey.currentState.save();
                                  }
                                  if (imageList.length < 1) {
                                    Toast.show('Please add images.', context,
                                        duration: Toast.LENGTH_LONG,
                                        gravity: Toast.BOTTOM);
                                  } else if (maritalStatus ==
                                      'Select Option:') {
                                    Toast.show(
                                        'Select marital status.', context,
                                        duration: Toast.LENGTH_LONG,
                                        gravity: Toast.BOTTOM);
                                  } else if (language == 'Select Option:') {
                                    Toast.show('Select language.', context,
                                        duration: Toast.LENGTH_LONG,
                                        gravity: Toast.BOTTOM);
                                  } else if (religion == 'Select Option:') {
                                    Toast.show('Select religion.', context,
                                        duration: Toast.LENGTH_LONG,
                                        gravity: Toast.BOTTOM);
                                  } else if (accommodationDuration ==
                                      'Select Option:') {
                                    Toast.show(
                                        'Select accommodation terms.', context,
                                        duration: Toast.LENGTH_LONG,
                                        gravity: Toast.BOTTOM);
                                  } else if (location == 'Select Option:') {
                                    Toast.show('Select location.', context,
                                        duration: Toast.LENGTH_LONG,
                                        gravity: Toast.BOTTOM);
                                  } else if (facilitiesOffered ==
                                      'Select Option:') {
                                    Toast.show(
                                        'Select facilitiesOffered.', context,
                                        duration: Toast.LENGTH_LONG,
                                        gravity: Toast.BOTTOM);
                                  } else if (pets == 'Select Option:') {
                                    Toast.show('Select pets.', context,
                                        duration: Toast.LENGTH_LONG,
                                        gravity: Toast.BOTTOM);
                                  } else if (transportProximity ==
                                      'Select Option:') {
                                    Toast.show(
                                        'Select transport proximity.', context,
                                        duration: Toast.LENGTH_LONG,
                                        gravity: Toast.BOTTOM);
                                  } else if (preferredStudentGender ==
                                      'Select Option:') {
                                    Toast.show(
                                        'Select preferred gender.', context,
                                        duration: Toast.LENGTH_LONG,
                                        gravity: Toast.BOTTOM);
                                  } else if (preferredLevelOfStudy ==
                                      'Select Option:') {
                                    Toast.show(
                                        'Select level of study.', context,
                                        duration: Toast.LENGTH_LONG,
                                        gravity: Toast.BOTTOM);
                                  } else if (smokingStudent ==
                                      'Select Option:') {
                                    Toast.show('Select smoking student option.',
                                        context,
                                        duration: Toast.LENGTH_LONG,
                                        gravity: Toast.BOTTOM);
                                  } else if (_nationality == '') {
                                    Toast.show(
                                        'State your nationality.', context,
                                        duration: Toast.LENGTH_LONG,
                                        gravity: Toast.BOTTOM);
                                  } else if (studentWithPets ==
                                      'Select Option:') {
                                    Toast.show(
                                        'Select student with or likes pets.',
                                        context,
                                        duration: Toast.LENGTH_LONG,
                                        gravity: Toast.BOTTOM);
                                  } else {
                                    Map<String, dynamic> listingData = {
                                      'cottageColorName':
                                          _myColor.getName.toString(),
                                      'hostParentUid': user.uid,
                                      'hostEmail': user.email,
                                      'hostPhotoUrl': fUser.photoUrl,
                                      'hostFullName': user.displayName,
                                      'hostFirstName': user.firstName,
                                      'hostLastName': user.lastName,
                                      'hostMaritalStatus': maritalStatus,
                                      'hostLanguage': language,
                                      'hostNationality': _nationality,
                                      'hostReligion': religion,
                                      'hostingExperience': yearsOfHosting,
                                      'accommodationDuration':
                                          accommodationDuration,
                                      'availableStartDate':
                                          _startDate.toString(),
                                      'availableEndDate': _endDate.toString(),
                                      'noOfrooms': noOfRooms,
                                      'noOfRoomsAvailable': noOfRoomsAvailable,
                                      'noOfBathrooms': noOfBathRooms,
                                      'noOfBathroomsAvailable':
                                          noOfBathRoomsAvailable,
                                      'location': location,
                                      'facilitiesOffered': facilitiesOffered,
                                      'typesOfFamilyPets': pets,
                                      'noOfFamilyPets': noOfPets,
                                      'transportProximity': transportProximity,
                                      'otherAmenities': otherAmenities,
                                      'preferedStudentGender':
                                          preferredStudentGender,
                                      'preferedLevelOfStudy':
                                          preferredLevelOfStudy,
                                      'smokingStudent': smokingStudent,
                                      'studentWithPets': studentWithPets,
                                    };
                                    _showSnackBar();
                                    ListingManagement()
                                        .saveListing(listingData)
                                        .then((listingID) async {
                                      _showSnackBar();
                                      List<String> imagesUrl =
                                          await ListingManagement()
                                              .uploadListingImages(
                                                  docID: listingID,
                                                  imageList: imageList);
                                      ListingManagement().updateListingImages(
                                          docID: listingID, data: imagesUrl);
                                    }).then((e) {
                                      Toast.show(
                                          'Listing added successfully', context,
                                          duration: Toast.LENGTH_SHORT,
                                          gravity: Toast.BOTTOM);
                                      Navigator.of(context)
                                          .pushNamedAndRemoveUntil(
                                              '/mylistings',
                                              ModalRoute.withName('/'));
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

  String generateColorCode() {
    Color _color = _randomColor.randomColor(
        colorSaturation: ColorSaturation.mediumSaturation);
    MyColor _myColor = getColorNameFromColor(_color);
    return _myColor.toString();
  }

  Widget startDate() {
    return Container(
      width: 150,
      child: DateTimePickerFormField(
        inputType: InputType.date,
        onSaved: (value) {
          setState(() {
            _startDate = value;
          });
        },
        format: DateFormat("yyyy-MM-dd"),
        editable: editable,
        decoration: InputDecoration(
            labelText: 'Select Date',
            hasFloatingPlaceholder: false,
            border: InputBorder.none),
        onChanged: (dt) => setState(() => date = dt),
        style: TextStyle(color: Colors.black),
      ),
    );
  }

  Widget endDate() {
    return Container(
      width: 150,
      child: DateTimePickerFormField(
        inputType: InputType.date,
        //controller: controllerBookDate,
        onSaved: (value) {
          setState(() {
            _endDate = value;
          });
        },
        format: DateFormat("yyyy-MM-dd"),
        editable: editable,
        decoration: InputDecoration(
            labelText: 'Select Date',
            hasFloatingPlaceholder: false,
            border: InputBorder.none),
        onChanged: (dt) => setState(() => date = dt),
        style: TextStyle(color: Colors.black),
      ),
    );
  }

  Widget maritalStatusDD(String _value) {
    return Center(
      child: DropdownButton<String>(
        value: _value,
        onChanged: (String newValue) {
          setState(() {
            maritalStatus = newValue;
            print(newValue);
          });
        },
        items: <String>['Select Option:', 'Single', 'Married']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  Widget languageDD(String _value) {
    return Center(
      child: DropdownButton<String>(
        value: _value,
        onChanged: (String newValue) {
          setState(() {
            language = newValue;
            print(newValue);
          });
        },
        items: <String>[
          'Select Option:',
          'English',
          'Gaelic',
          'German',
          'Spanish',
          'French'
        ].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  Widget religionDD(String _value) {
    return Center(
      child: DropdownButton<String>(
        value: _value,
        onChanged: (String newValue) {
          setState(() {
            religion = newValue;
            print(newValue);
          });
        },
        items: <String>[
          'Select Option:',
          'Christianity',
          'Buddhism',
          'Hinduism',
          'Ethists',
          'Islam'
        ].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
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

  Widget previousExperience(String _value) {
    return Center(
      child: DropdownButton<String>(
        value: _value,
        onChanged: (String newValue) {
          setState(() {
            yearsOfHosting = newValue;
            print(newValue);
          });
        },
        items: <String>['1', '2', '3', '4', '5']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  Widget nationalityTF() {
    return Container(
      width: 180,
      child: TextFormField(
        onSaved: (value) {
          setState(() {
            _nationality = value;
          });
        },
        validator: (_nationality) {
          String pattern = r'(^[a-zA-Z ]*$)';
          RegExp regExp = new RegExp(pattern);
          if (_nationality.isEmpty) {
            return 'Nationality is empty';
          } else if (!regExp.hasMatch(_nationality)) {
            return 'Invalid characters';
          }
          return null;
        },
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: 'Nationality',
          hintText: 'Nationality',
          hintStyle: TextStyle(color: Colors.black38),
          labelStyle: TextStyle(
            fontFamily: 'Muli',
            color: Colors.black,
          ),
          prefixIcon: Icon(
            Icons.perm_identity,
            color: Colors.black45,
            size: 20,
          ),
        ),
        style: TextStyle(fontFamily: 'Muli', color: Colors.black),
      ),
    );
  }

  Widget accommodationDD(String _value) {
    return Center(
      child: DropdownButton<String>(
        value: _value,
        onChanged: (String newValue) {
          setState(() {
            accommodationDuration = newValue;
            print(newValue);
          });
        },
        items: <String>[
          'Select Option:',
          'Short',
          'Long',
        ].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  Widget noOfRoomsDD(String _value) {
    return Center(
      child: DropdownButton<String>(
        value: _value,
        onChanged: (String newValue) {
          setState(() {
            noOfRooms = newValue;
            print(newValue);
          });
        },
        items: <String>['1', '2', '3', '4', '5', '6', '7', '8', '9', '10']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  Widget noOfRoomsAvailableDD(String _value) {
    return Center(
      child: DropdownButton<String>(
        value: _value,
        onChanged: (String newValue) {
          setState(() {
            noOfRoomsAvailable = newValue;
            print(newValue);
          });
        },
        items: <String>['1', '2', '3', '4', '5', '6', '7', '8', '9', '10']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  Widget noOfBathRoomsDD(String _value) {
    return Center(
      child: DropdownButton<String>(
        value: _value,
        onChanged: (String newValue) {
          setState(() {
            noOfBathRooms = newValue;
            print(newValue);
          });
        },
        items: <String>['1', '2', '3', '4', '5', '6']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  Widget noOfBathroomsAvailableDD(String _value) {
    return Center(
      child: DropdownButton<String>(
        value: _value,
        onChanged: (String newValue) {
          setState(() {
            noOfBathRoomsAvailable = newValue;
            print(newValue);
          });
        },
        items: <String>['1', '2', '3', '4', '5', '6']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  Widget locationDD(String _value) {
    return Center(
      child: DropdownButton<String>(
        value: _value,
        onChanged: (String newValue) {
          setState(() {
            location = newValue;
            print(newValue);
          });
        },
        items: <String>[
          'Select Option:',
          'Close to the City',
          'Close to the college',
          'Away from the college',
        ].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  Widget facilitiesOfferedDD(String _value) {
    return Center(
      child: DropdownButton<String>(
        value: _value,
        onChanged: (String newValue) {
          setState(() {
            facilitiesOffered = newValue;
            print(newValue);
          });
        },
        items: <String>[
          'Select Option:',
          'Pool',
          'Library',
          'Hiking',
          'Music Room'
        ].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  Widget familyPetsDD(String _value) {
    return Center(
      child: DropdownButton<String>(
        value: _value,
        onChanged: (String newValue) {
          setState(() {
            pets = newValue;
            print(newValue);
          });
        },
        items: <String>[
          'Select Option:',
          'Dogs',
          'Cats',
          'Other',
        ].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  Widget noOfFamilyPetDD(String _value) {
    return Center(
      child: DropdownButton<String>(
        value: _value,
        onChanged: (String newValue) {
          setState(() {
            noOfPets = newValue;
            print(newValue);
          });
        },
        items: <String>['1', '2', '3', '4', '5', '6', '7', '8', '9', '10']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  Widget transportDD(String _value) {
    return Center(
      child: DropdownButton<String>(
        value: _value,
        onChanged: (String newValue) {
          setState(() {
            transportProximity = newValue;
            print(newValue);
          });
        },
        items: <String>[
          'Select Option:',
          'Local city bus',
          'School bus',
          'Train',
          'Taxis',
        ].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  Widget amenitiesDD(String _value) {
    return Center(
      child: DropdownButton<String>(
        value: _value,
        onChanged: (String newValue) {
          setState(() {
            otherAmenities = newValue;
            print(newValue);
          });
        },
        items: <String>[
          'Select Option:',
          'Gym',
          'Shopping Mall',
          'Clinic',
          'Park',
          'CBD'
        ].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  Widget studentPreferredGenderDD(String _value) {
    return Center(
      child: DropdownButton<String>(
        value: _value,
        onChanged: (String newValue) {
          setState(() {
            preferredStudentGender = newValue;
            print(newValue);
          });
        },
        items: <String>[
          'Select Option:',
          'Not Specific',
          'Male',
          'Female',
          'Transgender',
        ].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  Widget studentPreferredLevelOfStudyDD(String _value) {
    return Center(
      child: DropdownButton<String>(
        value: _value,
        onChanged: (String newValue) {
          setState(() {
            preferredLevelOfStudy = newValue;
            print(newValue);
          });
        },
        items: <String>[
          'Select Option:',
          'Not Specific',
          'Undergraduate',
          'Postgraduate',
          'Diploma/Certificate',
        ].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  Widget smokingStudentDD(String _value) {
    return Center(
      child: DropdownButton<String>(
        value: _value,
        onChanged: (String newValue) {
          setState(() {
            smokingStudent = newValue;
            print(newValue);
          });
        },
        items: <String>[
          'Select Option:',
          'Not Specific',
          'Yes',
          'No',
        ].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  Widget studentWithPetsDD(String _value) {
    return Center(
      child: DropdownButton<String>(
        value: _value,
        onChanged: (String newValue) {
          setState(() {
            studentWithPets = newValue;
            print(newValue);
          });
        },
        items: <String>[
          'Select Option:',
          'Not Specific',
          'Yes',
          'No',
        ].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  List<File> imageList;

  pickImage() async {
    File file = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      List<File> imageFile = new List();
      imageFile.add(file);
      if (imageList == null) {
        imageList = new List.from(imageFile, growable: true);
      } else {
        for (int s = 0; s < imageFile.length; s++) {
          imageList.add(file);
        }
      }
      setState(() {});
    }
  }

  removeImage(int index) async {
    //imagesMap.remove(index);
    imageList.removeAt(index);
    setState(() {});
  }
}
