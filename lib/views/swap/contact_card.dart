import 'package:flutter/material.dart';
import 'package:flutter_parking_app/components/circle_image.dart';
import 'package:flutter_parking_app/components/constants.dart';
import 'package:flutter_parking_app/components/icon_content.dart';
import 'package:flutter_parking_app/components/reusable_card.dart';
import 'package:flutter_parking_app/views/home/home.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';







SharedPreferences prefs;

// Confirmation Screen
class ContactCard extends StatefulWidget {
  ContactCard(
      {this.swaperId, this.swaperName, this.swaperPhotoUrl, this.swapLocation,this.floor,this.timeSwap});

  final String swaperId;
  final String swaperName;
  final String swaperPhotoUrl;
  final String swapLocation;
  final DateTime timeSwap;
  final int floor;
  
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
    
    // print(widget.timeSwap);
    
    // print(widget.swapLocation);
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
    return  Expanded(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                widget.swaperName,
                style: kTitleTextStyle,
              ),
              CircleImage(
                icon: FontAwesomeIcons.userTie,
                photoUrl: widget.swaperPhotoUrl,
              ),
              Text(
                widget.swapLocation,
                style: kParkingListItemTextStyle,
              ),
              Text(
                'Floor: ${widget.floor.toString()}',
                style: kResultTextStyle,
              ),
              Text('Schedule time: ${widget.timeSwap.hour.toString().padLeft(2, '0')}:${widget.timeSwap.minute.toString().padLeft(2, '0')}',
              style: kTimeTextStyle,),
              
                ],
              ),
                 Row(
                      children: <Widget>[
                        Expanded(
                            child: ReusableCard(
                          onPress: _handleCall,
                          cardChild: IconContent(
                            icon: FontAwesomeIcons.phone,
                            label: 'CALL',
                          ),
                        )),
                        Expanded(
                            child: ReusableCard(
                          onPress: _handleMessage,
                          cardChild: IconContent(
                            icon: FontAwesomeIcons.sms,
                            label: 'MESSAGE',
                          ),
                        )),
                      ],
                    ),
                  
                 Row(
                      children: <Widget>[
                        Expanded(
                            child: ReusableCard(
                          onPress: _handleNavigation,
                          cardChild: IconContent(
                            icon: FontAwesomeIcons.directions,
                            label: 'NAVIGATION',
                          ),
                        )),
                        Expanded(
                            child: ReusableCard(
                          onPress: () => _handleFinish(context),
                          cardChild: IconContent(
                            icon: FontAwesomeIcons.check,
                            label: 'FINISH',
                          ),
                        )),
                      ],
                    ),
                 
                
            
            FutureBuilder<void>(future: _launched, builder: _launchStatus),
          ],
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
                // Fluttertoast.showToast(msg: "Update success");
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
