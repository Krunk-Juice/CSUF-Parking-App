import 'package:flutter/material.dart';



class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            
            Image.network('https://images.unsplash.com/photo-1509822929063-6b6cfc9b42f2?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1500&q=80'),


            Text('Username',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              
            ),
            ),
            Card(
              child: ListTile(
                leading: Icon(
                  Icons.email,
                  color: Colors.orange,
                ),
                title: Text('myemail@gmail.com'),
              ),

            ),
            SizedBox(
              height: 20,
            ),

            Text('Password',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              
            ),
            ),
            Card(
              child: ListTile(
                
                title: Text('**********'),
              ),

            ),


          ],
        ),
      ),  // SafeArea prevents iOS or Android from overflowing
    );
  }
}