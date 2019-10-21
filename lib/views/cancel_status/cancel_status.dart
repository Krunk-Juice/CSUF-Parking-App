import 'package:flutter/material.dart';
import 'package:flutter_parking_app/views/home/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

SharedPreferences prefs;
String status = '';

// If user state is releasing
// Cancel Screen for user in release state
class CancelStatus extends StatefulWidget {
  static const String id = "cancel_status";
  @override
  _CancelStatusState createState() => _CancelStatusState();
}

class _CancelStatusState extends State<CancelStatus> {
  String id = '';
  String nickname = '';
  String photoUrl = '';
  

  String releaserId = '';
  // String releaserName = '';
  // String releaserPhotoUrl = '';

  // Initialize State of Cancel Screen
  @override
  void initState() {
    super.initState();

    readLocal();
  }

  // Read RAM for user information.
  void readLocal() async {
    prefs = await SharedPreferences.getInstance();
    id = prefs.getString('id') ?? '';
    nickname = prefs.getString('nickname') ?? '';
    photoUrl = prefs.getString('photoUrl') ?? '';
    status = prefs.getString('status') ?? '';

    releaserId = prefs.getString('releaserId') ?? '';
    // releaserName = prefs.getString('releaserName') ?? '';
    // releaserPhotoUrl = prefs.getString('releaserPhotoUrl') ?? '';

    // Force refresh input
    setState(() {});
  }

  // UI Construct of Cancel Screen
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          // backgroundColor: Colors.transparent,
          leading: IconButton(
            // color: Colors.black,
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.arrow_back, 
            // color: Colors.black,
            ),
          ),
          title: Text('Update',
              style:
                  TextStyle(
                    // color: Colors.black, 
                    fontWeight: FontWeight.w700
                  )
          ),
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
                            padding: EdgeInsets.only(top: 50),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(status,
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.white)),
                              ],
                            )),
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
                                      child: photoUrl == null
                                          ? Icon(
                                              Icons.account_circle,
                                              size: 90.0,
                                              color: Colors.grey,
                                            )
                                          : CachedNetworkImage(
                                              imageUrl: photoUrl,
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
                                Text(nickname,
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.white)),
                              ],
                            ))
                      ],
                    )),
                SizedBox(
                  height: 100,
                ),
                /* Button Container */
                RaisedButton(
                  padding: EdgeInsets.symmetric(vertical: 25, horizontal: 80),
                  // padding: EdgeInsets.all(0),
                  elevation: 15,

                  splashColor: Colors.blueAccent,
                  child: Text('Cancel',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.green[900])),

                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  onPressed: () => _handleCancel(context),
                ),
              ],
            )
          ],
        )));
  }

  // Update User State from Releasing to Relaxing
  void _handleCancel(BuildContext context) {
//update status
    
    if(status == 'Requesting')
    {
    Firestore.instance.collection('requests').document(releaserId).updateData({
      'turnOn': false,
    });
    
    Firestore.instance.collection('users').document(releaserId).updateData({
      'status': 'Releasing',
    });
    }

    // if(status == 'Getting Request')
    // {
    // Firestore.instance.collection('requests').document(releaserId).updateData({
    //   'turnOn': false,
    // });
    // Firestore.instance.collection('users').document().updateData({
    //   'status': 'Releasing',
    // });
    
    // }
    
    
    Firestore.instance.collection('users').document(id).updateData({
      'status': 'Relaxing',
    }).then((data) async {
      
      await prefs.setString('status', 'Relaxing');
      Navigator.pushNamed(context, Home.id);
      Fluttertoast.showToast(msg: "Update success");
      
    }).catchError((err) => print(err));

    
  }
}
