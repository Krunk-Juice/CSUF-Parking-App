import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_parking_app/views/get_request/accept_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences prefs;

// Screen that shows a list of users requesting your spot
class GetRequest extends StatefulWidget {
  static const String id = "get_request";

  @override
  _GetRequestState createState() => _GetRequestState();
}

class _GetRequestState extends State<GetRequest> {
  // FirebaseUser currentUser;
  bool isLoading = false;
  String id = '';
  String bookerId = '';
  String bookerName = '';
  String bookerPhotoUrl = '';

  Firestore _firestore = Firestore.instance;

  // Initialize State of Request List Screen
  @override
  initState() {
    super.initState();
    readLocal();
  }

  // Read RAM for user information.
  void readLocal() async {
    prefs = await SharedPreferences.getInstance();
    id = prefs.getString('id') ?? '';
    // nickname = prefs.getString('nickname') ?? '';
    // Force refresh input
    setState(() {});
  }

  // UI Construct of the Request List Screen
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
            //color: Colors.black,
          ),
        ),
        title: Text('Person Requests Your Spot',
            style: TextStyle(
                // color: Colors.black,
                fontWeight: FontWeight.w700)),
        centerTitle: true,
      ),
      body:StreamBuilder(
              stream: _firestore.collection('requests').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final doc = snapshot.data.documents;
                  
                  for (var item in doc) {
                    final releaserId = item.data['releaserId'];
                    final turnOn = item.data['turnOn'];

                    if (releaserId == id && turnOn) {
                    bookerId = item.data['bookerId'];
                    bookerName = item.data['bookerName'];
                    bookerPhotoUrl = item.data['bookerPhotoUrl'];
                    }
                  }
                  return AcceptCard(
                    bookerId: bookerId,
                    bookerName: bookerName,
                    bookerPhotoUrl: bookerPhotoUrl,
                  );
                } else {
                  return Center(
                      child: Container(
                          alignment: FractionalOffset.center,
                          child: Image.asset('assets/images/loading.gif')));
                }
              },
            ),
          
        
      
    );
  }
}

