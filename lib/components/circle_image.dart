
import 'package:flutter/material.dart';
import 'package:flutter_parking_app/components/round_icon_button.dart';

class CircleImage extends StatelessWidget {
  CircleImage({this.photoUrl, this.onPressed,this.icon});

  final String photoUrl;
  final Function onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return (photoUrl==null)?RoundIconButton(icon: icon,):Material(
        shape: CircleBorder(),
        elevation: 10,
        shadowColor: Colors.grey,
        child: CircleAvatar(
          backgroundImage: NetworkImage(photoUrl),
          radius: 40,
        ));
  }
}
