import 'package:flutter/material.dart';
import 'package:flutter_parking_app/screens/register/register_body.dart';
import 'package:flutter_parking_app/screens/register/register_header.dart';

class Register extends StatefulWidget {
  static const String id = "register";

  @override
  MapScreenState createState() => MapScreenState();
}

String emailValidator(String value) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  if (!regex.hasMatch(value))
    return 'Email format is invalid';
  else
    return null;
}

String pwdValidator(String value) {
  if (value.length < 8)
    return 'Password must be at least 8 characters.';
  else
    return null;
}

class MapScreenState extends State<Register>
    with SingleTickerProviderStateMixin {
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
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            color: Colors.black,
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.arrow_back, color: Colors.black),
          ),
          title: Text('Register',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w700)),
          centerTitle: true,
        ),
        body: Container(
            color: Colors.blueGrey,
            child: ListView(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    /* Header and Image Section */
                    RegisterHeader(),
                    RegisterBody(),
                    /* Infomation Section */
                  ],
                )
              ],
            )));
  }
}
