import 'package:flutter/material.dart';
import 'package:flutter_parking_app/components/round_button.dart';
import 'package:flutter_parking_app/components/constants.dart';
import 'package:flutter_parking_app/screens/home/home.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'register_v2';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  FirebaseUser firebaseUser;
  SharedPreferences prefs;
  GlobalKey<FormState> _key = new GlobalKey();
  bool _validate = false;

  bool _isInAsyncCall = false;

  String nickname;
  String email;
  String password;
  String errorMessage;

  @override
  void initState() {
    errorMessage = "";

    super.initState();
  }

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
                  textAlign: TextAlign.center,
                  validator: validateName,
                  onSaved: (value) {
                    nickname = value;
                  },
                  decoration: kTextFeildDecoration.copyWith(
                      hintText: 'Enter your username'),
                ),
                SizedBox(
                  height: 8.0,
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
                  colour: Colors.blueAccent,
                  title: 'Register',
                  onPressed: _sendToServer,
                )
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

  String validateName(String value) {
    if (value.length < 3)
      return 'Name must be more than 2 charater';
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
        final user = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        if (user != null) {
          firebaseUser = await _auth.currentUser();
          Firestore.instance
              .collection('users')
              .document(firebaseUser.uid)
              .setData({
            'nickname': nickname,
            'photoUrl': null,
            'id': firebaseUser.uid,
            'email': email,
            'phone': null,
            'createdAt': DateTime.now().microsecondsSinceEpoch.toString(),
            'leavingAt': null,
            'parkAt': null,
            'chattingWith': null,
            'online': null,
            'status': 'Relaxing',
          });

          //set user data to local
           prefs = await SharedPreferences.getInstance();
           await prefs.setString('id', firebaseUser.uid);
           await prefs.setString('email', email);
           await prefs.setString('phone', null);
           await prefs.setString('nickname', nickname);
           await prefs.setString('photoUrl', null);
           await prefs.setString('status', 'Relaxing');

          Navigator.pushNamed(context, Home.id);
          Fluttertoast.showToast(msg: "Sign up success");
        } else {
          Fluttertoast.showToast(msg: "Sign up fail");
        }
      } catch (e) 
      {
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

  /// Validate and submit the user to firebase base on what activity

}
