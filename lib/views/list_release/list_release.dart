import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_parking_app/views/list_release/request_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences prefs;

// Screen that shows a list of users releasing their spot
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

  // Read RAM for user information.
  void readLocal() async {
    prefs = await SharedPreferences.getInstance();
    id = prefs.getString('id') ?? '';
    nickname = prefs.getString('nickname') ?? '';
    photoUrl = prefs.getString('photoUrl') ?? '';

    // Force refresh input
    setState(() {});
  }

  // UI Construct of the general screen
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        // backgroundColor: Colors.transparent,
        leading: IconButton(
          // color: Colors.black,
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(
            Icons.arrow_back,
            // color: Colors.black,
          ),
        ),
        title: Text('List of Users Releasing Spot',
            style: TextStyle(
                // color: Colors.black,
                fontWeight: FontWeight.w700)),
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

// Container holding information of users releasing
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

  // UI Construct of the Container
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical:15.0, horizontal: 5.0),
      // margin: EdgeInsets.symmetric(vertical: 20,horizontal: 5),
      child: Card(
        elevation: 10.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        
        child: InkWell(
          splashColor: Colors.blueAccent,
          
          onTap: () {
            //set prefs for releaser
            prefs.setString('releaserId', releaserId);
            prefs.setString('releaserName', releaserName);
            prefs.setString('releaserPhotoUrl', releaserPhotoUrl);
            Navigator.pushNamed(context, RequestCard.id);
          },
          child: Row(
            children: <Widget>[
              (releaserPhotoUrl == null)
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
                                backgroundImage: NetworkImage(releaserPhotoUrl),
                                radius: 30,
                              )),
              SizedBox(
                width: 10,
              ),
              Column(
                children: <Widget>[
                  Text(
                    releaserName,
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  Text(
                    releaserParking,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),

      
    );
  }
}
