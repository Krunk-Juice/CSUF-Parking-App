import 'package:flutter/material.dart';
import 'home_sections/book_slide_card_section.dart';
import 'home_sections/release_slide_card_section.dart';
import 'home_sections/map_section.dart';



class HomePage extends StatelessWidget {
    static const String id ="home_page";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text('CSUF Parking'),
          ),
          body: TabBarView(
            children: [
              SlidingCardsView(),
              SpotHolderSlidingCardsView(),
              MapPage(),
            ],
            
          ),
          bottomNavigationBar: TabBar(
              tabs: [
                Tab(text: 'Book',),
                Tab(text: 'Release',),
                Tab(text: 'Free Parking',),
              ],
            labelColor: Colors.black,
            unselectedLabelColor: Colors.blue,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorPadding: EdgeInsets.all(5.0),
            indicatorColor: Colors.red,
            
            ),
            
        ),
      ),
    );
  }
}
