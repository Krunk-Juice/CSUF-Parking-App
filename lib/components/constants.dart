import 'package:flutter/material.dart';

const kTextFeildDecoration = InputDecoration(
  hintText: '',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

const String MIN_DATETIME = '2010-05-12 00:00:00';
const String MAX_DATETIME = '2021-11-25 23:59:00';
const String INIT_DATETIME = '2019-08-17 08:30:00';


const kBottomDatePickerDarkColor = Color(0xFF0A0E21);
const kBottomDatePickerColor = Colors.white;
// const kDarkCardColor = Color(0xFF1D1E33);
// const kCardColor = Color(0xFF111328);
// const kBottomContainerColor = Color(0xFFEB1555);

const kHintTextStyle = TextStyle(fontSize: 30.0,color: Colors.grey);
const kStatusTextStyle = TextStyle(fontSize: 20.0);
const kLabelTextStyle = TextStyle(fontSize: 18.0,color: Colors.grey);
const kDateTextStyle = TextStyle(fontSize: 40.0,fontWeight: FontWeight.bold);
const kNumberTextStyle = TextStyle(fontSize: 50.0,fontWeight: FontWeight.bold);
const kLargeButtonTextStyle = TextStyle(fontSize: 25.0,fontWeight: FontWeight.bold, color: Colors.white);
const kTitleTextStyle = TextStyle(fontSize: 30.0);
const kErrorTextStyle = TextStyle(fontSize: 15.0,color: Colors.red);
const kResultTextStyle = TextStyle(color: Color(0xFF24D867), fontSize: 30.0, fontWeight: FontWeight.bold);

const kTimeTextStyle = TextStyle(fontSize: 25.0,color: Colors.greenAccent);
const kNicknameTextStyle = TextStyle(fontSize: 20.0);
const kParkingListItemTextStyle = TextStyle(fontSize: 25.0,);
const kRoundButtonTextStyle = TextStyle(fontSize: 25.0,fontWeight: FontWeight.bold);


const kDatePickerTextStyle = TextStyle(fontSize: 35.0);
// const kDatePickerDarkThemeTextStyle = TextStyle(fontSize: 35.0, color: Colors.white);
