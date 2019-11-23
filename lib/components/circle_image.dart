
import 'package:flutter/material.dart';

class CircleImage extends StatelessWidget {
  CircleImage({this.photoUrl, this.onPressed});

  final String photoUrl;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
        shape: CircleBorder(),
        elevation: 10,
        shadowColor: Colors.grey,
        child: CircleAvatar(
          backgroundImage: NetworkImage(photoUrl),
          radius: 30,
        ));
  }
}
