import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_parking_app/screens/home/home.dart';
import 'package:flutter_parking_app/screens/login/login_v2.dart';
import 'package:flutter_parking_app/components/round_button.dart';
import 'package:flutter_parking_app/screens/register/register_v2.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';
  SharedPreferences prefs;

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

final _auth = FirebaseAuth.instance;
 

void getCurrentUser()async
{
  try {
    final user = await _auth.currentUser();
 if(user != null)
 {
   Navigator.pushNamed(context, Home.id);

 }
  } catch (e) {
    print(e);
  }
 
}

  @override
  void initState() {
    super.initState();
   
    getCurrentUser();
  }

 
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
            Column(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('assets/images/CSUF Parking Swap Big Car.png'),
                    height: 60.0,
                  ),
                ),
                TyperAnimatedTextKit(
                  text: ['CSUF SWAP'],
                  textStyle: TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                    color: Colors.blueAccent,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundedButton(
              colour: Colors.lightBlueAccent,
              title: 'Login',
              onPressed: () => Navigator.pushNamed(context, LoginScreen.id),
            ),
            RoundedButton(
              colour: Colors.blueAccent,
              title: 'Register',
              onPressed: () =>
                  Navigator.pushNamed(context, RegistrationScreen.id),
            ),
          ],
        ),
      ),
    );
  }
}
