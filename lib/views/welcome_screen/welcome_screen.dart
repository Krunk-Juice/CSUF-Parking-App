import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_parking_app/components/round_button.dart';
import 'package:flutter_parking_app/views/home/home.dart';
import 'package:flutter_parking_app/views/login/login.dart';
import 'package:flutter_parking_app/views/register/register.dart';
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

  // Initialize User State
  @override
  void initState() {
    super.initState();
   
    getCurrentUser();
  }

  // UI Construct
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[

            FittedBox(
            fit: BoxFit.fitWidth,
            child:
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              
              children: <Widget>[

                // Flutter Hero Widget https://flutter.dev/docs/development/ui/animations/hero-animations
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('assets/images/CSUF Parking Swap Big Car.png'),
                    height: 150.0,
                  ),
                ),
                // TyperAnimatedTextKit(
                //   text: ['CSUF SWAP'],
                //   textStyle: TextStyle(
                //     fontSize: 45.0,
                //     fontWeight: FontWeight.w900,
                //     color: Colors.blueAccent,
                //   ),
                // ),

                // Spacer
                SizedBox(
                  width: 22.5,
                ),

                // Animated Text Kit https://pub.dev/packages/animated_text_kit
                RotateAnimatedTextKit(
                  text:["CSUF", "SWAP"],
                  textStyle: TextStyle(
                    fontSize: 67.5,
                    fontWeight: FontWeight.w900,
                    color: Colors.blueAccent,
                  ),
                  textAlign: TextAlign.justify,
                  alignment: AlignmentDirectional.topStart,
                ),
              ],
            ),
            ),

            // Spacer
            SizedBox(
              height: 48.0,
            ),
            
            // Login Button
            RoundedButton(
              colour: Colors.lightBlueAccent,
              title: 'Login',
              onPressed: () => Navigator.pushNamed(context, Login.id),
            ),
            SizedBox(
              height: 20.0,
            ),
            // Register Button
            RoundedButton(
              colour: Colors.blueAccent,
              title: 'Register',
              onPressed: () =>
                  Navigator.pushNamed(context, Register.id),
            ),
          ],
        ),
      ),
    );
  }
}
