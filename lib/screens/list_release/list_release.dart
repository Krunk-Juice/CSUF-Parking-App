import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_parking_app/screens/list_release/request_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences prefs;

class ListRelease extends StatefulWidget {
  static const String id = "list_release";

  @override
  _ListReleaseState createState() => _ListReleaseState();
}

class _ListReleaseState extends State<ListRelease> {
  // FirebaseUser currentUser;
  bool isLoading = false;
  String id = '';
  String nickname = '';
  String photoUrl = '';
  Firestore _firestore = Firestore.instance;

  @override
  initState() {
    super.initState();
    readLocal();
  }

  void readLocal() async {
    prefs = await SharedPreferences.getInstance();
    id = prefs.getString('id') ?? '';
    nickname = prefs.getString('nickname') ?? '';
    photoUrl = prefs.getString('photoUrl') ?? '';

    // Force refresh input
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          color: Colors.black,
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.arrow_back, color: Colors.black),
        ),
        title: Text('List Spot Holder Releasing Spot',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700)),
            centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamBuilder(
              stream: _firestore.collection('users').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final doc = snapshot.data.documents;
                  List<ReleaseItem> releaserWidgets = [];
                  for (var item in doc) {
                    final releaserName = item.data['nickname'];
                    final releaserPhotoUrl = item.data['photoUrl'];
                    final releaserStatus = item.data['status'];
                    final releaserId = item.data['id'];
                    final releaserParking = item.data['parkAt'];
                    final releaserLeavingTime = item.data['leaveAt'];

                    if (releaserId != id && releaserStatus == 'Releasing') {
                      final releaserWidget = ReleaseItem(
                        releaserName: releaserName,
                        releaserId: releaserId,
                        releaserPhotoUrl: releaserPhotoUrl,
                        releaserParking: releaserParking,
                        releaserLeavingTime: releaserLeavingTime,
                      );
                      releaserWidgets.add(releaserWidget);
                    }
                  }
                  return Expanded(
                    child: ListView(
                      children: releaserWidgets,
                    ),
                  );
                } else {
                  return Center(
                      child: Container(
                          alignment: FractionalOffset.center,
                          child: Image.asset('assets/images/loading.gif')));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ReleaseItem extends StatelessWidget {
  final String releaserName;
  final String releaserId;
  final String releaserPhotoUrl;
  final String releaserParking;
  final String releaserLeavingTime;

  const ReleaseItem(
      {Key key,
      @required this.releaserName,
      @required this.releaserParking,
      @required this.releaserLeavingTime,
      @required this.releaserId,
      @required this.releaserPhotoUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.0),
      child: Stack(
        children: <Widget>[
          /// Item card
          Align(
            alignment: Alignment.topCenter,
            child: SizedBox.fromSize(
                size: Size.fromHeight(172.0),
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    /// Item description inside a material
                    Container(
                      margin: EdgeInsets.only(top: 24.0),
                      child: Material(
                        elevation: 14.0,
                        borderRadius: BorderRadius.circular(12.0),
                        shadowColor: Color(0x802196F3),
                        color: Colors.white,
                        child: InkWell(
                          onTap: () => {
                            //set prefs for releaser
                            prefs.setString('releaserId', releaserId),
                            prefs.setString('releaserName', releaserName),
                            prefs.setString(
                                'releaserPhotoUrl', releaserPhotoUrl),
                            Navigator.pushNamed(context, RequestCard.id),
                          },
                          child: Padding(
                            padding: EdgeInsets.all(24.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                /// Title and rating
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(releaserName,
                                        style: TextStyle(
                                            color: Colors.blueAccent)),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                            releaserParking != null
                                                ? releaserParking
                                                : 'Not Available',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 34.0)),
                                        Icon(Icons.directions,
                                            color: Colors.blue, size: 24.0),
                                      ],
                                    ),
                                  ],
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text('Release at', style: TextStyle()),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 4.0),
                                      child: Material(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        color: Colors.green,
                                        child: Padding(
                                          padding: EdgeInsets.all(4.0),
                                          child: Text(
                                              releaserLeavingTime != null
                                                  ? releaserLeavingTime
                                                  : 'Not Available',
                                              style: TextStyle(
                                                  color: Colors.white)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: EdgeInsets.only(right: 16.0),
                        child: SizedBox.fromSize(
                          size: Size.fromRadius(54.0),
                          child: (releaserPhotoUrl == null)
                              ? Material(
                                  color: Colors.blueAccent,
                                  shape: CircleBorder(),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Icon(Icons.account_circle,
                                        color: Colors.white, size: 30.0),
                                  ))
                              : Material(
                                  shape: CircleBorder(),
                                  elevation: 14,
                                  shadowColor: Colors.black,
                                  child: CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(releaserPhotoUrl),
                                    radius: 30,
                                  )),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}