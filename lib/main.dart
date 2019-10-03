import 'package:flutter/material.dart';
import 'package:flutter_parking_app/screens/csuf_map/csuf_map.dart';
import 'package:flutter_parking_app/screens/drawer/drawer_navigation.dart';
import 'package:flutter_parking_app/screens/free_parking_map/free_parking_map.dart';
import 'package:flutter_parking_app/screens/home/home.dart';
import 'package:flutter_parking_app/screens/home/slide_card_release.dart';
import 'package:flutter_parking_app/screens/home/update_status.dart';
import 'package:flutter_parking_app/screens/list_release/list_release.dart';
import 'package:flutter_parking_app/screens/list_release/request_card.dart';
import 'package:flutter_parking_app/screens/list_request/accept_card.dart';
import 'package:flutter_parking_app/screens/list_request/list_request.dart';
import 'package:flutter_parking_app/screens/login/login.dart';
import 'package:flutter_parking_app/screens/parking_status/parking_status.dart';
import 'package:flutter_parking_app/screens/profile/profile.dart';
import 'package:flutter_parking_app/screens/register/register-v2.dart';
import 'package:flutter_parking_app/screens/register/register.dart';
import 'package:flutter_parking_app/screens/welcome_screen/welcome_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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
        'registration':(context) => RegistrationScreen(),
        // 'google_login': (context) => GoogleLogin(),
        'login': (context)=>Login(),
        'home': (context) => Home(),
        'profile': (context) => Profile(),
        'drawer_navigation': (context) => DrawerNavigation(),
        'parking_status':(context) => ParkingStatus(),
        'csuf_map': (context) => CsufMap(),
        'free_parking_map': (context) => FreeParkingMap(),
        'slide_card_release': (context) => SlideCardRelease(),
        'update_status': (context) => UpdateStatus(),
        'list_release': (context) => ListRelease(),
        'request_card': (context) => RequestCard(),
        'accept_card': (context) => AcceptCard(),
        'list_request': (context) => ListRequest(),
        'register': (context) => Register(),
      },
    );
  }
}
