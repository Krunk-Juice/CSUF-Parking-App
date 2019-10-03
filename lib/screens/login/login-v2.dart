import 'package:flutter/material.dart';
import 'package:flutter_parking_app/components/constants.dart';
import 'package:flutter_parking_app/components/round_button.dart';
import 'package:flutter_parking_app/screens/home/home.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Hero(
              tag: 'logo',
                          child: Container(
                height: 200.0,
                child: Image.asset('assets/images/eastside.png'),
              ),
            ),
            SizedBox(
              height: 48.0,
            ),
            TextFormField(
              onChanged: (value) {
                //Do something with the user input.
              },
              decoration: kTextFeildDecoration.copyWith(hintText: 'Enter your email'),
            ),
            SizedBox(
              height: 8.0,
            ),
            TextFormField(
              onChanged: (value) {
                //Do something with the user input.
              },
              decoration: kTextFeildDecoration.copyWith(hintText: 'Enter your password')
            ),
            SizedBox(
              height: 24.0,
            ),
            RoundedButton(colour: Colors.lightBlueAccent,title: 'Log In',
            onPressed: ()=>null,),
            
          ],
        ),
      ),
    );
  }



  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }

  String validatePassword(String value) {
    if (value.length < 8)
      return 'Password must be at least 8 characters.';
    else
      return null;
  }
}
