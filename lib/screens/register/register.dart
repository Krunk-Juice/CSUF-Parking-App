import 'package:flutter/material.dart';
import 'package:flutter_parking_app/screens/register/register_body.dart';
import 'package:flutter_parking_app/screens/register/register_header.dart';
import 'package:quiver/strings.dart';

class Register extends StatefulWidget {
  static const String id = "Register";

  @override
  MapScreenState createState() => MapScreenState();
}

bool isCSUFemail(String value) {
  bool special = false;
  bool complete = false;
  String pattern = "@csu.fullerton.edu";
  for (int i = 0; i < value.length; i++) {
    if (special == false && value[i] == '@')
      special = true;
    if (special && (value.length - i == pattern.length)) {
      complete = true;
      for (int j = 0; j < pattern.length && i < value.length; j++, i++) {
        if (value[i] != pattern[j])
          complete = false;
      }
    }
  }
  return complete;
}

String phoneValidator(String value) {
  bool complete = true;
  for (int i = 0; i < value.length; i++) {
    int d = int.parse(value[i]);
    if (!isDigit(d)) 
      complete = false;
  }
  if(complete && value.length != 10)
    return "Phone number must have 10 digits";
  else if (!complete && value.length == 10)
    return "Invalid character for phone number";
  else if (!complete && value.length != 10)
    return "Invalid character for phone number and phone number must have 10 digits";
  else
    return null;
}

String emailValidator(String value) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  if (!regex.hasMatch(value))
    return 'Email format is invalid';
  else if (!isCSUFemail(value))
    return 'Email must be a Cal State Fullerton email';
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
        body: 
        
        
        
        Container(
            color: Color(0xFFFFFFFF),
            child: 
            ListView(
              // shrinkWrap: true,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    /* Header and Image Section */
                    // RegisterHeader(),
                    RegisterBody(),
                    /* Infomation Section */
                  ],
                )
              ],
            )
            ));
  }
}
