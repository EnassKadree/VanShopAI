import 'package:flutter/material.dart';

class MyFirstCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0, size.height - 120);

    path.quadraticBezierTo(
      size.width * 0.25, 
      size.height - 30, 
      size.width * 0.5, 
      size.height - 100,
    );

    path.quadraticBezierTo(
      size.width * 0.75, 
      size.height - 150, 
      size.width, 
      size.height - 80,
    );

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
class MySecondCustomClipper extends CustomClipper<Path>
{
  @override
  Path getClip(Size size) 
  {
    return Path()
    ..lineTo(0, size.height - 20)
    ..quadraticBezierTo
    (
      size.width/4,
      size.height - 150,
      size.width /2 ,
      size.height-80
    )
    ..quadraticBezierTo
    (
      3/4 * size.width,
      size.height - 20,
      size.width,
      size.height - 90
    )
    ..lineTo(size.width, 0);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) 
  {
    return false;
  }
}

