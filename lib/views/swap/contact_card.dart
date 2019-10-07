import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_parking_app/views/home/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_parking_app/components/round_button.dart';
import 'package:url_launcher/url_launcher.dart';

SharedPreferences prefs;

class ContactCard extends StatefulWidget {
  static const String id = "contact_card";
  @override
  _ContactCardState createState() => _ContactCardState();
}

class _ContactCardState extends State<ContactCard> {
  // final db = Firestore.instance;

  String id = '';
  // String nickname = '';
  // String photoUrl = '';
  // String status = '';
  Future<void> _launched;
  String swaperId = '';
  String swaperName = '';
  String swaperPhotoUrl = '';
  String swaperPhoneNumber = '';

  @override
  void initState() {
    super.initState();

    readLocal();
  }

  void readLocal() async {
    prefs = await SharedPreferences.getInstance();
    id = prefs.getString('id') ?? '';
    // nickname = prefs.getString('nickname') ?? '';
    // photoUrl = prefs.getString('photoUrl') ?? '';
    // status = prefs.getString('status') ?? '';

    swaperId = prefs.getString('swaperId') ?? '';
    swaperName = prefs.getString('swaperName') ?? '';
    swaperPhotoUrl = prefs.getString('swaperPhotoUrl') ?? '';

    Firestore.instance
        .collection('users')
        .document(swaperId)
        .get()
        .then((DocumentSnapshot snapshot) {
      swaperPhoneNumber = snapshot.data['phone'].toString();
      // swaperName = snapshot.data['nickname'].toString();
      swaperPhotoUrl = snapshot.data['photoUrl'];
    });

    // Force refresh input
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            color: Colors.black,
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.arrow_back, color: Colors.black),
          ),
          title: Text('Swaper',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w700)),
          centerTitle: true,
        ),
        body: Container(
            //color: Colors.blueGrey,
            child: Column(
          children: <Widget>[
            Column(
              children: <Widget>[
                /* Header Section */
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
                                      child: swaperPhotoUrl == null
                                          ? Icon(
                                              Icons.account_circle,
                                              size: 90.0,
                                              color: Colors.grey,
                                            )
                                          : CachedNetworkImage(
                                              imageUrl: swaperPhotoUrl,
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
                                Text(swaperName,
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.white)),
                              ],
                            ))
                      ],
                    )),
                SizedBox(
                  height: 50,
                ),
                /* Button Container */
                Row(
                  children: <Widget>[
                    RoundedButton(
                      colour: Colors.blueAccent,
                      title: 'Call',
                      onPressed: () => _handleCall(),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    RoundedButton(
                      colour: Colors.greenAccent,
                      title: 'Message',
                      onPressed: () => _handleMessage(),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                RoundedButton(
                  colour: Colors.redAccent,
                  title: 'Finish',
                  onPressed: () => _handleFinish(context),
                )
              ],
            ),
            FutureBuilder<void>(future: _launched, builder: _launchStatus),
          ],
        )));
  }

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

  void _handleCall() async {
    _launched = _makePhoneCallAndTextMessage('tel:$swaperPhoneNumber');
  }

  void _handleMessage() async {
    _launched = _makePhoneCallAndTextMessage('sms:$swaperPhoneNumber');
  }

  Widget _launchStatus(BuildContext context, AsyncSnapshot<void> snapshot) {
    if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    } else {
      return const Text('');
    }
  }

  Future<void> _makePhoneCallAndTextMessage(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
