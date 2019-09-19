import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';


class ParkingMapPage extends StatelessWidget {
      static const String id ="parking_map"; 

  @override
  Widget build(BuildContext context) {
    return Scaffold
    (
      appBar: AppBar
      (
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: IconButton
        (
          color: Colors.black,
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.arrow_back, color: Colors.black),
        ),
        title: Text('Parking Lots & Structures Map', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700)),
        
      ),
      body: Container(
        child: PhotoView(
          imageProvider: AssetImage('assets/images/CSUF Map with Parking Office-1.png'),
        ),
      ),
    );
  }
}