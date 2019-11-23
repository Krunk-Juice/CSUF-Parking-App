
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_parking_app/views/home/home.dart';
import 'package:flutter_parking_app/views/list_release/release_item.dart';
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
  Firestore _firestore = Firestore.instance;
  String releaserId='';

  @override
  initState() {
    super.initState();
    readLocal();
  }

  // Read RAM for user information.
  void readLocal() async {
    prefs = await SharedPreferences.getInstance();
    id = prefs.getString('id') ?? '';

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
              stream:
                  _firestore.collection('users').orderBy('leaveAt').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final doc = snapshot.data.documents;
                  List<ReleaseItem> releaserWidgets = [];
                  for (var item in doc) {
                    
                    final releaserStatus = item.data['status'];
                    releaserId = item.data['id'];
                    
                    if (releaserId != id && releaserStatus == 'Releasing') {
                      final releaserWidget = ReleaseItem(
                        releaserName: item.data['nickname'],
                        releaserId: releaserId,
                        releaserPhotoUrl: item.data['photoUrl'],
                        releaserParking: item.data['parkAt'],
                        releaserLeavingTime:
                            DateTime.fromMillisecondsSinceEpoch(
                                item.data['leaveAt']),
                        releaserFloor: item.data['floor'],
                        
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

