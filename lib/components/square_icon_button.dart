import 'package:flutter/material.dart';

class SquareIconButton extends StatelessWidget {
  SquareIconButton({this.icon, this.onPressed});

  final IconData icon;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      elevation: 0.0,
      child: Icon(icon),
      onPressed: onPressed,
      constraints: BoxConstraints.tightFor(
        width: 56.0,
        height: 56.0,
      ),
      // shape: CircleBorder(),
      fillColor: Color(0xFF4C4F5E),
    );
  }
}
