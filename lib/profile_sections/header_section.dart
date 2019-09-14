import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ProfileHeaderSection extends StatefulWidget {
  @override
  _ProfileHeaderSectionState createState() => _ProfileHeaderSectionState();
}

class _ProfileHeaderSectionState extends State<ProfileHeaderSection> {
  File _image;

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
        children: <Widget>[
          Padding(
              padding: EdgeInsets.only(left: 20, top: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 22,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 25),
                    child: Text('PROFILE',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            fontFamily: 'sans-serif-light',
                            color: Colors.white)),
                  )
                ],
              )),
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: Stack(fit: StackFit.loose, children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  /* Profile Image */
                  Container(
                      width: 140,
                      height: 140,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 15,
                          color: Colors.blue),
                        image: DecorationImage(
                          image: ExactAssetImage(
                              'assets/images/undraw_profile_pic_ic5t.png'),
                          fit: BoxFit.cover,
                        ),
                      )),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 90, right: 100),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    /* Camera Icon */
                    RawMaterialButton(
                      shape: CircleBorder(),
                      fillColor: Colors.red,
                      elevation: 2.0,
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                      ),
                      onPressed: () => getImage(),
                    ),
                  ],
                ),
              ),
            ]),
          )
        ],
      ),
    );
  }

  Future getImage() async {

    var image;

    if (await checkAndRequestCameraPermissions())
      image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
      print('Image Path $_image');
    });
  }

  /* Check if the application has permission to use camera. */
  Future<bool> checkAndRequestCameraPermissions() async {
    PermissionStatus permission =
      await PermissionHandler().checkPermissionStatus(PermissionGroup.camera);
    if (permission != PermissionStatus.granted) {
      Map<PermissionGroup, PermissionStatus> permissions =
        await PermissionHandler().requestPermissions([PermissionGroup.camera]);
      return permissions[PermissionGroup.camera] == PermissionStatus.granted;
    }
    else {
      return true;
    }
  }
}
