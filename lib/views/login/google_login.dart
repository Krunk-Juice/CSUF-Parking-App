import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_parking_app/views/home/home.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GoogleLogin extends StatefulWidget {
  static const String id = 'google_login';

  @override
  GoogleLoginState createState() => GoogleLoginState();
}

class GoogleLoginState extends State<GoogleLogin> {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  SharedPreferences prefs;

  bool isLoading = false;
  bool isLoggedIn = false;
  FirebaseUser currentUser;

  @override
  void initState() {
    super.initState();
    isSignedIn();
  }

  void isSignedIn() async {
    this.setState(() {
      isLoading = true;
    });

    prefs = await SharedPreferences.getInstance();

    isLoggedIn = await googleSignIn.isSignedIn();
    if (isLoggedIn) {
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => MainScreen(currentUserId: prefs.getString('id'))),
      // );
      Navigator.pushNamed(context, Home.id);
    }

    this.setState(() {
      isLoading = false;
    });
  }

  Future<Null> handleSignIn() async {
    prefs = await SharedPreferences.getInstance();

    this.setState(() {
      isLoading = true;
    });

    GoogleSignInAccount googleUser = await googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    FirebaseUser firebaseUser =
        (await firebaseAuth.signInWithCredential(credential)).user;

    if (firebaseUser != null) {
      // Check is already sign up
      final QuerySnapshot result = await Firestore.instance
          .collection('users')
          .where('id', isEqualTo: firebaseUser.uid)
          .getDocuments();
      final List<DocumentSnapshot> documents = result.documents;
      if (documents.length == 0) {
        // Update data to server if new user
        Firestore.instance
            .collection('users')
            .document(firebaseUser.uid)
            .setData({
          'nickname': firebaseUser.displayName,
          'photoUrl': firebaseUser.photoUrl,
          'id': firebaseUser.uid,
          'email': firebaseUser.email,
          'phone': firebaseUser.phoneNumber,
          'createdAt': DateTime.now().microsecondsSinceEpoch.toString(),
          'leavingAt':null,
          'parkAt':null,
          'chattingWith': null,
          'online': null,
          'status': 'Relaxing',
          
        });

        // Write data to local
        currentUser = firebaseUser;

        await prefs.setString('id', currentUser.uid);
        await prefs.setString('email', currentUser.email);
        await prefs.setString('phone', currentUser.phoneNumber);
        await prefs.setString('nickname', currentUser.displayName);
        await prefs.setString('photoUrl', currentUser.photoUrl);
        await prefs.setString('status', 'Relaxing');
      } else {
        // Write data to local
        await prefs.setString('id', documents[0]['id']);
        await prefs.setString('email', documents[0]['email']);
         await prefs.setString('phone', documents[0]['phone']);
        await prefs.setString('nickname', documents[0]['nickname']);
        await prefs.setString('photoUrl', documents[0]['photoUrl']);
        await prefs.setString('status', documents[0]['status']);
        
      }
      Fluttertoast.showToast(msg: "Sign in success");
      this.setState(() {
        isLoading = false;
      });
      Navigator.pushNamed(context, Home.id);
      // Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen(currentUserId: firebaseUser.uid)));
    } else {
      Fluttertoast.showToast(msg: "Sign in fail");
      this.setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Hero(
                  tag: 'hero',
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0.0, 70.0, 0.0, 0.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 80.0,
                      child: Image.asset('assets/images/undraw_Login_v483.png'),
                    ),
                  ),
                ),
                SizedBox(height: 40,),
          Stack(
          children: <Widget>[
            Center(
              child: OutlineButton(
                splashColor: Colors.grey,
                
                onPressed: handleSignIn,
                
                shape:
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                highlightElevation: 0,
                borderSide: BorderSide(color: Colors.grey),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image(
                          image: AssetImage("assets/images/google_logo.png"),
                          height: 35.0),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          'Sign in with Google',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.grey,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),

            // Loading
            Positioned(
              child: isLoading
                  ? Container(
                      child: Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                        ),
                      ),
                      color: Colors.white.withOpacity(0.8),
                    )
                  : Container(),
            ),
          ],
    ),
        ],
      ));
  }

  Widget _signInButton() {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: handleSignIn,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
                image: AssetImage("assets/images/google_logo.png"),
                height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}


