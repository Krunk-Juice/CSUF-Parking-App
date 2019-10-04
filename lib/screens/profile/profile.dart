import 'package:flutter/material.dart';
import 'package:flutter_parking_app/screens/profile/profile_body.dart';
import 'package:flutter_parking_app/screens/profile/profile_header.dart';



class Profile extends StatefulWidget {
        static const String id ="profile"; 

  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<Profile> with SingleTickerProviderStateMixin {
  //bool _status = true;
  //final FocusNode myFocusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar
      (
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: IconButton
        (
          color: Colors.black,
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.arrow_back, color: Colors.black),
        ),
        title: Text('Profile', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700)),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.blueGrey,
        child: ListView(
          children: <Widget>[
            Column(children: <Widget>[

              /* Header and Image Section */
              ProfileHeader(),
              ProfileBody(),
                /* Infomation Section */
            ],)
          ],
        )));
  }


  
}

