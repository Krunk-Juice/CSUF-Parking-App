import 'package:flutter/material.dart';
import 'package:flutter_parking_app/views/home/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_parking_app/components/round_button.dart';




// This screen shows up after you have selected a user 
// to release your spot to. Showing the users name and
// photo with the options to accept or reject the requester
// Confirmation Screen


class AcceptCard extends StatefulWidget {
  
  AcceptCard({this.bookerId,this.bookerName,this.bookerPhotoUrl});

  final String bookerId;
  final String bookerName;
  final String bookerPhotoUrl;
  

  @override
  _AcceptCardState createState() => _AcceptCardState();
}

class _AcceptCardState extends State<AcceptCard> {

  String id = '';
  String nickname = '';
  String photoUrl = '';
  int floor = 0;
  String parkAt = '';
  String leaveAt ='';
  


  // UI Construct of the Confirmation Screen
  @override
  Widget build(BuildContext context) {
    return  Container(
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
                                      child: widget.bookerPhotoUrl == null
                                          ? Icon(
                                              Icons.account_circle,
                                              size: 90.0,
                                              color: Colors.grey,
                                            )
                                          : CachedNetworkImage(
                                              imageUrl: widget.bookerPhotoUrl,
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
                                Text(widget.bookerName,
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.white)),
                              ],
                            ))
                      ],
                    )),
                SizedBox(
                  height: 50,
                ),
                /* Button Container */
                RoundedButton(
                  colour: Colors.greenAccent,
                  title: 'Accept',
                  onPressed:()=> _handleAccept(context),
                ),
                SizedBox(
                  height: 20,
                ),
                RoundedButton(
                  colour: Colors.redAccent,
                  title: 'Reject',
                  onPressed: ()=>_handleReject(context),
                ),
              ],
            )
          ],
    ));
  }

  

  // You reject the requesting user
  void _handleReject(BuildContext context) async {
//update status
 
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('status', 'Releasing');
      id = prefs.getString('id') ?? '';

    Firestore.instance.collection('users').document(widget.bookerId).updateData({
      'status': 'Relaxing',
    });

    Firestore.instance.collection('requests').document(id).updateData({
      'turnOn': false,
    });

    Firestore.instance.collection('users').document(id).updateData({
      'status': 'Releasing',
      
    }).then((data) async {
      
      Navigator.pushNamed(context, Home.id);
      
    }).catchError((err) => print(err));
  }

  // You accept the requesting user
  void _handleAccept(BuildContext context) async {
//update status
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id = prefs.getString('id') ?? '';
    nickname = prefs.getString('nickname') ?? '';
    photoUrl = prefs.getString('photoUrl') ?? '';
    parkAt = prefs.getString('parkAt')??'';
    floor = prefs.getInt('floor')??0;
    leaveAt = prefs.getString('leaveAt')??'';
    

    Firestore.instance.collection('users').document(widget.bookerId).updateData({
      'status': 'Swaping',
    });

    // Firestore.instance.collection('requests').document(id).updateData({
    //   'turnOn': false,
    // });

    Firestore.instance.collection('users').document(id).updateData({
      'status': 'Swaping',
    });

    Firestore.instance.collection('swaps').document(id).updateData({
      'releaserId': id,
      'releaserName': nickname,
      'releaserPhotoUrl': photoUrl,
      'bookerId': widget.bookerId,
      'bookerName': widget.bookerName,
      'bookerPhotoUrl': widget.bookerPhotoUrl,
      'turnOn': true,
      'swapLocation':parkAt,
      'floor': floor,
      'timeSwap': int.parse(leaveAt),

    }).then((data) async {
      Navigator.pushNamed(context, Home.id);
    }).catchError((err) => print(err));
  }
}
