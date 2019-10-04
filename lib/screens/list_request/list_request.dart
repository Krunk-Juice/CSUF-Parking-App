import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_parking_app/screens/list_request/accept_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences prefs;

class ListRequest extends StatefulWidget {
  static const String id = "list_request";

  @override
  _ListRequestState createState() => _ListRequestState();
}

class _ListRequestState extends State<ListRequest> {
  // FirebaseUser currentUser;
  bool isLoading = false;
  String id = '';
  
  // String nickname = '';
  
  Firestore _firestore = Firestore.instance;

  @override
  initState() {
    super.initState();
    readLocal();
  }

  void readLocal() async {
    prefs = await SharedPreferences.getInstance();
    id = prefs.getString('id') ?? '';
    // nickname = prefs.getString('nickname') ?? '';
    

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
        title: Text('List Requests Your Spot',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700)),
            centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamBuilder(
              stream: _firestore.collection('requests').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final doc = snapshot.data.documents;
                  List<RequestItem> bookerWidgets = [];
                  for (var item in doc) {
                    final releaserId = item.data['releaserId'];
                    final bookerId = item.data['bookerId'];
                    final bookerName = item.data['bookerName'];
                    final bookerPhotoUrl = item.data['bookerPhotoUrl'];
                    final turnOn = item.data['turnOn'];
                    
                    if (releaserId == id && turnOn) {
                      final bookerWidget = RequestItem(
                        bookerName: bookerName,
                        bookerId: bookerId,
                        bookerPhotoUrl: bookerPhotoUrl,
                        
                        
                      );
                      bookerWidgets.add(bookerWidget);
                    }
                  }
                  return Expanded(
                    child: ListView(
                      children: bookerWidgets,
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class RequestItem extends StatelessWidget {
  final String bookerName;
  final String bookerId;
  final String bookerPhotoUrl;
  

  const RequestItem(
      {Key key,
      @required this.bookerName,
      @required this.bookerId,
      @required this.bookerPhotoUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.0),
      child: Stack(
        children: <Widget>[
          /// Item card
          Align(
            alignment: Alignment.topCenter,
            child: SizedBox.fromSize(
                size: Size.fromHeight(172.0),
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    /// Item description inside a material
                    Container(
                      margin: EdgeInsets.only(top: 24.0),
                      child: Material(
                        elevation: 14.0,
                        borderRadius: BorderRadius.circular(12.0),
                        shadowColor: Color(0x802196F3),
                        color: Colors.white,
                        child: InkWell(
                          onTap: () => {
                            //set prefs for releaser
                            prefs.setString('bookerId', bookerId),
                            prefs.setString('bookerName', bookerName),
                            prefs.setString('bookerPhotoUrl', bookerPhotoUrl),
                            Navigator.pushNamed(context, AcceptCard.id),
                          },
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => RequestPage(
                          //       releaserId: releaserId,
                          //       releaserName: releaserName,
                          //       releaserPhotoUrl: releaserPhotoUrl,
                          //     ),
                          //   ),
                          // ),
                          // RequestPage(releaserId: releaserId,releaserName: releaserName,releaserPhotoUrl: releaserPhotoUrl,),
                          child: Padding(
                            padding: EdgeInsets.all(24.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                /// Title and rating
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(bookerName,
                                        style: TextStyle(
                                            color: Colors.blueAccent)),
                                    // Row(
                                    //   mainAxisAlignment:
                                    //       MainAxisAlignment.start,
                                    //   crossAxisAlignment:
                                    //       CrossAxisAlignment.center,
                                    //   children: <Widget>[
                                    //     Text(
                                    //         releaserParking != null
                                    //             ? releaserParking
                                    //             : 'Not Available',
                                    //         style: TextStyle(
                                    //             color: Colors.black,
                                    //             fontWeight: FontWeight.w700,
                                    //             fontSize: 34.0)),
                                    //     Icon(Icons.directions,
                                    //         color: Colors.blue, size: 24.0),
                                    //   ],
                                    // ),
                                  ],
                                ),

                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.start,
                                //   crossAxisAlignment: CrossAxisAlignment.center,
                                //   children: <Widget>[
                                //     Text('Release at', style: TextStyle()),
                                //     Padding(
                                //       padding:
                                //           EdgeInsets.symmetric(horizontal: 4.0),
                                //       child: Material(
                                //         borderRadius:
                                //             BorderRadius.circular(8.0),
                                //         color: Colors.green,
                                //         child: Padding(
                                //           padding: EdgeInsets.all(4.0),
                                //           child: Text(
                                //               releaserLeavingTime != null
                                //                   ? releaserLeavingTime
                                //                   : 'Not Available',
                                //               style: TextStyle(
                                //                   color: Colors.white)),
                                //         ),
                                //       ),
                                //     ),
                                //   ],
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: EdgeInsets.only(right: 16.0),
                        child: SizedBox.fromSize(
                          size: Size.fromRadius(54.0),
                          child: Material(
                            elevation: 20.0,
                            shadowColor: Color(0x802196F3),
                            shape: CircleBorder(),
                            child: ClipOval(
                              child: CachedNetworkImage(
                                imageUrl: bookerPhotoUrl,
                                fit: BoxFit.cover,
                                
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
