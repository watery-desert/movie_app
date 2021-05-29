import 'package:flutter/material.dart';

class RippleClipper extends CustomClipper<Path> {
  RippleClipper({required this.progress});

  final double progress;

  @override
  Path getClip(Size size) {
    Path path = Path();
//    double radius =
//        math.sqrt(math.pow(size.width, 2) + math.pow(size.height, 2));
//    path.addOval(
//        new Rect.fromCircle(center: Offset.zero, radius: radius * progress));
    path.addRect(
      Rect.fromLTRB(
          size.width - (size.width * progress), 0, size.width, size.height),
    );
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
