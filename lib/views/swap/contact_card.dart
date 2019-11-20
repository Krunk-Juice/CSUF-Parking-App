import 'package:flutter/material.dart';
import 'package:flutter_parking_app/views/home/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_parking_app/components/round_button.dart';
import 'package:url_launcher/url_launcher.dart';

SharedPreferences prefs;

// Confirmation Screen
class ContactCard extends StatefulWidget {
  ContactCard(
      {this.swaperId, this.swaperName, this.swaperPhotoUrl, this.swapLocation});

  final String swaperId;
  final String swaperName;
  final String swaperPhotoUrl;
  final String swapLocation;

  @override
  _ContactCardState createState() => _ContactCardState();
}

class _ContactCardState extends State<ContactCard> {
  String id = '';
  Future<void> _launched;
  String swaperPhoneNumber = '';
  String urlLocation = '';

  // Initialize State Confirmation Screen
  @override
  void initState() {
    super.initState();

    readLocal();
    getUrlLocation();
  }

  // Read RAM for user information.
  void readLocal() async {
    prefs = await SharedPreferences.getInstance();
    id = prefs.getString('id') ?? '';

    Firestore.instance
        .collection('users')
        .document(widget.swaperId)
        .get()
        .then((DocumentSnapshot snapshot) {
      swaperPhoneNumber = snapshot.data['phone'].toString();
    });

    // Force refresh input
    setState(() {});
  }

  // UI Construct of the Confirmation Screen
  @override
  Widget build(BuildContext context) {
    return Container(
        //color: Colors.blueGrey,
        child: 
        
        // FittedBox(fit: BoxFit.contain, child:
        Expanded(child:
        
        Column(
      children: <Widget>[

        // FittedBox(fit: BoxFit.contain, child:
        Expanded(child:

        Column(
          children: <Widget>[
            /* Header Section */

            Flexible(flex: 4, child:

            Container(
                height: 350,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.lightBlue, Colors.cyan],
                      begin: Alignment.topLeft,
                      end: Alignment(-0.2, 0.7)),
                ),
                child: Column(
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(top: 30),
                        // child: Stack(fit: StackFit.loose, children: <Widget>[
                        //   /* Container fills the full width of the device */
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Material(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(24.0),
                                child: ClipOval(
                                  child: widget.swaperPhotoUrl == null
                                      ? Icon(
                                          Icons.account_circle,
                                          size: 90.0,
                                          color: Colors.grey,
                                        )
                                      : CachedNetworkImage(
                                          imageUrl: widget.swaperPhotoUrl,
                                          width: 50.0,
                                          height: 50.0,
                                        ),
                                ))
                          ],
                        )
                        //],)
                        ),
                    Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(widget.swaperName,
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white)),
                          ],
                        ))
                  ],
                )),

            ),

            SizedBox(
              height: 20.0,
            ),

            Flexible(flex: 1, child:
            // Expanded(child:

            RoundedButton(
              colour: Colors.orangeAccent,
              title: 'Navigation',
              onPressed: () => _handleNavigation(),
            ),

            ),

            // SizedBox(
            //   height: 5,
            // ),
            /* Button Container */

            // FittedBox(fit: BoxFit.fitWidth, child:
            Flexible(flex:1, child:
            // Expanded(child: 

            Row(
              children: <Widget>[

                // Expanded(child:

                RoundedButton(
                  colour: Colors.blueAccent,
                  title: 'Call',
                  onPressed: () => _handleCall(),
                ),

                // ),

                SizedBox(
                  width: 10,
                ),

                // Expanded(child:

                RoundedButton(
                  colour: Colors.greenAccent,
                  title: 'Message',
                  onPressed: () => _handleMessage(),
                ),

                // ),

              ],
            ),

            ),

            // SizedBox(
            //   height: 5,
            // ),

            Flexible(flex:1, child:
            // Expanded(child:

            RoundedButton(
              colour: Colors.redAccent,
              title: 'Finish',
              onPressed: () => _handleFinish(context),
            )

            ),

          ],

        ),

        ),

        FutureBuilder<void>(future: _launched, builder: _launchStatus),
      ],
    )

    ),
    
    );
  }

  // You complete the swap and exit the screen
  Future _handleFinish(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Are you sure?'),
        content: new Text('You finish swap'),
        actions: <Widget>[
          new FlatButton(
            onPressed: () {
              Firestore.instance.collection('users').document(id).updateData({
                'status': 'Relaxing',
              }).then((data) async {
                await prefs.setString('status', 'Relaxing');

                Navigator.pushNamed(context, Home.id);
                Fluttertoast.showToast(msg: "Update success");
              }).catchError((err) => print(err));
            },
            child: new Text('OK'),
          ),
        ],
      ),
    );
  }

  // Opens calling screen
  void _handleCall() async {
    _launched = _evaluateUrl('tel:$swaperPhoneNumber');
  }

  // Opens messaging screen
  void _handleMessage() async {
    _launched = _evaluateUrl('sms:$swaperPhoneNumber');
  }

  // Opens messaging screen
  void _handleNavigation() async {
    print("this is swaplocation: ${widget.swapLocation}");

    print("this is urlLocation: $urlLocation");
    _launched = _evaluateUrl(urlLocation);
  }

  Widget _launchStatus(BuildContext context, AsyncSnapshot<void> snapshot) {
    if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    } else {
      return const Text('');
    }
  }

  Future<void> _evaluateUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void getUrlLocation() async {
    final locations =
        await Firestore.instance.collection('parking_locations').getDocuments();
    for (var location in locations.documents) {
      if (location.data['name'] == widget.swapLocation) {
        setState(() {
          urlLocation = location.data['url'];
        });
      }
    }
  }
}
