import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_parking_app/components/circle_image.dart';
import 'package:flutter_parking_app/main.dart';
import 'package:flutter_parking_app/views/profile/profile.dart';
import 'package:flutter_parking_app/views/settings/settings.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

// The drawer for the home page
class DrawerNavigation extends StatefulWidget {
  static const String id = "drawer_navigation";

  @override
  _DrawerNavigationState createState() => _DrawerNavigationState();
}

class _DrawerNavigationState extends State<DrawerNavigation> {
  SharedPreferences prefs;

  String nickname = '';
  String photoUrl = '';
  String id = '';

  // Initialize State
  @override
  void initState() {
    super.initState();

    readLocal();
  }

  void readLocal() async {
    prefs = await SharedPreferences.getInstance();
    id = prefs.getString('id') ?? '';
    photoUrl = prefs.getString('photoUrl') ?? '';
    nickname = prefs.getString('nickname') ?? '';
    // Force refresh input
    setState(() {});
  }

  // UI Construct
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: <Widget>[
        UserAccountsDrawerHeader(
          accountName: Text(nickname),
          accountEmail: Text(""),
          currentAccountPicture: CircleImage(
            photoUrl: photoUrl,
            icon: FontAwesomeIcons.userTie,
          ),
        ),
        ListTile(
          title: Text("Profile"),
          trailing: Icon(Icons.arrow_forward),
          onTap: () => Navigator.pushNamed(context, Profile.id),
        ),
        ListTile(
          title: Text("Settings"),
          trailing: Icon(Icons.arrow_forward),
          onTap: () => Navigator.pushNamed(context, Settings.id),
        ),
        ListTile(
          title: Text(
            "Sign Out",
          ),
          trailing: Icon(Icons.exit_to_app),
          onTap: () {
            handleSignOut();
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => MyApp()),
                (Route<dynamic> route) => false);
          },
        ),
      ],
    ));
  }

  // SignOut of application
  Future<Null> handleSignOut() async {
    setState(() {});

    await FirebaseAuth.instance.signOut();

    // prefs.clear();

    setState(() {});
  }
}
