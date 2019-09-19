import 'package:flutter/material.dart';
import 'profile_sections/header_section.dart';
import 'profile_sections/body_section.dart';

class ProfilePage extends StatefulWidget {
        static const String id ="profile"; 

  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<ProfilePage> with SingleTickerProviderStateMixin {
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
        
      ),
      body: Container(
        color: Colors.blueGrey,
        child: ListView(
          children: <Widget>[
            Column(children: <Widget>[

              /* Header and Image Section */
              ProfileHeaderSection(),
              ProfileBodySection(),
                /* Infomation Section */
            ],)
          ],
        )));
  }


  
}

