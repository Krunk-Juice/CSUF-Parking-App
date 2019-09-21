import 'package:flutter/material.dart';
import 'package:flutter_parking_app/screens/drawer_navigations/navigation_drawer.dart';
import 'package:flutter_parking_app/screens/drawer_navigations/profile_page.dart';
import 'package:flutter_parking_app/screens/google_login.dart';
import 'package:flutter_parking_app/screens/home_sections/free_parking_page.dart';
import 'package:flutter_parking_app/screens/home_sections/list_release_page.dart';
import 'package:flutter_parking_app/screens/home_sections/parking_map_page.dart';
import 'package:flutter_parking_app/screens/home_sections/request_card.dart';
import 'package:flutter_parking_app/screens/home_sections/slide_card_page.dart';
import 'screens/login_page.dart';
import 'screens/home_page.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // this removes the debug banner
      title: 'Parking App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: 'google_login',
      routes: {
        'google_login': (context)=>GoogleLogin(),
        'login_page': (context)=>LoginPage(),
        'home_page': (context)=>HomePage(),
        'profile': (context)=>ProfilePage(),
        'navigation_drawer': (context)=>Navigationdrawer(),
        'list_view': (context)=>ListReleasePage(),
        'free_parking_locations': (context)=>FreeParkingPage(),
        'parking_map': (context)=>ParkingMapPage(),
        'slide_card': (context)=>SlideCardPage(),
        'request_card': (context)=>RequestPage(),
      },
    );
  }

  
}