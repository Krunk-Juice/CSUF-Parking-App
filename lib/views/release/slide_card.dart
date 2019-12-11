import 'package:flutter/material.dart';
import 'package:flutter_parking_app/components/constants.dart';
import 'package:flutter_parking_app/views/release/input_parking_data.dart';



import 'dart:math' as math;




// Slide Cards
class SlideCards extends StatefulWidget {
  @override
  _SlideCardsState createState() => _SlideCardsState();
}

class _SlideCardsState extends State<SlideCards> {
  PageController pageController;
  double pageOffset = 0;

  // Initialize State of the Slide Cards
  @override
  void initState() {
    super.initState();
    pageController = PageController(viewportFraction: 0.8);
    pageController.addListener(() {
      setState(() => pageOffset = pageController.page);
    });
    
  }

  

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  // UI Construct of the Slide Cards structure
  @override
  Widget build(BuildContext context) {
    return PageView(
        controller: pageController,
        children: <Widget>[
          SlidingCard(
            nameParking: 'Nutwood Parking Structure',
            assetName: 'nutwood.png',
            offset: pageOffset,
          ),
          SlidingCard(
            nameParking: 'State College Parking Structure',
            assetName: 'state_college.png',
            offset: pageOffset - 1,
          ),
          SlidingCard(
            nameParking: 'Eastside Parking Structure',
            assetName: 'eastside.png',
            offset: pageOffset - 2,
          ),
        ],
      );
  }
}

// Designing card interior
class SlidingCard extends StatelessWidget {
  
  final String nameParking;
  final String assetName;
  final double offset;

  const SlidingCard({
    @required this.nameParking,
    @required this.assetName,
    @required this.offset,
  });

  @override
  Widget build(BuildContext context) {
    double gauss = math.exp(-(math.pow((offset.abs() - 0.5), 2) / 0.08));
    return Transform.translate(
      offset: Offset(-32 * gauss * offset.sign, 0),
      child: Card(
        margin: EdgeInsets.only(left: 10, right: 10, bottom: 30),
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        child:  GestureDetector(
          onTap:() => Navigator.push(context, MaterialPageRoute(builder: (context) => InputParkingData(
                 nameParking: nameParking,
               ))),
                  child: Column(
              children: <Widget>[
                SizedBox(height: 10,),
                Expanded(
                  child:  ClipRRect(
                    borderRadius:  BorderRadius.circular(10.0),
                                      child: Image.asset(
                        'assets/images/$assetName',
                        
                        // height: MediaQuery.of(context).size.height * 0.3,
                        alignment: Alignment(-offset.abs(), 0),
                        // fit: BoxFit.none,
                      ),
                  ),
                  
                ),
                SizedBox(height: 10,),
                Expanded(
                        child:Text(nameParking, style: kTitleTextStyle,textAlign: TextAlign.center,)
                      ),
                
              ],
            
          ),
        ),
      ),
    );
  }

  
}

// Content inside of the cards container