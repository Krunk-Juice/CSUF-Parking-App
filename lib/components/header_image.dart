import 'package:flutter/material.dart';
import 'package:flutter_parking_app/components/constants.dart';
import 'package:flutter_parking_app/components/circle_image.dart';
import 'package:flutter_parking_app/components/reusable_card.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HeaderImage extends StatelessWidget {
  const HeaderImage({
    Key key,
    this.name,
    this.photoUrl,
    this.location,
    this.floor,
    this.time,
    this.color
  }) : super(key: key);

  final String name;
  final String photoUrl;
  final String location;
  final String floor;
  final DateTime time;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ReusableCard(
      colour: color,
          cardChild: Column(
        
        children: <Widget>[
          Text(
            name,
            style: kTitleTextStyle,
          ),
          SizedBox(height: 10,),
          CircleImage(
            icon: FontAwesomeIcons.userTie,
            photoUrl: photoUrl,
          ),
          Text(
            location==null?'':location,
            style: kParkingListItemTextStyle,
          ),
          Text(
            floor == null?'':'Floor: $floor',
            style: kResultTextStyle,
          ),
          Text(
            time==null?'':'Schedule time: ${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}',
            style: kTimeTextStyle,
          ),
          Divider(
            thickness: 2.0,
          ),
        ],
      ),
    );
  }
}