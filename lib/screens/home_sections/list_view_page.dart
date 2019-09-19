import 'package:flutter/material.dart';

class ListViewPage extends StatefulWidget
{
  static const String id ="list_view"; 

  @override
  _ListViewPageState createState() => _ListViewPageState();
}

class _ListViewPageState extends State<ListViewPage>
{
  @override
  Widget build(BuildContext context)
  {
    return Scaffold
    (
      appBar: AppBar
      (
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: IconButton
        (
          color: Colors.black,
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.arrow_back, color: Colors.black),
        ),
        title: Text('Release Spot (2)', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700)),
        
      ),
      body: ListView
      (
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        children: <Widget>
        [
          Container
          (
            margin: EdgeInsets.symmetric(vertical: 16.0, horizontal: 54.0),
            child: Material
            (
              elevation: 8.0,
              color: Colors.black,
              borderRadius: BorderRadius.circular(32.0),
              child: InkWell
              (
                onTap: () {},
                child: Padding
                (
                  padding: EdgeInsets.all(12.0),
                  child: Row
                  (
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>
                    [
                      Icon(Icons.add, color: Colors.white),
                      Padding(padding: EdgeInsets.only(right: 16.0)),
                      Text('RELEASE', style: TextStyle(color: Colors.white))
                    ],
                  ),
                ),
              ),
            )
          ),
          ShopItem(),
          BadShopItem(),
          
        ],
      )
    );
  }
}

class ShopItem extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return Padding
    (
      padding: EdgeInsets.only(bottom: 16.0),
      child: Stack
      (
        children: <Widget>
        [
          /// Item card
          Align
          (
            alignment: Alignment.topCenter,
            child: SizedBox.fromSize
            (
              size: Size.fromHeight(172.0),
              child: Stack
              (
                fit: StackFit.expand,
                children: <Widget>
                [
                  /// Item description inside a material
                  Container
                  (
                    margin: EdgeInsets.only(top: 24.0),
                    child: Material
                    (
                      elevation: 14.0,
                      borderRadius: BorderRadius.circular(12.0),
                      shadowColor: Color(0x802196F3),
                      color: Colors.white,
                      child: InkWell
                      (
                        onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => null)),
                        child: Padding
                        (
                          padding: EdgeInsets.all(24.0),
                          child: Column
                          (
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>
                            [
                              /// Title and rating
                              Column
                              (
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>
                                [
                                  Text('Alex Ho', style: TextStyle(color: Colors.blueAccent)),
                                  Row
                                  (
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>
                                    [
                                      Text('4.6', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 34.0)),
                                      Icon(Icons.star, color: Colors.black, size: 24.0),
                                    ],
                                  ),
                                ],
                              ),
                              /// Infos
                              // Row
                              // (
                              //   mainAxisAlignment: MainAxisAlignment.start,
                              //   crossAxisAlignment: CrossAxisAlignment.center,
                              //   children: <Widget>
                              //   [
                              //     Text('Bought', style: TextStyle()),
                              //     Padding
                              //     (
                              //       padding: EdgeInsets.symmetric(horizontal: 4.0),
                              //       child: Text('1,361', style: TextStyle(fontWeight: FontWeight.w700)),
                              //     ),
                              //     Text('times for a profit of', style: TextStyle()),
                              //     Padding
                              //     (
                              //       padding: EdgeInsets.symmetric(horizontal: 4.0),
                              //       child: Material
                              //       (
                              //         borderRadius: BorderRadius.circular(8.0),
                              //         color: Colors.green,
                              //         child: Padding
                              //         (
                              //           padding: EdgeInsets.all(4.0),
                              //           child: Text('\$ 13K', style: TextStyle(color: Colors.white)),
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
                  /// Item image
                  Align
                  (
                    alignment: Alignment.topRight,
                    child: Padding
                    (
                      padding: EdgeInsets.only(right: 16.0),
                      child: SizedBox.fromSize
                      (
                        size: Size.fromRadius(54.0),
                        child: Material
                        (
                          elevation: 20.0,
                          shadowColor: Color(0x802196F3),
                          shape: CircleBorder(),
                          child: Image.asset('assets/images/undraw_profile_pic_ic5t.png'),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ),
          ),
          
          
        ],
      ),
    );
  }
}

class BadShopItem extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return Padding
    (
      padding: EdgeInsets.only(bottom: 16.0),
      child: Stack
      (
        children: <Widget>
        [
          /// Item card
          Align
          (
            alignment: Alignment.topCenter,
            child: SizedBox.fromSize
            (
              size: Size.fromHeight(172.0),
              child: Stack
              (
                fit: StackFit.expand,
                children: <Widget>
                [
                  /// Item description inside a material
                  Container
                  (
                    margin: EdgeInsets.only(top: 24.0),
                    child: Material
                    (
                      elevation: 14.0,
                      borderRadius: BorderRadius.circular(12.0),
                      shadowColor: Color(0x802196F3),
                      color: Colors.transparent,
                      child: Container
                      ( 
                        decoration: BoxDecoration
                        (
                          gradient: LinearGradient
                          (
                            colors: [ Color(0xFFDA4453), Color(0xFF89216B) ]
                          )
                        ),
                        child: Padding
                        (
                          padding: EdgeInsets.all(24.0),
                          child: Column
                          (
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>
                            [
                              /// Title and rating
                              Column
                              (
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>
                                [
                                  Text('Chris Ta', style: TextStyle(color: Colors.white)),
                                  Row
                                  (
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>
                                    [
                                      Text('4.5', style: TextStyle(color: Colors.amber, fontWeight: FontWeight.w700, fontSize: 34.0)),
                                      Icon(Icons.star, color: Colors.amber, size: 24.0),
                                    ],
                                  ),
                                ],
                              ),
                              
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  /// Item image
                  Align
                  (
                    alignment: Alignment.topRight,
                    child: Padding
                    (
                      padding: EdgeInsets.only(right: 16.0),
                      child: SizedBox.fromSize
                      (
                        size: Size.fromRadius(54.0),
                        child: Material
                        (
                          elevation: 20.0,
                          shadowColor: Color(0x802196F3),
                          shape: CircleBorder(),
                          child: Image.asset('assets/images/undraw_profile_pic_ic5t.png'),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ),
          ),
          /// Review
          
        ],
      ),
    );
  }
}

