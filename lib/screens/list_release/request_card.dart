import 'package:flutter/material.dart';
import 'package:flutter_parking_app/screens/home/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_parking_app/components/round_button.dart';

SharedPreferences prefs;

class RequestCard extends StatefulWidget {
  static const String id = "request_card";
  @override
  _RequestCardState createState() => _RequestCardState();
}

class _RequestCardState extends State<RequestCard> {
  String id = '';
  String nickname = '';
  String photoUrl = '';
  // String status = '';

  String releaserId = '';
  String releaserName = '';
  String releaserPhotoUrl = '';

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

    releaserId = prefs.getString('releaserId') ?? '';
    releaserName = prefs.getString('releaserName') ?? '';
    releaserPhotoUrl = prefs.getString('releaserPhotoUrl') ?? '';
      // Firestore.instance.collection('users').document(releaserId).get().then(
      //     (DocumentSnapshot snapshot){
            
      //         releaserName = snapshot.data['nickname'].toString(); 
      //         releaserPhotoUrl = snapshot.data['photoUrl'].toString();
      //         });
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
          title: Text('Request',
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
                                Text('Spot Holder',
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
                                      child: releaserPhotoUrl == null
                                          ? Icon(
                                              Icons.account_circle,
                                              size: 90.0,
                                              color: Colors.grey,
                                            )
                                          : CachedNetworkImage(
                                              imageUrl: releaserPhotoUrl,
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
                                Text(releaserName,
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
                RoundedButton(colour: Colors.blueAccent,title: 'Request',onPressed:()=>_handleRequest(context),),
                
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
        content: new Text('Can not request while releasing'),
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

  void _handleRequest(BuildContext context) {
//update release status
    Firestore.instance.collection('users').document(id).updateData({
      'status': 'Requesting',
    });

    Firestore.instance.collection('users').document(releaserId).updateData({
      'status': 'Getting Request',
    });
    

    Firestore.instance.collection('requests').document(releaserId).updateData({
      'releaserId': releaserId,
      'bookerId': id,
      'bookerName': nickname,
      'bookerPhotoUrl': photoUrl,
      'turnOn':true,
    });
    Navigator.pushNamed(context, Home.id);
    Fluttertoast.showToast(msg: "Update success");
  }
}
