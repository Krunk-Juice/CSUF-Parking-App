import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<ProfilePage> with SingleTickerProviderStateMixin {
  bool _status = true;
  final FocusNode myFocusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            Column(children: <Widget>[
              Container(
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
                ),),
                
                /* Infomations */
                Container (
                  color: Color(0xFFFFFFFF),
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[

                        /* Personal Information */
                        Padding(
                          padding: EdgeInsets.only(
                            left: 25,
                            right: 25,
                            top: 25),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text('Personal Information',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                  ),
                                  ),
                                ],
                              ),

                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  _status ? _getEditIcon() : new Container(),
                                ],
                              )
                            ],
                          )
                        ),

                        /* Name Section */
                        Padding(
                          padding: EdgeInsets.only(
                            left: 25,
                            right: 25,
                            top: 25
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(
                                    'Name',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ),

                        /* HINT: Enter your name */  
                        Padding(
                          padding: EdgeInsets.only(
                            left: 25,
                            right: 25, 
                            top: 25
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Flexible(
                                child: TextField(
                                  decoration: const InputDecoration(
                                    hintText: "Enter Your Name",
                                  ),
                                  enabled: !_status,
                                  autofocus: !_status,
                                )
                              )
                            ], 
                          )
                        ),

                        Padding(
                          padding: EdgeInsets.only(
                            left: 25,
                            right: 25,
                            top: 25
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(
                                    'Email ID',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ),

                        Padding(
                          padding: EdgeInsets.only(
                            left: 25, right: 25, top: 2
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Flexible(
                                child: TextField(
                                  decoration: const InputDecoration(
                                    hintText: "Enter Email ID"
                                  ),
                                  enabled: !_status,
                                ),
                              ),
                            ],
                          )
                        ),

                        
                      ],
                    )))
            ],)
          ],
        )));
  }



  _getEditIcon() {
    return GestureDetector(
      child: CircleAvatar(
        backgroundColor: Colors.red,
        radius: 14,
        child: Icon(
          Icons.edit,
          color: Colors.white,
          size: 16,
        ),
      ),

      onTap: () {
        setState(() {
          _status = false;
        });
      }
    );
  }
}

