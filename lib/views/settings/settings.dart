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
          margin: EdgeInsets.all(16.0),
          //  child: Expanded(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text('Notifications'),
                  ),
                  Expanded(
                    child: SizedBox(
                      width: 300,
                    ),
                  ),
                  Switch(
                    value: false,
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text('Dark Theme'),
                  ),
                  Expanded(
                    child: SizedBox(
                      width: 300,
                    ),
                  ),
                  Switch(
                    value: true,
                  ),
                ],
              ),
            ],
          ),
          // )
        ));
  }
}
