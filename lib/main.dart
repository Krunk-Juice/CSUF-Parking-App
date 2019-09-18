import 'package:flutter/material.dart';
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
      initialRoute: 'navigation_drawer',
      routes: {
        'login_page': (context)=>LoginPage(),
        'home_page': (context)=>HomePage(),
        'profile_page': (context)=>ProfilePage(),
        'navigation_drawer': (context)=>Navigationdrawer(),
      },
    );
  }
}