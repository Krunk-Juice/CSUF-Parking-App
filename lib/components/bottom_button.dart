import 'package:flutter/material.dart';
import 'constants.dart';
class BottomButton extends StatelessWidget {
  BottomButton({
    this.onPressed,this.title,this.color
  });
final Function onPressed;
final String title;
final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        child: Center(child: Text(title, style: kLargeButtonTextStyle,)),
        color: color,
        margin: EdgeInsets.only(top: 10.0),
        width: double.infinity,
        height: 80.0,
      ),
    );
  }
}