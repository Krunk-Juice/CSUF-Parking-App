import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_parking_app/views/cancel_status/cancel_status.dart';
import 'package:flutter_parking_app/views/csuf_map/csuf_map.dart';
import 'package:flutter_parking_app/views/drawer/drawer_navigation.dart';
import 'package:flutter_parking_app/views/free_parking_map/free_parking_map.dart';
import 'package:flutter_parking_app/views/home/home.dart';
import 'package:flutter_parking_app/views/list_release/list_release.dart';
import 'package:flutter_parking_app/views/list_release/request_card.dart';
import 'package:flutter_parking_app/views/login/login_v2.dart';
import 'package:flutter_parking_app/views/parking_status/parking_status.dart';
import 'package:flutter_parking_app/views/profile/profile.dart';
import 'package:flutter_parking_app/views/register/register_v2.dart';
import 'package:flutter_parking_app/views/request/accept_card.dart';
import 'package:flutter_parking_app/views/request/request.dart';
import 'package:flutter_parking_app/views/slide_card_release/slide_card_release.dart';
import 'package:flutter_parking_app/views/swap/contact_card.dart';
import 'package:flutter_parking_app/views/swap/swap.dart';
import 'package:flutter_parking_app/views/welcome_screen/welcome_screen.dart';

void main() => runApp(MyApp());
// This widget is the root of your application.
class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // this removes the debug banner
      title: 'Parking App',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.blue,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
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
        'swap': (context) => Swap(),
        'contact_card': (context) => ContactCard(),
      },
    );
  }
}
