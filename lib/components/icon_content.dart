import 'package:flutter_parking_app/components/constants.dart';
import 'package:flutter/material.dart';


class IconContent extends StatelessWidget {
   IconContent({
    this.icon,this.label
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          icon,
          size: 80,
        ),
        SizedBox(height: 15,),
        Text(label,style: kLabelTextStyle,)
      ],
    );
  }
}
