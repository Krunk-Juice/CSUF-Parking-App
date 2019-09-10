import 'package:flutter/material.dart';
import 'package:flutter_parking_app/home_page.dart';
import 'login_page.dart';
import 'page_sections/map_section.dart';

void main() => runApp(HomePage());

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
      home: HomePage(),
    );
  }
}