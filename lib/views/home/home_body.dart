import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_parking_app/components/bottom_button.dart';
import 'package:flutter_parking_app/views/csuf_map/csuf_map.dart';
import 'package:flutter_parking_app/views/free_parking_map/free_parking_map.dart';
import 'package:flutter_parking_app/views/get_request/get_request.dart';
import 'package:flutter_parking_app/views/list_release/list_release.dart';
import 'package:flutter_parking_app/views/parking_status/parking_status.dart';
import 'package:flutter_parking_app/views/release/release.dart';
import 'package:flutter_parking_app/views/swap/swap.dart';
import 'package:flutter_parking_app/components/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_parking_app/components/reusable_card.dart';
import 'package:flutter_parking_app/components/icon_content.dart';
import 'package:shared_preferences/shared_preferences.dart';


class HomeBody extends StatefulWidget {

  HomeBody({this.id,this.name,this.status,this.photoUrl});

  final String id;
  final String name;
  final String status;
  final String photoUrl;
  

  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {


  String releaserId = '';

  @override
  Widget build(BuildContext context) {
    return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                
                child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('Hi ${widget.name} !', style: kTitleTextStyle,),
                Text('Your status: ${widget.status}',style: kResultTextStyle,),
                
                
            ],),
              ),
              Expanded(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: ReusableCard(
                        onPress: () =>
                            Navigator.pushNamed(context, CsufMap.id),
                        // colour: kActiveCardColor,
                        cardChild: IconContent(
                          icon: FontAwesomeIcons.mapSigns,
                          label: 'CSUF MAP',
                        ),
                      ),
                    ),
                    Expanded(
                      child: ReusableCard(
                        onPress: () => Navigator.pushNamed(context, ParkingStatus.id),
                        // colour: kActiveCardColor,
                        cardChild: IconContent(
                          icon: FontAwesomeIcons.assistiveListeningSystems,
                          label: 'PARKING STATUS',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: <Widget>[
                    (widget.status == 'Relaxing')?Expanded(
                      child: ReusableCard(
                        onPress: () => Navigator.pushNamed(context, ListRelease.id),
                        // colour: kActiveCardColor,
                        cardChild: IconContent(
                          icon: FontAwesomeIcons.list,
                          label: 'LIST RELEASES',
                        ),
                      ),
                    ):SizedBox(width: 0,),
                    Expanded(
                      child: ReusableCard(
                        onPress: () => Navigator.pushNamed(context, FreeParkingMap.id),
                        // colour: kActiveCardColor,
                        cardChild: IconContent(
                          icon: FontAwesomeIcons.mapMarkedAlt,
                          label: 'FREE PARKING',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ( widget.status == 'Swaping')
              ? BottomButton(onPressed: ()=>Navigator.pushNamed(context, Swap.id),title: 'SWAP',color: Colors.orangeAccent,)
              :(widget.status =='Getting Request')
              ?BottomButton(onPressed: ()=>Navigator.pushNamed(context, GetRequest.id),title: 'CHECK REQUEST',color: Colors.greenAccent,)
              :(widget.status == 'Releasing' || widget.status == 'Requesting')
              ?BottomButton(onPressed: ()=>_handleCancel( context),title: 'CANCEL STATUS',color: Colors.redAccent,)
              :BottomButton(onPressed: ()=>Navigator.pushNamed(context, Release.id),title: 'RELEASE', color: Colors.blueAccent,),
            ],
          );



    
  }

  void _handleCancel(BuildContext context) async{
//update status

    if (widget.status == 'Requesting') {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      releaserId = prefs.getString('releaserId') ?? '';

      Firestore.instance
          .collection('requests')
          .document(releaserId)
          .updateData({
        'turnOn': false,
      });



      Firestore.instance.collection('users').document(releaserId).updateData({
        'status': 'Releasing',
      });
    }

    

    Firestore.instance.collection('users').document(widget.id).updateData({
      'status': 'Relaxing',
    }).then((data) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('status', 'Relaxing');
      
      
    }).catchError((err) => print(err));
  }
}
