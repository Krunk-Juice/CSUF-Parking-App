import 'package:flutter/material.dart';


class ProfileHeaderSection extends StatefulWidget {
  @override
  _ProfileHeaderSectionState createState() => _ProfileHeaderSectionState();
}

class _ProfileHeaderSectionState extends State<ProfileHeaderSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
                height: 250,
                color: Colors.white,
                child: Column(children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 20, top: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,
                          size: 22,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 25),
                          child: Text('PROFILE',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              fontFamily: 'sans-serif-light',
                              color: Colors.black
                            )),)
                      ],)
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Stack(fit: StackFit.loose, children: <Widget>[
                      Row(crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        /* Profile Image */
                        Container(
                          width: 140,
                          height: 140,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: ExactAssetImage(
                                'assets/images/undraw_profile_pic_ic5t.png'
                              ),
                              fit: BoxFit.cover,),
                          )),
                      ],),
                      Padding(
                        padding: EdgeInsets.only(top: 90, right: 100),
                        child: Row(
                          mainAxisAlignment:  MainAxisAlignment.center,
                          children: <Widget>[
                            /* Camera Icon */
                            CircleAvatar(
                              backgroundColor: Colors.red,
                              radius: 25,
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                              ),
                            )
                          ],
                        )),
                    ]),
                  )
                ],
                ),);
  }
}