import 'package:flutter/material.dart';
import 'profile_sections/header_section.dart';
import 'profile_sections/body_section.dart';

class ProfilePage extends StatefulWidget {
  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<ProfilePage> with SingleTickerProviderStateMixin {
  //bool _status = true;
  //final FocusNode myFocusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* Top Bar */
      body: Container(
        color: Colors.blueGrey,
        child: ListView(
          children: <Widget>[
            Column(children: <Widget>[

              /* Header and Image Section */
<<<<<<< HEAD
              ProfileHeaderSection(),
              ProfileBodySection(),
=======
              Container(
                height: 250,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.lightBlue, Colors.cyan],
                    begin: Alignment.topLeft,
                    end: FractionalOffset(0.2, 0.8)
                  )
                ),
                child: Column(children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 20, top: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        /* < PROFILE */
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
                              color: Colors.white
                            )),)
                      ],)
                  ),

                  /* Profile Image and Camera Icon */
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
                            border: Border.all(
                              width: 15,
                              color: Colors.blue),
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
                ),),
                
>>>>>>> 9828211169dd0c283d3d19c03ff0ea1a2ed9e42a
                /* Infomation Section */
            ],)
          ],
        )));
  }


  
}

