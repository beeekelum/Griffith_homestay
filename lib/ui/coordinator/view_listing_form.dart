import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:homestay/models/user.dart';
import 'package:homestay/services/firestore_services.dart';
import 'package:homestay/widgets/app_widgets.dart';
import 'package:provider/provider.dart';

class ViewListingForm extends StatefulWidget {
  ViewListingForm({this.cottage});

  final DocumentSnapshot cottage;

  @override
  _ViewListingFormState createState() => _ViewListingFormState();
}

class _ViewListingFormState extends State<ViewListingForm> {
  final _formKey = GlobalKey<FormState>();
  bool _validate = false;

  final auth = FirebaseAuth.instance;
  final fs = FirestoreServices();

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    var fUser = Provider.of<FirebaseUser>(context);
    return StreamBuilder<User>(
      stream: fs.streamHostParent(fUser.uid),
      builder: (context, snapshot) {
        var user = snapshot.data;
        if (user != null) {
          return Scaffold(
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
                        .pushReplacementNamed('/coodinatorhomepage');
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
                            formHeading('Host marital status:'),
                            Spacer(),
                            Text(widget.cottage.data['hostMaritalStatus']),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: <Widget>[
                            formHeading('Host parent\'s language:'),
                            Spacer(),
                            Text(widget.cottage.data['hostLanguage']),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: <Widget>[
                            formHeading('Nationality:'),
                            Spacer(),
                            Text(widget.cottage.data['hostNationality']),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: <Widget>[
                            formHeading('Host parent\'s religion:'),
                            Spacer(),
                            Text(widget.cottage.data['hostReligion']),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: <Widget>[
                            formHeading('Past experience of hosting (Years):'),
                            Spacer(),
                            Text(widget.cottage.data['hostingExperience']),
                          ],
                        ),
                        Divider(),
                        titleWidget('Accommodation Details'),
                        Divider(),
                        Row(
                          children: <Widget>[
                            formHeading('Accommodation term:'),
                            Spacer(),
                            Text(widget.cottage.data['accommodationDuration']),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: <Widget>[
                            formHeading('Available Start Date:'),
                            Spacer(),
                            Text(
                              widget.cottage.data['availableStartDate']
                                  .toString()
                                  .substring(0, 10),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: <Widget>[
                            formHeading('Available End Date:'),
                            Spacer(),
                            Text(widget.cottage.data['availableEndDate']
                                .toString()
                                .substring(0, 10)),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: <Widget>[
                            formHeading('Number of rooms:'),
                            Spacer(),
                            Text(widget.cottage.data['noOfrooms']),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: <Widget>[
                            formHeading('Number of rooms available:'),
                            Spacer(),
                            Text(widget.cottage.data['noOfRoomsAvailable']),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: <Widget>[
                            formHeading('Number of bathrooms:'),
                            Spacer(),
                            Text(widget.cottage.data['noOfBathrooms']),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: <Widget>[
                            formHeading('Number of bathrooms available:'),
                            Spacer(),
                            Text(widget.cottage.data['noOfBathroomsAvailable']),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: <Widget>[
                            formHeading('Location:'),
                            Spacer(),
                            Text(widget.cottage.data['location']),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: <Widget>[
                            formHeading('Facilites Offered:'),
                            Spacer(),
                            Text(widget.cottage.data['facilitiesOffered']),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: <Widget>[
                            formHeading('Types of family pets:'),
                            Spacer(),
                            Text(widget.cottage.data['typesOfFamilyPets']),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: <Widget>[
                            formHeading('No of family pets:'),
                            Spacer(),
                            Text(widget.cottage.data['noOfFamilyPets']),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: <Widget>[
                            formHeading('Tranport proximity:'),
                            Spacer(),
                            Text(widget.cottage.data['transportProximity']),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: <Widget>[
                            formHeading('Other amenities:'),
                            Spacer(),
                            Text(widget.cottage.data['otherAmenities']),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        formHeading('Listing images:'),
                        Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: Card(
                            elevation: 0,
                            child: new Container(
                              width: screenSize.width,
                              height: 160.0,
                              child: new ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemCount:
                                      widget.cottage.data['listingImages'] ==
                                              null
                                          ? 0
                                          : widget.cottage.data['listingImages']
                                              .length,
                                  itemBuilder: (context, index) {
                                    return new Stack(
                                      alignment: Alignment.center,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: new Container(
                                            height: 140.0,
                                            width: 150.0,
                                            child: new Image.network(
                                              widget.cottage.data[
                                                          'listingImages'] ==
                                                      ''
                                                  ? Center(
                                                      child:
                                                          CircularProgressIndicator(),
                                                    )
                                                  : widget.cottage
                                                          .data['listingImages']
                                                      [index],
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  }),
                            ),
                          ),
                        ),
                        Divider(),
                        titleWidget('Host parent\'s preferences'),
                        Divider(),
                        Row(
                          children: <Widget>[
                            formHeading('Prefered student gender:'),
                            Spacer(),
                            Text(widget.cottage.data['preferedStudentGender']),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: <Widget>[
                            formHeading('Prefered level of study:'),
                            Spacer(),
                            Text(widget.cottage.data['preferedLevelOfStudy']),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: <Widget>[
                            formHeading('Smoking student:'),
                            Spacer(),
                            Text(widget.cottage.data['smokingStudent']),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: <Widget>[
                            formHeading('Students with/like pets:'),
                            Spacer(),
                            Text(widget.cottage.data['studentWithPets']),
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
}
