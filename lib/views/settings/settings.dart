import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_parking_app/views/home/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  static const String id = "settings";

  // Settings({this.context});
  // final BuildContext context;

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  SharedPreferences prefs;
  bool darkTheme = false;
  bool notification = false;

  @override
  void initState() {
    super.initState();
    // if (Theme.of(context).brightness == Brightness.dark) {
    //   darkTheme = true;
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          leading: IconButton(
            onPressed: () => Navigator.pushNamed(context, Home.id),
            icon: Icon(
              Icons.arrow_back,
            ),
          ),
          
        ),
        body: Container(
          margin:
              EdgeInsets.only(left: 24.0, right: 16.0, top: 8.0, bottom: 8.0),
          //  child: Expanded(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text('Notifications',
                        style: TextStyle(
                          fontSize: 16.0,
                        )),
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
                    child: Text(
                      'Dark Theme',
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      width: 300,
                    ),
                  ),
                  Switch(
                    value:Theme.of(context).brightness == Brightness.dark ,
                    activeColor: Colors.blue,
                    onChanged: (bool newValue) {
                      setState(() {
                        
                        DynamicTheme.of(context).setBrightness(
                            Theme.of(context).brightness == Brightness.dark
                                ? Brightness.light
                                : Brightness.dark);
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
