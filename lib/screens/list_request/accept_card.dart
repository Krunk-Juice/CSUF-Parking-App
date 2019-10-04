import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_parking_app/screens/home/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
  String status = '';

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
    status = prefs.getString('status') ?? '';

    bookerId = prefs.getString('bookerId') ?? '';
    bookerName = prefs.getString('bookerName') ?? '';
    bookerPhotoUrl = prefs.getString('bookerPhotoUrl') ?? '';

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
          title: Text('Checking',
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
                            padding: EdgeInsets.only(top: 50),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text('Booker',
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.white)),
                              ],
                            )),
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
                RaisedButton(
                  padding: EdgeInsets.symmetric(vertical: 25, horizontal: 80),
                  // padding: EdgeInsets.all(0),
                  elevation: 15,

                  splashColor: Colors.blueAccent,
                  child: Text('Accept',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.green[900])),

                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  onPressed: () => (status == 'Swaping')
                      ? _handleError(context)
                      : null,
                      // _handleAccept(context),
                ),
              ],
            )
          ],
        )));
  }

  Future _handleError(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Check your status'),
        content: new Text('Can not accpect request while giving'),
        actions: <Widget>[
          new FlatButton(
            onPressed: () => Navigator.pushNamed(context, Home.id),
            child: new Text('OK'),
          ),
          // new FlatButton(
          //   onPressed: () {
          //     // handleSignOut();
          //     // Navigator.pushNamedAndRemoveUntil(context, LoginPage.id, (Route <dynamic> route)=>false);

          //   },
          //   child: new Text('Yes'),
          // ),
        ],
      ),
    );
  }

  

  void _handleAccept(BuildContext context) async {
//update release status
    Firestore.instance.collection('users').document(id).updateData({
      'status': 'Swaping',
    }).then((data) async {
      await prefs.setString('status', 'Swaping');
      await db.collection('requests').document(id).delete();
      // Navigator.pushNamed(context, Home.id);
      // Fluttertoast.showToast(msg: "Update success");
    }).catchError((err) => print(err));

    Firestore.instance.collection('users').document(bookerId).updateData({
      'status': 'Swaping',
    });



    Firestore.instance.collection('swaps').add({
      'releaserId': id,
      'releaserName': nickname,
      'releaserPhoto': photoUrl,
      'bookerId': bookerId,
      'bookerName': bookerName,
      'bookerPhotoUrl': bookerPhotoUrl,
    }).then((data) async {
      Navigator.pushNamed(context, Home.id);
      Fluttertoast.showToast(msg: "Update success");
    }).catchError((err) => print(err));
  }
}
