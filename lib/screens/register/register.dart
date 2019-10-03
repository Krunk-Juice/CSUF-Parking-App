import 'package:flutter/material.dart';
// import 'package:flutter_parking_app/screens/register/register_body.dart';
// import 'package:flutter_parking_app/screens/register/register_header.dart';
import 'package:quiver/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Register extends StatefulWidget {
  static const String id = "register";

  @override
  MapScreenState createState() => MapScreenState();
}

bool isCSUFemail(String value) {
  bool special = false;
  bool complete = false;
  String pattern = "@csu.fullerton.edu";
  for (int i = 0; i < value.length; i++) {
    if (special == false && value[i] == '@') special = true;
    if (special && (value.length - i == pattern.length)) {
      complete = true;
      for (int j = 0; j < pattern.length && i < value.length; j++, i++) {
        if (value[i] != pattern[j]) complete = false;
      }
    }
  }
  return complete;
}

String phoneValidator(String value) {
  bool complete = true;
  for (int i = 0; i < value.length; i++) {
    int d = int.parse(value[i]);
    if (!isDigit(d)) complete = false;
  }
  if (complete && value.length != 10)
    return "Phone number must have 10 digits";
  else if (!complete && value.length == 10)
    return "Invalid character for phone number";
  else if (!complete && value.length != 10)
    return "Invalid character for phone number and phone number must have 10 digits";
  else
    return null;
}

String emailValidator(String value) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  if (!regex.hasMatch(value))
    return 'Email format is invalid';
  else if (!isCSUFemail(value))
    return 'Email must be a Cal State Fullerton email';
  else
    return null;
}

String pwdValidator(String value) {
  if (value.length < 8)
    return 'Password must be at least 8 characters.';
  else
    return null;
}

class MapScreenState extends State<Register>
    with SingleTickerProviderStateMixin {
  //bool _status = true;
  //final FocusNode myFocusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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

  // @override
  // void initState() {
  //   super.initState();
  //   readLocal();
  // }

  void readLocal() async {
    prefs = await SharedPreferences.getInstance();
    id = prefs.getString('id') ?? '';
    nickname = prefs.getString('nickname') ?? '';
    email = prefs.getString('email') ?? '';
    phone = prefs.getString('phone') ?? '';
    password = prefs.getString('password') ?? '';

    controllerNickname = new TextEditingController(text: nickname);
    controllerEmail = new TextEditingController(text: email);
    controllerPhone = new TextEditingController(text: phone);
    controllerPassword = new TextEditingController(text: password);
    // Force refresh input
    setState(() {});
  }

  void handleUpdateData() {
    // focusNodeNickname.unfocus();
    // focusNodeAboutMe.unfocus();

    setState(() {
      // isLoading = true;
    });

    Firestore.instance.collection('users').document(id).updateData({
      'nickname': nickname,
      'email': email,
      'password': password,
      'phone': phone
    }).then((data) async {
      await prefs.setString('nickname', nickname);
      await prefs.setString('email', email);
      await prefs.setString('password', password);
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
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            color: Colors.black,
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.arrow_back, color: Colors.black),
          ),
          title: Text('Register',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w700)),
          centerTitle: true,
        ),
        body: Container(
          color: Color(0xFFFFFFFF),
          child:
              // Column(children:<Widget>[
              ListView(
            // shrinkWrap: true,
            children: <Widget>[
              Column(
                children: <Widget>[
                  /* Header and Image Section */
                  // RegisterHeader(),
                  // RegisterBody(),
                  /* Infomation Section */

                  Container(
                      child: Padding(
                          padding: EdgeInsets.only(bottom: 25),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              /* Personal Information */
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 25, right: 25, top: 25),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Text(
                                            'Personal Information',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
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
                                  )),

                              /* Name Section */
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 25, right: 25, top: 25),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Text(
                                            'User Name',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),

                              /* HINT: Enter your name */
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 25, right: 25, top: 10),
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
                                          } else
                                            return null;
                                        },
                                        // enabled: !_status,
                                        // autofocus: !_status,
                                        onChanged: (value) {
                                          nickname = value;
                                        },
                                      ))
                                    ],
                                  )),

                              /* Email ID */
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 25, right: 25, top: 25),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Text(
                                            'Email',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),

                              /* HINT: Enter Email ID */
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 25, right: 25, top: 10),
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
                                          onChanged: (value) {
                                            email = value;
                                          },
                                        ),
                                      ),
                                    ],
                                  )),

                              /* Password Section */
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 25, right: 25, top: 25),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Text(
                                            'Password',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),

                              /* HINT: Enter Your Password */
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 25, right: 25, top: 10),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      Flexible(
                                          child: TextFormField(
                                        decoration: const InputDecoration(
                                          hintText: "Enter Your Password",
                                        ),
                                        controller: controllerPassword,
                                        validator: pwdValidator,
                                        // enabled: !_status,
                                        // autofocus: !_status,
                                      ))
                                    ],
                                  )),
                              /* HINT: Confirm Your Password */
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 25, right: 25, top: 10),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      Flexible(
                                          child: TextFormField(
                                        decoration: const InputDecoration(
                                          hintText: "Confirm Your Password",
                                        ),
                                        controller: controllerPassword,
                                        validator: (value) {
                                          if (value.length == password.length) {
                                            for (int i = 0;
                                                i < value.length;
                                                i++) {
                                              if (value[i] != password[i])
                                                return "Passwords do not match.";
                                            }
                                            return null;
                                          }
                                          return "Passwords do not match.";
                                        },
                                        // enabled: !_status,
                                        // autofocus: !_status,
                                      ))
                                    ],
                                  )),

                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 25, right: 25, top: 25),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      Text(
                                        'Mobile',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  )),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 25, right: 25, top: 10),
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
                                          onChanged: (value) {
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
                          )))
                ],
              )
            ],
          ),
          // _getActionButtons(),
          // ])
        ));
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
                child: Text("Register"),
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