import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_parking_app/screens/register/register.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterBody extends StatefulWidget {
  @override
  _RegisterBodyState createState() => _RegisterBodyState();
}

class _RegisterBodyState extends State<RegisterBody> {
  bool _status = true;
  final FocusNode myFocusNode = FocusNode();
  SharedPreferences prefs;
  TextEditingController controllerNickname;
  TextEditingController controllerEmail;
  TextEditingController controllerPhone;
  TextEditingController controllerPassword;

  String id = '';
  String phone = '';
  String nickname = '';
  String email = '';
  String password = '';

  @override
  void initState() {
    super.initState();
    readLocal();
  }
  void readLocal() async {
    prefs = await SharedPreferences.getInstance();
    id = prefs.getString('id')??'';
    nickname = prefs.getString('nickname') ?? '';
    email = prefs.getString('email') ?? '';
    phone = prefs.getString('phone') ?? '';

    controllerNickname = new TextEditingController(text: nickname);
    controllerEmail = new TextEditingController(text: email);
    controllerPhone = new TextEditingController(text: phone);
    // Force refresh input
    setState(() {});
  }
void handleUpdateData() {
    // focusNodeNickname.unfocus();
    // focusNodeAboutMe.unfocus();

    setState(() {
      // isLoading = true;
    });

    Firestore.instance
        .collection('users')
        .document(id)
        .updateData({'nickname': nickname, 'email': email, 'phone': phone}).then((data) async {
      await prefs.setString('nickname', nickname);
      await prefs.setString('email', email);
      await prefs.setString('phone', phone);

      

      setState(() {
        // isLoading = false;
      });

      Fluttertoast.showToast(msg: "Update success");
    }).catchError((err) {
      setState(() {
        // isLoading = false;
      });

      Fluttertoast.showToast(msg: err.toString());
    });
  }
  @override
  Widget build(BuildContext context) {

    /* Information Section */
    return Container(
        child: Padding(
            padding: EdgeInsets.only(bottom: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                /* Personal Information */
                Padding(
                    padding: EdgeInsets.only(left: 25, right: 25, top: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              'Personal Information',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        // Column(
                        //   mainAxisAlignment: MainAxisAlignment.end,
                        //   mainAxisSize: MainAxisSize.min,
                        //   children: <Widget>[
                        //     _status ? _getEditIcon() : new Container(),
                        //   ],
                        // )
                      ],
                    )
                  ),

                /* Name Section */
                Padding(
                    padding: EdgeInsets.only(left: 25, right: 25, top: 25),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              'User Name',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    )),

                /* HINT: Enter your name */
                Padding(
                    padding: EdgeInsets.only(left: 25, right: 25, top: 2),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Flexible(
                          child: TextFormField(
                            decoration: const InputDecoration(
                            hintText: "Enter Your User Name",
                            ),
                            controller: controllerNickname,
                            validator: (value) {
                              if (value.length > 10) {
                                return "User name should be at most 10 characters.";
                              }
                              else
                                return null;
                            },
                            // enabled: !_status,
                            // autofocus: !_status,
                            onChanged: (value){
                            nickname = value;
                            },
                        ))
                      ],
                    )),

                /* Email ID */
                Padding(
                    padding: EdgeInsets.only(left: 25, right: 25, top: 25),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              'Email',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    )),
                    
                /* HINT: Enter Email ID */
                Padding(
                    padding: EdgeInsets.only(left: 25, right: 25, top: 2),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Flexible(
                          child: TextFormField(
                            decoration: const InputDecoration(
                                hintText: "Enter Email "),
                            controller: controllerEmail,
                            validator: emailValidator,
                            // enabled: !_status,
                            onChanged: (value){
                              email = value;
                            },
                          ),
                        ),
                      ],
                    )),

                /* Password Section */
                Padding(
                    padding: EdgeInsets.only(left: 25, right: 25, top: 25),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              'Password',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    )),

                /* HINT: Change Your Password */
                Padding(
                    padding: EdgeInsets.only(left: 25, right: 25, top: 2),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Flexible(
                            child: TextFormField(
                            decoration: const InputDecoration(
                            hintText: "Change Your Password",
                          ),
                          controller: controllerPassword,
                          validator: pwdValidator,
                          // enabled: !_status,
                          // autofocus: !_status,
                          
                        ))
                      ],
                    )),

                Padding(
                    padding: EdgeInsets.only(left: 25, right: 25, top: 25),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Text(
                          'Mobile',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    )),
                Padding(
                    padding: EdgeInsets.only(left: 25, right: 25, top: 2),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Flexible(
                          child: TextFormField(
                            decoration: const InputDecoration(
                                hintText: "Enter Mobile Number"),
                                controller: controllerPhone,
                                validator: phoneValidator,
                            // enabled: !_status,
                            onChanged: (value){
                              phone = value;
                            },
                          ),
                        ),
                      ],
                    )),

                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  // height: 10,
                ),
                // Padding(
                //     padding: EdgeInsets.only(left: 25, right: 25, top: 25),
                //     child: Row(
                //       mainAxisSize: MainAxisSize.max,
                //       mainAxisAlignment: MainAxisAlignment.start,
                //       children: <Widget>[
                //         Expanded(
                //           child: Container(
                //             child: Text(
                //               'PIN Code',
                //               style: TextStyle(
                //                   fontSize: 16, fontWeight: FontWeight.bold),
                //             ),
                //           ),
                //           flex: 2,
                //         ),
                //         Expanded(
                //           child: Container(
                //             child: Text(
                //               'State',
                //               style: TextStyle(
                //                   fontSize: 16, fontWeight: FontWeight.bold),
                //             ),
                //           ),
                //           flex: 2,
                //         ),
                //       ],
                //     )),
                // Padding(
                //   padding: EdgeInsets.only(left: 25, right: 25, top: 2),
                //   child: Row(
                //     mainAxisSize: MainAxisSize.max,
                //     mainAxisAlignment: MainAxisAlignment.start,
                //     children: <Widget>[
                //       Flexible(
                //         child: Padding(
                //           padding: EdgeInsets.only(right: 10),
                //           child: TextField(
                //             decoration: const InputDecoration(
                //                 hintText: "Enter PIN Code"),
                //             enabled: !_status,
                //             onChanged: (value){

                //             },
                //           ),
                //         ),
                //         flex: 2,
                //       ),
                //       Flexible(
                //         child: TextField(
                //           decoration:
                //               const InputDecoration(hintText: "Enter State"),
                //           enabled: !_status,
                //         ),
                //         flex: 2,
                //       ),
                //     ],
                //   ),
                // ),
                // !_status ? _getActionButtons() : Container(),

                _getActionButtons(),
              ],
            )
          )
        );
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed.
    myFocusNode.dispose();
    super.dispose();
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
        });
  }

  _getActionButtons() {
    return Padding(
      padding: EdgeInsets.only(left: 25, right: 25, top: 45),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 10),
              child: Container(
                  child: RaisedButton(
                child: Text("Save"),
                textColor: Colors.white,
                color: Colors.green,
                elevation: 10,
                onPressed: () {
                  setState(() {
                    _status = true;
                    FocusScope.of(context).requestFocus(FocusNode());
                    handleUpdateData();
                  });
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
              )),
            ),
            flex: 2,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10),
              child: Container(
                  child: RaisedButton(
                child: Text("Cancel"),
                textColor: Colors.white,
                color: Colors.red,
                elevation: 10,
                onPressed: () {
                  setState(() {
                    _status = true;
                    FocusScope.of(context).requestFocus(FocusNode());
                  });
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
              )),
            ),
            flex: 2,
          ),
        ],
      ),
    );
  }
}
