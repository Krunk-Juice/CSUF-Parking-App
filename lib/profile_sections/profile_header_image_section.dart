import 'package:flutter/material.dart';

class CutColoredImage extends StatelessWidget {
  CutColoredImage(this.image, {@required this.color});

  final Image image;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: Clipper(),
      child: DecoratedBox(
        position: DecorationPosition.foreground,
        decoration: BoxDecoration(color: color),
        child:image,
      ),
    );
  }
}

class Clipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}