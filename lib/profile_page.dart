import 'package:flutter/material.dart';
import 'profile_sections/header_section.dart';
import 'profile_sections/body_section.dart';

class ProfilePage extends StatefulWidget {
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
      /* Top Bar */
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

