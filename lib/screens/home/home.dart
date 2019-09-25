import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_parking_app/screens/csuf_map/csuf_map.dart';
import 'package:flutter_parking_app/screens/drawer/drawer_navigation.dart';
import 'package:flutter_parking_app/screens/free_parking_map/free_parking_map.dart';
import 'package:flutter_parking_app/screens/home/slide_card_release.dart';
import 'package:flutter_parking_app/screens/home/update_status.dart';
import 'package:flutter_parking_app/screens/list_release/list_release.dart';
import 'package:flutter_parking_app/screens/list_request/list_request.dart';
import 'package:flutter_parking_app/screens/parking_status/parking_status.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Home extends StatefulWidget {
  static const String id = "home";
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  SharedPreferences prefs;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  String id = '';
  String nickname = '';
  String photoUrl = '';
  String status = '';

  int count = 0;

  @override
  void initState() {
    super.initState();
    readLocal();
    // count =0;
    // countRelease();
  }

  void readLocal() async {
    prefs = await SharedPreferences.getInstance();
    id = prefs.getString('id') ?? '';
    nickname = prefs.getString('nickname') ?? '';
    photoUrl = prefs.getString('photoUrl') ?? '';
    status = prefs.getString('status') ?? '';
    // Force refresh input
    setState(() {});
  }

  Future<bool> _onWillPop() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit an App'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              new FlatButton(
                onPressed: () {
                  // handleSignOut();
                  // Navigator.pushNamedAndRemoveUntil(context, LoginPage.id, (Route <dynamic> route)=>false);
                  exit(0);
                },
                child: new Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;
  }

  // Future<Null> handleSignOut()async{
  //   setState(() {
  //   });

  //   await FirebaseAuth.instance.signOut();
  //   await googleSignIn.disconnect();
  //   await googleSignIn.signOut();
  //   setState(() {

  //   });

  // }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        endDrawer: DrawerNavigation(),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.green),
          elevation: 2.0,
          backgroundColor: Colors.white,
          title: Text('Dashboard',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 30.0)),
          centerTitle: true,
        ),
        body: StaggeredGridView.count(
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
                          Text('List Releasing',
                              style:
                                  TextStyle(color: Colors.pink, fontSize: 15)),
                          Text('$count Available',
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
          ],
          staggeredTiles: [
            StaggeredTile.extent(2, 110.0),
            StaggeredTile.extent(1, 180.0),
            StaggeredTile.extent(1, 180.0),
            StaggeredTile.extent(2, 110.0),
            StaggeredTile.extent(2, 110.0),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: (status == 'Releasing' || status == 'Booking')
              ? () => Navigator.pushNamed(context, UpdateStatus.id)
              : () => Navigator.pushNamed(context, SlideCardRelease.id),
          label: (status == 'Releasing' || status == 'Booking')
              ? Text('Update')
              : Text('Release'),
          icon: (status == 'Releasing' || status == 'Booking')
              ? Icon(Icons.track_changes)
              : Icon(Icons.add),
          backgroundColor: (status == 'Releasing' || status == 'Booking')
              ? Colors.redAccent
              : Colors.blueAccent,
          elevation: 14,
        ),
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
}
