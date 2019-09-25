import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_parking_app/screens/home/home.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ParkingStatus extends StatefulWidget {
  static const String id = "parking_status";

  @override
  _ParkingStatusState createState() => _ParkingStatusState();
}

class _ParkingStatusState extends State<ParkingStatus> {
  Completer<WebViewController> _controller = Completer<WebViewController>();
  bool _isLoading;

@override
void initState() {
    
    super.initState();
    _isLoading = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          elevation: 2.0,
          backgroundColor: Colors.black,
          // title: Text('CSUF Parking Status',
          //     style: TextStyle(
          //         color: Colors.black,
          //         fontWeight: FontWeight.w700,
          //         fontSize: 30.0)),
          // centerTitle: true,
        ),
      body: Stack(
        children: <Widget>[
          
           WebView(
          initialUrl:
              'https://parking.fullerton.edu/parkinglotcounts/mobile.aspx',
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
          onPageFinished: (finish){
            setState(() {
              _isLoading = false;
            });
          },
        ),
        _isLoading? Container(
                  alignment: FractionalOffset.center,
                  child: CircularProgressIndicator(),
                )
              : Container(
                  color: Colors.transparent,
                ),
        ],
              
      ),
      
    );
  }
}
