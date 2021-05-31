import 'package:flutter/material.dart';

import '../widget/image_clipper/image_clipper.dart';

class BackgroundImageSlide extends StatefulWidget {
  final int backgroundIndex;
  final String imageURL;
  final PageController pageController;
  final double deviceWidth;

  BackgroundImageSlide({
    required this.backgroundIndex,
    required this.pageController,
    required this.deviceWidth,
    required this.imageURL,
  });

  @override
  _BackgroundImageSlideState createState() => _BackgroundImageSlideState();
}

class _BackgroundImageSlideState extends State<BackgroundImageSlide> with SingleTickerProviderStateMixin {
  double clipProgress = 1.0;

  Widget viewImage(String location) {
    return Container(
      height: double.infinity,
      child: Image.asset(
        location,
        fit: BoxFit.cover,
      ),
    );
  }

  @override
  void initState() {
    final pageController = widget.pageController;
    final deviceWidth = widget.deviceWidth;
    final backgroundIndex = widget.backgroundIndex;
    super.initState();

    pageController.addListener(() {
      final offset = (pageController.position.pixels / 0.8) / deviceWidth;
      final currentPage = offset.toInt() + 1;
      if (currentPage == backgroundIndex ) {
        setState(() {
          clipProgress = 1 - removeIntegerPart(offset);
        });
      }
    });
  }

  double removeIntegerPart(double number) {
    final decimalLength = 100000000;

    /// This code is copied from here
    /// https://stackoverflow.com/a/59738706/10993985
    return (((number * decimalLength).toInt() % decimalLength) / decimalLength);
  }

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: RippleClipper(progress: clipProgress),
      child: viewImage(widget.imageURL),
    );
  }
}
