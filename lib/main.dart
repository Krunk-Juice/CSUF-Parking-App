import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_parking_app/screens/cancel_status/cancel_status.dart';
import 'package:flutter_parking_app/screens/csuf_map/csuf_map.dart';
import 'package:flutter_parking_app/screens/drawer/drawer_navigation.dart';
import 'package:flutter_parking_app/screens/free_parking_map/free_parking_map.dart';
import 'package:flutter_parking_app/screens/home/home.dart';
import 'package:flutter_parking_app/screens/list_release/list_release.dart';
import 'package:flutter_parking_app/screens/list_release/request_card.dart';
import 'package:flutter_parking_app/screens/login/login_v2.dart';
import 'package:flutter_parking_app/screens/parking_status/parking_status.dart';
import 'package:flutter_parking_app/screens/profile/profile.dart';
import 'package:flutter_parking_app/screens/register/register.dart';
import 'package:flutter_parking_app/screens/register/register_v2.dart';
import 'package:flutter_parking_app/screens/request/accept_card.dart';
import 'package:flutter_parking_app/screens/request/request.dart';
import 'package:flutter_parking_app/screens/slide_card_release/slide_card_release.dart';
import 'package:flutter_parking_app/screens/swap/contact_card.dart';
import 'package:flutter_parking_app/screens/swap/swap.dart';
import 'package:flutter_parking_app/screens/welcome_screen/welcome_screen.dart';

void main() => runApp(MyApp());
// This widget is the root of your application.
class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // this removes the debug banner
      title: 'Parking App',
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      // ),
      initialRoute: 'welcome_screen',
      routes: {
        'welcome_screen': (context) => WelcomeScreen(),
        'register_v2':(context) => RegistrationScreen(),
        'login_v2': (context)=>LoginScreen(),
        'home': (context) => Home(),
        'profile': (context) => Profile(),
        'drawer_navigation': (context) => DrawerNavigation(),
        'parking_status':(context) => ParkingStatus(),
        'csuf_map': (context) => CsufMap(),
        'free_parking_map': (context) => FreeParkingMap(),
        'slide_card_release': (context) => SlideCardRelease(),
        'cancel_status': (context) => CancelStatus(),
        'list_release': (context) => ListRelease(),
        'request_card': (context) => RequestCard(),
        'accept_card': (context) => AcceptCard(),
        'request': (context) => Request(),
        'register': (context) => Register(),
        'swap': (context) => Swap(),
        'contact_card': (context) => ContactCard(),
      },
    );
  }
}
