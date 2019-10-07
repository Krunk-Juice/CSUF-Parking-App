import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_parking_app/views/drawer/drawer_navigation.dart';
import 'package:flutter_parking_app/views/home/home_body.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Home extends StatefulWidget {
  static const String id = "home";
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _auth = FirebaseAuth.instance;
  FirebaseUser firebaseUser;
  Firestore _firestore = Firestore.instance;
  SharedPreferences prefs;
  // final GoogleSignIn googleSignIn = GoogleSignIn();
  String id = '';
  String nickname = '';
  String photoUrl = '';
  String status = '';

  @override
  void initState() {
    super.initState();
    readLocal();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        firebaseUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  void readLocal() async {
    prefs = await SharedPreferences.getInstance();
    id = prefs.getString('id') ?? '';
    nickname = prefs.getString('nickname') ?? '';
    photoUrl = prefs.getString('photoUrl') ?? '';
    status = prefs.getString('status') ?? '';
    // Force refresh input
    setState(() {});
  }

  Future<bool> _onWillPop() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit an App'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              new FlatButton(
                onPressed: () {
                  // handleSignOut();
                  // Navigator.pushNamedAndRemoveUntil(context, LoginPage.id, (Route <dynamic> route)=>false);
                  exit(0);
                },
                child: new Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        endDrawer: DrawerNavigation(),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.green),
          elevation: 2.0,
          backgroundColor: Colors.white,
          title: Text('Dashboard',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 30.0)),
          centerTitle: true,
        ),
        body: StreamBuilder(
          stream: _firestore.collection('users').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final doc = snapshot.data.documents;
              
              for (var item in doc) {
                // final firestoreName = item.data['nickname'];
                // final firesPhotoUrl = item.data['photoUrl'];
                // final firestoreStatus = item.data['status'];
                final firestoreId = item.data['id'];

                if (firestoreId == id) {
                  status = item.data['status'];
                  nickname = item.data['nickname'];
                  photoUrl = item.data['photoUrl'];
                  prefs.setString('nickname', nickname);
                  prefs.setString('status', status);
                  prefs.setString('photoUrl', photoUrl);
                }
              }
              return HomeBody(
                name: nickname,
                photoUrl: photoUrl,
                status: status,
              );
            } else {
              return Center(
                  child: Container(
                      alignment: FractionalOffset.center,
                      child: Image.asset('assets/images/loading.gif')));
            }
          },
        ),
        
      ),
    );
  }

 
}
