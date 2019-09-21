import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

 SharedPreferences prefs;


class RequestPage extends StatefulWidget {
  

  

  static const String id = "request_card";
  @override
  _RequestPageState createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
 
  String id = '';
  String nickname = '';
  String photoUrl = '';
  String releaserId = '';
  String releaserName = '';
  String releaserPhotoUrl = '';

  @override
  void initState() {
    super.initState();

    readLocal();
  }

  void readLocal() async {
    prefs = await SharedPreferences.getInstance();
    id = prefs.getString('id') ?? '';
    nickname = prefs.getString('nickname') ?? '';
    releaserId = prefs.getString('releaserId') ?? '';
    releaserName = prefs.getString('releaserName') ?? '';
    photoUrl = prefs.getString('releaserPhotoUrl') ?? '';

    // Force refresh input
    setState(() {});
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
          title: Text('Request',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w700)),
        ),
        body: Container(
            //color: Colors.blueGrey,
            child: Column(
          children: <Widget>[
            Column(
              children: <Widget>[
                /* Header Section */
                Container(
                    height: 350,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.lightBlue, Colors.cyan],
                          begin: Alignment.topLeft,
                          end: Alignment(-0.2, 0.7)),
                    ),
                    child: Column(
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(top: 50),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text('Releaser',
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.white)),
                              ],
                            )),
                        Padding(
                            padding: EdgeInsets.only(top: 30),
                            // child: Stack(fit: StackFit.loose, children: <Widget>[
                            //   /* Container fills the full width of the device */
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                    width: 140,
                                    height: 140,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            width: 15,
                                            color: Colors.blueAccent),
                                        image: DecorationImage(
                                          image: ExactAssetImage(
                                              releaserPhotoUrl),
                                          fit: BoxFit.cover,
                                        )))
                              ],
                            )
                            //],)
                            ),
                        Padding(
                            padding: EdgeInsets.only(top: 30),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(releaserName,
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.white)),
                              ],
                            ))
                      ],
                    )),
                SizedBox(
                  height: 100,
                ),
                /* Button Container */
                RaisedButton(
                  padding: EdgeInsets.symmetric(vertical: 25, horizontal: 80),
                  // padding: EdgeInsets.all(0),
                  elevation: 15,

                  splashColor: Colors.blueAccent,
                  child: Text('Request',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.green[900])),

                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  onPressed: () => null,
                ),
              ],
            )
          ],
        )));
  }

// void _handleRequest(BuildContext context)
//   {
// //update release status
//                     Firestore.instance
//                         .collection('users')
//                         .document(id)
//                         .updateData({'book': true}).then((data) async {
//                       await prefs.setBool('release', true);

//                       Fluttertoast.showToast(msg: "Update success");
//                     }).catchError((err) => print(err));

//                     //add new release to list
//                     Firestore.instance
//                         .collection('releases')
//                         .document(id)
//                         .setData({
//                           'nickname': nickname,
//                           'photoUrl': photoUrl,
//                           'parking': nameParking,
//                         })
//                         .then((result) => {
//                               Navigator.of(context).pop(),
//                             })
//                         .catchError((err) => print(err));
//   }

}
