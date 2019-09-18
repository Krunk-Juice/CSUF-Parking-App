import 'package:flutter/material.dart';

class Navigationdrawer extends StatefulWidget {
  static const String id = "navigation_drawer";

  @override
  _NavigationdrawerState createState() => _NavigationdrawerState();
}

class _NavigationdrawerState extends State<Navigationdrawer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("CSUF Parking App"),
        ),
      ),
      drawer: Drawer(
          child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text("Michaelangelo"),
            accountEmail: Text("ManEater@gmail.com"),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Theme.of(context).platform == TargetPlatform.iOS
                  ? Colors.blue
                  : Colors.white,
              child: Text(
                "A",
                style: TextStyle(fontSize: 40.0),
              ),
            ),
          ),
          ListTile(
            title: Text("Profile"),
            trailing: Icon(Icons.arrow_forward),
            // onTap: ()=>Navigator.pushNamed(context, Profile.id),
          ),
          ListTile(
            title: Text("Signout"),
            trailing: Icon(Icons.arrow_forward),
          ),
          ListTile(
            title: Text("Settings"),
            trailing: Icon(Icons.arrow_forward),
          ),
        ],
      )),
    );
  }
}
