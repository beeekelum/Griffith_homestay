import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:homestay/ui/coordinator/view_listing_form.dart';
import 'package:homestay/utils/routes.dart';
import 'package:provider/provider.dart';

class HostParentListingForm extends StatefulWidget {
  @override
  _HostParentListingFormState createState() => _HostParentListingFormState();
}

class _HostParentListingFormState extends State<HostParentListingForm> {
  final CollectionReference collectionReference =
      Firestore.instance.collection('listings');

  @override
  Widget build(BuildContext context) {
    var fUser = Provider.of<FirebaseUser>(context);
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
              Navigator.of(context).pushReplacementNamed('/coodinatorhomepage');
            },
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Container(
      child: Column(
        children: <Widget>[
          _getListViewWidget(),
        ],
      ),
    );
  }

  Widget _getListViewWidget() {
    return Flexible(
      child: RefreshIndicator(
          child: StreamBuilder<QuerySnapshot>(
            stream: collectionReference.snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) return new Text('${snapshot.error}');
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator());
                default:
                  return ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) {
                      final item = snapshot.data.documents[index];
                      return Container(
                        margin: const EdgeInsets.only(top: 0),
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Card(
                            elevation: 1,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                ListTile(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(new FadePageRoute(
                                      builder: (c) {
                                        return ViewListingForm(
                                            cottage:
                                                snapshot.data.documents[index]);
                                      },
                                      settings: new RouteSettings(),
                                    ));
                                  },
                                  leading: Hero(
                                    tag: index,
                                    child: CircleAvatar(
                                      child: Text(
                                        item['cottageColorName'][0],
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          fontStyle: FontStyle.normal,
                                          fontFamily: 'Muli',
                                        ),
                                      ),
                                    ),
                                  ),
                                  subtitle: Text(
                                    item['hostFullName'] ?? '',
                                    //'Host: ' + item['hostFullName'] ?? '',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  title: Text(
                                    item['cottageColorName'] + ' Cottage',
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 17, color: Colors.teal),
                                  ),
                                  trailing: Icon(
                                    FontAwesomeIcons.home,
                                    color: Colors.teal,
                                  ),
                                  isThreeLine: true,
                                  dense: false,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
              }
            },
          ),
          onRefresh: refresh),
    );
  }

  Future<Null> refresh() {
    return new Future<Null>.value();
  }
}
