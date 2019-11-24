import 'package:flutter/material.dart';
import 'package:flutter_parking_app/components/constants.dart';

import 'package:flutter_parking_app/views/release/slide_card.dart';




// Releasing Screen with cards of the parking structures.
// Select a parking structure to release your spot.
// This will also list you in the release list.
class Release extends StatefulWidget {
  static const String id = 'release';

  @override
  _ReleaseState createState() => _ReleaseState();
}

class _ReleaseState extends State<Release> {
  
  // UI Construct for the general screen
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(
              Icons.arrow_back,
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 10,),
            Expanded(
            child: Text('Where did you park your car?', style: kTitleTextStyle)),
            
            Expanded(
              flex: 3,
              child: SlideCards(),
            ),
            SizedBox(height: 10,),
            
          ],
        ),
      ),
    );
  }
}
