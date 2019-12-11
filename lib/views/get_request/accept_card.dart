import 'package:flutter/material.dart';
import 'package:flutter_parking_app/components/header_image.dart';
import 'package:flutter_parking_app/components/icon_content.dart';
import 'package:flutter_parking_app/components/reusable_card.dart';
import 'package:flutter_parking_app/views/home/home.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// This screen shows up after you have selected a user
// to release your spot to. Showing the users name and
// photo with the options to accept or reject the requester
// Confirmation Screen

class AcceptCard extends StatefulWidget {
  AcceptCard({this.bookerId, this.bookerName, this.bookerPhotoUrl});

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
  String leaveAt = '';

  // UI Construct of the Confirmation Screen
  @override
  Widget build(BuildContext context) {
    return Container(
        //color: Colors.blueGrey,
        child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        /* Header Section */
        Expanded(
          child: HeaderImage(
            
            photoUrl: widget.bookerPhotoUrl,
            name: widget.bookerName,
          ),
        ),

        /* Button Container */
        Expanded(
          child: Row(
            children: <Widget>[
              Expanded(
                  child: ReusableCard(
                onPress: () => _handleAccept(context),
                cardChild: IconContent(
                  icon: FontAwesomeIcons.check,
                  label: 'ACCEPT',
                ),
              )),
              Expanded(
                  child: ReusableCard(
                onPress: () => _handleReject(context),
                cardChild: IconContent(
                  icon: FontAwesomeIcons.times,
                  label: 'REJECT',
                ),
              )),
            ],
          ),
        ),
      ],
    ));
  }

  // You reject the requesting user
  void _handleReject(BuildContext context) async {
//update status

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('status', 'Releasing');
    id = prefs.getString('id') ?? '';

    Firestore.instance
        .collection('users')
        .document(widget.bookerId)
        .updateData({
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
    parkAt = prefs.getString('parkAt') ?? '';
    floor = prefs.getInt('floor') ?? 0;
    leaveAt = prefs.getString('leaveAt') ?? '';

    Firestore.instance
        .collection('users')
        .document(widget.bookerId)
        .updateData({
      'status': 'Swaping',
    });

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
      'swapLocation': parkAt,
      'floor': floor,
      'timeSwap': int.parse(leaveAt),
    }).then((data) async {
      Navigator.pushNamed(context, Home.id);
    }).catchError((err) => print(err));
  }
}
