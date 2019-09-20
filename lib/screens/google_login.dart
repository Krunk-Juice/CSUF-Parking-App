import 'dart:async';
import 'dart:ffi';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_parking_app/screens/home_page.dart';
import 'package:flutter_parking_app/services/sign_in.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:google_sign_in/google_sign_in.dart';

// import 'package:shared_preferences/shared_preferences.dart';

class GoogleLogin extends StatefulWidget {
  static const String id = "google_login";
  @override
  _GoogleLoginState createState() => _GoogleLoginState();
}

class _GoogleLoginState extends State<GoogleLogin> {
  bool isLoggedIn;

  bool _isLoading;
  // SharedPreferences prefs;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  @override
  void initState() {
    _isLoading = false;

    super.initState();
    isSignedIn();
  }

  void isSignedIn() async {
    this.setState(() {
      _isLoading = true;
    });


    isLoggedIn = await googleSignIn.isSignedIn();
    if (isLoggedIn) {
      Navigator.pushNamed(context, HomePage.id);
    }

    this.setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: _isLoading,
              child: Container(
          color: Colors.white,
          child: Center(
            child: Column(
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
                SizedBox(height: 50),
                _signInButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _signInButton() {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: () {
        setState(() {
          _isLoading = true;
        });
        signInWithGoogle().whenComplete(() {
          // Navigator.of(context).push(
          //   MaterialPageRoute(
          //     builder: (context) {
          //       return HomePage();
          //     },
          //   ),
          // );
          Navigator.pushNamed(context, HomePage.id);
          setState(() {
            _isLoading = false;
          });
        });
      },
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

// class GoogleLogin extends StatelessWidget {

//   static const String id = "google_login";
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'CSUF Parking',

//       home: LoginScreen(title: 'CSUF PARKING'),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }

// class LoginScreen extends StatefulWidget {
//   LoginScreen({Key key, this.title}) : super(key: key);

//   final String title;

//   @override
//   LoginScreenState createState() => LoginScreenState();
// }

// class LoginScreenState extends State<LoginScreen> {
//   final GoogleSignIn googleSignIn = GoogleSignIn();
//   final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
//   SharedPreferences prefs;

//   bool isLoading = false;
//   bool isLoggedIn = false;
//   FirebaseUser currentUser;

//   @override
//   void initState() {
//     super.initState();
//     isSignedIn();
//   }

//   void isSignedIn() async {
//     this.setState(() {
//       // isLoading = true;
//     });

//     prefs = await SharedPreferences.getInstance();

//     isLoggedIn = await googleSignIn.isSignedIn();
//     if (isLoggedIn) {
//       Navigator.pushNamed(context, HomePage.id);
//     }

//     this.setState(() {
//       isLoading = false;
//     });
//   }

//   Future<Null> handleSignIn() async {
//     prefs = await SharedPreferences.getInstance();

//     this.setState(() {
//       isLoading = true;
//     });

//     GoogleSignInAccount googleUser = await googleSignIn.signIn();
//     GoogleSignInAuthentication googleAuth = await googleUser.authentication;

//     final AuthCredential credential = GoogleAuthProvider.getCredential(
//       accessToken: googleAuth.accessToken,
//       idToken: googleAuth.idToken,
//     );

//     final FirebaseUser firebaseUser = (await firebaseAuth.signInWithCredential(credential)).user;

//     if (firebaseUser != null) {
//       // Check is already sign up
//       final QuerySnapshot result =
//           await Firestore.instance.collection('users').where('id', isEqualTo: firebaseUser.uid).getDocuments();
//       final List<DocumentSnapshot> documents = result.documents;
//       if (documents.length == 0) {
//         // Update data to server if new user
//         Firestore.instance.collection('users').document(firebaseUser.uid).setData({
//           'nickname': firebaseUser.displayName,
//           'photoUrl': firebaseUser.photoUrl,
//           'id': firebaseUser.uid,
//           'createdAt': DateTime.now().millisecondsSinceEpoch.toString(),
//           'chattingWith': null
//         });

//         // Write data to local
//         currentUser = firebaseUser;
//         await prefs.setString('id', currentUser.uid);
//         await prefs.setString('nickname', currentUser.displayName);
//         await prefs.setString('photoUrl', currentUser.photoUrl);
//       } else {
//         // Write data to local
//         await prefs.setString('id', documents[0]['id']);
//         await prefs.setString('nickname', documents[0]['nickname']);
//         await prefs.setString('photoUrl', documents[0]['photoUrl']);
//         await prefs.setString('aboutMe', documents[0]['aboutMe']);
//       }
//       Fluttertoast.showToast(msg: "Sign in success");
//       this.setState(() {
//         isLoading = false;
//       });
//         Navigator.pushNamed(context, HomePage.id);
//     } else {
//       Fluttertoast.showToast(msg: "Sign in fail");
//       this.setState(() {
//         isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text(
//             widget.title,
//             style: TextStyle( fontWeight: FontWeight.bold),
//           ),
//           centerTitle: true,
//         ),
//         body: Stack(
//           children: <Widget>[
//             Center(
//               child: FlatButton(
//                   onPressed: handleSignIn,
//                   child: Text(
//                     'SIGN IN WITH GOOGLE',
//                     style: TextStyle(fontSize: 16.0),
//                   ),
//                   color: Color(0xffdd4b39),
//                   highlightColor: Color(0xffff7f7f),
//                   splashColor: Colors.transparent,
//                   textColor: Colors.white,
//                   padding: EdgeInsets.fromLTRB(30.0, 15.0, 30.0, 15.0)),
//             ),

//             // Loading
//             Positioned(
//               child: isLoading
//                   ? Container(
//                       child: Center(
//                         child: CircularProgressIndicator(
//                           valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
//                         ),
//                       ),
//                       color: Colors.white.withOpacity(0.8),
//                     )
//                   : Container(),
//             ),
//           ],
//         ));
//   }
// }
