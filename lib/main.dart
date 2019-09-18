import 'package:flutter/material.dart';
import 'package:flutter_parking_app/screens/home_sections/release_slide_card_section.dart';
import 'package:flutter_parking_app/screens/list_view_page.dart';
import 'screens/login_page.dart';
import 'screens/home_page.dart';
import 'screens/profile_page.dart';
import 'screens/navigation_drawer.dart';

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
      initialRoute: 'login_page',
      routes: {
        'login_page': (context)=>LoginPage(),
        'home_page': (context)=>HomePage(),
        'profile_page': (context)=>ProfilePage(),
        'navigation_drawer': (context)=>Navigationdrawer(),
        'list_view': (context)=>ListViewPage(),
        'sliding_view': (context)=>SpotHolderSlidingCardsView(),
        
      },
    );
  }
}