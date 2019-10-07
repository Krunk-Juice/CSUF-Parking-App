import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProfileHeader extends StatefulWidget {
  @override
  _ProfileHeaderState createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  File avatarImageFile;
  SharedPreferences prefs;

  String id = '';
  String photoUrl = '';
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    readLocal();
  }

  void readLocal() async {
    prefs = await SharedPreferences.getInstance();
    id = prefs.getString('id') ?? '';
    photoUrl = prefs.getString('photoUrl') ?? '';

    // Force refresh input
    setState(() {});
  }

  Future getImage() async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        avatarImageFile = image;
        isLoading = true;
      });
    }
    uploadFile();
  }

  Future uploadFile() async {
    String fileName = id;
    StorageReference reference = FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTask = reference.putFile(avatarImageFile);
    StorageTaskSnapshot storageTaskSnapshot;
    uploadTask.onComplete.then((value) {
      if (value.error == null) {
        storageTaskSnapshot = value;
        storageTaskSnapshot.ref.getDownloadURL().then((downloadUrl) {
          photoUrl = downloadUrl;
          Firestore.instance
              .collection('users')
              .document(id)
              .updateData({'photoUrl': photoUrl}).then((data) async {
            await prefs.setString('photoUrl', photoUrl);
            setState(() {
              isLoading = false;
            });
            Fluttertoast.showToast(msg: "Upload success");
          }).catchError((err) {
            setState(() {
              isLoading = false;
            });
            Fluttertoast.showToast(msg: err.toString());
          });
        }, onError: (err) {
          setState(() {
            isLoading = false;
          });
          Fluttertoast.showToast(msg: 'This file is not an image');
        });
      } else {
        setState(() {
          isLoading = false;
        });
        Fluttertoast.showToast(msg: 'This file is not an image');
      }
    }, onError: (err) {
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(msg: err.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [Colors.lightBlue, Colors.cyan],
            begin: Alignment.topLeft,
            end: Alignment(-0.2, 0.7)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            child: Center(
              child: Stack(
                alignment: Alignment.bottomRight,
                fit: StackFit.loose,
                children: <Widget>[
                  (avatarImageFile == null)
                      ? (photoUrl == null)
                          ? Material(
                              color: Colors.green,
                              shape: CircleBorder(),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Icon(Icons.account_circle,
                                    color: Colors.white, size: 30.0),
                              ))
                          : Material(
                              shape: CircleBorder(),
                              elevation: 20,
                              shadowColor: Colors.black,
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(photoUrl),
                                radius: 60,
                              ))
                      : Material(
                          child: Image.file(
                            avatarImageFile,
                            width: 90.0,
                            height: 90.0,
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(45.0)),
                          clipBehavior: Clip.hardEdge,
                        ),
                ],
              ),
            ),
            width: double.infinity,
            
          ),
          IconButton(
            icon: Icon(
              Icons.camera_alt,
              color: Colors.orange,
            ),
            onPressed: getImage,
            // padding: EdgeInsets.all(30.0),
            splashColor: Colors.transparent,
            highlightColor: Colors.grey,
            iconSize: 30.0,
          ),
        ],
      ),
    );
  }
}
