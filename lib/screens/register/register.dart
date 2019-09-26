import 'package:flutter/material.dart';
import 'package:flutter_parking_app/screens/register/register_body.dart';
import 'package:flutter_parking_app/screens/register/register_header.dart';



class Register extends StatefulWidget {
        static const String id ="Register"; 

  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<Register> with SingleTickerProviderStateMixin {
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
        title: Text('Register', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700)),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.blueGrey,
        child: ListView(
          children: <Widget>[
            Column(children: <Widget>[

              /* Header and Image Section */
              RegisterHeader(),
              RegisterBody(),
                /* Infomation Section */
            ],)
          ],
        )));
  }


  
}

