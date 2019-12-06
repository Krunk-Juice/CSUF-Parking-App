import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_parking_app/components/circle_image.dart';
import 'package:flutter_parking_app/components/constants.dart';
import 'package:flutter_parking_app/components/reusable_card.dart';
import 'package:flutter_parking_app/components/round_button.dart';
import 'package:flutter_parking_app/views/home/home.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReleaseItem extends StatefulWidget {
  final String releaserName;
  final String releaserId;
  final String releaserPhotoUrl;
  final String releaserParking;
  final DateTime releaserLeavingTime;

  final int releaserFloor;

  ReleaseItem({
    Key key,
    @required this.releaserName,
    @required this.releaserParking,
    @required this.releaserLeavingTime,
    @required this.releaserId,
    @required this.releaserPhotoUrl,
    @required this.releaserFloor,
    
  }) : super(key: key);

  @override
  _ReleaseItemState createState() => _ReleaseItemState();
}

class _ReleaseItemState extends State<ReleaseItem> {
 
  String id = '';
  String nickname = '';
  String photoUrl = '';

  

  

  @override
  Widget build(BuildContext context) {
    return ReusableCard(
      // colour: kActiveCardColor,
      
      cardChild: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
               CircleImage(
                      photoUrl: widget.releaserPhotoUrl,
                      icon: FontAwesomeIcons.userTie,
                      
                    ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.releaserName,
                      style: kNicknameTextStyle,
                    ),
                    Row(
                      children: <Widget>[
                        Text('Release at ', style: kParkingListItemTextStyle),
                        Text(
                          '${widget.releaserLeavingTime.hour.toString().padLeft(2, '0')}:${widget.releaserLeavingTime.minute.toString().padLeft(2, '0')}',
                          style: kTimeTextStyle,
                        ),
                        
                      ],
                    ),
                    Text(
                      widget.releaserParking,
                      style: kParkingListItemTextStyle,
                    ),
                     Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Expanded(
                
                  child: SizedBox(
                width: 1,
              )),
              Expanded(
                  child: RoundedButton(
                title: 'Request',
                colour: Colors.green,
                onPressed: ()=>_handleRequest( context),
              ))
            ],
          ),
                  ],
                ),
              )
            ],
          ),
         
        ],
      ),
    );

    
  }

  void _handleRequest(BuildContext context) async {
//update release status
   

     SharedPreferences prefs = await SharedPreferences.getInstance();
     
    id = prefs.getString('id') ?? '';
    nickname = prefs.getString('nickname') ?? '';
    photoUrl = prefs.getString('photoUrl') ?? '';
     prefs.setString('releaserId', widget.releaserId);
    
    Firestore.instance.collection('users').document(id).updateData({
      'status': 'Requesting',
    });

    Firestore.instance.collection('users').document(widget.releaserId).updateData({
      'status': 'Getting Request',
    });
    

    Firestore.instance.collection('requests').document(widget.releaserId).updateData({
      'releaserId': widget.releaserId,
      'bookerId': id,
      'bookerName': nickname,
      'bookerPhotoUrl': photoUrl,
      
    });
    Navigator.pushNamed(context, Home.id);
    
  }

  
}
