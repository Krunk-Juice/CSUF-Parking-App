import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_parking_app/views/home/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_parking_app/components/round_button.dart';

SharedPreferences prefs;

class AcceptCard extends StatefulWidget {
  static const String id = "accept_card";
  @override
  _AcceptCardState createState() => _AcceptCardState();
}

class _AcceptCardState extends State<AcceptCard> {
  final db = Firestore.instance;

  String id = '';
  String nickname = '';
  String photoUrl = '';
  // String status = '';

  String bookerId = '';
  String bookerName = '';
  String bookerPhotoUrl = '';

  @override
  void initState() {
    super.initState();

    readLocal();
  }

  void readLocal() async {
    prefs = await SharedPreferences.getInstance();
    id = prefs.getString('id') ?? '';
    nickname = prefs.getString('nickname') ?? '';
    photoUrl = prefs.getString('photoUrl') ?? '';
    // status = prefs.getString('status') ?? '';

    bookerId = prefs.getString('bookerId') ?? '';
    bookerName = prefs.getString('bookerName') ?? '';
    bookerPhotoUrl = prefs.getString('bookerPhotoUrl') ?? '';
// Firestore.instance.collection('users').document(bookerId).get().then(
//           (DocumentSnapshot snapshot){
            
//               bookerName = snapshot.data['nickname'].toString(); 
//               bookerPhotoUrl = snapshot.data['photoUrl'].toString();
//               });
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
          title: Text('Requester',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w700)),
          centerTitle: true,
        ),
        body: Container(
            //color: Colors.blueGrey,
            child: Column(
          children: <Widget>[
            Column(
              children: <Widget>[
                /* Header Section */
                Container(
                    height: 350,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.lightBlue, Colors.cyan],
                          begin: Alignment.topLeft,
                          end: Alignment(-0.2, 0.7)),
                    ),
                    child: Column(
                      children: <Widget>[
                        
                        Padding(
                            padding: EdgeInsets.only(top: 30),
                            // child: Stack(fit: StackFit.loose, children: <Widget>[
                            //   /* Container fills the full width of the device */
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Material(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(24.0),
                                    child: ClipOval(
                                      child: bookerPhotoUrl == null
                                          ? Icon(
                                              Icons.account_circle,
                                              size: 90.0,
                                              color: Colors.grey,
                                            )
                                          : CachedNetworkImage(
                                              imageUrl: bookerPhotoUrl,
                                              width: 50.0,
                                              height: 50.0,
                                            ),
                                    ))
                              ],
                            )
                            //],)
                            ),
                        Padding(
                            padding: EdgeInsets.only(top: 30),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(bookerName,
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.white)),
                              ],
                            ))
                      ],
                    )),
                SizedBox(
                  height: 100,
                ),
                /* Button Container */
                RoundedButton(
                  colour: Colors.greenAccent,
                  title: 'Accept',
                  onPressed:()=> _handleAccept(context),
                ),
                SizedBox(
                  height: 10,
                ),
                RoundedButton(
                  colour: Colors.redAccent,
                  title: 'Reject',
                  onPressed: ()=>_handleReject(context),
                ),
              ],
            )
          ],
        )));
  }

  // Future _handleError(BuildContext context) {
  //   return showDialog(
  //     context: context,
  //     builder: (context) => new AlertDialog(
  //       title: new Text('Check your status'),
  //       content: new Text('Can not accpect request while giving'),
  //       actions: <Widget>[
  //         new FlatButton(
  //           onPressed: () => Navigator.pushNamed(context, Home.id),
  //           child: new Text('OK'),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  void _handleReject(BuildContext context) async {
//update status

    Firestore.instance.collection('users').document(bookerId).updateData({
      'status': 'Relaxing',
    });

    Firestore.instance.collection('requests').document(id).updateData({
      'turnOn': false,
    });

    Firestore.instance.collection('users').document(id).updateData({
      'status': 'Releasing',
    }).then((data) async {
      await prefs.setString('status', 'Releasing');
      
      Navigator.pushNamed(context, Home.id);
      Fluttertoast.showToast(msg: "Update success");
    }).catchError((err) => print(err));
  }

  void _handleAccept(BuildContext context) async {
//update status

    Firestore.instance.collection('users').document(bookerId).updateData({
      'status': 'Swaping',
    });

    Firestore.instance.collection('requests').document(id).updateData({
      'turnOn': false,
    });

    Firestore.instance.collection('users').document(id).updateData({
      'status': 'Swaping',
    });

    Firestore.instance.collection('swaps').document(id).updateData({
      'releaserId': id,
      'releaserName': nickname,
      'releaserPhotoUrl': photoUrl,
      'bookerId': bookerId,
      'bookerName': bookerName,
      'bookerPhotoUrl': bookerPhotoUrl,
      'turnOn': true,
    }).then((data) async {
      Navigator.pushNamed(context, Home.id);
      Fluttertoast.showToast(msg: "Update success");
    }).catchError((err) => print(err));
  }
}
