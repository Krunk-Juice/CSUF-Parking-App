import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


// Display Webpage showing parking structure space data
class ParkingStatus extends StatefulWidget {
  static const String id = "parking_status";

  @override
  _ParkingStatusState createState() => _ParkingStatusState();
}

class _ParkingStatusState extends State<ParkingStatus> {
  Completer<WebViewController> _controller = Completer<WebViewController>();
  bool _isLoading;

  // Initialize State
  @override
  void initState() {
    
    super.initState();
    _isLoading = true;
  }

  // UI Construct
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
          
          // View Static Webpage
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

        // Handles if the webpage did not load.
        // If the webpage loads, position the image to the center.
        // If the webpage does not load, load a transparent page.
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
