import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:homestay/widgets/app_widgets.dart';

class CottageDetailsBody extends StatefulWidget {
  CottageDetailsBody(this.cottage);

  final DocumentSnapshot cottage;

  @override
  _CottageDetailsBodyState createState() => _CottageDetailsBodyState();
}

class _CottageDetailsBodyState extends State<CottageDetailsBody> {
  _createCircleBadge(IconData iconData, Color color) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: CircleAvatar(
        backgroundColor: color,
        child: Icon(
          iconData,
          color: Colors.white,
          size: 16,
        ),
        radius: 16,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    var separator = Divider(
      height: 5,
      color: Colors.white70,
    );
    var accommodationDuration = Padding(
      padding: EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Accommodation terms: ',
            style: TextStyle(fontSize: 15, color: Colors.white),
          ),
          Text(
            widget.cottage.data['accommodationDuration'],
            style: TextStyle(fontSize: 15, color: Colors.white),
          )
        ],
      ),
    );

    var location = Padding(
      padding: EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Homestay location: ',
            style: TextStyle(fontSize: 15, color: Colors.white),
          ),
          Text(
            widget.cottage.data['location'],
            style: TextStyle(fontSize: 15, color: Colors.white),
          )
        ],
      ),
    );
    var offeredFacilities = Padding(
      padding: EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Offered facilites: ',
            style: TextStyle(fontSize: 15, color: Colors.white),
          ),
          Text(
            widget.cottage.data['facilitiesOffered'],
            style: TextStyle(fontSize: 15, color: Colors.white),
          )
        ],
      ),
    );
    var familyPets = Padding(
      padding: EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Family pets: ',
            style: TextStyle(fontSize: 15, color: Colors.white),
          ),
          Text(
            widget.cottage.data['typesOfFamilyPets'],
            style: TextStyle(fontSize: 15, color: Colors.white),
          )
        ],
      ),
    );
    var noOfPets = Padding(
      padding: EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Number of pets: ',
            style: TextStyle(fontSize: 15, color: Colors.white),
          ),
          Text(
            widget.cottage.data['noOfFamilyPets'],
            style: TextStyle(fontSize: 15, color: Colors.white),
          )
        ],
      ),
    );
    var transport = Padding(
      padding: EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Transport proximity: ',
            style: TextStyle(fontSize: 15, color: Colors.white),
          ),
          Text(
            widget.cottage.data['transportProximity'],
            style: TextStyle(fontSize: 15, color: Colors.white),
          )
        ],
      ),
    );
    var amenities = Padding(
      padding: EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Other amenities: ',
            style: TextStyle(fontSize: 15, color: Colors.white),
          ),
          Text(
            widget.cottage.data['otherAmenities'],
            style: TextStyle(fontSize: 15, color: Colors.white),
          )
        ],
      ),
    );
    var preferredStudentGender = Padding(
      padding: EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Preferred student gender: ',
            style: TextStyle(fontSize: 15, color: Colors.white),
          ),
          Text(
            widget.cottage.data['preferedStudentGender'],
            style: TextStyle(fontSize: 15, color: Colors.white),
          )
        ],
      ),
    );
    var preferredStudentLevelOfStudy = Padding(
      padding: EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Preferred level of study: ',
            style: TextStyle(fontSize: 15, color: Colors.white),
          ),
          Text(
            widget.cottage.data['preferedLevelOfStudy'],
            style: TextStyle(fontSize: 15, color: Colors.white),
          )
        ],
      ),
    );
    var smokingStudent = Padding(
      padding: EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Smoking student: ',
            style: TextStyle(fontSize: 15, color: Colors.white),
          ),
          Text(
            widget.cottage.data['smokingStudent'],
            style: TextStyle(fontSize: 15, color: Colors.white),
          )
        ],
      ),
    );
    var studentWithPets = Padding(
      padding: EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Student with/likes pets: ',
            style: TextStyle(fontSize: 15, color: Colors.white),
          ),
          Text(
            widget.cottage.data['studentWithPets'],
            style: TextStyle(fontSize: 15, color: Colors.white),
          )
        ],
      ),
    );
    var noOfRooms = Padding(
      padding: EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Number of rooms: ',
            style: TextStyle(fontSize: 15, color: Colors.white),
          ),
          Text(
            widget.cottage.data['noOfrooms'],
            style: TextStyle(fontSize: 15, color: Colors.white),
          )
        ],
      ),
    );
    var availableRooms = Padding(
      padding: EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Available Rooms: ',
            style: TextStyle(fontSize: 15, color: Colors.white),
          ),
          Text(
            widget.cottage.data['noOfRoomsAvailable'],
            style: TextStyle(fontSize: 15, color: Colors.white),
          )
        ],
      ),
    );
    var noOfBathrooms = Padding(
      padding: EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Number of bathrooms: ',
            style: TextStyle(fontSize: 15, color: Colors.white),
          ),
          Text(
            widget.cottage.data['noOfBathrooms'],
            style: TextStyle(fontSize: 15, color: Colors.white),
          )
        ],
      ),
    );

    var noOfBathroomsAvailable = Padding(
      padding: EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Bathrooms Available: ',
            style: TextStyle(fontSize: 15, color: Colors.white),
          ),
          Text(
            widget.cottage.data['noOfBathroomsAvailable'],
            style: TextStyle(fontSize: 15, color: Colors.white),
          )
        ],
      ),
    );
    var hostParentMaritalStatus = Padding(
      padding: EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Host marital status: ',
            style: TextStyle(fontSize: 15, color: Colors.white),
          ),
          Text(
            widget.cottage.data['hostMaritalStatus'],
            style: TextStyle(fontSize: 15, color: Colors.white),
          )
        ],
      ),
    );
    var hostParentLanguage = Padding(
      padding: EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Host parent\'s language: ',
            style: TextStyle(fontSize: 15, color: Colors.white),
          ),
          Text(
            widget.cottage.data['hostLanguage'],
            style: TextStyle(fontSize: 15, color: Colors.white),
          )
        ],
      ),
    );
    var hostNationality = Padding(
      padding: EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Host parent\'s nationality: ',
            style: TextStyle(fontSize: 15, color: Colors.white),
          ),
          Text(
            widget.cottage.data['hostNationality'],
            style: TextStyle(fontSize: 15, color: Colors.white),
          )
        ],
      ),
    );
    var hostReligion = Padding(
      padding: EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Host parent\'s religion: ',
            style: TextStyle(fontSize: 15, color: Colors.white),
          ),
          Text(
            widget.cottage.data['hostReligion'],
            style: TextStyle(fontSize: 15, color: Colors.white),
          )
        ],
      ),
    );
    var previousExperience = Padding(
      padding: EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Hosting students experience (years): ',
            style: TextStyle(fontSize: 15, color: Colors.white),
          ),
          Text(
            widget.cottage.data['hostingExperience'],
            style: TextStyle(fontSize: 15, color: Colors.white),
          )
        ],
      ),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        titleWidget2('Host parent\'s personal details'),
        Divider(),
//        _makeProfileItem('Host marital Status',
//            widget.cottage.data['hostMaritalStatus'], Icons.people),
        hostParentMaritalStatus,
        separator,
        hostParentLanguage,
        separator,
        hostNationality,
        separator,
        hostReligion,
        separator,
        previousExperience,
        separator,
        titleWidget2('Accommodation Details'),
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
                  itemCount: widget.cottage.data['listingImages'] == null
                      ? 0
                      : widget.cottage.data['listingImages'].length,
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
                              widget.cottage.data['listingImages'] == ''
                                  ? Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : widget.cottage.data['listingImages'][index],
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
        accommodationDuration,
        separator,
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Available From ' +
                widget.cottage.data['availableStartDate']
                    .toString()
                    .substring(0, 10) +
                ' To ' +
                widget.cottage.data['availableEndDate']
                    .toString()
                    .substring(0, 10),
            style: TextStyle(color: Colors.white),
          ),
        ),
        separator,
        noOfRooms,
        separator,
        availableRooms,
        separator,
        noOfBathrooms,
        separator,
        noOfBathroomsAvailable,
        separator,
        location,
        separator,
        offeredFacilities,
        separator,
        familyPets,
        separator,
        noOfPets,
        separator,
        transport,
        separator,
        amenities,
        separator,
        titleWidget2('Host parent\'s preferences'),
        separator,
        preferredStudentGender,
        separator,
        preferredStudentLevelOfStudy,
        separator,
        smokingStudent,
        separator,
        studentWithPets

//        Padding(
//          padding: const EdgeInsets.only(top: 16),
//          child: Row(
//            children: <Widget>[
//              _createCircleBadge(
//                Icons.share,
//                theme.accentColor,
//              ),
//              _createCircleBadge(
//                Icons.phone,
//                Colors.white12,
//              ),
//              _createCircleBadge(
//                Icons.email,
//                Colors.white12,
//              ),
//            ],
//          ),
//        ),
      ],
    );
  }

  Card _makeProfileItem(String title, String value, IconData icon) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      elevation: 1,
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.purple,
          size: 25,
        ),
        title: Text(
          value,
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontFamily: 'Muli'),
        ),
        subtitle: Text(
          title,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w100,
            fontFamily: 'Muli',
          ),
        ),
      ),
    );
  }
}
