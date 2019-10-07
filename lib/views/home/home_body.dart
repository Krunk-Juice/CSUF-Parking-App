import 'package:flutter/material.dart';
import 'package:flutter_parking_app/components/round_button.dart';
import 'package:flutter_parking_app/views/cancel_status/cancel_status.dart';
import 'package:flutter_parking_app/views/csuf_map/csuf_map.dart';
import 'package:flutter_parking_app/views/free_parking_map/free_parking_map.dart';
import 'package:flutter_parking_app/views/list_release/list_release.dart';
import 'package:flutter_parking_app/views/list_release/request_card.dart';
import 'package:flutter_parking_app/views/parking_status/parking_status.dart';
import 'package:flutter_parking_app/views/request/accept_card.dart';
import 'package:flutter_parking_app/views/request/request.dart';
import 'package:flutter_parking_app/views/slide_card_release/slide_card_release.dart';
import 'package:flutter_parking_app/views/swap/swap.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomeBody extends StatelessWidget {

  HomeBody({this.name,this.status,this.photoUrl});

  final String name;
  final String status;
  final String photoUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      

    child: StaggeredGridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 12.0,
          mainAxisSpacing: 12.0,
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          children: <Widget>[
            _buildTile(
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Status',
                              style: TextStyle(color: Colors.blueAccent)),
                              
                          Text(status,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 30.0))
                        ],
                      ),
                      (photoUrl == null)
                          ? Material(
                              color: Colors.blueAccent,
                              shape: CircleBorder(),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Icon(Icons.account_circle,
                                    color: Colors.white, size: 30.0),
                              ))
                          : Material(
                              shape: CircleBorder(),
                              elevation: 14,
                              shadowColor: Colors.black,
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(photoUrl),
                                radius: 30,
                              )),
                    ]),
              ),
              onTap: () => Null,
            ),
            _buildTile(
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Material(
                          color: Colors.teal,
                          shape: CircleBorder(),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Icon(Icons.map,
                                color: Colors.white, size: 30.0),
                          )),
                      Padding(padding: EdgeInsets.only(bottom: 16.0)),
                      Text('CSUF Map',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 24.0)),
                      Text('Zoom In and Out Map',
                          style: TextStyle(color: Colors.teal)),
                    ]),
              ),
              onTap: () => Navigator.pushNamed(context, CsufMap.id),
            ),
            _buildTile(
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Material(
                          color: Colors.amber,
                          shape: CircleBorder(),
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Icon(Icons.hearing,
                                color: Colors.white, size: 30.0),
                          )),
                      Padding(padding: EdgeInsets.only(bottom: 16.0)),
                      Text('Parking Status',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 20.0)),
                      
                    ]),
              ),
              onTap: () => Navigator.pushNamed(context, ParkingStatus.id),
              // Navigator.pushNamed(context, ListRequest.id),
            ),
            (status != 'Relaxing' )?SizedBox(height: 0,):_buildTile(
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('List Releasing',
                              style:
                                  TextStyle(color: Colors.pink, fontSize: 15)),
                          Text('Available',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 34.0)),
                        ],
                      ),
                      Material(
                          color: Colors.pinkAccent,
                          borderRadius: BorderRadius.circular(24.0),
                          child: Center(
                              child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Icon(Icons.directions_car,
                                color: Colors.white, size: 30.0),
                          )))
                    ]),
              ),
              onTap: () => Navigator.pushNamed(context, ListRelease.id),
            ),
            _buildTile(
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Free Parkings',
                              style: TextStyle(
                                  color: Colors.purpleAccent, fontSize: 15)),
                          Text('4 Locations',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 34.0))
                        ],
                      ),
                      Material(
                          color: Colors.purple,
                          borderRadius: BorderRadius.circular(24.0),
                          child: Center(
                              child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Icon(Icons.explore,
                                color: Colors.white, size: 30.0),
                          )))
                    ]),
              ),
              onTap: () => Navigator.pushNamed(context, FreeParkingMap.id),
            ),
            _bottomButton(context),
          ],
          staggeredTiles: [
            StaggeredTile.extent(2, 110.0),
            StaggeredTile.extent(1, 180.0),
            StaggeredTile.extent(1, 180.0),
            (status !='Relaxing')?StaggeredTile.extent(2,0):StaggeredTile.extent(2, 110.0),
            StaggeredTile.extent(2, 110.0),
            StaggeredTile.extent(2, 100.0),
          ],
        ),

    );
  }

  Widget _buildTile(Widget child, {Function() onTap}) {
    return Material(
        elevation: 14.0,
        borderRadius: BorderRadius.circular(12.0),
        shadowColor: Color(0x802196F3),
        child: InkWell(
            // Do onTap() if it isn't null, otherwise do print()
            onTap: onTap != null
                ? () => onTap()
                : () {
                    print('Not set yet');
                  },
            child: child));
  }


  Widget _bottomButton(BuildContext context){
    if ( status == 'Swaping') {
      return RoundedButton(
        onPressed: () => Navigator.pushNamed(context, Swap.id),
        title: 'Check Swap',
        colour: Colors.orangeAccent,
      );
    } else if(status =='Getting Request'){
      return RoundedButton(
        onPressed: () => Navigator.pushNamed(context, Request.id),
        title: 'Check Request',
        colour: Colors.greenAccent,
      );
    }
    else{
      
      return RoundedButton(
        onPressed: (status == 'Releasing' || status == 'Requesting')
            ? () => Navigator.pushNamed(context, CancelStatus.id)
            : () => Navigator.pushNamed(context, SlideCardRelease.id),
        title: (status == 'Releasing' || status == 'Requesting')
            ? 'Update'
            : 'Release',
        
        colour: (status == 'Releasing' || status == 'Requesting')
            ? Colors.redAccent
            : Colors.blueAccent,
        
      );
    }
  }
}
