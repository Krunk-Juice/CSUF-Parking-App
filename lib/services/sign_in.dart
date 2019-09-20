import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();
SharedPreferences prefs;

String name;
String email;
String imageUrl;

Future<String> signInWithGoogle() async {
  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final FirebaseUser firebaseUser = (await _auth.signInWithCredential(credential)).user;

  // Checking if email and name is null
  // assert(user.email != null);
  // assert(user.displayName != null);
  // assert(user.photoUrl != null);

  // name = user.displayName;
  // email = user.email;
  // imageUrl = user.photoUrl;

  // // Only taking the first part of the name, i.e., First Name
  // if (name.contains(" ")) {
  //   name = name.substring(0, name.indexOf(" "));
  // }

  // assert(!user.isAnonymous);
  // assert(await user.getIdToken() != null);

  // final FirebaseUser currentUser = await _auth.currentUser();
  // assert(user.uid == currentUser.uid);
if (firebaseUser != null) {

      // Check is already sign up
      final QuerySnapshot result =
          await Firestore.instance.collection('users').where('id', isEqualTo: firebaseUser.uid).getDocuments();
      final List<DocumentSnapshot> documents = result.documents;
      if (documents.length == 0) {
        // Update data to server if new user
        Firestore.instance.collection('users').document(firebaseUser.uid).setData({
          'nickname': firebaseUser.displayName,
          'email': firebaseUser.email,
          'photoUrl': firebaseUser.photoUrl,
          'id': firebaseUser.uid,
          'createdAt': DateTime.now().toString(),
          'chattingWith': null
        });

   FirebaseUser currentUser = await _auth.currentUser();

        // Write data to local
        currentUser = firebaseUser;
        await prefs.setString('id', currentUser.uid);
        await prefs.setString('email', currentUser.email);
        await prefs.setString('nickname', currentUser.displayName);
        await prefs.setString('photoUrl', currentUser.photoUrl);
      } else {
        // Write data to local
        await prefs.setString('id', documents[0]['id']);
        await prefs.setString('email', documents[0]['email']);
        await prefs.setString('nickname', documents[0]['nickname']);
        await prefs.setString('photoUrl', documents[0]['photoUrl']);
        await prefs.setString('aboutMe', documents[0]['aboutMe']);
      }
      // Fluttertoast.showToast(msg: "Sign in success");



    } 
    // else {
    //   Fluttertoast.showToast(msg: "Sign in fail");

    // }



  return 'signInWithGoogle succeeded: $firebaseUser';

}

void signOutGoogle() async{
  await _auth.signOut();
  await googleSignIn.signOut();
  await googleSignIn.disconnect();
  prefs.clear();
  print("User Sign Out");
}