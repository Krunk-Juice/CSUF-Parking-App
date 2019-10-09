import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_parking_app/views/home/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:math' as math;
import 'dart:io';

SharedPreferences prefs;
String id = '';
// String nickname = '';
// String photoUrl = '';
TimeOfDay leaveTime;

class SlideCardRelease extends StatefulWidget {
  static const String id = 'slide_card_release';

  @override
  _SlideCardReleaseState createState() => _SlideCardReleaseState();
}

class _SlideCardReleaseState extends State<SlideCardRelease> {


  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Scaffold(
        // backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            // color: Colors.black,
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.arrow_back, 
            // color: Colors.black,
            ),
          ),
          // title: Text('Releasing',
          //     style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700)),
        ),
        body: Stack(
          children: <Widget>[
            SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 10),
                  _buildTile(
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('Where did you park your car?',
                                    style: TextStyle(
                                        color: Colors.redAccent, fontSize: 15)),
                                Text('Please choose one!',
                                    style: TextStyle(
                                        // color: Colors.black,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20)),
                              ],
                            ),
                            Material(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(24.0),
                                child: Center(
                                    child: Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Icon(Icons.directions_car,
                                      color: Colors.white, size: 30.0),
                                )))
                          ]),
                    ),
                    onTap: () => null,
                  ),
                  SizedBox(height: 80),
                  Flexible(child: SlideCards(),),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTile(Widget child, {Function() onTap}) {
    return 
           Material(
          elevation: 14.0,
          borderRadius: BorderRadius.circular(12.0),
          shadowColor: Color(0x802196F3),
          child: InkWell(
              // Do onTap() if it isn't null, otherwise do print()
              onTap: onTap != null
                  ? () => onTap()
                  : () {
                      print('Not set yet');
                    },
              child: child));
  }
}

class SlideCards extends StatefulWidget {
  static const String id = "slide_card";
  @override
  _SlideCardsState createState() => _SlideCardsState();
}

class _SlideCardsState extends State<SlideCards> {
  PageController pageController;
  double pageOffset = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController(viewportFraction: 0.8);
    pageController.addListener(() {
      setState(() => pageOffset = pageController.page);
    });
    readLocal();
  }

  void readLocal() async {
    prefs = await SharedPreferences.getInstance();
    id = prefs.getString('id') ?? '';
    // nickname = prefs.getString('nickname') ?? '';
    // photoUrl = prefs.getString('photoUrl') ?? '';
    // Force refresh input
    setState(() {});
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.55,
      child: PageView(
        controller: pageController,
        children: <Widget>[
          SlidingCard(
            nameParking: 'Nutwood',
            date: '',
            assetName: 'nutwood.png',
            offset: pageOffset,
          ),
          SlidingCard(
            nameParking: 'State College',
            date: '',
            assetName: 'state_college.png',
            offset: pageOffset - 1,
          ),
          SlidingCard(
            nameParking: 'Eastside',
            date: '',
            assetName: 'eastside.png',
            offset: pageOffset - 2,
          ),
        ],
      ),
    );
  }
}

class SlidingCard extends StatelessWidget {
  final String nameParking;
  final String date;
  final String assetName;
  final double offset;

  const SlidingCard({
    Key key,
    @required this.nameParking,
    @required this.date,
    @required this.assetName,
    @required this.offset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double gauss = math.exp(-(math.pow((offset.abs() - 0.5), 2) / 0.08));
    return Transform.translate(
      offset: Offset(-32 * gauss * offset.sign, 0),
      child: Card(
        margin: EdgeInsets.only(left: 8, right: 8, bottom: 24),
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              child: Image.asset(
                'assets/images/$assetName',
                height: MediaQuery.of(context).size.height * 0.3,
                alignment: Alignment(-offset.abs(), 0),
                fit: BoxFit.none,
              ),
            ),
            SizedBox(height: 8),
            Expanded(
              child: CardContent(
                nameParking: nameParking,
                date: date,
                offset: gauss,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CardContent extends StatelessWidget {
  final String nameParking;
  final String date;
  final double offset;

  const CardContent(
      {Key key,
      @required this.nameParking,
      @required this.date,
      @required this.offset})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Transform.translate(
            offset: Offset(8 * offset, 0),
            child: Center(
                child: Text(nameParking,
                    style:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.bold))),
          ),
          SizedBox(height: 8),
          Transform.translate(
            offset: Offset(32 * offset, 0),
            child: Text(
              date,
              style: TextStyle(
                // color: Colors.grey
              ),
            ),
          ),
          Spacer(),
          Row(
            children: <Widget>[
              SizedBox(width: 16),
              Spacer(),
              Transform.translate(
                offset: Offset(48 * offset, 0),
                child: RaisedButton(
                  color: Colors.blueAccent,
                  child: Transform.translate(
                    offset: Offset(24 * offset, 0),
                    child: Text('Release'),
                  ),
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                  onPressed: () => _handleRelease(context),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  void _handleRelease(BuildContext context) {
//update release status
    Firestore.instance.collection('users').document(id).updateData(
        {'status': 'Releasing', 'parkAt': nameParking}).then((data) async {
      await prefs.setString('status', 'Releasing');

      Fluttertoast.showToast(msg: "Update success");
      Navigator.pushNamed(context, Home.id);
    }).catchError((err) => print(err));

    // //add new release to list
    // Firestore.instance
    //     .collection('releases')
    //     .document(id)
    //     .setData({
    //       'id':id,
    //       // 'nickname': nickname,
    //       // 'photoUrl': photoUrl,
    //       'parking': nameParking,
    //       'occupied': false,
    //       'timeRelease':null,
    //     })
    //     .then((result) => {
    //           Navigator.of(context).pop(),
    //         })
    //     .catchError((err) => print(err));
  }

  //TODO:create time picker for time leaving
}
