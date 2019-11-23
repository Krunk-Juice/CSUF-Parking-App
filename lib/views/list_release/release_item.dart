import 'package:flutter/material.dart';
import 'package:flutter_parking_app/components/circle_image.dart';
import 'package:flutter_parking_app/components/constants.dart';
import 'package:flutter_parking_app/components/reusable_card.dart';
import 'package:flutter_parking_app/components/round_button.dart';
import 'package:flutter_parking_app/components/round_icon_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReleaseItem extends StatefulWidget {
  final String releaserName;
  final String releaserId;
  final String releaserPhotoUrl;
  final String releaserParking;
  final DateTime releaserLeavingTime;
  final Function onPressed;
  final int releaserFloor;

  ReleaseItem({
    Key key,
    @required this.releaserName,
    @required this.releaserParking,
    @required this.releaserLeavingTime,
    @required this.releaserId,
    @required this.releaserPhotoUrl,
    @required this.releaserFloor,
    this.onPressed
  }) : super(key: key);

  @override
  _ReleaseItemState createState() => _ReleaseItemState();
}

class _ReleaseItemState extends State<ReleaseItem> {
  SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    readLocal();
  }

  void readLocal() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return ReusableCard(
      colour: kActiveCardColor,
      
      cardChild: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              (widget.releaserPhotoUrl == null)
                  ? RoundIconButton(
                      icon: FontAwesomeIcons.userTie,
                      
                    )
                  : CircleImage(
                      photoUrl: widget.releaserPhotoUrl,
                      
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
                        Text('Release at ', style: kParkingTextStyle),
                        Text(
                          '${widget.releaserLeavingTime.hour.toString().padLeft(2, '0')}:${widget.releaserLeavingTime.minute.toString().padLeft(2, '0')}',
                          style: kTimeTextStyle,
                        ),
                      ],
                    ),
                    Text(
                      widget.releaserParking,
                      style: kParkingTextStyle,
                    ),
                    // RoundedButton(title: 'Request',colour: Colors.greenAccent,)
                  ],
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Expanded(
                flex: 2,
                  child: SizedBox(
                width: 1,
              )),
              Expanded(
                  child: RoundedButton(
                title: 'Request',
                colour: Colors.green,
                onPressed: widget.onPressed,
              ))
            ],
          ),
        ],
      ),
    );

    
  }
}
