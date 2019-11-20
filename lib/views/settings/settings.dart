import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  static const String id = "settings";

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title:
              Text('Settings', style: TextStyle(fontWeight: FontWeight.w700)),
          centerTitle: true,
        ),
        body: Container(
          //  child: Expanded(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: 
              Row(
                children: <Widget>[
                  Text('Notifications'),
                  Switch(
                    value: false,
                    
                  ),
              ],),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child:
                Expanded (
                  child:
              Row(
                children: <Widget>[
                  Text('Dark Theme'),
                  
                  Switch(
                    value: true,
                  ),
              ],),
                ),
              ),
            ],
          ),
          // )
        )
    );
  }
}
