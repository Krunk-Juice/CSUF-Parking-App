import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_parking_app/views/swap/contact_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences prefs;

// Screen with list of users you are swaping spots with
class Swap extends StatefulWidget {
  static const String id = "swap";

  @override
  _SwapState createState() => _SwapState();
}

class _SwapState extends State<Swap> {
  bool isLoading = false;
  String id = '';
  String releaserId = '';
  String swaperId = '';
  String swaperName = '';
  String swaperPhotoUrl = '';
  String swapLocation = '';
  String parkAt = '';
  DateTime timeSwap;
  int floor = 0;

  Firestore _firestore = Firestore.instance;

  // Initialize State of
  @override
  initState() {
    super.initState();
    readLocal();
  }

  // Read RAM for user information.
  void readLocal() async {
    prefs = await SharedPreferences.getInstance();
    id = prefs.getString('id') ?? '';
    releaserId = prefs.getString('releaserId') ?? '';

    // Force refresh input
    setState(() {});
  }

  // UI Construct of the Swap List Screen
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        // backgroundColor: Colors.transparent,
        leading: IconButton(
          // color: Colors.black,
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(
            Icons.arrow_back,
            // color: Colors.black,
          ),
        ),
        title: Text('Swaping',
            style: TextStyle(
                // color: Colors.black,
                fontWeight: FontWeight.w700)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamBuilder(
              stream: _firestore.collection('swaps').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final doc = snapshot.data.documents;
                  // List<SwapItem> swapWidgets = [];
                  for (var item in doc) {
                    final releaserIdSwap = item.data['releaserId'];
                    final bookerId = item.data['bookerId'];
                    // final turnOn = item.data['turnOn'];

                    if (id == releaserIdSwap) {
                      return ContactCard(
                        swaperId: bookerId,
                        swaperName: item.data['bookerName'],
                        swaperPhotoUrl: item.data['bookerPhotoUrl'],
                        swapLocation: item.data['swapLocation'],
                        floor: item.data['floor'],
                        timeSwap: DateTime.fromMillisecondsSinceEpoch(
                            item.data['timeSwap']),
                      );
                      
                    } else  if(releaserId == releaserIdSwap){
                      return ContactCard(
                        swaperId: releaserId,
                        swaperName: item.data['releaserName'],
                        swaperPhotoUrl: item.data['releaserPhotoUrl'],
                        swapLocation: item.data['swapLocation'],
                        floor: item.data['floor'],
                        timeSwap: DateTime.fromMillisecondsSinceEpoch(
                            item.data['timeSwap']),
                      );
                    }
                  }
                } else {
                  return Center(
                      child: Container(
                          alignment: FractionalOffset.center,
                          child: Image.asset('assets/images/loading.gif')));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
