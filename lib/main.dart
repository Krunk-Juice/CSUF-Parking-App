import 'package:flutter/material.dart';
import 'package:flutter_parking_app/views/cancel_status/cancel_status.dart';
import 'package:flutter_parking_app/views/csuf_map/csuf_map.dart';
import 'package:flutter_parking_app/views/drawer/drawer_navigation.dart';
import 'package:flutter_parking_app/views/free_parking_map/free_parking_map.dart';
import 'package:flutter_parking_app/views/get_request/get_request.dart';
import 'package:flutter_parking_app/views/home/home.dart';
import 'package:flutter_parking_app/views/list_release/list_release.dart';
import 'package:flutter_parking_app/views/list_release/request_card.dart';
import 'package:flutter_parking_app/views/login/login.dart';
import 'package:flutter_parking_app/views/parking_status/parking_status.dart';
import 'package:flutter_parking_app/views/profile/profile.dart';
import 'package:flutter_parking_app/views/register/register.dart';
import 'package:flutter_parking_app/views/slide_card_release/slide_card_release.dart';
import 'package:flutter_parking_app/views/swap/swap.dart';
import 'package:flutter_parking_app/views/welcome_screen/welcome_screen.dart';
import 'package:flutter_parking_app/views/settings/settings.dart';

void main() => runApp(MyApp());
// This widget is the root of your application.
class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      // Removes Debug Banner
      debugShowCheckedModeBanner: false,

      /* NOTE: Universal Theme tested and supported on Android Q. */
      // Default Theme
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.blue,
      ),

      // Dark Theme
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),

      // Screen Routes
      initialRoute: 'settings',
      routes: {
        'welcome_screen': (context) => WelcomeScreen(),
        'register':(context) => Register(),
        'login': (context)=>Login(),
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
        'get_request': (context) => GetRequest(),
        'swap': (context) => Swap(),
        'settings': (context) => Settings(),
      },
    );
  }
}
