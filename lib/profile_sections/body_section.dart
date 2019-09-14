import 'package:flutter/material.dart';

class ProfileBodySection extends StatefulWidget {

  
  @override
  _ProfileBodyState createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBodySection> {
  bool _status = true;
  final FocusNode myFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    /* Information Section */
    return Container (
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
                            top: 2
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

                        Padding(
                          padding: EdgeInsets.only(
                            left: 25, right: 25, top: 25
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Text(
                                'Mobile',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold
                                ),
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
                                    hintText: "Enter Mobile Number"
                                  ),
                                  enabled: !_status,
                                ),
                              ),
                            ],
                          )
                        ),

                        Padding(
                          padding: EdgeInsets.only(
                            left: 25, right: 25, top: 25
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  child: Text(
                                    'PIN Code',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                                flex: 2,
                              ),

                              Expanded(
                                child: Container(
                                  child: Text(
                                    'State',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                                flex: 2,
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
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Flexible(
                                child: Padding(
                                  padding: EdgeInsets.only(right: 10),
                                  child: TextField(
                                    decoration: const InputDecoration(
                                      hintText: "Enter PIN Code"),
                                    enabled: !_status,
                                  ),
                                ),
                                flex: 2,
                              ),
                              Flexible(
                                child: TextField(
                                  decoration: const InputDecoration(
                                    hintText: "Enter State"
                                  ),
                                  enabled: !_status,
                                ),
                                flex: 2,
                              ),
                            ],
                          ),

                        ),

                        !_status ? _getActionButtons() : Container(),
                      ],
                    ))
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
      }
    );
  }



  _getActionButtons() {
    return Padding(
      padding: EdgeInsets.only(
        left: 25,
        right: 25,
        top: 45
      ),
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
                  onPressed: () {
                    setState(() {
                      _status = true;
                      FocusScope.of(context).requestFocus(FocusNode());
                    });
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                  ),
                )
              ),
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
                  onPressed: () {
                    setState(() {
                     _status = true;
                     FocusScope.of(context).requestFocus(FocusNode()); 
                    });
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                  ),
                )
              ),
            ),
            flex: 2,
          ),
        ],
      ),
    );
  }
}