import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'free_parking_page.dart';
import 'package:flutter_parking_app/screens/home_sections/list_view_page.dart';
import 'package:flutter_parking_app/screens/home_sections/parking_map_page.dart';
import 'package:flutter_parking_app/screens/navigation_drawer.dart';
import 'package:flutter_parking_app/screens/profile_page.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomePage extends StatefulWidget {
  static const String id = "home_page";
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SharedPreferences prefs;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  String id = '';
  String nickname = '';
  String photoUrl = '';

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
                  // Navigator.of(context).pop(true);
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
          endDrawer: Navigationdrawer(),
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.green),
            elevation: 2.0,
            backgroundColor: Colors.white,
            title: Text('Dashboard',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 30.0)),
            // actions: <Widget>[
            //   Container(
            //     margin: EdgeInsets.only(right: 8.0),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       crossAxisAlignment: CrossAxisAlignment.center,
            //       children: <Widget>[
            //         Text('CSUF Parking',
            //             style: TextStyle(
            //                 color: Colors.blue,
            //                 fontWeight: FontWeight.w700,
            //                 fontSize: 14.0)),
            //       ],
            //     ),
            //   )
            // ],
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
                            Text('Profile',
                                style: TextStyle(color: Colors.blueAccent)),
                            Text(nickname,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 30.0))
                          ],
                        ),
                        Material(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(24.0),
                            child: ClipOval(
                              child: CachedNetworkImage(
                                imageUrl: photoUrl,
                                width: 50.0,
                                height: 50.0,
                              ),
                            )
                            // Center(
                            //     child: Padding(
                            //   padding: const EdgeInsets.all(16.0),
                            //   child:
                            //   Icon(
                            //    Icons.timeline,
                            //       color: Colors.white, size: 30.0),

                            // ))
                            )
                      ]),
                ),
                onTap: () => Navigator.pushNamed(context, ProfilePage.id),
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
                        Text('Zones', style: TextStyle(color: Colors.teal)),
                      ]),
                ),
                onTap: () => Navigator.pushNamed(context, ParkingMapPage.id),
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
                              child: Icon(Icons.notifications,
                                  color: Colors.white, size: 30.0),
                            )),
                        Padding(padding: EdgeInsets.only(bottom: 16.0)),
                        Text('Alerts',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 24.0)),
                        Text('All ', style: TextStyle(color: Colors.black45)),
                      ]),
                ),
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
                            Text('Parking Structures',
                                style: TextStyle(
                                    color: Colors.redAccent, fontSize: 15)),
                            Text('0 Available',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 34.0))
                          ],
                        ),
                        Material(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(24.0),
                            child: Center(
                                child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Icon(Icons.directions_car,
                                  color: Colors.white, size: 30.0),
                            )))
                      ]),
                ),
                onTap: () => Navigator.pushNamed(context, ListViewPage.id),
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
                onTap: () => Navigator.pushNamed(context, FreeParkingPage.id),
              ),
            ],
            staggeredTiles: [
              StaggeredTile.extent(2, 110.0),
              StaggeredTile.extent(1, 180.0),
              StaggeredTile.extent(1, 180.0),
              StaggeredTile.extent(2, 110.0),
              StaggeredTile.extent(2, 110.0),
            ],
          )),
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
