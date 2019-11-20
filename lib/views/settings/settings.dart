import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  static const String id = "settings";

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  bool darktheme = false;
  bool notification = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.arrow_back,
            
            ),
          ),
          title:
              Text('Settings', style: TextStyle(fontWeight: FontWeight.w700)),
          centerTitle: true,
        ),
        body: Container(
          margin: EdgeInsets.only(left: 24.0, right: 16.0, top: 8.0, bottom: 8.0),
          //  child: Expanded(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text('Notifications', 
                    style: TextStyle(fontSize: 16.0,)),
                  ),
                  Expanded(
                    child: SizedBox(
                      width: 300,
                    ),
                  ),
                  Switch(
                    value: notification,
                    activeColor: Colors.blue,
                    onChanged: (bool newValue) {
                      setState(() {
                        notification = newValue;
                      });
                    },
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text('Dark Theme', 
                    style: TextStyle(fontSize: 16.0,),),
                  ),
                  Expanded(
                    child: SizedBox(
                      width: 300,
                    ),
                  ),
                  Switch(
                    value: darktheme,
                    activeColor: Colors.blue,
                    onChanged: (bool newValue) {
                      setState(() {
                        darktheme = newValue;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
          // )
        ));
  }
}
