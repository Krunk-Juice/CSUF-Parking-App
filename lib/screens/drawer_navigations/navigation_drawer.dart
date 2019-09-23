import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_parking_app/screens/drawer_navigations/profile_page.dart';
import 'package:flutter_parking_app/main.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';



class Navigationdrawer extends StatefulWidget {
  static const String id = "navigation_drawer";

  @override
  _NavigationdrawerState createState() => _NavigationdrawerState();
}

class _NavigationdrawerState extends State<Navigationdrawer> {
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
          // UserAccountsDrawerHeader(
          //   accountName: Text(nickname),
          //   accountEmail: Text(id),
          //   currentAccountPicture: CircleAvatar(
          //     backgroundColor: Theme.of(context).platform == TargetPlatform.iOS
          //         ? Colors.blue
          //         : Colors.white,
          //     child: CachedNetworkImage(
          //       imageUrl: photoUrl,
                
          //     ),  
          //   ),
          // ),
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
