import 'package:flutter/material.dart';
import 'package:flutter_parking_app/components/constants.dart';

class RoundedButton extends StatelessWidget {

  RoundedButton({this.colour,this.title,this.onPressed});

  final Color colour;
  final String title;
  final Function onPressed;


  @override
  Widget build(BuildContext context) {
    return  Material(
                elevation: 5.0,
                color: colour,
                borderRadius: BorderRadius.circular(15.0),
                child: MaterialButton(
                  onPressed: onPressed,
                  minWidth: 200.0,
                  height: 40.0,
                  child: Text(
                    title,
                    style: kRoundButtonTextStyle,
                  ),
                ),
              )
            ;
  }
}