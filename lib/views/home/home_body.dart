import 'package:flutter/material.dart';
import 'package:flutter_parking_app/components/bottom_button.dart';
import 'package:flutter_parking_app/components/round_button.dart';
import 'package:flutter_parking_app/views/cancel_status/cancel_status.dart';
import 'package:flutter_parking_app/views/csuf_map/csuf_map.dart';
import 'package:flutter_parking_app/views/free_parking_map/free_parking_map.dart';
import 'package:flutter_parking_app/views/get_request/get_request.dart';
import 'package:flutter_parking_app/views/list_release/list_release.dart';
import 'package:flutter_parking_app/views/parking_status/parking_status.dart';
import 'package:flutter_parking_app/views/slide_card_release/slide_card_release.dart';
import 'package:flutter_parking_app/views/swap/swap.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_parking_app/components/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_parking_app/components/reusable_card.dart';
import 'package:flutter_parking_app/components/icon_content.dart';

class HomeBody extends StatelessWidget {

  HomeBody({this.name,this.status,this.photoUrl});

  final String name;
  final String status;
  final String photoUrl;

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
                Text('Hi $name !', style: kTitleTextStyle,),
                Text('Your status: $status',style: kResultTextStyle,),
                
                
            ],),
              ),
              Expanded(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: ReusableCard(
                        onPress: () =>
                            Navigator.pushNamed(context, CsufMap.id),
                        colour: kActiveCardColor,
                        cardChild: IconContent(
                          icon: FontAwesomeIcons.mapSigns,
                          label: 'CSUF MAP',
                        ),
                      ),
                    ),
                    Expanded(
                      child: ReusableCard(
                        onPress: () => Navigator.pushNamed(context, ParkingStatus.id),
                        colour: kActiveCardColor,
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
                    (status == 'Relaxing')?Expanded(
                      child: ReusableCard(
                        onPress: () => Navigator.pushNamed(context, ListRelease.id),
                        colour: kActiveCardColor,
                        cardChild: IconContent(
                          icon: FontAwesomeIcons.list,
                          label: 'LIST RELEASES',
                        ),
                      ),
                    ):SizedBox(width: 0,),
                    Expanded(
                      child: ReusableCard(
                        onPress: () => Navigator.pushNamed(context, FreeParkingMap.id),
                        colour: kActiveCardColor,
                        cardChild: IconContent(
                          icon: FontAwesomeIcons.mapMarkedAlt,
                          label: 'FREE PARKING',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ( status == 'Swaping')
              ? BottomButton(onPressed: ()=>Navigator.pushNamed(context, Swap.id),title: 'SWAP',color: Colors.orangeAccent,)
              :(status =='Getting Request')
              ?BottomButton(onPressed: ()=>Navigator.pushNamed(context, Swap.id),title: 'CHECK REQUEST',color: Colors.greenAccent,)
              :(status == 'Releasing' || status == 'Requesting')
              ?BottomButton(onPressed: ()=>Navigator.pushNamed(context, CancelStatus.id),title: 'UPDATE',color: Colors.redAccent,)
              :BottomButton(onPressed: ()=>Navigator.pushNamed(context, SlideCardRelease.id),title: 'RELEASE', color: Colors.blueAccent,),
            ],
          );



    
  }

}
