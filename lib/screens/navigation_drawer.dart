import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_parking_app/screens/profile_page.dart';
import 'package:flutter_parking_app/main.dart';


class Navigationdrawer extends StatefulWidget {
  static const String id = "navigation_drawer";

  @override
  _NavigationdrawerState createState() => _NavigationdrawerState();
}

class _NavigationdrawerState extends State<Navigationdrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
          child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text("Michaelangelo"),
            accountEmail: Text("ManEater@gmail.com"),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Theme.of(context).platform == TargetPlatform.iOS
                  ? Colors.blue
                  : Colors.white,
              child: Text(
                "A",
                style: TextStyle(fontSize: 40.0),
              ),  
            ),
          ),
          ListTile(
            title: Text("Profile"),
            trailing: Icon(Icons.arrow_forward),
            onTap: ()=>Navigator.pushNamed(context, ProfilePage.id),
          ),
          ListTile(
            title: Text("Settings"),
            trailing: Icon(Icons.arrow_forward),
          ),
          ListTile(
            title: Text("SignOut"),
            trailing: Icon(Icons.exit_to_app),
            onTap: ()=> Navigator.of(context)
        .pushAndRemoveUntil(MaterialPageRoute(builder: (context) => MyApp()), (Route<dynamic> route) => false),
          ),
        ],
      ));
  
  }








}
