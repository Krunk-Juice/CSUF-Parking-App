import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_parking_app/components/constants.dart';
import 'package:flutter_parking_app/components/round_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_parking_app/views/home/home.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_v2';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  FirebaseUser firebaseUser;
  SharedPreferences prefs;
  GlobalKey<FormState> _key = new GlobalKey();
  bool _validate = false;

  bool _isInAsyncCall = false;

  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
              child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: _key,
            autovalidate: _validate,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Flexible(
                                child: Hero(
                    tag: 'logo',
                    child: Container(
                      height: 200.0,
                      child: Image.asset(
                          'assets/images/CSUF Parking Swap Big Car.png'),
                    ),
                  ),
                ),
                SizedBox(
                  height: 48.0,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  validator: validateEmail,
                  onSaved: (value) {
                    email = value;
                  },
                  decoration:
                      kTextFeildDecoration.copyWith(hintText: 'Enter your email'),
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextFormField(
                  textAlign: TextAlign.center,
                  obscureText: true,
                  validator: validatePassword,
                  onSaved: (value) {
                    password = value;
                  },
                  decoration: kTextFeildDecoration.copyWith(
                      hintText: 'Enter your password'),
                ),
                SizedBox(
                  height: 24.0,
                ),
                RoundedButton(
                  colour: Colors.lightBlueAccent,
                  title: 'Log In',
                  onPressed: _sendToServer,
                ),
              ],
            ),
          ),
        ),
         inAsyncCall: _isInAsyncCall,
        
        opacity: 0.5,
        progressIndicator: CircularProgressIndicator(),
      ),
    );
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }

  String validatePassword(String value) {
    if (value.length < 8)
      return 'Password must be at least 8 characters.';
    else
      return null;
  }

  _sendToServer() async {
    //run circle progess
    setState(() {
        _isInAsyncCall = true;
      });
    if (_key.currentState.validate()) {
      // No any error in validation
      _key.currentState.save();

      try {
        final user = await _auth.signInWithEmailAndPassword(
                email: email, password: password);

        if (user != null) //if user already signup
        {
          firebaseUser = await _auth.currentUser();
          //get user data from cloud firestore
          final QuerySnapshot result = await Firestore.instance
              .collection('users')
              .where('id', isEqualTo: firebaseUser.uid)
              .getDocuments();
          final List<DocumentSnapshot> documents = result.documents;

          //set user data to local
          prefs = await SharedPreferences.getInstance();
          await prefs.setString('id', documents[0]['id']);
          await prefs.setString('email', documents[0]['email']);
          await prefs.setString('phone', documents[0]['phone']);
          await prefs.setString('nickname', documents[0]['nickname']);
          await prefs.setString('photoUrl', documents[0]['photoUrl']);
          await prefs.setString('status', documents[0]['status']);
          Navigator.pushNamed(context, Home.id);
          Fluttertoast.showToast(msg: "Sign in success");
        }
        else{
            Fluttertoast.showToast(msg: "Sign in fail");
        }
      } catch (e) {
        print(e);

      }
    } else {
      // validation error
      setState(() {
        _validate = true;
        
      });
    }
    //stop circle progess
    setState(() {
        _isInAsyncCall = false;
      });
  }
}
