import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_parking_app/main.dart';
import 'package:flutter_parking_app/screens/profile/profile.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';



class DrawerNavigation extends StatefulWidget {
  static const String id = "drawer_navigation";

  @override
  _DrawerNavigationState createState() => _DrawerNavigationState();
}

class _DrawerNavigationState extends State<DrawerNavigation> {
  SharedPreferences prefs;
  
  final GoogleSignIn googleSignIn = GoogleSignIn();

 
  String nickname='';
  String photoUrl='';
  String id ='';

 @override
  void initState() {
    super.initState();
    
    readLocal();
  }
  void readLocal() async {
    prefs = await SharedPreferences.getInstance();
    id = prefs.getString('id') ?? '';
    photoUrl = prefs.getString('photoUrl') ?? '';
    nickname = prefs.getString('nickname')??'';
    // Force refresh input
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
          child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(nickname),
             accountEmail: Text(""),
            currentAccountPicture: (photoUrl== null)
                       ?Material(
                          color: Colors.blueAccent,
                          shape: CircleBorder(),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Icon(Icons.account_circle,
                                color: Colors.white, size: 30.0),
                          ))
                      :Material(
                        shape: CircleBorder(),
                        elevation: 14,
                        shadowColor: Colors.black,
                        child: CircleAvatar(backgroundImage: NetworkImage(photoUrl),radius: 30,)),
          ),
          ListTile(
            title: Text("Profile"),
            trailing: Icon(Icons.arrow_forward),
            onTap: ()=>Navigator.pushNamed(context, Profile.id),
            
          ),
          ListTile(
            title: Text("Settings"),
            trailing: Icon(Icons.arrow_forward),
          ),
          ListTile(
            title: Text("SignOut"),
            trailing: Icon(Icons.exit_to_app),
            onTap: () {
              handleSignOut();
              Navigator.of(context)
        .pushAndRemoveUntil(MaterialPageRoute(builder: (context) => MyApp()), (Route<dynamic> route) => false);},
          ),
        ],
      ));
  
  }


Future<Null> handleSignOut()async{
    setState(() {
    });

    await FirebaseAuth.instance.signOut();
    await googleSignIn.disconnect();
    await googleSignIn.signOut();
    prefs.clear();
    
    setState(() {
      
    });

  }







}